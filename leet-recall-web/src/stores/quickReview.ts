import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import { reviewApi } from '@/api/review'
import { problemContentApi } from '@/api/problemContent'
import { readActiveProblemId, writeActiveProblemId } from '@/utils/problemSelection'
import { readStorage, writeStorage } from '@/utils/storage'
import type {
  MasteryLevel,
  ProblemContent,
  ProblemContentUpdate,
  ReviewProblemDetail,
  ReviewQueueItem,
  ReviewSubmitResult,
} from '@/types/problem'

type ReviewDrafts = Record<number, Record<number, string>>

const CURRENT_KEY = 'leet-recall:review-current'
const DRAFTS_KEY = 'leet-recall:review-drafts'

export const useQuickReviewStore = defineStore('quick-review', () => {
  const todayQueue = ref<ReviewQueueItem[]>([])
  const currentProblemId = ref<number | null>(
    readActiveProblemId() ?? readStorage<number | null>(CURRENT_KEY, null),
  )
  const currentProblem = ref<ReviewProblemDetail | null>(null)
  const recallDrafts = ref<ReviewDrafts>(readStorage<ReviewDrafts>(DRAFTS_KEY, {}))
  const hintVisible = ref(false)
  const answerVisible = ref(false)
  const startTime = ref(Date.now())
  const loading = ref(false)
  const detailLoading = ref(false)
  const submitting = ref(false)
  const error = ref('')
  const saveState = ref<'idle' | 'saved'>('idle')

  const editing = ref(false)
  const editContent = ref<ProblemContent | null>(null)
  const editLoading = ref(false)
  const editSaving = ref(false)
  const editError = ref('')

  const completedCount = computed(() => todayQueue.value.filter((item) => item.completed).length)
  const currentIndex = computed(() => todayQueue.value.findIndex(
    (item) => item.problemId === currentProblemId.value,
  ))
  const currentDraft = computed(() => currentProblemId.value === null
    ? {}
    : recallDrafts.value[currentProblemId.value] ?? {})

  async function loadQueue(): Promise<void> {
    loading.value = true
    error.value = ''
    try {
      const queue = await reviewApi.getTodayQueue()
      todayQueue.value = queue.items
      const activeProblemId = readActiveProblemId()
      if (activeProblemId !== null && queue.items.some((item) => item.problemId === activeProblemId)) {
        currentProblemId.value = activeProblemId
      }
      const currentExists = queue.items.some((item) => item.problemId === currentProblemId.value)
      if (!currentExists) {
        currentProblemId.value = queue.items.find((item) => !item.completed)?.problemId
          ?? queue.items[0]?.problemId
          ?? null
      }
      persistCurrent()
      if (currentProblemId.value !== null) {
        await loadProblem(currentProblemId.value)
      } else {
        currentProblem.value = null
      }
    } catch (cause) {
      error.value = cause instanceof Error ? cause.message : '加载失败，请重试'
    } finally {
      loading.value = false
    }
  }

  async function refreshQueue(): Promise<void> {
    if (loading.value) return
    try {
      const queue = await reviewApi.getTodayQueue()
      todayQueue.value = queue.items
      const previousProblemId = currentProblemId.value
      const activeProblemId = readActiveProblemId()
      if (activeProblemId !== null && queue.items.some((item) => item.problemId === activeProblemId)) {
        currentProblemId.value = activeProblemId
      }
      const currentExists = queue.items.some((item) => item.problemId === currentProblemId.value)
      if (!currentExists) {
        currentProblemId.value = queue.items.find((item) => !item.completed)?.problemId
          ?? queue.items[0]?.problemId
          ?? null
      }
      persistCurrent()
      if (currentProblemId.value === null) {
        currentProblem.value = null
        return
      }
      // 同题也重拉：导入/编辑会覆盖当前题内容，切回页面必须直接拿到新数据，不再要求 F5。
      // 题号没变时保留面板展开状态与计时；换题走完整重置。
      await loadProblem(currentProblemId.value, {
        keepPanelState: currentProblemId.value === previousProblemId,
      })
    } catch (cause) {
      if (!currentProblem.value) error.value = cause instanceof Error ? cause.message : '加载失败，请重试'
    }
  }

  /** keepPanelState：同题重拉（切页回来）时保留提示/答案展开状态与计时，只换数据。 */
  async function loadProblem(problemId: number, options?: { keepPanelState?: boolean }): Promise<void> {
    detailLoading.value = true
    error.value = ''
    try {
      currentProblem.value = await reviewApi.getProblemDetail(problemId)
      currentProblemId.value = problemId
      if (!options?.keepPanelState) {
        hintVisible.value = false
        answerVisible.value = false
        startTime.value = Date.now()
      }
      persistCurrent()
    } catch (cause) {
      error.value = cause instanceof Error ? cause.message : '加载失败，请重试'
    } finally {
      detailLoading.value = false
    }
  }

  /**
   * 编辑表单必须走 /content 接口拉全量内容。
   * 复习详情接口只返回前 4 个标签，用 currentProblem 初始化表单会在保存时静默删除其余标签。
   */
  async function enterEdit(): Promise<void> {
    const problemId = currentProblemId.value
    if (problemId === null || editing.value) return
    editing.value = true
    editLoading.value = true
    editError.value = ''
    editContent.value = null
    try {
      editContent.value = await problemContentApi.get(problemId)
    } catch (cause) {
      editError.value = cause instanceof Error ? cause.message : '读取题目内容失败，请重试'
    } finally {
      editLoading.value = false
    }
  }

  function cancelEdit(): void {
    editing.value = false
    editContent.value = null
    editError.value = ''
    editLoading.value = false
  }

  async function saveEdit(payload: ProblemContentUpdate): Promise<boolean> {
    const problemId = currentProblemId.value
    if (problemId === null || editSaving.value) return false
    editSaving.value = true
    editError.value = ''
    try {
      await problemContentApi.save(problemId, payload)
      editing.value = false
      editContent.value = null
      await loadProblem(problemId)
      const queueItem = todayQueue.value.find((item) => item.problemId === problemId)
      if (queueItem && currentProblem.value) {
        queueItem.title = currentProblem.value.title
        queueItem.difficulty = currentProblem.value.difficulty
        queueItem.tags = currentProblem.value.tags
      }
      return true
    } catch (cause) {
      editError.value = cause instanceof Error ? cause.message : '保存失败，请重试'
      return false
    } finally {
      editSaving.value = false
    }
  }

  async function openProblem(problemId: number): Promise<void> {
    await loadProblem(problemId)
  }

  let saveStateTimer: ReturnType<typeof setTimeout> | undefined

  function updateDraft(questionId: number, answer: string): void {
    const problemId = currentProblemId.value
    if (problemId === null) return
    recallDrafts.value = {
      ...recallDrafts.value,
      [problemId]: {
        ...recallDrafts.value[problemId],
        [questionId]: answer,
      },
    }
    writeStorage(DRAFTS_KEY, recallDrafts.value)
    saveState.value = 'saved'
    if (saveStateTimer) clearTimeout(saveStateTimer)
    saveStateTimer = setTimeout(() => { saveState.value = 'idle' }, 2000)
  }

  function toggleHint(): void {
    hintVisible.value = !hintVisible.value
  }

  function toggleAnswer(): void {
    answerVisible.value = !answerVisible.value
  }

  async function submit(result: Exclude<MasteryLevel, 'NEW'>): Promise<ReviewSubmitResult | null> {
    const problem = currentProblem.value
    if (!problem || submitting.value || editing.value) return null
    submitting.value = true
    try {
      const response = await reviewApi.submit(problem.problemId, {
        result,
        recallAnswers: problem.recallQuestions.map((question) => ({
          questionId: question.id,
          answer: currentDraft.value[question.id] ?? '',
        })),
        usedHint: hintVisible.value,
        viewedAnswer: answerVisible.value,
        durationSeconds: Math.max(0, Math.round((Date.now() - startTime.value) / 1000)),
      })
      const queueItem = todayQueue.value.find((item) => item.problemId === problem.problemId)
      if (queueItem) {
        queueItem.completed = true
        queueItem.todayResult = result
        queueItem.masteryLevel = result
      }
      await moveToNextIncomplete()
      return response
    } finally {
      submitting.value = false
    }
  }

  async function moveToNextIncomplete(): Promise<void> {
    if (todayQueue.value.length === 0) return
    const start = Math.max(0, currentIndex.value)
    const ordered = [...todayQueue.value.slice(start + 1), ...todayQueue.value.slice(0, start + 1)]
    const next = ordered.find((item) => !item.completed)
    if (next) await loadProblem(next.problemId)
  }

  async function move(delta: -1 | 1): Promise<void> {
    if (editing.value) return
    if (todayQueue.value.length === 0) return
    const index = currentIndex.value < 0 ? 0 : currentIndex.value
    const nextIndex = (index + delta + todayQueue.value.length) % todayQueue.value.length
    const next = todayQueue.value[nextIndex]
    if (next) await loadProblem(next.problemId)
  }

  function persistCurrent(): void {
    writeStorage(CURRENT_KEY, currentProblemId.value)
    if (currentProblemId.value !== null) writeActiveProblemId(currentProblemId.value)
  }

  return {
    todayQueue,
    currentProblemId,
    currentProblem,
    recallDrafts,
    hintVisible,
    answerVisible,
    startTime,
    loading,
    detailLoading,
    submitting,
    error,
    saveState,
    editing,
    editContent,
    editLoading,
    editSaving,
    editError,
    completedCount,
    currentIndex,
    currentDraft,
    loadQueue,
    refreshQueue,
    loadProblem,
    openProblem,
    updateDraft,
    toggleHint,
    toggleAnswer,
    submit,
    move,
    enterEdit,
    cancelEdit,
    saveEdit,
  }
})
