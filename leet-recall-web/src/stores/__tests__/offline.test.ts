import 'fake-indexeddb/auto'
import { createPinia, setActivePinia } from 'pinia'
import { OFFLINE_PROBLEM_CACHE_CHANGED_EVENT, clearOfflineData, invalidateProblem, readAllProblems, readMeta, readProblem, replacePack } from '@/offline/db'
import { readDictationAnswer, readDictationDetail, readNote, readReviewDetail } from '@/offline/repo'
import { markNetworkSuccess } from '@/offline/network'
import { useOfflineStore } from '@/stores/offline'
import { createMeta, createPack, createProblem } from '@/tests/offlineFixtures'

function packResponse(etag = '"pack-v1"'): Response {
  const body = { code: 0, message: 'ok', data: createPack([createProblem(1, '两数之和')]) }
  return new Response(JSON.stringify(body), {
    status: 200,
    headers: { 'Content-Type': 'application/json', ETag: etag },
  })
}

describe('offline store', () => {
  let fetchMock = vi.fn()

  beforeEach(async () => {
    setActivePinia(createPinia())
    localStorage.clear()
    markNetworkSuccess()
    await clearOfflineData()
    fetchMock = vi.fn()
    vi.stubGlobal('fetch', fetchMock)
  })

  afterEach(() => {
    vi.unstubAllGlobals()
  })

  it('首次同步写入资料包并记录 ETag', async () => {
    fetchMock.mockResolvedValueOnce(packResponse('"pack-v1"'))
    const store = useOfflineStore()

    await store.sync({ force: true })

    expect(store.hasPack).toBe(true)
    expect(store.problemCount).toBe(1)
    expect(store.meta?.etag).toBe('"pack-v1"')
    expect((await readAllProblems()).map((problem) => problem.title)).toEqual(['两数之和'])
    expect(store.error).toBe('')
  })

  it('带 If-None-Match 命中 304 时保留资料并刷新检查时间', async () => {
    fetchMock.mockResolvedValueOnce(packResponse())
    const store = useOfflineStore()
    await store.sync({ force: true })
    fetchMock.mockResolvedValueOnce(new Response(null, { status: 304 }))

    await store.sync({ force: true })

    expect(fetchMock.mock.calls[1]?.[1]?.headers).toEqual({ 'If-None-Match': '"pack-v1"' })
    expect(store.problemCount).toBe(1)
    expect(store.error).toBe('')
  })

  it('断网时保留旧资料并切换为离线状态', async () => {
    fetchMock.mockResolvedValueOnce(packResponse())
    const store = useOfflineStore()
    await store.sync({ force: true })
    fetchMock.mockRejectedValueOnce(new TypeError('Failed to fetch'))

    await store.sync({ force: true })

    expect(store.offline).toBe(true)
    expect(store.error).toContain('网络不可用')
    expect(await readAllProblems()).toHaveLength(1)
  })

  it('服务端 500 不切换离线状态，也不覆盖旧资料', async () => {
    fetchMock.mockResolvedValueOnce(packResponse())
    const store = useOfflineStore()
    await store.sync({ force: true })
    fetchMock.mockResolvedValueOnce(new Response('', { status: 500 }))

    await store.sync({ force: true })

    expect(store.offline).toBe(false)
    expect(store.error).toContain('HTTP 500')
    expect(await readAllProblems()).toHaveLength(1)
  })

  it('返回内容无法解析时保留旧资料', async () => {
    fetchMock.mockResolvedValueOnce(packResponse())
    const store = useOfflineStore()
    await store.sync({ force: true })
    fetchMock.mockResolvedValueOnce(new Response('<html>bad gateway</html>', { status: 200 }))

    await store.sync({ force: true })

    expect(store.offline).toBe(false)
    expect(store.error).not.toBe('')
    expect(await readAllProblems()).toHaveLength(1)
  })

  it('关闭自动更新后已有资料不再自动检查，首次下载仍会执行', async () => {
    const store = useOfflineStore()
    store.setAutoUpdate(false)
    fetchMock.mockResolvedValueOnce(packResponse())

    await store.sync({ automatic: true })
    expect(fetchMock).toHaveBeenCalledTimes(1)

    if (store.meta) store.meta = { ...store.meta, lastCheckedAt: 0 }
    await store.sync({ automatic: true })
    expect(fetchMock).toHaveBeenCalledTimes(1)
  })

  it('清除离线资料后题库与元数据都被移除', async () => {
    fetchMock.mockResolvedValueOnce(packResponse())
    const store = useOfflineStore()
    await store.sync({ force: true })

    await store.clear()

    expect(store.hasPack).toBe(false)
    expect(store.problemCount).toBe(0)
    expect(await readAllProblems()).toEqual([])
  })

  it('收到其他标签页的缓存变更通知后刷新离线包元数据', async () => {
    const idleDescriptor = Object.getOwnPropertyDescriptor(window, 'requestIdleCallback')
    Object.defineProperty(window, 'requestIdleCallback', { configurable: true, value: () => 0 })
    try {
      await replacePack(createPack([createProblem(1, '导入题'), createProblem(2, '其他题')]), createMeta(2))
      const store = useOfflineStore()
      await store.initialize()
      expect(store.problemCount).toBe(2)

      await invalidateProblem(1)
      window.dispatchEvent(new CustomEvent(OFFLINE_PROBLEM_CACHE_CHANGED_EVENT, { detail: { problemId: 1 } }))
      await vi.waitFor(() => expect(store.problemCount).toBe(1))
      expect(store.meta?.etag).toBe('')
    } finally {
      if (idleDescriptor) Object.defineProperty(window, 'requestIdleCallback', idleDescriptor)
      else Reflect.deleteProperty(window, 'requestIdleCallback')
    }
  })

  it('导入后删除旧缓存，关闭自动更新也补回该题完整资料，其他题不变', async () => {
    const other = { ...createProblem(2, '其他题'), coreIdea: '本地已有内容', noteMarkdown: '已有笔记' }
    await replacePack(createPack([createProblem(1, '导入题'), other]), createMeta(2))
    const fresh = { ...createProblem(1, '导入题'), coreIdea: '新思路', templateCode: '新模板', fullCode: '新代码', dictationAnswers: { blank: '新答案' }, noteMarkdown: '新笔记' }
    let respond!: (response: Response) => void
    fetchMock.mockReturnValueOnce(new Promise<Response>((resolve) => { respond = resolve }))
    const store = useOfflineStore()
    store.setAutoUpdate(false)
    const refreshing = store.refreshImportedProblem(1)
    await vi.waitFor(() => expect(fetchMock).toHaveBeenCalledTimes(1))
    expect(await readProblem(1)).toBeNull()
    expect(fetchMock.mock.calls[0]?.[1]?.headers).toBeUndefined()
    respond(new Response(JSON.stringify({ code: 0, data: createPack([fresh, createProblem(2, '远端其他题')]) }), { status: 200 }))
    await refreshing

    expect(await readProblem(1)).toEqual(fresh)
    expect(await readProblem(2)).toEqual(other)
    expect(await readReviewDetail(1)).toMatchObject({ coreIdea: '新思路' })
    expect(await readDictationDetail(1)).toMatchObject({ templateCode: '新模板' })
    expect(await readDictationAnswer(1)).toEqual({ fullCode: '新代码', answers: { blank: '新答案' } })
    expect(await readNote(1)).toMatchObject({ markdown: '新笔记' })
    expect(store.meta).toMatchObject({ problemCount: 2, etag: '' })
  })

  it('导入前正在下载的旧整包不能回写，随后重新下载并只补回导入题', async () => {
    const old = createProblem(1, '旧题目')
    const other = createProblem(2, '其他题')
    await replacePack(createPack([old, other]), createMeta(2))
    let respondOld!: (response: Response) => void
    fetchMock.mockReturnValueOnce(new Promise<Response>((resolve) => { respondOld = resolve }))
    fetchMock.mockResolvedValueOnce(new Response(JSON.stringify({ code: 0, data: createPack([{ ...old, fullCode: '新代码' }]) }), { status: 200 }))
    const store = useOfflineStore()
    store.meta = await readMeta()
    const oldDownload = store.sync({ force: true })
    const refreshing = store.refreshImportedProblem(1)
    await vi.waitFor(async () => expect(await readProblem(1)).toBeNull())
    respondOld(new Response(JSON.stringify({ code: 0, data: createPack([old]) }), { status: 200, headers: { ETag: '"old"' } }))
    await Promise.all([oldDownload, refreshing])

    expect((await readProblem(1))?.fullCode).toBe('新代码')
    expect(await readProblem(2)).toEqual(other)
    expect(store.meta).toMatchObject({ problemCount: 2, etag: '' })
    expect(fetchMock).toHaveBeenCalledTimes(2)
  })

  it('首次题包尚未保存时不创建只有单题的不完整题库', async () => {
    const store = useOfflineStore()

    await store.refreshImportedProblem(1)

    expect(fetchMock).not.toHaveBeenCalled()
    expect(store.hasPack).toBe(false)
    fetchMock.mockResolvedValueOnce(packResponse())
    await store.sync({ automatic: true })
    expect(store.hasPack).toBe(true)
  })

  it('首次整包下载与导入重叠时，丢弃旧包后仍完成完整题库下载', async () => {
    let respondOld!: (response: Response) => void
    fetchMock.mockReturnValueOnce(new Promise<Response>((resolve) => { respondOld = resolve }))
    const freshPack = createPack([createProblem(1, '新导入题'), createProblem(2, '其他题')])
    fetchMock.mockResolvedValueOnce(new Response(JSON.stringify({ code: 0, data: freshPack }), { status: 200 }))
    const store = useOfflineStore()
    const initialDownload = store.sync({ automatic: true })
    const refreshing = store.refreshImportedProblem(1)
    respondOld(packResponse())

    await Promise.all([initialDownload, refreshing])

    expect((await readProblem(1))?.title).toBe('新导入题')
    expect((await readProblem(2))?.title).toBe('其他题')
    expect(store.problemCount).toBe(2)
    expect(fetchMock).toHaveBeenCalledTimes(2)
  })

  it.each(['http-error', 'missing-problem', 'partial-problem', 'unexpected-304'])('补回失败 %s 不恢复已删除的旧内容，保留重试能力', async (failure) => {
    await replacePack(createPack([createProblem(1, '旧题'), createProblem(2, '其他题')]), createMeta(2))
    const store = useOfflineStore()
    const response = failure === 'http-error' ? new Response('', { status: 500 })
      : failure === 'unexpected-304' ? new Response(null, { status: 304 })
        : new Response(JSON.stringify({ code: 0, data: createPack([
          failure === 'missing-problem' ? createProblem(2, '其他题') : { problemId: 1 },
        ] as ReturnType<typeof createProblem>[]) }), { status: 200 })
    fetchMock.mockResolvedValueOnce(response)

    await expect(store.refreshImportedProblem(1)).rejects.toThrow()

    expect(store.error).toContain('该题离线资料暂不可用')
    expect(await readProblem(1)).toBeNull()
    expect((await readMeta())?.problemCount).toBe(1)
    expect(await readProblem(2)).not.toBeNull()
    fetchMock.mockResolvedValueOnce(packResponse())
    await store.refreshImportedProblem(1)
    expect(await readProblem(1)).not.toBeNull()
    expect(store.error).toBe('')
  })
})
