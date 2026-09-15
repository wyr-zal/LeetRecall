import { createPinia, setActivePinia } from 'pinia'
import { reviewApi } from '@/api/review'
import { useQuickReviewStore } from '@/stores/quickReview'
import { ACTIVE_PROBLEM_KEY } from '@/utils/problemSelection'
import type { ReviewProblemDetail, TodayReviewQueue } from '@/types/problem'

const queue: TodayReviewQueue = {
  total: 2,
  completed: 0,
  items: [
    { problemId: 1, leetcodeNumber: 1, title: '两数之和', difficulty: 'EASY', tags: ['哈希表'], masteryLevel: 'NEW', completed: false },
    { problemId: 8, leetcodeNumber: 236, title: '二叉树的最近公共祖先', difficulty: 'MEDIUM', tags: ['递归'], masteryLevel: 'NEW', completed: false },
  ],
}

function detail(problemId: number): ReviewProblemDetail {
  return {
    problemId,
    leetcodeNumber: problemId === 1 ? 1 : 236,
    title: problemId === 1 ? '两数之和' : '二叉树的最近公共祖先',
    difficulty: 'MEDIUM',
    descriptionMarkdown: '给定题目描述。',
    tags: ['递归'],
    recallQuestions: [{ id: problemId * 10, question: '使用什么方法？' }],
    hint: '先回忆', coreIdea: '核心思路', mistakes: ['边界'], keyCode: 'return root;',
  }
}

describe('quickReviewStore', () => {
  beforeEach(() => {
    localStorage.clear()
    sessionStorage.clear()
    setActivePinia(createPinia())
    vi.spyOn(reviewApi, 'getTodayQueue').mockResolvedValue(structuredClone(queue))
    vi.spyOn(reviewApi, 'getProblemDetail').mockImplementation(async (id) => detail(id))
    vi.spyOn(reviewApi, 'submit').mockResolvedValue({ nextReviewAt: '2026-07-24T20:00:00', nextIntervalDays: 1 })
  })

  afterEach(() => vi.restoreAllMocks())

  it('toggles hint and answer explicitly', () => {
    const store = useQuickReviewStore()
    store.toggleHint()
    store.toggleAnswer()
    expect(store.hintVisible).toBe(true)
    expect(store.answerVisible).toBe(true)
  })

  it('submits mastery and advances to the next pending problem', async () => {
    const store = useQuickReviewStore()
    await store.loadQueue()
    store.updateDraft(10, '哈希表')
    await store.submit('FORGOT')

    expect(reviewApi.submit).toHaveBeenCalledWith(1, expect.objectContaining({ result: 'FORGOT' }))
    expect(store.todayQueue[0]?.completed).toBe(true)
    expect(store.currentProblemId).toBe(8)
  })

  it('restores recall drafts after creating a fresh Pinia session', () => {
    const first = useQuickReviewStore()
    first.currentProblemId = 1
    first.updateDraft(10, '哈希表')

    setActivePinia(createPinia())
    const restored = useQuickReviewStore()
    restored.currentProblemId = 1
    expect(restored.currentDraft[10]).toBe('哈希表')
  })

  it('publishes the selected problem for the other study mode', async () => {
    const store = useQuickReviewStore()
    await store.loadQueue()
    await store.openProblem(8)

    expect(JSON.parse(localStorage.getItem(ACTIVE_PROBLEM_KEY) ?? 'null')).toBe(8)
  })

  // 导入覆盖当前题后切回页面，题号不变也必须重拉详情，不再要求 F5。
  it('refetches the current problem detail on queue refresh and keeps panel visibility', async () => {
    const store = useQuickReviewStore()
    await store.loadQueue()
    store.toggleHint()
    store.toggleAnswer()
    expect(reviewApi.getProblemDetail).toHaveBeenCalledTimes(1)

    await store.refreshQueue()

    expect(reviewApi.getProblemDetail).toHaveBeenCalledTimes(2)
    expect(store.currentProblemId).toBe(1)
    expect(store.hintVisible).toBe(true)
    expect(store.answerVisible).toBe(true)
  })

  it('resets the panels when queue refresh lands on a different problem', async () => {
    const store = useQuickReviewStore()
    await store.loadQueue()
    store.toggleHint()
    store.toggleAnswer()
    localStorage.setItem(ACTIVE_PROBLEM_KEY, JSON.stringify(8))

    await store.refreshQueue()

    expect(store.currentProblemId).toBe(8)
    expect(store.hintVisible).toBe(false)
    expect(store.answerVisible).toBe(false)
  })
})
