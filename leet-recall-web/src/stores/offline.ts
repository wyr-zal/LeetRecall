import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import {
  clearOfflineData,
  readMeta,
  replacePack,
  requestStoragePersistence,
  storageEstimate,
  storagePersisted,
} from '@/offline/db'
import { markNetworkFailure, markNetworkSuccess, online } from '@/offline/network'
import type { ApiResponse } from '@/types/api'
import type { OfflineMeta, OfflinePack } from '@/types/offline'
import { OFFLINE_SCHEMA_VERSION } from '@/types/offline'

const AUTO_UPDATE_KEY = 'leet-recall:offline-auto-update'
const AUTO_CHECK_INTERVAL = 30 * 60 * 1000

interface InstallPromptEvent extends Event {
  prompt: () => Promise<void>
  userChoice: Promise<{ outcome: 'accepted' | 'dismissed' }>
}

export const useOfflineStore = defineStore('offline', () => {
  const available = ref(typeof indexedDB !== 'undefined')
  const meta = ref<OfflineMeta | null>(null)
  const syncing = ref(false)
  const error = ref('')
  const autoUpdate = ref(localStorage.getItem(AUTO_UPDATE_KEY) !== '0')
  const persisted = ref<boolean | null>(null)
  const usage = ref(0)
  const quota = ref(0)
  const installAvailable = ref(false)
  let installPrompt: InstallPromptEvent | null = null
  let initialized = false
  let syncTask: Promise<void> | null = null

  const offline = computed(() => !online.value)
  const hasPack = computed(() => meta.value !== null && meta.value.problemCount > 0)
  const problemCount = computed(() => meta.value?.problemCount ?? 0)
  const packBytes = computed(() => meta.value?.packBytes ?? 0)
  const downloadedAt = computed(() => meta.value?.downloadedAt ?? 0)

  function setAutoUpdate(value: boolean): void {
    autoUpdate.value = value
    localStorage.setItem(AUTO_UPDATE_KEY, value ? '1' : '0')
  }

  async function refreshStorageState(): Promise<void> {
    persisted.value = await storagePersisted()
    const estimate = await storageEstimate()
    if (estimate) {
      usage.value = estimate.usage
      quota.value = estimate.quota
    }
  }

  /** 只在资料已成功落盘后申请持久化，避免首次访问就弹权限。 */
  async function ensurePersistence(): Promise<void> {
    if (persisted.value === true) return
    persisted.value = await requestStoragePersistence()
    if (persisted.value === null) persisted.value = await storagePersisted()
  }

  async function initialize(): Promise<void> {
    if (initialized) return
    initialized = true
    meta.value = await readMeta().catch(() => null)
    await refreshStorageState()
    if (typeof window !== 'undefined') {
      window.addEventListener('beforeinstallprompt', (event) => {
        event.preventDefault()
        installPrompt = event as InstallPromptEvent
        installAvailable.value = true
      })
      window.addEventListener('appinstalled', () => {
        installPrompt = null
        installAvailable.value = false
      })
      // 网络恢复时补一次检查；30 分钟内已检查过则自动跳过。
      window.addEventListener('online', () => { void sync({ automatic: true }) })
      // 首次联网且尚未保存资料时立即下载，其余情况走空闲时的增量检查。
      const run = () => { void sync({ automatic: true }) }
      if ('requestIdleCallback' in window) window.requestIdleCallback(run, { timeout: 4000 })
      else setTimeout(run, 1200)
    }
  }

  async function sync(options?: { force?: boolean; automatic?: boolean }): Promise<void> {
    if (syncTask) return syncTask
    if (!available.value) {
      error.value = '当前浏览器不支持离线存储'
      return
    }
    // 首次下载不受自动更新开关影响；关闭后已有资料只能手动更新。
    if (options?.automatic && !autoUpdate.value && hasPack.value) return
    const lastCheckedAt = meta.value?.lastCheckedAt ?? 0
    if (!options?.force && lastCheckedAt && Date.now() - lastCheckedAt < AUTO_CHECK_INTERVAL) return

    syncTask = (async () => {
      syncing.value = true
      error.value = ''
      const controller = new AbortController()
      const timeout = window.setTimeout(() => controller.abort(), 30_000)
      try {
        const response = await fetch('/api/offline/pack', {
          headers: meta.value?.etag ? { 'If-None-Match': meta.value.etag } : undefined,
          cache: 'no-cache',
          signal: controller.signal,
        })
        // 拿到 HTTP 响应即说明网络可达；断网导致的 fetch 失败由下方 catch 处理。
        markNetworkSuccess()
        if (response.status === 304) {
          if (meta.value) {
            meta.value = { ...meta.value, lastCheckedAt: Date.now() }
          }
          return
        }
        if (!response.ok) throw new Error(`离线资料下载失败（HTTP ${response.status}）`)
        const payload = await response.json().catch(() => null) as ApiResponse<OfflinePack> | null
        if (!payload || payload.code !== 0) throw new Error(payload?.message || '离线资料下载失败')
        const pack = payload.data
        if (!pack || pack.schemaVersion !== OFFLINE_SCHEMA_VERSION || !Array.isArray(pack.problems) || pack.problems.length === 0) {
          throw new Error('离线资料格式不受支持，请刷新页面后重试')
        }
        const text = JSON.stringify(pack)
        const nextMeta: OfflineMeta = {
          etag: response.headers.get('ETag') ?? '',
          downloadedAt: Date.now(),
          packBytes: new Blob([text]).size,
          schemaVersion: pack.schemaVersion,
          problemCount: pack.problems.length,
          lastCheckedAt: Date.now(),
        }
        // 同一个事务内清空并写入；失败会回滚，旧资料继续可用。
        await replacePack(pack, nextMeta)
        meta.value = nextMeta
        await ensurePersistence()
        await refreshStorageState()
      } catch (cause) {
        if (cause instanceof DOMException && cause.name === 'QuotaExceededError') {
          error.value = '浏览器存储空间不足，旧资料已保留。请清理空间后重试。'
        } else if (cause instanceof DOMException && cause.name === 'AbortError') {
          error.value = '离线资料下载超时，旧资料已保留。'
          markNetworkFailure()
        } else if (cause instanceof TypeError) {
          // fetch 本身失败（断网、DNS 或连接被拒）才判定为离线；HTTP 与格式错误不改变在线状态。
          error.value = '网络不可用，旧资料已保留。'
          markNetworkFailure()
        } else {
          error.value = cause instanceof Error ? cause.message : '离线资料下载失败，旧资料已保留。'
        }
      } finally {
        window.clearTimeout(timeout)
        syncing.value = false
        syncTask = null
      }
    })()
    return syncTask
  }

  /** 仅清除本应用写入的离线资料；不触碰服务端记录，也不清理应用外壳缓存。 */
  async function clear(): Promise<void> {
    await clearOfflineData()
    meta.value = null
    error.value = ''
    await refreshStorageState()
  }

  async function install(): Promise<void> {
    if (!installPrompt) return
    await installPrompt.prompt()
    await installPrompt.userChoice.catch(() => undefined)
    installPrompt = null
    installAvailable.value = false
  }

  return {
    available,
    meta,
    syncing,
    error,
    autoUpdate,
    persisted,
    usage,
    quota,
    installAvailable,
    offline,
    hasPack,
    problemCount,
    packBytes,
    downloadedAt,
    initialize,
    sync,
    clear,
    setAutoUpdate,
    install,
    refreshStorageState,
  }
})