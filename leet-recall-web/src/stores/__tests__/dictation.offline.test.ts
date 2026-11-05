import 'fake-indexeddb/auto'
import { createPinia, setActivePinia } from 'pinia'
import { dictationApi } from '@/api/dictation'
import { clearOfflineData, replacePack } from '@/offline/db'
import { markNetworkFailure, markNetworkSuccess } from '@/offline/network'
import {
  addPendingAnswerView,
  cacheDictationQueue,
  clearPendingAnswerViews,
  readPendingAnswerViews,
} from '@/offline/repo'
import { useDictationStore } from '@/stores/dictation'
import { createMeta, createPack, createProblem } from '@/tests/offlineFixtures'
import { ACTIVE_PROBLEM_KEY } from '@/utils/problemSelection'

describe('dictationStore offline fallback', () => {
  beforeEach(async () => {
    localStorage.clear()
    sessionStorage.clear()
    setActivePinia(createPinia())
    markNetworkSuccess()
    await clearOfflineData()
    await clearPendingAnswerViews()
    await replacePack(
      createPack([{
        ...createProblem(1, '两数之和'),
        templateCode: 'return {{blank_1}};',
        dictationAnswers: { blank_1: 'root' },
        fullCode: 'class Solution { }',
      }]),
      createMeta(1),
    )
    localStorage.setItem(ACTIVE_PROBLEM_KEY, JSON.stringify(1))
    vi.spyOn(dictationApi, 'getTodayQueue').mockResolvedValue({
      total: 1,
      completed: 0,
      items: [{ problemId: 1, leetcodeNumber: 1, title: '两数之和', completed: false }],
    })
    vi.spyOn(dictationApi, 'getProblemDetail').mockRejectedValue(new TypeError('Failed to fetch'))
    vi.spyOn(dictationApi, 'getRecords').mockRejectedValue(new TypeError('Failed to fetch'))
    vi.spyOn(dictationApi, 'viewAnswer').mockRejectedValue(new TypeError('Failed to fetch'))
    vi.spyOn(dictationApi, 'submit').mockResolvedValue({
      correctCount: 0,
      totalCount: 0,
      accuracy: 0,
      viewedAnswer: false,
      resultItems: [],
    })
  })

  afterEach(() => vi.restoreAllMocks())

  it('详情请求失败时回退到本地快照', async () => {
    const store = useDictationStore()

    await store.loadQueue()

    expect(store.detailFromCache).toBe(true)
    expect(store.currentProblem?.title).toBe('两数之和')
    expect(store.error).toBe('')
  })

  it('队列请求失败时使用上次缓存的队列进入当前题', async () => {
    vi.spyOn(dictationApi, 'getTodayQueue').mockRejectedValue(new TypeError('Failed to fetch'))
    await cacheDictationQueue({
      total: 1,
      completed: 0,
      items: [{ problemId: 1, leetcodeNumber: 1, title: '两数之和', completed: false }],
    })
    const store = useDictationStore()

    await store.loadQueue()

    expect(store.currentProblemId).toBe(1)
    expect(store.currentProblem?.title).toBe('两数之和')
  })

  it('离线查看答案使用本地快照，并登记待补记留痕', async () => {
    const store = useDictationStore()
    await store.loadProblem(1)

    await store.setAnswerVisible(true)

    expect(store.answerVisible).toBe(true)
    expect(store.revealedAnswer?.fullCode).toBe('class Solution { }')
    expect(await readPendingAnswerViews()).toEqual([1])
  })

  it('离线时禁止提交默写', async () => {
    const store = useDictationStore()
    await store.loadProblem(1)
    markNetworkFailure()

    await store.submit()

    expect(dictationApi.submit).not.toHaveBeenCalled()
    expect(store.error).toContain('离线')
  })

  it('恢复联网后补记离线期间查看过的答案', async () => {
    await addPendingAnswerView(1)
    const view = vi.spyOn(dictationApi, 'viewAnswer').mockResolvedValue({
      answers: {},
      fullCode: 'class Solution { }',
    })
    const store = useDictationStore()

    await store.flushPendingAnswerViews()

    expect(view).toHaveBeenCalledWith(1, expect.any(String))
    expect(await readPendingAnswerViews()).toEqual([])
  })
})
