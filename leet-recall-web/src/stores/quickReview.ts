import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import { reviewApi } from '@/api/review'
import { readActiveProblemId, writeActiveProblemId } from '@/utils/problemSelection'
import { readStorage, writeStorage } from '@/utils/storage'
import type {
  MasteryLevel,
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

  async function loadProblem(problemId: number): Promise<void> {
    detailLoading.value = true
    error.value = ''
    try {
      currentProblem.value = await reviewApi.getProblemDetail(problemId)
      currentProblemId.value = problemId
      hintVisible.value = false
      answerVisible.value = false
      startTime.value = Date.now()
      persistCurrent()
    } catch (cause) {
      error.value = cause instanceof Error ? cause.message : '加载失败，请重试'
    } finally {
      detailLoading.value = false
    }
  }

  async function openProblem(problemId: number): Promise<void> {
    await loadProblem(problemId)
  }

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
  }

  function toggleHint(): void {
    hintVisible.value = !hintVisible.value
  }

  function toggleAnswer(): void {
    answerVisible.value = !answerVisible.value
  }

  async function submit(result: Exclude<MasteryLevel, 'NEW'>): Promise<ReviewSubmitResult | null> {
    const problem = currentProblem.value
    if (!problem || submitting.value) return null
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
    if (todayQueue.value.length === 0) return
    const index = currentIndex.value < 0 ? 0 : currentIndex.value
    const nextIndex = (index + delta + todayQueue.value.length) % todayQueue.value.length
    const next = todayQueue.value[nextIndex]
    if (next) await loadProblem(next.problemId)
  }

  async function endReview(): Promise<void> {
    const first = todayQueue.value[0]
    if (first) await loadProblem(first.problemId)
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
    completedCount,
    currentIndex,
    currentDraft,
    loadQueue,
    loadProblem,
    openProblem,
    updateDraft,
    toggleHint,
    toggleAnswer,
    submit,
    move,
    endReview,
  }
})
