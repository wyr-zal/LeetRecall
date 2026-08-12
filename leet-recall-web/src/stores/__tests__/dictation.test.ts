import { createPinia, setActivePinia } from 'pinia'
import { dictationApi } from '@/api/dictation'
import { useDictationStore } from '@/stores/dictation'
import { ACTIVE_PROBLEM_KEY } from '@/utils/problemSelection'

describe('dictationStore', () => {
  beforeEach(() => {
    localStorage.clear()
    sessionStorage.clear()
    setActivePinia(createPinia())
    vi.spyOn(dictationApi, 'getTodayQueue').mockResolvedValue({
      total: 2, completed: 0,
      items: [
        { problemId: 1, leetcodeNumber: 1, title: '两数之和', completed: false },
        { problemId: 8, leetcodeNumber: 236, title: '二叉树的最近公共祖先', completed: false },
      ],
    })
    vi.spyOn(dictationApi, 'getProblemDetail').mockImplementation(async (problemId) => ({
      problemId,
      leetcodeNumber: problemId === 1 ? 1 : 236,
      title: problemId === 1 ? '两数之和' : '二叉树的最近公共祖先',
      tags: ['递归'], language: 'JAVA', templateCode: 'return {{blank_1}};',
      keywords: ['返回节点'], mistakes: ['返回错误'],
    }))
    vi.spyOn(dictationApi, 'getRecords').mockResolvedValue({ page: 1, pageSize: 2, total: 0, items: [] })
    vi.spyOn(dictationApi, 'submit').mockResolvedValue({
      correctCount: 1, totalCount: 1, accuracy: 100, viewedAnswer: false,
      resultItems: [{ blankKey: 'blank_1', submittedAnswer: 'root', correctAnswer: 'root', correct: true }],
    })
  })

  afterEach(() => vi.restoreAllMocks())

  it('submits current blank answers and stores the score', async () => {
    localStorage.setItem(ACTIVE_PROBLEM_KEY, JSON.stringify(8))
    const store = useDictationStore()
    await store.loadQueue()
    store.updateAnswers({ blank_1: 'root' })
    await store.submit()

    expect(dictationApi.submit).toHaveBeenCalledWith(
      8,
      expect.any(String),
      { blank_1: 'root' },
      false,
      expect.any(Number),
    )
    expect(store.submitResult?.accuracy).toBe(100)
    expect(store.todayQueue[1]?.completed).toBe(true)
  })

  it('opens the problem most recently selected in quick review', async () => {
    localStorage.setItem('leet-recall:dictation-current', JSON.stringify(8))
    localStorage.setItem(ACTIVE_PROBLEM_KEY, JSON.stringify(1))
    const store = useDictationStore()

    await store.loadQueue()

    expect(store.currentProblemId).toBe(1)
    expect(dictationApi.getProblemDetail).toHaveBeenCalledWith(1)
  })
})
