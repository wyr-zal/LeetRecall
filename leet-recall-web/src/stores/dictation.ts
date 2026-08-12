import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import { dictationApi } from '@/api/dictation'
import { readActiveProblemId, writeActiveProblemId } from '@/utils/problemSelection'
import { readStorage, writeStorage } from '@/utils/storage'
import type {
  DictationAnswer,
  DictationProblemDetail,
  DictationQueueItem,
  DictationRecord,
  DictationSubmitResult,
} from '@/types/dictation'

type DictationDrafts = Record<number, Record<string, string>>
const CURRENT_KEY = 'leet-recall:dictation-current'
const DRAFTS_KEY = 'leet-recall:dictation-drafts'

function createSessionId(): string {
  const existing = sessionStorage.getItem('leet-recall:dictation-session')
  if (existing) return existing
  const id = crypto.randomUUID()
  sessionStorage.setItem('leet-recall:dictation-session', id)
  return id
}

export const useDictationStore = defineStore('dictation', () => {
  const todayQueue = ref<DictationQueueItem[]>([])
  const currentProblemId = ref<number | null>(
    readActiveProblemId() ?? readStorage<number | null>(CURRENT_KEY, null),
  )
  const currentProblem = ref<DictationProblemDetail | null>(null)
  const drafts = ref<DictationDrafts>(readStorage<DictationDrafts>(DRAFTS_KEY, {}))
  const viewedAnswer = ref(false)
  const revealedAnswer = ref<DictationAnswer | null>(null)
  const submitResult = ref<DictationSubmitResult | null>(null)
  const history = ref<DictationRecord[]>([])
  const startTime = ref(Date.now())
  const loading = ref(false)
  const detailLoading = ref(false)
  const submitting = ref(false)
  const error = ref('')
  const sessionId = createSessionId()

  const currentIndex = computed(() => todayQueue.value.findIndex(
    (item) => item.problemId === currentProblemId.value,
  ))
  const currentAnswers = computed(() => currentProblemId.value === null
    ? {}
    : drafts.value[currentProblemId.value] ?? {})
  const currentAccuracy = computed(() => submitResult.value?.accuracy
    ?? todayQueue.value.find((item) => item.problemId === currentProblemId.value)?.accuracy
    ?? 0)

  async function loadQueue(): Promise<void> {
    loading.value = true
    error.value = ''
    try {
      const queue = await dictationApi.getTodayQueue()
      todayQueue.value = queue.items
      const activeProblemId = readActiveProblemId()
      if (activeProblemId !== null && queue.items.some((item) => item.problemId === activeProblemId)) {
        currentProblemId.value = activeProblemId
      }
      if (!queue.items.some((item) => item.problemId === currentProblemId.value)) {
        currentProblemId.value = queue.items.find((item) => !item.completed)?.problemId
          ?? queue.items[0]?.problemId
          ?? null
      }
      if (currentProblemId.value !== null) await loadProblem(currentProblemId.value)
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
      currentProblem.value = await dictationApi.getProblemDetail(problemId)
      currentProblemId.value = problemId
      viewedAnswer.value = false
      revealedAnswer.value = null
      submitResult.value = null
      startTime.value = Date.now()
      writeStorage(CURRENT_KEY, problemId)
      writeActiveProblemId(problemId)
      await loadHistory()
    } catch (cause) {
      error.value = cause instanceof Error ? cause.message : '加载失败，请重试'
    } finally {
      detailLoading.value = false
    }
  }

  function updateAnswers(answers: Record<string, string>): void {
    if (currentProblemId.value === null) return
    drafts.value = { ...drafts.value, [currentProblemId.value]: { ...answers } }
    writeStorage(DRAFTS_KEY, drafts.value)
  }

  function reset(): void {
    updateAnswers({})
    submitResult.value = null
    revealedAnswer.value = null
  }

  async function showAnswer(): Promise<void> {
    if (currentProblemId.value === null) return
    revealedAnswer.value = await dictationApi.viewAnswer(currentProblemId.value, sessionId)
    viewedAnswer.value = true
  }

  async function submit(): Promise<void> {
    if (currentProblemId.value === null || submitting.value) return
    submitting.value = true
    try {
      submitResult.value = await dictationApi.submit(
        currentProblemId.value,
        sessionId,
        currentAnswers.value,
        viewedAnswer.value,
        Math.max(0, Math.round((Date.now() - startTime.value) / 1000)),
      )
      const item = todayQueue.value.find((entry) => entry.problemId === currentProblemId.value)
      if (item) {
        item.completed = true
        item.accuracy = submitResult.value.accuracy
      }
      await loadHistory()
    } finally {
      submitting.value = false
    }
  }

  async function loadHistory(): Promise<void> {
    if (currentProblemId.value === null) return
    const page = await dictationApi.getRecords(currentProblemId.value, 1, 2)
    history.value = page.items
  }

  async function move(delta: -1 | 1): Promise<void> {
    if (todayQueue.value.length === 0) return
    const index = currentIndex.value < 0 ? 0 : currentIndex.value
    const nextIndex = (index + delta + todayQueue.value.length) % todayQueue.value.length
    const next = todayQueue.value[nextIndex]
    if (next) await loadProblem(next.problemId)
  }

  return {
    todayQueue,
    currentProblemId,
    currentProblem,
    viewedAnswer,
    revealedAnswer,
    submitResult,
    history,
    loading,
    detailLoading,
    submitting,
    error,
    currentIndex,
    currentAnswers,
    currentAccuracy,
    loadQueue,
    loadProblem,
    updateAnswers,
    reset,
    showAnswer,
    submit,
    loadHistory,
    move,
  }
})
