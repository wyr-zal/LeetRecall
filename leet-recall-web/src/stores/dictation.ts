import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import { dictationApi } from '@/api/dictation'
import { readActiveProblemId, writeActiveProblemId } from '@/utils/problemSelection'
import { readStorage, writeStorage } from '@/utils/storage'
import { online } from '@/offline/network'
import {
  addPendingAnswerView,
  cacheDictationAnswer,
  cacheDictationDetail,
  cacheDictationHistory,
  cacheDictationQueue,
  clearPendingAnswerViews,
  readDictationAnswer,
  readDictationDetail,
  readDictationHistory,
  readDictationQueue,
  readPendingAnswerViews,
} from '@/offline/repo'
import type {
  DictationAnswer,
  DictationProblemDetail,
  DictationQueueItem,
  DictationRecord,
  DictationSubmitResult,
  TodayDictationQueue,
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
  /** 当前题目是否来自本地离线快照（网络请求失败时保留页面内容）。 */
  const detailFromCache = ref(false)
  const sessionId = createSessionId()
  let detailRequestSequence = 0
  let answerRequestSequence = 0
  let answerRequest: Promise<void> | null = null

  const currentIndex = computed(() => todayQueue.value.findIndex(
    (item) => item.problemId === currentProblemId.value,
  ))
  const currentAnswers = computed(() => currentProblemId.value === null
    ? {}
    : drafts.value[currentProblemId.value] ?? {})
  const currentAccuracy = computed(() => submitResult.value?.accuracy
    ?? todayQueue.value.find((item) => item.problemId === currentProblemId.value)?.accuracy
    ?? 0)

  /** 队列只负责选中题目；详情另行加载，离线快照与在线响应共用同一条路径。 */
  function applyQueue(queue: TodayDictationQueue): void {
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
  }

  async function loadQueue(): Promise<void> {
    loading.value = true
    error.value = ''
    try {
      const queue = await dictationApi.getTodayQueue()
      void cacheDictationQueue(queue).catch(() => undefined)
      applyQueue(queue)
      if (currentProblemId.value !== null) await loadProblem(currentProblemId.value)
      void flushPendingAnswerViews()
    } catch (cause) {
      const cached = await readDictationQueue<TodayDictationQueue>().catch(() => null)
      if (!cached || !Array.isArray(cached.data.items)) {
        error.value = cause instanceof Error ? cause.message : '加载失败，请重试'
        return
      }
      applyQueue(cached.data)
      if (currentProblemId.value !== null) await loadProblem(currentProblemId.value)
    } finally {
      loading.value = false
    }
  }

  async function refreshQueue(): Promise<void> {
    if (loading.value) return
    try {
      const queue = await dictationApi.getTodayQueue()
      void cacheDictationQueue(queue).catch(() => undefined)
      applyQueue(queue)
      if (currentProblemId.value === null) {
        currentProblem.value = null
        history.value = []
        return
      }
      // 同题也重拉：导入覆盖默写模板后，切回页面立即生效。答案视图、评分结果对应旧模板，
      // 一并重置（草稿按题号独立保留，未受影响的空位内容不丢）。
      await loadProblem(currentProblemId.value)
      void flushPendingAnswerViews()
    } catch (cause) {
      const cached = await readDictationQueue<TodayDictationQueue>().catch(() => null)
      if (!cached || !Array.isArray(cached.data.items)) {
        if (!currentProblem.value) error.value = cause instanceof Error ? cause.message : '加载失败，请重试'
        return
      }
      applyQueue(cached.data)
      if (currentProblemId.value !== null) await loadProblem(currentProblemId.value)
    }
  }

  function applyDetail(
    problemId: number,
    detail: DictationProblemDetail,
    resetState: boolean,
  ): void {
    currentProblem.value = detail
    currentProblemId.value = problemId
    if (resetState) {
      viewedAnswer.value = false
      answerVisible.value = false
      revealedAnswer.value = null
      submitResult.value = null
      startTime.value = Date.now()
    }
    writeStorage(CURRENT_KEY, problemId)
    writeActiveProblemId(problemId)
  }

  async function loadProblem(problemId: number): Promise<void> {
    const requestSequence = ++detailRequestSequence
    cancelAnswerRequest()
    detailLoading.value = true
    error.value = ''
    detailFromCache.value = false
    let usedCache = false
    try {
      const cached = await readDictationDetail(problemId).catch(() => null)
      if (cached && requestSequence === detailRequestSequence) {
        applyDetail(problemId, cached, true)
        detailFromCache.value = true
        usedCache = true
        detailLoading.value = false
      }
      // 详情与历史互不阻塞：历史失败时仍可正常默写。
      const [detailResult, historyResult] = await Promise.allSettled([
        dictationApi.getProblemDetail(problemId),
        dictationApi.getRecords(problemId, 1, 2),
      ])
      if (requestSequence !== detailRequestSequence) return
      if (detailResult.status === 'fulfilled') {
        applyDetail(problemId, detailResult.value, !usedCache)
        detailFromCache.value = false
        void cacheDictationDetail(detailResult.value).catch(() => undefined)
      } else if (!usedCache) {
        error.value = detailResult.reason instanceof Error ? detailResult.reason.message : '加载失败，请重试'
      }
      if (historyResult.status === 'fulfilled') {
        history.value = historyResult.value.items
        void cacheDictationHistory(problemId, historyResult.value.items).catch(() => undefined)
      } else {
        history.value = await readDictationHistory(problemId).catch(() => [])
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
    cancelAnswerRequest()
    updateAnswers({})
    submitResult.value = null
    answerVisible.value = false
    revealedAnswer.value = null
  }

  function cancelAnswerRequest(): void {
    answerRequestSequence += 1
    answerRequest = null
  }

  /** 路由恢复是确保状态，不是切换；收起和切题都会使晚到的展开响应失效。 */
  async function setAnswerVisible(visible: boolean): Promise<void> {
    if (!visible) {
      cancelAnswerRequest()
      answerVisible.value = false
      return
    }
    if (currentProblemId.value === null || answerVisible.value) return
    if (answerRequest) return answerRequest
    const problemId = currentProblemId.value
    const detailSequence = detailRequestSequence
    const sequence = ++answerRequestSequence
    answerRequest = (async () => {
      try {
        const answer = await dictationApi.viewAnswer(problemId, sessionId)
        if (problemId !== currentProblemId.value || detailSequence !== detailRequestSequence || sequence !== answerRequestSequence) return
        revealedAnswer.value = answer
        viewedAnswer.value = true
        answerVisible.value = true
        void cacheDictationAnswer(problemId, answer).catch(() => undefined)
      } catch (cause) {
        // 网络不可用时使用本地答案快照；联网后再补记一次查看留痕。
        const cached = await readDictationAnswer(problemId).catch(() => null)
        if (!cached || problemId !== currentProblemId.value || detailSequence !== detailRequestSequence || sequence !== answerRequestSequence) {
          throw cause
        }
        revealedAnswer.value = cached
        viewedAnswer.value = true
        answerVisible.value = true
        // 服务端未记录本次查看：先登记待补记，联网后补记留痕。
        await addPendingAnswerView(problemId).catch(() => undefined)
      } finally {
        if (sequence === answerRequestSequence) answerRequest = null
      }
    })()
    return answerRequest
  }

  async function toggleAnswer(): Promise<void> {
    await setAnswerVisible(!answerVisible.value)
  }

  async function submit(): Promise<void> {
    if (currentProblemId.value === null || submitting.value) return
    if (!online.value) {
      error.value = '离线状态下无法提交默写，请联网后重试。'
      return
    }
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
    const problemId = currentProblemId.value
    if (problemId === null) return
    try {
      const page = await dictationApi.getRecords(problemId, 1, 2)
      if (problemId !== currentProblemId.value) return
      history.value = page.items
      void cacheDictationHistory(problemId, page.items).catch(() => undefined)
    } catch {
      history.value = await readDictationHistory(problemId).catch(() => [])
    }
  }

  /** 离线查看答案只写本地待补记列表；恢复联网后逐题补记，失败项原地保留。 */
  async function flushPendingAnswerViews(): Promise<void> {
    if (!online.value) return
    const pending = await readPendingAnswerViews().catch(() => [])
    if (pending.length === 0) return
    const succeeded = new Set<number>()
    for (const problemId of pending) {
      try {
        await dictationApi.viewAnswer(problemId, sessionId)
        succeeded.add(problemId)
      } catch {
        // 保留在待补记列表，下次联网再试。
      }
    }
    if (succeeded.size === 0) return
    const latest = await readPendingAnswerViews().catch(() => [])
    const remaining = latest.filter((problemId) => !succeeded.has(problemId))
    await clearPendingAnswerViews()
    for (const problemId of remaining) await addPendingAnswerView(problemId)
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
    detailFromCache,
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
    setAnswerVisible,
    submit,
    loadHistory,
    flushPendingAnswerViews,
    move,
  }
})
