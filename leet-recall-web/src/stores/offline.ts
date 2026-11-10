import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import {
  OFFLINE_PROBLEM_CACHE_CHANGED_EVENT,
  cacheImportedProblem,
  clearOfflineData,
  getPackCacheVersion,
  getProblemCacheVersion,
  hasExpiredProblemCache,
  invalidateProblem,
  isPackCacheVersionCurrent,
  readMeta,
  readProblem,
  refreshProblemCacheTimes,
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
  const handledCacheMetaEvents = new Set<string>()

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
      window.addEventListener(OFFLINE_PROBLEM_CACHE_CHANGED_EVENT, (event) => {
        const detail = (event as CustomEvent<{
          problemId?: number
          all?: boolean
          phase?: string
          pageEpoch?: string
          pageProblemToken?: string
        }>).detail
        const eventKey = `${detail?.all ? 'all' : detail?.problemId}:${detail?.phase ?? ''}:${detail?.pageEpoch ?? ''}:${detail?.pageProblemToken ?? ''}`
        if (handledCacheMetaEvents.has(eventKey)) return
        handledCacheMetaEvents.add(eventKey)
        void readMeta().then((value) => { meta.value = value }).catch(() => undefined)
      })
      // 首次联网且尚未保存资料时立即下载，其余情况走空闲时的增量检查。
      const run = () => { void sync({ automatic: true }) }
      if ('requestIdleCallback' in window) window.requestIdleCallback(run, { timeout: 4000 })
      else setTimeout(run, 1200)
    }
  }

  async function sync(options?: { force?: boolean; automatic?: boolean; problemId?: number }): Promise<void> {
    if (syncTask) {
      await syncTask
      if (options?.problemId === undefined) return
    }
    if (!available.value) {
      error.value = '当前浏览器不支持离线存储'
      return
    }
    const task = (async () => {
      // 在首次异步等待前捕获版本；导入若随后发生，旧整包响应必须被拒绝。
      const packVersion = await getPackCacheVersion()
      const cacheExpired = await hasExpiredProblemCache()
      // 关闭自动更新时跳过常规检查；已过期的资料仍需在线确认。
      if (options?.automatic && !autoUpdate.value && hasPack.value && !cacheExpired) return
      const lastCheckedAt = meta.value?.lastCheckedAt ?? 0
      if (!options?.force && lastCheckedAt && Date.now() - lastCheckedAt < AUTO_CHECK_INTERVAL && !cacheExpired) return

      const problemId = options?.problemId
      syncing.value = true
      error.value = ''
      const controller = new AbortController()
      const timeout = window.setTimeout(() => controller.abort(), 30_000)
      try {
        const problemVersion = problemId === undefined ? null : await getProblemCacheVersion(problemId)
        const response = await fetch('/api/offline/pack', {
          headers: problemId === undefined && meta.value?.etag ? { 'If-None-Match': meta.value.etag } : undefined,
          cache: 'no-cache',
          signal: controller.signal,
        })
        // 拿到 HTTP 响应即说明网络可达；断网导致的 fetch 失败由下方 catch 处理。
        markNetworkSuccess()
        if (response.status === 304) {
          if (problemId !== undefined) throw new Error('未取得导入题目的新资料，请重试')
          if (!await isPackCacheVersionCurrent(packVersion)) return
          meta.value = await refreshProblemCacheTimes() ?? await readMeta()
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
        if (problemId === undefined) {
          // 导入前开始的整包下载不允许把已失效的旧题目写回来。
          if (!await replacePack(pack, nextMeta, packVersion)) {
            if (!packVersion.readable) throw new Error('无法校验离线资料版本，请重试更新。')
            return
          }
          meta.value = await readMeta()
        } else {
          const problem = pack.problems.find((item) => item.problemId === problemId)
          if (!problem) throw new Error('离线资料包中缺少导入题目，请重试')
          const textFields = ['title', 'descriptionMarkdown', 'hint', 'coreIdea', 'keyCode', 'fullCode', 'templateCode', 'noteMarkdown'] as const
          const listFields = ['tags', 'recallQuestions', 'mistakes', 'keywords', 'annotations'] as const
          if (!textFields.every((key) => typeof problem[key] === 'string')
            || !listFields.every((key) => Array.isArray(problem[key]))
            || !problem.dictationAnswers || typeof problem.dictationAnswers !== 'object'
            || Array.isArray(problem.dictationAnswers)) {
            throw new Error('导入题目的离线资料不完整，请重试')
          }
          const saved = problemVersion && await cacheImportedProblem(problem, problemVersion)
          if (!saved && !await readProblem(problemId)) throw new Error('无法确认该题离线资料已更新，请重试。')
          meta.value = await readMeta()
        }
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
        if (problemId !== undefined) {
          error.value = '该题离线资料暂不可用，其他题缓存仍保留。请重试更新。'
        }
      } finally {
        window.clearTimeout(timeout)
        syncing.value = false
      }
    })()
    syncTask = task
    try {
      await task
    } finally {
      if (syncTask === task) syncTask = null
    }
  }

  /** 由确认导入成功后的回调调用；整包只用于取完整字段，落盘仅涉及导入题。 */
  async function refreshImportedProblem(problemId: number): Promise<void> {
    if (!available.value) return
    const pendingDownload = syncTask
    await invalidateProblem(problemId)
    meta.value = await readMeta()
    // 尚未保存过题包时没有旧缓存需要补回，首次自动下载仍负责建立完整题库。
    if (!meta.value) {
      if (!pendingDownload) return
      await pendingDownload
      await sync({ force: true })
    } else {
      await sync({ force: true, problemId })
    }
    if (error.value) throw new Error(error.value)
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
    refreshImportedProblem,
    clear,
    setAutoUpdate,
    install,
    refreshStorageState,
  }
})
