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
  const answerVisible = ref(false)
  const revealedAnswer = ref<DictationAnswer | null>(null)
  const submitResult = ref<DictationSubmitResult | null>(null)
  const history = ref<DictationRecord[]>([])
  const startTime = ref(Date.now())
  const loading = ref(false)
  const detailLoading = ref(false)
  const submitting = ref(false)
  const error = ref('')
  const sessionId = createSessionId()
  let detailRequestSequence = 0

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

  async function refreshQueue(): Promise<void> {
    if (loading.value) return
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
      if (currentProblemId.value === null) {
        currentProblem.value = null
        history.value = []
        return
      }
      // 同题也重拉：导入覆盖默写模板后，切回页面立即生效。答案视图、评分结果对应旧模板，
      // 一并重置（草稿按题号独立保留，未受影响的空位内容不丢）。
      await loadProblem(currentProblemId.value)
    } catch (cause) {
      if (!currentProblem.value) error.value = cause instanceof Error ? cause.message : '加载失败，请重试'
    }
  }

  async function loadProblem(problemId: number): Promise<void> {
    const requestSequence = ++detailRequestSequence
    detailLoading.value = true
    error.value = ''
    try {
      const [detail, page] = await Promise.all([
        dictationApi.getProblemDetail(problemId),
        dictationApi.getRecords(problemId, 1, 2),
      ])
      if (requestSequence !== detailRequestSequence) return
      currentProblem.value = detail
      currentProblemId.value = problemId
      viewedAnswer.value = false
      answerVisible.value = false
      revealedAnswer.value = null
      submitResult.value = null
      startTime.value = Date.now()
      writeStorage(CURRENT_KEY, problemId)
      writeActiveProblemId(problemId)
      history.value = page.items
    } catch (cause) {
      if (requestSequence === detailRequestSequence) {
        error.value = cause instanceof Error ? cause.message : '加载失败，请重试'
      }
    } finally {
      if (requestSequence === detailRequestSequence) detailLoading.value = false
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
    answerVisible.value = false
    revealedAnswer.value = null
  }

  /** 首次显示会向后端留痕（本次最高 60 分），之后可在答案与默写之间自由切换，草稿不丢。
   *  每次打开都重新拉取，避免题目被导入覆盖后仍显示旧答案。 */
  async function toggleAnswer(): Promise<void> {
    if (currentProblemId.value === null) return
    if (answerVisible.value) {
      answerVisible.value = false
      return
    }
    revealedAnswer.value = await dictationApi.viewAnswer(currentProblemId.value, sessionId)
    viewedAnswer.value = true
    answerVisible.value = true
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
    answerVisible,
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
    refreshQueue,
    loadProblem,
    updateAnswers,
    reset,
    toggleAnswer,
    submit,
    loadHistory,
    move,
  }
})
