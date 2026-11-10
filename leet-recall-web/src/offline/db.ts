import type {
  OfflineMeta,
  OfflinePack,
  OfflineProblem,
  OfflineQueueSnapshot,
  OfflineSearchItem,
} from '@/types/offline'
import { OFFLINE_SCHEMA_VERSION } from '@/types/offline'

const DB_NAME = 'leet-recall-offline'
const DB_VERSION = 1
const META_STORE = 'meta'
const PROBLEM_STORE = 'problems'
const QUEUE_STORE = 'queues'
const PACK_KEY = 'pack'
const PACK_VERSION_KEY = 'pack-cache-version'
const CACHE_EPOCH_KEY = 'cache-epoch'
const PROBLEM_VERSION_PREFIX = 'problem-cache-version:'
const OFFLINE_PROBLEM_CACHE_TTL_MS = 24 * 60 * 60 * 1000
const PAGE_EPOCH_KEY = 'leet-recall:offline-cache:page-epoch'
const PROBLEM_PAGE_PREFIX = 'leet-recall:offline-cache:problem:'
const PAGE_NOTICE_KEY = 'leet-recall:offline-cache:page-notice'
const PROBLEM_NOTICE_PREFIX = 'leet-recall:offline-cache:problem-notice:'
export const OFFLINE_PROBLEM_CACHE_CHANGED_EVENT = 'offline-problem-cache-changed'
/** 离线查看答案的待补记列表；清除资料时保留，联网后补记到服务端留痕。 */
export const PENDING_ANSWER_VIEW_KEY = 'pending-answer-views'

let databasePromise: Promise<IDBDatabase | null> | null = null
const invalidatedProblems = new Set<number>()
const problemPageStates = new Map<number, StoredProblemPageState>()
const knownProblemRevisions = new Map<number, { epoch: number; version: number }>()
let fallbackPageEpoch = '0'
let knownPackRevision: { epoch: number; version: number } | null = null

export interface CacheVersion {
  epoch: number
  version: number
  readable: boolean
  pageEpoch?: string
  pageProblemToken?: string
  pageReadable?: boolean
}

interface StoredProblemPageState {
  token: string
  invalidated: boolean
  epoch: string
  localOnly?: boolean
}

interface PageVersionState {
  epoch: string
  problemToken: string
  readable: boolean
  invalidated: boolean
}

function isRevisionAtLeast(
  current: { epoch: number; version: number } | undefined,
  next: CacheVersion,
): boolean {
  return !current || next.epoch > current.epoch
    || (next.epoch === current.epoch && next.version >= current.version)
}

function rememberProblemRevision(problemId: number, version: CacheVersion): boolean {
  if (!isRevisionAtLeast(knownProblemRevisions.get(problemId), version)) return false
  knownProblemRevisions.set(problemId, { epoch: version.epoch, version: version.version })
  return true
}

function rememberPackRevision(version: CacheVersion): boolean {
  if (!isRevisionAtLeast(knownPackRevision ?? undefined, version)) return false
  knownPackRevision = { epoch: version.epoch, version: version.version }
  return true
}

function pageProblemKey(problemId: number): string {
  return `${PROBLEM_PAGE_PREFIX}${problemId}`
}

function newPageToken(): string {
  return `${Date.now().toString(36)}-${Math.random().toString(36).slice(2)}`
}

function readPageEpoch(): { value: string; readable: boolean } {
  try {
    const value = localStorage.getItem(PAGE_EPOCH_KEY)
    if (value !== null) fallbackPageEpoch = value
    return { value: value ?? fallbackPageEpoch, readable: true }
  } catch {
    return { value: fallbackPageEpoch, readable: false }
  }
}

function readPageVersionState(problemId: number): PageVersionState {
  const epoch = readPageEpoch()
  let readable = epoch.readable
  let state: StoredProblemPageState = problemPageStates.get(problemId)
    ?? { token: '0', invalidated: false, epoch: epoch.value }
  try {
    const raw = localStorage.getItem(pageProblemKey(problemId))
    if (raw !== null) {
      const parsed = JSON.parse(raw) as Partial<typeof state>
      if (typeof parsed.token === 'string' && typeof parsed.epoch === 'string' && typeof parsed.invalidated === 'boolean') {
        const memoryState = problemPageStates.get(problemId)
        if (memoryState?.localOnly && memoryState.epoch === epoch.value && memoryState.token !== parsed.token) {
          state = memoryState
          readable = false
        } else {
          state = { token: parsed.token, invalidated: parsed.invalidated, epoch: parsed.epoch }
        }
      } else {
        readable = false
      }
    } else if (problemPageStates.get(problemId)?.localOnly) {
      state = problemPageStates.get(problemId)!
      readable = false
    }
  } catch {
    readable = false
  }
  if (state.epoch !== epoch.value) state = { ...state, invalidated: false, epoch: epoch.value }
  problemPageStates.set(problemId, state)
  if (state.invalidated) invalidatedProblems.add(problemId)
  else invalidatedProblems.delete(problemId)
  return {
    epoch: epoch.value,
    problemToken: state.token,
    readable,
    invalidated: state.invalidated,
  }
}

function bumpPageEpoch(): { value: string; readable: boolean } {
  const value = newPageToken()
  fallbackPageEpoch = value
  invalidatedProblems.clear()
  try {
    localStorage.setItem(PAGE_EPOCH_KEY, value)
    return { value, readable: true }
  } catch {
    return { value, readable: false }
  }
}

function notifyPageChange(type: string, problemId: number | undefined, version: CacheVersion): void {
  const key = problemId === undefined ? PAGE_NOTICE_KEY : `${PROBLEM_NOTICE_PREFIX}${problemId}`
  try {
    localStorage.setItem(key, JSON.stringify({ type, problemId, version, nonce: newPageToken() }))
  } catch {
    // 页面版本本身仍有效；BroadcastChannel 会作为 storage 通知失败时的回退。
  }
}

function setProblemPageState(problemId: number, invalidated: boolean): PageVersionState {
  const epoch = readPageEpoch()
  const state = { token: newPageToken(), invalidated, epoch: epoch.value }
  problemPageStates.set(problemId, state)
  if (invalidated) invalidatedProblems.add(problemId)
  else invalidatedProblems.delete(problemId)
  let readable = epoch.readable
  let localOnly = false
  try {
    localStorage.setItem(pageProblemKey(problemId), JSON.stringify(state))
  } catch {
    readable = false
    localOnly = true
  }
  if (localOnly) problemPageStates.set(problemId, { ...state, localOnly: true })
  return { epoch: state.epoch, problemToken: state.token, readable, invalidated }
}

function pageVersionMatches(problemId: number, expected: CacheVersion, includeEpoch = true): boolean {
  const current = readPageVersionState(problemId)
  return expected.pageProblemToken === current.problemToken
    && (!includeEpoch || expected.pageEpoch === current.epoch)
}

function problemPageTokenMatches(problemId: number, expected: CacheVersion): boolean {
  return expected.pageProblemToken === readPageVersionState(problemId).problemToken
}

function isProblemInvalidated(problemId: number): boolean {
  return readPageVersionState(problemId).invalidated
}

function applyRemoteProblemPageState(problemId: number, version: CacheVersion, invalidated: boolean): boolean {
  const current = readPageVersionState(problemId)
  const pageMatches = current.epoch === version.pageEpoch && current.problemToken === version.pageProblemToken
  if (current.readable && !pageMatches && version.pageReadable !== false) return false
  if (!pageMatches && version.pageEpoch && version.pageProblemToken) {
    fallbackPageEpoch = version.pageEpoch
    const state = { token: version.pageProblemToken, invalidated, epoch: version.pageEpoch, localOnly: true }
    problemPageStates.set(problemId, state)
    try {
      localStorage.setItem(pageProblemKey(problemId), JSON.stringify(state))
      problemPageStates.set(problemId, { ...state, localOnly: false })
    } catch {
      // Keep the verified remote token in memory when localStorage is full.
    }
  }
  if (invalidated) invalidatedProblems.add(problemId)
  else invalidatedProblems.delete(problemId)
  return true
}

function applyRemotePageEpoch(version: CacheVersion): boolean {
  const current = readPageEpoch()
  if (current.readable && current.value !== version.pageEpoch && version.pageReadable !== false) return false
  if (current.value !== version.pageEpoch && version.pageEpoch) {
    fallbackPageEpoch = version.pageEpoch
    try {
      localStorage.setItem(PAGE_EPOCH_KEY, version.pageEpoch)
    } catch {
      // Keep the verified remote epoch in memory when localStorage is full.
    }
  }
  invalidatedProblems.clear()
  return true
}

function problemVersionKey(problemId: number): string {
  return `${PROBLEM_VERSION_PREFIX}${problemId}`
}

async function readCacheVersion(versionKey: string): Promise<CacheVersion> {
  try {
    const database = await openDatabase()
    if (!database) return { epoch: 0, version: 0, readable: false }
    const transaction = database.transaction(META_STORE, 'readonly')
    const store = transaction.objectStore(META_STORE)
    const [epoch, version] = await Promise.all([
      requestResult(store.get(CACHE_EPOCH_KEY)),
      requestResult(store.get(versionKey)),
    ])
    return {
      epoch: typeof epoch === 'number' ? epoch : 0,
      version: typeof version === 'number' ? version : 0,
      readable: true,
    }
  } catch {
    return { epoch: 0, version: 0, readable: false }
  }
}

export async function getPackCacheVersion(): Promise<CacheVersion> {
  const pageEpoch = readPageEpoch()
  const version = await readCacheVersion(PACK_VERSION_KEY)
  if (version.readable) rememberPackRevision(version)
  return { ...version, pageEpoch: pageEpoch.value, pageReadable: pageEpoch.readable }
}

export async function getProblemCacheVersion(problemId: number): Promise<CacheVersion> {
  const page = readPageVersionState(problemId)
  const version = await readCacheVersion(problemVersionKey(problemId))
  if (version.readable) rememberProblemRevision(problemId, version)
  return {
    ...version,
    pageEpoch: page.epoch,
    pageProblemToken: page.problemToken,
    pageReadable: page.readable,
  }
}

function sameVersion(left: CacheVersion, right: CacheVersion): boolean {
  return left.readable && right.readable
    && left.epoch === right.epoch
    && left.version === right.version
}

export async function isPackCacheVersionCurrent(version: CacheVersion): Promise<boolean> {
  const currentPageEpoch = readPageEpoch()
  if (version.pageEpoch !== undefined && currentPageEpoch.value !== version.pageEpoch) return false
  if (!version.readable) return currentPageEpoch.readable || version.pageReadable === true
  const current = await getPackCacheVersion()
  if (version.pageEpoch !== current.pageEpoch) return false
  if (!current.readable) return current.pageReadable === true && version.pageReadable === true
  return sameVersion(version, current)
}

export async function isProblemCacheVersionCurrent(problemId: number, version: CacheVersion): Promise<boolean> {
  if (version.pageProblemToken !== undefined && !pageVersionMatches(problemId, version)) return false
  if (!version.readable) return version.pageReadable === true
  const current = await getProblemCacheVersion(problemId)
  if (version.pageProblemToken !== current.pageProblemToken || version.pageEpoch !== current.pageEpoch) return false
  if (!current.readable) return current.pageReadable === true && version.pageReadable === true
  return sameVersion(version, current)
}

const cacheChannel = typeof window === 'undefined' || typeof window.BroadcastChannel === 'undefined'
  ? null
  : new window.BroadcastChannel('leet-recall-offline-cache')

interface CacheChangeMessage {
  type?: string
  problemId?: number
  version?: CacheVersion
}

function handleCacheChangeMessage(message: CacheChangeMessage): void {
  if ((message?.type === 'problem-invalidated' || message?.type === 'problem-restored')
    && Number.isInteger(message.problemId) && message.version) {
    const problemId = message.problemId as number
    void getProblemCacheVersion(problemId).then((current) => {
      if (current.readable) {
        if (!sameVersion(current, message.version!)) return
      } else if (!rememberProblemRevision(problemId, message.version!)) {
        return
      }
      if (!applyRemoteProblemPageState(problemId, message.version!, message.type === 'problem-invalidated')) return
      if (message.type === 'problem-invalidated') invalidatedProblems.add(problemId)
      else invalidatedProblems.delete(problemId)
      window.dispatchEvent(new CustomEvent(OFFLINE_PROBLEM_CACHE_CHANGED_EVENT, {
        detail: {
          problemId,
          phase: message.type === 'problem-invalidated' ? 'committed' : 'restored',
          pageEpoch: message.version!.pageEpoch,
          pageProblemToken: message.version!.pageProblemToken,
        },
      }))
    }).catch(() => undefined)
  } else if ((message?.type === 'pack-replaced' || message?.type === 'cache-cleared') && message.version) {
    void getPackCacheVersion().then((current) => {
      if (current.readable) {
        if (!sameVersion(current, message.version!)) return
      } else if (!rememberPackRevision(message.version!)) {
        return
      }
      if (!applyRemotePageEpoch(message.version!)) return
      window.dispatchEvent(new CustomEvent(OFFLINE_PROBLEM_CACHE_CHANGED_EVENT, {
        detail: { all: true, phase: 'committed', pageEpoch: message.version!.pageEpoch },
      }))
    }).catch(() => undefined)
  }
}

cacheChannel?.addEventListener('message', (event: MessageEvent<CacheChangeMessage>) => {
  handleCacheChangeMessage(event.data)
})

if (typeof window !== 'undefined') {
  window.addEventListener('storage', (event) => {
    if (event.key === PAGE_EPOCH_KEY) {
      const page = readPageEpoch()
      invalidatedProblems.clear()
      window.dispatchEvent(new CustomEvent(OFFLINE_PROBLEM_CACHE_CHANGED_EVENT, {
        detail: { all: true, phase: 'invalidated', pageEpoch: page.value },
      }))
    } else if (event.key?.startsWith(PROBLEM_PAGE_PREFIX)) {
      const problemId = Number(event.key.slice(PROBLEM_PAGE_PREFIX.length))
      if (!Number.isInteger(problemId)) return
      const page = readPageVersionState(problemId)
      window.dispatchEvent(new CustomEvent(OFFLINE_PROBLEM_CACHE_CHANGED_EVENT, {
        detail: { problemId, phase: page.invalidated ? 'invalidated' : 'restored', pageEpoch: page.epoch, pageProblemToken: page.problemToken },
      }))
    } else if (event.key === PAGE_NOTICE_KEY) {
      try {
        const message = JSON.parse(event.newValue ?? '') as CacheChangeMessage
        handleCacheChangeMessage(message)
      } catch {
        // Ignore malformed cache notification values.
      }
    } else if (event.key?.startsWith(PROBLEM_NOTICE_PREFIX)) {
      try {
        const message = JSON.parse(event.newValue ?? '') as CacheChangeMessage
        handleCacheChangeMessage(message)
      } catch {
        // Ignore malformed cache notification values.
      }
    }
  })
}

function broadcastCacheEvent(type: string, problemId?: number, version?: CacheVersion): void {
  cacheChannel?.postMessage({ type, problemId, version })
}

export function indexedDbAvailable(): boolean {
  return typeof indexedDB !== 'undefined'
}

function openDatabase(): Promise<IDBDatabase | null> {
  if (!indexedDbAvailable()) return Promise.resolve(null)
  if (databasePromise) return databasePromise
  databasePromise = new Promise((resolve) => {
    let settled = false
    const finish = (database: IDBDatabase | null) => {
      if (settled) return
      settled = true
      resolve(database)
    }
    const request = indexedDB.open(DB_NAME, DB_VERSION)
    request.onupgradeneeded = () => {
      const database = request.result
      if (!database.objectStoreNames.contains(META_STORE)) {
        database.createObjectStore(META_STORE)
      }
      if (!database.objectStoreNames.contains(PROBLEM_STORE)) {
        const problems = database.createObjectStore(PROBLEM_STORE, { keyPath: 'problemId' })
        problems.createIndex('leetcodeNumber', 'leetcodeNumber', { unique: false })
      }
      if (!database.objectStoreNames.contains(QUEUE_STORE)) {
        database.createObjectStore(QUEUE_STORE)
      }
    }
    request.onsuccess = () => {
      const database = request.result
      // 清除站点数据或其他标签页升级时主动断开，避免删除被阻塞；下次访问会重新打开。
      database.onversionchange = () => {
        database.close()
        databasePromise = null
      }
      database.onclose = () => {
        databasePromise = null
      }
      finish(database)
    }
    request.onerror = () => finish(null)
    request.onblocked = () => finish(null)
  })
  return databasePromise
}

function requestResult<T>(request: IDBRequest<T>): Promise<T> {
  return new Promise((resolve, reject) => {
    request.onsuccess = () => resolve(request.result)
    request.onerror = () => reject(request.error ?? new Error('IndexedDB 请求失败'))
  })
}

function transactionDone(transaction: IDBTransaction): Promise<void> {
  return new Promise((resolve, reject) => {
    transaction.oncomplete = () => resolve()
    transaction.onerror = () => reject(transaction.error ?? new Error('IndexedDB 事务失败'))
    transaction.onabort = () => reject(transaction.error ?? new Error('IndexedDB 事务已中止'))
  })
}

/** 在同一个读写事务中核对请求开始时的版本，确保其他标签页的失效也能挡住旧响应。 */
function guardCacheVersion(
  transaction: IDBTransaction,
  versionKey: string,
  expected: CacheVersion,
  write: () => void,
): () => boolean {
  const store = transaction.objectStore(META_STORE)
  const epochRequest = store.get(CACHE_EPOCH_KEY)
  const versionRequest = store.get(versionKey)
  let epochReady = false
  let versionReady = false
  let current = false
  let epoch = 0
  let version = 0
  const check = () => {
    if (!epochReady || !versionReady) return
    current = expected.readable && epoch === expected.epoch && version === expected.version
    if (current) write()
  }
  epochRequest.onsuccess = () => {
    epoch = typeof epochRequest.result === 'number' ? epochRequest.result : 0
    epochReady = true
    check()
  }
  versionRequest.onsuccess = () => {
    version = typeof versionRequest.result === 'number' ? versionRequest.result : 0
    versionReady = true
    check()
  }
  return () => current
}

export async function readMeta(): Promise<OfflineMeta | null> {
  const database = await openDatabase()
  if (!database) return null
  const transaction = database.transaction(META_STORE, 'readonly')
  const value = await requestResult(transaction.objectStore(META_STORE).get(PACK_KEY))
  return (value as OfflineMeta | undefined) ?? null
}

export async function writeMeta(meta: OfflineMeta): Promise<void> {
  const database = await openDatabase()
  if (!database) return
  const transaction = database.transaction(META_STORE, 'readwrite')
  transaction.objectStore(META_STORE).put(meta, PACK_KEY)
  await transactionDone(transaction)
}

function cacheTimesForProblems(problems: OfflineProblem[], cachedAt: number): Record<string, number> {
  return Object.fromEntries(problems.map((problem) => [String(problem.problemId), cachedAt]))
}

function isProblemCacheFresh(meta: OfflineMeta | undefined, problemId: number, now = Date.now()): boolean {
  const cachedAt = meta?.problemCacheTimes?.[String(problemId)]
  return typeof cachedAt === 'number'
    && Number.isFinite(cachedAt)
    && cachedAt >= 0
    && now >= cachedAt
    && now - cachedAt < OFFLINE_PROBLEM_CACHE_TTL_MS
}

/** 整包 304 表示服务器确认缓存内容未变，因此为当前整包续期。 */
export async function refreshProblemCacheTimes(validatedAt = Date.now()): Promise<OfflineMeta | null> {
  const database = await openDatabase()
  if (!database) return null
  const transaction = database.transaction([PROBLEM_STORE, META_STORE], 'readwrite')
  const problemsRequest = transaction.objectStore(PROBLEM_STORE).getAll()
  const metaStore = transaction.objectStore(META_STORE)
  const metaRequest = metaStore.get(PACK_KEY)
  let problems: OfflineProblem[] | null = null
  let currentMeta: OfflineMeta | undefined
  let metaReady = false
  let nextMeta: OfflineMeta | null = null
  let saved = false
  const saveWhenReady = () => {
    if (saved || problems === null || !metaReady) return
    saved = true
    if (!currentMeta) return
    nextMeta = {
      ...currentMeta,
      lastCheckedAt: validatedAt,
      problemCacheTimes: cacheTimesForProblems(problems, validatedAt),
    }
    metaStore.put(nextMeta, PACK_KEY)
  }
  problemsRequest.onsuccess = () => {
    problems = problemsRequest.result as OfflineProblem[]
    saveWhenReady()
  }
  metaRequest.onsuccess = () => {
    currentMeta = metaRequest.result as OfflineMeta | undefined
    metaReady = true
    saveWhenReady()
  }
  await transactionDone(transaction)
  return nextMeta
}

export async function readProblem(problemId: number): Promise<OfflineProblem | null> {
  if (isProblemInvalidated(problemId)) return null
  const database = await openDatabase()
  if (!database) return null
  const transaction = database.transaction(PROBLEM_STORE, 'readonly')
  const value = await requestResult(transaction.objectStore(PROBLEM_STORE).get(problemId))
  if (isProblemInvalidated(problemId)) return null
  return (value as OfflineProblem | undefined) ?? null
}

export async function readAllProblems(): Promise<OfflineProblem[]> {
  const database = await openDatabase()
  if (!database) return []
  const transaction = database.transaction(PROBLEM_STORE, 'readonly')
  const problems = await requestResult(transaction.objectStore(PROBLEM_STORE).getAll()) as OfflineProblem[]
  return problems.filter((problem) => !isProblemInvalidated(problem.problemId))
}

/** 过期资料仍可离线兜底，但必须跳过短间隔并立即尝试联网确认。 */
export async function hasExpiredProblemCache(): Promise<boolean> {
  const database = await openDatabase()
  if (!database) return false
  const transaction = database.transaction([PROBLEM_STORE, META_STORE], 'readonly')
  const problemsRequest = requestResult(transaction.objectStore(PROBLEM_STORE).getAll())
  const metaRequest = requestResult(transaction.objectStore(META_STORE).get(PACK_KEY))
  const [problems, meta] = await Promise.all([problemsRequest, metaRequest]) as [OfflineProblem[], OfflineMeta | undefined]
  const cachedMeta = meta as OfflineMeta | undefined
  if (problems.length !== (cachedMeta?.problemCount ?? 0)) return true
  return problems.some((problem) => !isProblemCacheFresh(cachedMeta, problem.problemId))
}

/**
 * 整包替换：clear 与全部 put 在同一个事务内完成；任何一步失败都会回滚，
 * 旧资料保持可用，不会出现半新半旧的状态。
 */
export async function replacePack(
  pack: OfflinePack,
  meta: OfflineMeta,
  version?: CacheVersion,
): Promise<boolean> {
  const database = await openDatabase()
  if (!database) throw new Error('当前浏览器不支持 IndexedDB')
  const expectedVersion = version ?? await getPackCacheVersion()
  const transaction = database.transaction([PROBLEM_STORE, META_STORE], 'readwrite')
  let replacedVersion: CacheVersion | null = null
  const isCurrent = guardCacheVersion(transaction, PACK_VERSION_KEY, expectedVersion, () => {
    if (expectedVersion.pageEpoch !== undefined && expectedVersion.pageEpoch !== readPageEpoch().value) return
    const problems = transaction.objectStore(PROBLEM_STORE)
    const metaStore = transaction.objectStore(META_STORE)
    problems.clear()
    for (const problem of pack.problems) problems.put(problem)
    const cachedAt = meta.lastCheckedAt || meta.downloadedAt || Date.now()
    metaStore.put({ ...meta, problemCacheTimes: cacheTimesForProblems(pack.problems, cachedAt) }, PACK_KEY)
    const pageEpoch = bumpPageEpoch()
    replacedVersion = {
      epoch: expectedVersion.epoch + 1,
      version: expectedVersion.version + 1,
      readable: true,
      pageEpoch: pageEpoch.value,
      pageReadable: pageEpoch.readable,
    }
    metaStore.put(replacedVersion.version, PACK_VERSION_KEY)
    metaStore.put(replacedVersion.epoch, CACHE_EPOCH_KEY)
  })
  await transactionDone(transaction)
  if (!isCurrent() || !replacedVersion) return false
  rememberPackRevision(replacedVersion)
  notifyPageChange('pack-replaced', undefined, replacedVersion)
  if (replacedVersion) broadcastCacheEvent('pack-replaced', undefined, replacedVersion)
  return true
}

/** 单题变动后原整包 ETag 已失效，计数和大小按当前实际缓存计算。 */
function updatePackMeta(transaction: IDBTransaction, downloadedAt?: number, refreshedProblemId?: number): void {
  const problems = transaction.objectStore(PROBLEM_STORE).getAll()
  const store = transaction.objectStore(META_STORE)
  const meta = store.get(PACK_KEY)
  meta.onsuccess = () => {
    const current = meta.result as OfflineMeta | undefined
    const items = problems.result as OfflineProblem[]
    if (!current && items.length === 0) return
    const pack = { schemaVersion: OFFLINE_SCHEMA_VERSION, problemCount: items.length, problems: items }
    const problemCacheTimes: Record<string, number> = {}
    for (const item of items) {
      const key = String(item.problemId)
      const cachedAt = item.problemId === refreshedProblemId
        ? downloadedAt
        : current?.problemCacheTimes?.[key]
      if (typeof cachedAt === 'number' && Number.isFinite(cachedAt)) problemCacheTimes[key] = cachedAt
    }
    store.put({
      schemaVersion: OFFLINE_SCHEMA_VERSION,
      downloadedAt: downloadedAt ?? current?.downloadedAt ?? 0,
      etag: '',
      problemCount: items.length,
      packBytes: new Blob([JSON.stringify(pack)]).size,
      lastCheckedAt: 0,
      problemCacheTimes,
    } satisfies OfflineMeta, PACK_KEY)
  }
}

/** 在数据库导入成功之后调用；持久化提升版本并删除缓存，在途旧请求无法再写回。 */
export async function invalidateProblem(problemId: number): Promise<void> {
  const pageState = setProblemPageState(problemId, true)
  const database = await openDatabase()
  if (!database) throw new Error('本地离线缓存不可用')
  const transaction = database.transaction([PROBLEM_STORE, META_STORE], 'readwrite')
  const meta = transaction.objectStore(META_STORE)
  const packVersion = meta.get(PACK_VERSION_KEY)
  const problemVersion = meta.get(problemVersionKey(problemId))
  const cacheEpoch = meta.get(CACHE_EPOCH_KEY)
  let nextProblemVersion = 0
  let epoch = 0
  packVersion.onsuccess = () => meta.put((typeof packVersion.result === 'number' ? packVersion.result : 0) + 1, PACK_VERSION_KEY)
  problemVersion.onsuccess = () => {
    nextProblemVersion = (typeof problemVersion.result === 'number' ? problemVersion.result : 0) + 1
    meta.put(nextProblemVersion, problemVersionKey(problemId))
  }
  cacheEpoch.onsuccess = () => { epoch = typeof cacheEpoch.result === 'number' ? cacheEpoch.result : 0 }
  transaction.objectStore(PROBLEM_STORE).delete(problemId)
  updatePackMeta(transaction)
  await transactionDone(transaction)
  rememberProblemRevision(problemId, { epoch, version: nextProblemVersion, readable: true })
  const invalidationVersion: CacheVersion = {
    epoch,
    version: nextProblemVersion,
    readable: true,
    pageEpoch: pageState.epoch,
    pageProblemToken: pageState.problemToken,
    pageReadable: pageState.readable,
  }
  notifyPageChange('problem-invalidated', problemId, invalidationVersion)
  broadcastCacheEvent('problem-invalidated', problemId, invalidationVersion)
}

/** 只补回导入题的完整记录；详情接口的局部响应不能走此入口。 */
export async function cacheImportedProblem(
  problem: OfflineProblem,
  version: CacheVersion,
): Promise<boolean> {
  const database = await openDatabase()
  if (!database) throw new Error('本地离线缓存不可用')
  const transaction = database.transaction([PROBLEM_STORE, META_STORE], 'readwrite')
  const meta = transaction.objectStore(META_STORE)
  let pageAccepted = false
  const isCurrent = guardCacheVersion(transaction, problemVersionKey(problem.problemId), version, () => {
    if (!problemPageTokenMatches(problem.problemId, version)) return
    pageAccepted = true
    transaction.objectStore(PROBLEM_STORE).put(problem)
    meta.put(version.version + 1, problemVersionKey(problem.problemId))
    updatePackMeta(transaction, Date.now(), problem.problemId)
  })
  await transactionDone(transaction)
  if (!isCurrent() || !pageAccepted) return false
  rememberProblemRevision(problem.problemId, {
    epoch: version.epoch,
    version: version.version + 1,
    readable: true,
  })
  const pageState = setProblemPageState(problem.problemId, false)
  broadcastCacheEvent('problem-restored', problem.problemId, {
    epoch: version.epoch,
    version: version.version + 1,
    readable: true,
    pageEpoch: pageState.epoch,
    pageProblemToken: pageState.problemToken,
    pageReadable: pageState.readable,
  })
  return true
}

/**
 * 写回单题缓存。只在资料包已存在时更新，避免把只含局部字段的对象写进题库。
 * get 与 put 放在同一个事务回调里，避免 await 让事务提前失活。
 */
export async function updateProblem(
  problemId: number,
  updater: (current: OfflineProblem) => Partial<OfflineProblem>,
  version?: CacheVersion,
): Promise<void> {
  if (isProblemInvalidated(problemId)) return
  const database = await openDatabase()
  if (!database) return
  const expectedVersion = version ?? await getProblemCacheVersion(problemId)
  await new Promise<void>((resolve, reject) => {
    const transaction = database.transaction([PROBLEM_STORE, META_STORE], 'readwrite')
    const store = transaction.objectStore(PROBLEM_STORE)
    guardCacheVersion(transaction, problemVersionKey(problemId), expectedVersion, () => {
      const request = store.get(problemId)
      request.onsuccess = () => {
        if (isProblemInvalidated(problemId) || !pageVersionMatches(problemId, expectedVersion)) return
        const current = request.result as OfflineProblem | undefined
        if (current) store.put({ ...current, ...updater(current) })
      }
    })
    transaction.oncomplete = () => resolve()
    transaction.onerror = () => reject(transaction.error ?? new Error('IndexedDB 写入失败'))
    transaction.onabort = () => reject(transaction.error ?? new Error('IndexedDB 事务已中止'))
  })
}

export async function readQueueSnapshot<T>(key: string): Promise<OfflineQueueSnapshot<T> | null> {
  const database = await openDatabase()
  if (!database) return null
  const transaction = database.transaction(QUEUE_STORE, 'readonly')
  const value = await requestResult(transaction.objectStore(QUEUE_STORE).get(key))
  return (value as OfflineQueueSnapshot<T> | undefined) ?? null
}

export async function writeQueueSnapshot<T>(key: string, data: T): Promise<void> {
  const database = await openDatabase()
  if (!database) return
  const transaction = database.transaction(QUEUE_STORE, 'readwrite')
  transaction.objectStore(QUEUE_STORE).put({ savedAt: Date.now(), data }, key)
  await transactionDone(transaction)
}

export async function clearOfflineData(): Promise<void> {
  const database = await openDatabase()
  if (!database) return
  const pageEpoch = bumpPageEpoch()
  const transaction = database.transaction([META_STORE, PROBLEM_STORE, QUEUE_STORE], 'readwrite')
  const meta = transaction.objectStore(META_STORE)
  const epoch = meta.get(CACHE_EPOCH_KEY)
  const packVersion = meta.get(PACK_VERSION_KEY)
  const clearedVersion: CacheVersion = { epoch: 0, version: 0, readable: true, pageEpoch: pageEpoch.value, pageReadable: pageEpoch.readable }
  epoch.onsuccess = () => {
    clearedVersion.epoch = (typeof epoch.result === 'number' ? epoch.result : 0) + 1
    meta.put(clearedVersion.epoch, CACHE_EPOCH_KEY)
  }
  packVersion.onsuccess = () => {
    clearedVersion.version = (typeof packVersion.result === 'number' ? packVersion.result : 0) + 1
    meta.put(clearedVersion.version, PACK_VERSION_KEY)
  }
  meta.delete(PACK_KEY)
  transaction.objectStore(PROBLEM_STORE).clear()
  const queues = transaction.objectStore(QUEUE_STORE)
  const keys = queues.getAllKeys()
  keys.onsuccess = () => {
    // 待补记的查看答案记录属于用户留痕，清除缓存时必须保留。
    for (const key of keys.result) {
      if (key !== PENDING_ANSWER_VIEW_KEY) queues.delete(key)
    }
  }
  await transactionDone(transaction)
  rememberPackRevision(clearedVersion)
  notifyPageChange('cache-cleared', undefined, clearedVersion)
  broadcastCacheEvent('cache-cleared', undefined, clearedVersion)
}

export async function searchOfflineProblems(keyword: string): Promise<OfflineSearchItem[]> {
  const trimmed = keyword.trim().toLowerCase()
  if (!trimmed) return []
  const problems = await readAllProblems()
  return problems
    .filter((problem) => (
      problem.title.toLowerCase().includes(trimmed)
      || String(problem.leetcodeNumber).includes(trimmed)
    ))
    .sort((left, right) => (
      (left.hot100Order ?? Number.MAX_SAFE_INTEGER) - (right.hot100Order ?? Number.MAX_SAFE_INTEGER)
      || left.leetcodeNumber - right.leetcodeNumber
    ))
    .slice(0, 8)
    .map((problem) => ({
      problemId: problem.problemId,
      leetcodeNumber: problem.leetcodeNumber,
      title: problem.title,
      hot100Order: problem.hot100Order,
    }))
}

export async function storageEstimate(): Promise<{ usage: number; quota: number } | null> {
  if (typeof navigator === 'undefined' || !navigator.storage?.estimate) return null
  try {
    const estimate = await navigator.storage.estimate()
    return { usage: estimate.usage ?? 0, quota: estimate.quota ?? 0 }
  } catch {
    return null
  }
}

export async function storagePersisted(): Promise<boolean | null> {
  if (typeof navigator === 'undefined' || !navigator.storage?.persisted) return null
  try {
    return await navigator.storage.persisted()
  } catch {
    return null
  }
}

export async function requestStoragePersistence(): Promise<boolean | null> {
  if (typeof navigator === 'undefined' || !navigator.storage?.persist) return null
  try {
    return await navigator.storage.persist()
  } catch {
    return null
  }
}
