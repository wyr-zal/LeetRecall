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
  const contentRevision = ref(0)
  let detailRequestSequence = 0
  let beforeProblemChange: (() => Promise<boolean>) | undefined

  function setBeforeProblemChange(guard?: () => Promise<boolean>): void {
    beforeProblemChange = guard
  }

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

  async function refreshQueue(options?: { reloadDetail?: boolean }): Promise<void> {
    if (loading.value) return
    try {
      const queue = await reviewApi.getTodayQueue()
      todayQueue.value = queue.items
      if (options?.reloadDetail === false) return
      const activeProblemId = readActiveProblemId()
      const target = queue.items.find((item) => item.problemId === activeProblemId)?.problemId
        ?? queue.items.find((item) => item.problemId === currentProblemId.value)?.problemId
        ?? queue.items[0]?.problemId
      if (target !== undefined) {
        await loadProblem(target, { keepPanelState: target === currentProblemId.value })
      } else {
        currentProblem.value = null
        currentProblemId.value = null
      }
    } catch (cause) {
      error.value = cause instanceof Error ? cause.message : '加载失败，请重试'
    }
  }

  /** 同题刷新保留内容容器；只有数据成功返回后才切换当前题。 */
  async function loadProblem(problemId: number, options?: { keepPanelState?: boolean }): Promise<boolean> {
    const sequence = ++detailRequestSequence
    if (problemId !== currentProblemId.value) {
      if (editing.value) {
        error.value = '请先保存或取消题目编辑，再切换题目。'
        detailLoading.value = false
        return false
      }
      if (beforeProblemChange && !await beforeProblemChange()) {
        if (sequence === detailRequestSequence) detailLoading.value = false
        return false
      }
      if (sequence !== detailRequestSequence) return false
    }
    detailLoading.value = true
    error.value = ''
    try {
      const detail = await reviewApi.getProblemDetail(problemId)
      if (sequence !== detailRequestSequence) return false
      currentProblem.value = detail
      currentProblemId.value = problemId
      if (!options?.keepPanelState) {
        hintVisible.value = false
        answerVisible.value = false
        startTime.value = Date.now()
      }
      persistCurrent()
      return true
    } catch (cause) {
      if (sequence === detailRequestSequence) error.value = cause instanceof Error ? cause.message : '加载失败，请重试'
      return false
    } finally {
      if (sequence === detailRequestSequence) detailLoading.value = false
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
      contentRevision.value += 1
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
    if (!problem || submitting.value || editing.value || detailLoading.value) return null
    if (beforeProblemChange && !await beforeProblemChange()) return null
    if (submitting.value || detailLoading.value || currentProblem.value !== problem) return null
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
    contentRevision,
    setBeforeProblemChange,
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
