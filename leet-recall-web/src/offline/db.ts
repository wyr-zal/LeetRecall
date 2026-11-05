import type {
  OfflineMeta,
  OfflinePack,
  OfflineProblem,
  OfflineQueueSnapshot,
  OfflineSearchItem,
} from '@/types/offline'

const DB_NAME = 'leet-recall-offline'
const DB_VERSION = 1
const META_STORE = 'meta'
const PROBLEM_STORE = 'problems'
const QUEUE_STORE = 'queues'
const PACK_KEY = 'pack'
/** 离线查看答案的待补记列表；清除资料时保留，联网后补记到服务端留痕。 */
export const PENDING_ANSWER_VIEW_KEY = 'pending-answer-views'

let databasePromise: Promise<IDBDatabase | null> | null = null

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

export async function readProblem(problemId: number): Promise<OfflineProblem | null> {
  const database = await openDatabase()
  if (!database) return null
  const transaction = database.transaction(PROBLEM_STORE, 'readonly')
  const value = await requestResult(transaction.objectStore(PROBLEM_STORE).get(problemId))
  return (value as OfflineProblem | undefined) ?? null
}

export async function readAllProblems(): Promise<OfflineProblem[]> {
  const database = await openDatabase()
  if (!database) return []
  const transaction = database.transaction(PROBLEM_STORE, 'readonly')
  return requestResult(transaction.objectStore(PROBLEM_STORE).getAll()) as Promise<OfflineProblem[]>
}

/**
 * 整包替换：clear 与全部 put 在同一个事务内完成；任何一步失败都会回滚，
 * 旧资料保持可用，不会出现半新半旧的状态。
 */
export async function replacePack(pack: OfflinePack, meta: OfflineMeta): Promise<void> {
  const database = await openDatabase()
  if (!database) throw new Error('当前浏览器不支持 IndexedDB')
  const transaction = database.transaction([PROBLEM_STORE, META_STORE], 'readwrite')
  const problems = transaction.objectStore(PROBLEM_STORE)
  problems.clear()
  for (const problem of pack.problems) problems.put(problem)
  transaction.objectStore(META_STORE).put(meta, PACK_KEY)
  await transactionDone(transaction)
}

/**
 * 写回单题缓存。只在资料包已存在时更新，避免把只含局部字段的对象写进题库。
 * get 与 put 放在同一个事务回调里，避免 await 让事务提前失活。
 */
export async function updateProblem(
  problemId: number,
  updater: (current: OfflineProblem) => Partial<OfflineProblem>,
): Promise<void> {
  const database = await openDatabase()
  if (!database) return
  await new Promise<void>((resolve, reject) => {
    const transaction = database.transaction(PROBLEM_STORE, 'readwrite')
    const store = transaction.objectStore(PROBLEM_STORE)
    const request = store.get(problemId)
    request.onsuccess = () => {
      const current = request.result as OfflineProblem | undefined
      if (current) store.put({ ...current, ...updater(current) })
    }
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
  const transaction = database.transaction([META_STORE, PROBLEM_STORE, QUEUE_STORE], 'readwrite')
  transaction.objectStore(META_STORE).clear()
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