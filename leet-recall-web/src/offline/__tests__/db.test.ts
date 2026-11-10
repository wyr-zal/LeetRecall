import 'fake-indexeddb/auto'
import {
  OFFLINE_PROBLEM_CACHE_CHANGED_EVENT,
  PENDING_ANSWER_VIEW_KEY,
  cacheImportedProblem,
  clearOfflineData,
  getPackCacheVersion,
  getProblemCacheVersion,
  hasExpiredProblemCache,
  invalidateProblem,
  isProblemCacheVersionCurrent,
  readAllProblems,
  readMeta,
  readProblem,
  readQueueSnapshot,
  replacePack,
  searchOfflineProblems,
  updateProblem,
  writeMeta,
  writeQueueSnapshot,
} from '@/offline/db'
import { createMeta, createPack, createProblem } from '@/tests/offlineFixtures'

describe('offline db', () => {
  beforeEach(async () => {
    await clearOfflineData()
  })

  it('写入资料包时同步保存题目与元数据', async () => {
    await replacePack(
      createPack([createProblem(1, '两数之和'), createProblem(2, '两数相加')]),
      createMeta(2),
    )

    expect((await readAllProblems()).map((problem) => problem.problemId).sort()).toEqual([1, 2])
    expect((await readMeta())?.problemCount).toBe(2)
  })

  it('整包替换而不是合并，旧题目不会残留', async () => {
    await replacePack(createPack([createProblem(1, '两数之和')]), createMeta(1))
    await replacePack(createPack([createProblem(3, '无重复字符的最长子串')]), createMeta(1, '"pack-v2"'))

    expect((await readAllProblems()).map((problem) => problem.problemId)).toEqual([3])
    expect(await readProblem(1)).toBeNull()
    expect((await readMeta())?.etag).toBe('"pack-v2"')
  })

  it('清除离线资料时保留待补记的答案查看记录', async () => {
    await replacePack(createPack([createProblem(1, '两数之和')]), createMeta(1))
    await writeQueueSnapshot(PENDING_ANSWER_VIEW_KEY, [1])

    await clearOfflineData()

    expect(await readAllProblems()).toEqual([])
    expect(await readMeta()).toBeNull()
    expect((await readQueueSnapshot<number[]>(PENDING_ANSWER_VIEW_KEY))?.data).toEqual([1])
  })

  it('不为不在资料包中的题目写入局部记录', async () => {
    await updateProblem(999, () => ({ title: '不应写入' }))

    expect(await readProblem(999)).toBeNull()
  })

  it('只删除导入题，并更新实际计数和 ETag，保留其他题及待补记留痕', async () => {
    const other = { ...createProblem(2, '其他题'), noteMarkdown: '已有笔记', fullCode: '已有代码' }
    await replacePack(createPack([createProblem(1, '导入题'), other]), createMeta(2))
    await writeQueueSnapshot(PENDING_ANSWER_VIEW_KEY, [1, 2])
    await writeQueueSnapshot('dictation-history:1', ['历史'])

    await invalidateProblem(1)

    expect(await readProblem(1)).toBeNull()
    expect(await readProblem(2)).toEqual(other)
    expect(await readMeta()).toMatchObject({ problemCount: 1, etag: '', lastCheckedAt: 0 })
    expect((await readQueueSnapshot(PENDING_ANSWER_VIEW_KEY))?.data).toEqual([1, 2])
    expect((await readQueueSnapshot('dictation-history:1'))?.data).toEqual(['历史'])
    await updateProblem(1, () => ({ coreIdea: '局部详情不能补回完整题目' }))
    expect(await readProblem(1)).toBeNull()
  })

  it('补回完整资料后恢复计数，导入前的局部响应不能覆盖新内容', async () => {
    await replacePack(createPack([createProblem(1, '导入题'), createProblem(2, '其他题')]), createMeta(2))
    const oldVersion = await getProblemCacheVersion(1)
    await invalidateProblem(1)
    const fresh = { ...createProblem(1, '导入题'), coreIdea: '新思路', fullCode: '新代码', dictationAnswers: { a: '新答案' }, noteMarkdown: '笔记' }

    expect(await cacheImportedProblem(fresh, await getProblemCacheVersion(1))).toBe(true)
    await updateProblem(1, () => ({ coreIdea: '旧思路', fullCode: '旧代码' }), oldVersion)

    expect(await readProblem(1)).toEqual(fresh)
    expect((await readMeta())?.problemCount).toBe(2)
    expect((await readMeta())?.packBytes).toBeGreaterThan(0)
  })

  it('题目缓存过期后仍可离线兜底，补回单题不会续期其它题', async () => {
    const first = createProblem(1, '第一题')
    const second = createProblem(2, '第二题')
    await replacePack(createPack([first, second]), createMeta(2))
    const meta = await readMeta()
    const now = Date.now()
    const expiredAt = now - 24 * 60 * 60 * 1000
    await writeMeta({
      ...meta!,
      problemCacheTimes: { '1': now, '2': expiredAt },
    })

    const refreshed = { ...first, coreIdea: '刚刚更新的思路' }
    expect(await cacheImportedProblem(refreshed, await getProblemCacheVersion(1))).toBe(true)

    expect(await hasExpiredProblemCache()).toBe(true)
    expect(await readProblem(1)).toEqual(refreshed)
    expect(await readProblem(2)).toEqual(second)
    expect((await readAllProblems()).map((problem) => problem.problemId)).toEqual([1, 2])
    expect((await readMeta())?.problemCacheTimes?.['2']).toBe(expiredAt)
  })

  it('没有缓存时间的旧版题目保留离线可读并要求联网刷新', async () => {
    const oldProblem = createProblem(1, '旧缓存')
    await replacePack(createPack([oldProblem]), createMeta(1))
    const meta = await readMeta()
    await writeMeta({ ...meta!, problemCacheTimes: undefined })

    expect(await hasExpiredProblemCache()).toBe(true)
    expect(await readProblem(1)).toEqual(oldProblem)
    expect(await readAllProblems()).toEqual([oldProblem])
  })

  it('导入前开始的整包响应不能重新写回旧题目', async () => {
    const oldPack = createPack([createProblem(1, '旧题目')])
    await replacePack(oldPack, createMeta(1))
    const version = await getPackCacheVersion()
    await invalidateProblem(1)

    expect(await replacePack(oldPack, createMeta(1), version)).toBe(false)
    expect(await readProblem(1)).toBeNull()
    expect((await readMeta())?.etag).toBe('')
  })

  it('失效后的新在线请求版本有效，但题目缓存仍不可读', async () => {
    await replacePack(createPack([createProblem(1, '旧题目')]), createMeta(1))
    const oldVersion = await getProblemCacheVersion(1)
    await invalidateProblem(1)
    const newVersion = await getProblemCacheVersion(1)

    expect(await isProblemCacheVersionCurrent(1, oldVersion)).toBe(false)
    expect(await isProblemCacheVersionCurrent(1, newVersion)).toBe(true)
    expect(await readProblem(1)).toBeNull()
  })

  it('整包替换提升 epoch，旧详情不会修改新包内容', async () => {
    await replacePack(createPack([createProblem(1, '旧题目')]), createMeta(1))
    const oldVersion = await getProblemCacheVersion(1)
    await replacePack(createPack([createProblem(1, '新题目')]), createMeta(1, '"new-pack"'))

    await updateProblem(1, () => ({ title: '迟到的旧详情' }), oldVersion)

    expect((await readProblem(1))?.title).toBe('新题目')
  })

  it('另一个标签页失效后，旧标签页持有的版本无法覆盖共享数据库', async () => {
    const firstTab = await import('@/offline/db')
    const oldProblem = createProblem(1, '旧题目')
    const oldPack = createPack([oldProblem])
    await firstTab.replacePack(oldPack, createMeta(1))
    const oldProblemVersion = await firstTab.getProblemCacheVersion(1)
    const oldPackVersion = await firstTab.getPackCacheVersion()
    const channelDescriptor = Object.getOwnPropertyDescriptor(window, 'BroadcastChannel')
    Object.defineProperty(window, 'BroadcastChannel', { configurable: true, value: undefined })
    try {
      await vi.resetModules()
      const secondTab = await import('@/offline/db')
      await secondTab.invalidateProblem(1)
      const fresh = { ...oldProblem, title: '导入后的新题目' }
      expect(await secondTab.cacheImportedProblem(fresh, await secondTab.getProblemCacheVersion(1))).toBe(true)

      localStorage.setItem('leet-recall:offline-cache:problem:1', JSON.stringify({
        token: oldProblemVersion.pageProblemToken,
        invalidated: false,
        epoch: oldProblemVersion.pageEpoch,
      }))
      await firstTab.updateProblem(1, () => ({ title: '迟到的旧详情' }), oldProblemVersion)
      expect(await firstTab.replacePack(oldPack, createMeta(1), oldPackVersion)).toBe(false)
      expect(await secondTab.readProblem(1)).toEqual(fresh)
    } finally {
      if (channelDescriptor) Object.defineProperty(window, 'BroadcastChannel', channelDescriptor)
      else Reflect.deleteProperty(window, 'BroadcastChannel')
    }
  })

  it('通过跨标签页通知失效、恢复、整包替换和清库状态', async () => {
    class ControlledBroadcastChannel {
      static instances = new Set<ControlledBroadcastChannel>()
      private readonly listeners = new Set<(event: MessageEvent) => void>()

      constructor(readonly name: string) {
        ControlledBroadcastChannel.instances.add(this)
      }

      addEventListener(type: string, listener: (event: MessageEvent) => void): void {
        if (type === 'message') this.listeners.add(listener)
      }

      postMessage(data: unknown): void {
        for (const target of ControlledBroadcastChannel.instances) {
          if (target === this || target.name !== this.name) continue
          queueMicrotask(() => {
            const event = new MessageEvent('message', { data })
            for (const listener of target.listeners) listener(event)
          })
        }
      }

      close(): void {
        ControlledBroadcastChannel.instances.delete(this)
        this.listeners.clear()
      }
    }

    const channelDescriptor = Object.getOwnPropertyDescriptor(window, 'BroadcastChannel')
    Object.defineProperty(window, 'BroadcastChannel', {
      configurable: true,
      value: ControlledBroadcastChannel as unknown as typeof BroadcastChannel,
    })
    const changes: Array<{ problemId?: number; all?: boolean; phase?: string; pageEpoch?: string; pageProblemToken?: string }> = []
    const handleChange = (event: Event) => {
      changes.push((event as CustomEvent<{ problemId?: number; all?: boolean; phase?: string; pageEpoch?: string; pageProblemToken?: string }>).detail)
    }
    window.addEventListener(OFFLINE_PROBLEM_CACHE_CHANGED_EVENT, handleChange)
    try {
      await vi.resetModules()
      const firstTab = await import('@/offline/db')
      await vi.resetModules()
      const secondTab = await import('@/offline/db')
      const stalePack = createPack([createProblem(1, '旧题目')])
      const freshProblem = createProblem(1, '导入后的新题目')
      await firstTab.replacePack(stalePack, createMeta(1))

      await firstTab.invalidateProblem(1)
      await vi.waitFor(() => expect(changes.some((change) => change.problemId === 1 && change.phase === 'committed')).toBe(true))
      expect(await secondTab.readProblem(1)).toBeNull()
      const staleInvalidation = await firstTab.getProblemCacheVersion(1)

      expect(await firstTab.cacheImportedProblem(freshProblem, staleInvalidation)).toBe(true)
      await vi.waitFor(async () => expect(await secondTab.readProblem(1)).toEqual(freshProblem))
      await vi.waitFor(() => expect(changes.some((change) => change.problemId === 1 && change.phase === 'restored')).toBe(true))
      const senderChannel = [...ControlledBroadcastChannel.instances][0]
      senderChannel?.postMessage({ type: 'problem-invalidated', problemId: 1, version: staleInvalidation })
      await new Promise((resolve) => setTimeout(resolve, 10))
      expect(await secondTab.readProblem(1)).toEqual(freshProblem)

      changes.length = 0
      await firstTab.invalidateProblem(1)
      await vi.waitFor(() => expect(changes.some((change) => change.problemId === 1 && change.phase === 'committed')).toBe(true))
      await firstTab.replacePack(createPack([freshProblem]), createMeta(1), await firstTab.getPackCacheVersion())
      await vi.waitFor(() => expect(changes.some((change) => change.all && change.phase === 'committed')).toBe(true))
      expect(await secondTab.readProblem(1)).toEqual(freshProblem)

      const originalSetItem = Storage.prototype.setItem
      const pageKey = 'leet-recall:offline-cache:problem:1'
      const failPageWrites = vi.spyOn(Storage.prototype, 'setItem').mockImplementation(function (this: Storage, key: string, value: string) {
        if (key === pageKey) throw new DOMException('存储空间不足', 'QuotaExceededError')
        return originalSetItem.call(this, key, value)
      })
      try {
        changes.length = 0
        await firstTab.invalidateProblem(1)
        const newerProblem = createProblem(1, '页面代次写入失败后的新题目')
        expect(await firstTab.cacheImportedProblem(newerProblem, await firstTab.getProblemCacheVersion(1))).toBe(true)
        await vi.waitFor(async () => expect(await secondTab.readProblem(1)).toEqual(newerProblem))
        await vi.waitFor(() => expect(changes.some((change) => change.problemId === 1 && change.phase === 'restored')).toBe(true))
      } finally {
        failPageWrites.mockRestore()
      }

      changes.length = 0
      await firstTab.invalidateProblem(1)
      await vi.waitFor(() => expect(changes.some((change) => change.problemId === 1 && change.phase === 'committed')).toBe(true))
      await firstTab.clearOfflineData()
      await vi.waitFor(() => expect(changes.some((change) => change.all && change.phase === 'committed')).toBe(true))
      expect(await secondTab.readMeta()).toBeNull()

      const request = indexedDB.open('leet-recall-offline', 1)
      const database = await new Promise<IDBDatabase>((resolve, reject) => {
        request.onsuccess = () => resolve(request.result)
        request.onerror = () => reject(request.error)
      })
      const transaction = database.transaction(['problems', 'meta'], 'readwrite')
      transaction.objectStore('problems').put(freshProblem)
      transaction.objectStore('meta').put({
        ...createMeta(1),
        problemCacheTimes: { '1': Date.now() },
      }, 'pack')
      await new Promise<void>((resolve, reject) => {
        transaction.oncomplete = () => resolve()
        transaction.onerror = () => reject(transaction.error)
        transaction.onabort = () => reject(transaction.error)
      })
      database.close()
      expect(await secondTab.readProblem(1)).toEqual(freshProblem)
    } finally {
      window.removeEventListener(OFFLINE_PROBLEM_CACHE_CHANGED_EVENT, handleChange)
      for (const channel of ControlledBroadcastChannel.instances) channel.close()
      if (channelDescriptor) Object.defineProperty(window, 'BroadcastChannel', channelDescriptor)
      else Reflect.deleteProperty(window, 'BroadcastChannel')
    }
  })

  it('BroadcastChannel 不可用时通过 storage 事件通知缓存变更', async () => {
    const channelDescriptor = Object.getOwnPropertyDescriptor(window, 'BroadcastChannel')
    Object.defineProperty(window, 'BroadcastChannel', { configurable: true, value: undefined })
    const changes: Array<{ problemId?: number; all?: boolean; phase?: string; pageEpoch?: string; pageProblemToken?: string }> = []
    const handleChange = (event: Event) => {
      changes.push((event as CustomEvent<{ problemId?: number; all?: boolean; phase?: string; pageEpoch?: string; pageProblemToken?: string }>).detail)
    }
    window.addEventListener(OFFLINE_PROBLEM_CACHE_CHANGED_EVENT, handleChange)
    try {
      await vi.resetModules()
      const tab = await import('@/offline/db')
      await tab.replacePack(createPack([createProblem(1, '导入题')]), createMeta(1))
      window.dispatchEvent(new StorageEvent('storage', {
        key: 'leet-recall:offline-cache:page-epoch',
        newValue: localStorage.getItem('leet-recall:offline-cache:page-epoch'),
      }))
      await vi.waitFor(() => expect(changes.some((change) => change.all && change.phase === 'invalidated')).toBe(true))
      window.dispatchEvent(new StorageEvent('storage', {
        key: 'leet-recall:offline-cache:page-notice',
        newValue: localStorage.getItem('leet-recall:offline-cache:page-notice'),
      }))
      await vi.waitFor(() => expect(changes.some((change) => change.all && change.phase === 'committed')).toBe(true))

      await tab.invalidateProblem(1)
      window.dispatchEvent(new StorageEvent('storage', {
        key: 'leet-recall:offline-cache:problem:1',
        newValue: localStorage.getItem('leet-recall:offline-cache:problem:1'),
      }))
      await vi.waitFor(() => expect(changes.some((change) => change.problemId === 1 && change.phase === 'invalidated')).toBe(true))
      window.dispatchEvent(new StorageEvent('storage', {
        key: 'leet-recall:offline-cache:problem-notice:1',
        newValue: localStorage.getItem('leet-recall:offline-cache:problem-notice:1'),
      }))
      await vi.waitFor(() => expect(changes.some((change) => change.problemId === 1 && change.phase === 'committed')).toBe(true))
      expect(await tab.readProblem(1)).toBeNull()
    } finally {
      window.removeEventListener(OFFLINE_PROBLEM_CACHE_CHANGED_EVENT, handleChange)
      if (channelDescriptor) Object.defineProperty(window, 'BroadcastChannel', channelDescriptor)
      else Reflect.deleteProperty(window, 'BroadcastChannel')
    }
  })

  it('清空缓存后，旧详情不能写入后来重新下载的题目', async () => {
    await replacePack(createPack([createProblem(1, '旧题目')]), createMeta(1))
    const oldVersion = await getProblemCacheVersion(1)
    await clearOfflineData()
    await replacePack(createPack([createProblem(1, '新题目')]), createMeta(1))

    await updateProblem(1, () => ({ title: '迟到的旧详情' }), oldVersion)

    expect((await readProblem(1))?.title).toBe('新题目')
  })

  it('读取版本失败时在线响应仍可用，但不写入未经校验的缓存', async () => {
    await replacePack(createPack([createProblem(1, '当前题目')]), createMeta(1))
    const failRead = vi.spyOn(IDBObjectStore.prototype, 'get').mockImplementationOnce(() => {
      throw new Error('IndexedDB 暂不可用')
    })

    const version = await getProblemCacheVersion(1)
    expect(version.readable).toBe(false)
    expect(await isProblemCacheVersionCurrent(1, version)).toBe(true)
    await updateProblem(1, () => ({ title: '未经校验的旧响应' }), version)

    failRead.mockRestore()
    expect((await readProblem(1))?.title).toBe('当前题目')
  })

  it('IndexedDB 版本读取失败时页面代次仍拒绝导入前响应', async () => {
    await replacePack(createPack([createProblem(1, '当前题目')]), createMeta(1))
    const oldRequestVersion = await getProblemCacheVersion(1)
    await invalidateProblem(1)
    const failRead = vi.spyOn(IDBObjectStore.prototype, 'get').mockImplementation(() => {
      throw new Error('IndexedDB 暂不可用')
    })

    try {
      expect(await isProblemCacheVersionCurrent(1, oldRequestVersion)).toBe(false)
      expect(failRead).not.toHaveBeenCalled()
    } finally {
      failRead.mockRestore()
    }
  })

  it('按标题或题号搜索，结果按 Hot100 顺序排列', async () => {
    await replacePack(
      createPack([
        createProblem(236, '二叉树的最近公共祖先'),
        createProblem(2, '两数相加'),
        createProblem(1, '两数之和'),
      ]),
      createMeta(3),
    )

    expect((await searchOfflineProblems('两数')).map((item) => item.problemId)).toEqual([1, 2])
    expect((await searchOfflineProblems('2')).map((item) => item.problemId)).toEqual([2, 236])
    expect(await searchOfflineProblems('   ')).toEqual([])
  })
})
