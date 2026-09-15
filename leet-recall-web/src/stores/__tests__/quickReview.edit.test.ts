import { createPinia, setActivePinia } from 'pinia'
import { problemContentApi } from '@/api/problemContent'
import { reviewApi } from '@/api/review'
import { useQuickReviewStore } from '@/stores/quickReview'
import type { ProblemContent, ReviewProblemDetail, TodayReviewQueue } from '@/types/problem'

const queue: TodayReviewQueue = {
  total: 1,
  completed: 0,
  items: [
    {
      problemId: 1,
      leetcodeNumber: 347,
      title: '前 K 个高频元素',
      difficulty: 'MEDIUM',
      tags: ['数组'],
      masteryLevel: 'NEW',
      completed: false,
    },
  ],
}

// 复习详情接口只返回前 4 个标签，这里刻意只给 4 个，用来验证编辑表单不会用它初始化。
const truncatedDetail: ReviewProblemDetail = {
  problemId: 1,
  leetcodeNumber: 347,
  title: '前 K 个高频元素',
  difficulty: 'MEDIUM',
  descriptionMarkdown: '题面',
  tags: ['数组', '哈希表', '桶排序', '堆'],
  recallQuestions: [{ id: 11, question: 'cnt 表示什么？', answer: '计数' }],
  hint: '提示',
  coreIdea: '核心思路',
  mistakes: ['边界'],
  keyCode: 'return result;',
}

const fullContent: ProblemContent = {
  problemId: 1,
  leetcodeNumber: 347,
  title: '前 K 个高频元素',
  difficulty: 'MEDIUM',
  descriptionMarkdown: '题面',
  tags: ['数组', '哈希表', '桶排序', '堆', '计数', '排序'],
  recallQuestions: [{ id: 11, question: 'cnt 表示什么？', answer: '计数' }],
  hint: '提示',
  coreIdea: '核心思路',
  mistakes: ['边界'],
  keyCode: 'return result;',
}

describe('quickReviewStore 编辑模式', () => {
  beforeEach(() => {
    localStorage.clear()
    sessionStorage.clear()
    setActivePinia(createPinia())
    vi.spyOn(reviewApi, 'getTodayQueue').mockResolvedValue(structuredClone(queue))
    vi.spyOn(reviewApi, 'getProblemDetail').mockResolvedValue(structuredClone(truncatedDetail))
    vi.spyOn(reviewApi, 'submit').mockResolvedValue({
      nextReviewAt: '2026-08-22T09:00:00',
      nextIntervalDays: 3,
    })
    vi.spyOn(problemContentApi, 'get').mockResolvedValue(structuredClone(fullContent))
    vi.spyOn(problemContentApi, 'save').mockResolvedValue(structuredClone(fullContent))
  })

  afterEach(() => vi.restoreAllMocks())

  it('通过 /content 接口拉取全部标签，而不是复用被截断的复习详情', async () => {
    const store = useQuickReviewStore()
    await store.loadQueue()
    await store.enterEdit()

    expect(problemContentApi.get).toHaveBeenCalledWith(1)
    expect(store.currentProblem?.tags).toHaveLength(4)
    expect(store.editContent?.tags).toEqual(['数组', '哈希表', '桶排序', '堆', '计数', '排序'])
  })

  it('取消编辑不会发起保存请求', async () => {
    const store = useQuickReviewStore()
    await store.loadQueue()
    await store.enterEdit()
    store.cancelEdit()

    expect(store.editing).toBe(false)
    expect(store.editContent).toBeNull()
    expect(problemContentApi.save).not.toHaveBeenCalled()
  })

  it('保存成功后退出编辑态并刷新题目详情', async () => {
    const store = useQuickReviewStore()
    await store.loadQueue()
    await store.enterEdit()
    const detailCallsBeforeSave = vi.mocked(reviewApi.getProblemDetail).mock.calls.length

    const saved = await store.saveEdit({
      title: '前 K 个高频元素',
      difficulty: 'MEDIUM',
      descriptionMarkdown: '题面',
      tags: ['数组'],
      recallQuestions: [{ id: 11, question: 'cnt 表示什么？', answer: '计数' }],
      hint: '提示',
      coreIdea: '核心思路',
      mistakes: ['边界'],
      keyCode: 'return result;',
    })

    expect(saved).toBe(true)
    expect(store.editing).toBe(false)
    expect(vi.mocked(reviewApi.getProblemDetail).mock.calls.length)
      .toBeGreaterThan(detailCallsBeforeSave)
  })

  it('保存失败时留在编辑态并给出错误信息', async () => {
    vi.mocked(problemContentApi.save).mockRejectedValueOnce(new Error('descriptionMarkdown 第 2 行：代码围栏 ``` 未闭合'))
    const store = useQuickReviewStore()
    await store.loadQueue()
    await store.enterEdit()

    const saved = await store.saveEdit({
      title: '前 K 个高频元素',
      difficulty: 'MEDIUM',
      descriptionMarkdown: '```java\nint a = 1;\n',
      tags: [],
      recallQuestions: [{ id: 11, question: 'cnt 表示什么？', answer: '计数' }],
      hint: '提示',
      coreIdea: '核心思路',
      mistakes: [],
      keyCode: 'return result;',
    })

    expect(saved).toBe(false)
    expect(store.editing).toBe(true)
    expect(store.editError).toContain('代码围栏')
  })

  it('编辑态下切题和提交复习结果全部不生效', async () => {
    const store = useQuickReviewStore()
    await store.loadQueue()
    await store.enterEdit()

    await store.move(1)
    const result = await store.submit('KNOWN')

    expect(result).toBeNull()
    expect(reviewApi.submit).not.toHaveBeenCalled()
    expect(store.currentProblemId).toBe(1)
  })
})
