import 'fake-indexeddb/auto'
import { createPinia, setActivePinia } from 'pinia'
import { clearOfflineData, readAllProblems } from '@/offline/db'
import { markNetworkSuccess } from '@/offline/network'
import { useOfflineStore } from '@/stores/offline'
import { createPack, createProblem } from '@/tests/offlineFixtures'

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
})
