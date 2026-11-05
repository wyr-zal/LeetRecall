import 'fake-indexeddb/auto'
import { createPinia, setActivePinia } from 'pinia'
import { problemContentApi } from '@/api/problemContent'
import { reviewApi } from '@/api/review'
import { clearOfflineData, replacePack } from '@/offline/db'
import { markNetworkFailure, markNetworkSuccess } from '@/offline/network'
import { cacheReviewQueue } from '@/offline/repo'
import { useQuickReviewStore } from '@/stores/quickReview'
import { createMeta, createPack, createProblem } from '@/tests/offlineFixtures'

describe('quickReviewStore offline fallback', () => {
  beforeEach(async () => {
    localStorage.clear()
    sessionStorage.clear()
    setActivePinia(createPinia())
    markNetworkSuccess()
    await clearOfflineData()
    await replacePack(createPack([createProblem(1, '两数之和')]), createMeta(1))
    vi.spyOn(reviewApi, 'getProblemDetail').mockRejectedValue(new TypeError('Failed to fetch'))
    vi.spyOn(reviewApi, 'getTodayQueue').mockRejectedValue(new TypeError('Failed to fetch'))
    vi.spyOn(reviewApi, 'submit').mockResolvedValue({ nextReviewAt: '2026-11-06T00:00:00', nextIntervalDays: 1 })
    vi.spyOn(problemContentApi, 'get').mockRejectedValue(new TypeError('Failed to fetch'))
  })

  afterEach(() => vi.restoreAllMocks())

  it('详情请求失败时回退到本地快照', async () => {
    const store = useQuickReviewStore()

    expect(await store.loadProblem(1)).toBe(true)

    expect(store.detailFromCache).toBe(true)
    expect(store.currentProblem?.title).toBe('两数之和')
    expect(store.error).toBe('')
  })

  it('队列请求失败时使用上次缓存的队列进入当前题', async () => {
    await cacheReviewQueue({
      total: 1,
      completed: 0,
      items: [{
        problemId: 1,
        leetcodeNumber: 1,
        title: '两数之和',
        difficulty: 'EASY',
        tags: ['哈希表'],
        masteryLevel: 'NEW',
        completed: false,
      }],
    })
    const store = useQuickReviewStore()

    await store.loadQueue()

    expect(store.todayQueue).toHaveLength(1)
    expect(store.currentProblemId).toBe(1)
    expect(store.currentProblem?.title).toBe('两数之和')
  })

  it('离线时禁止提交评分', async () => {
    const store = useQuickReviewStore()
    await store.loadProblem(1)
    markNetworkFailure()

    expect(await store.submit('KNOWN')).toBeNull()
    expect(reviewApi.submit).not.toHaveBeenCalled()
    expect(store.error).toContain('离线')
  })

  it('离线时禁止进入题目编辑', async () => {
    const store = useQuickReviewStore()
    await store.loadProblem(1)
    markNetworkFailure()

    await store.enterEdit()

    expect(store.editing).toBe(false)
    expect(store.editError).toContain('离线')
    expect(problemContentApi.get).not.toHaveBeenCalled()
  })
})
