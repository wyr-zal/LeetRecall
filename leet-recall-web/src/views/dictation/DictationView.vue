<script setup lang="ts">
import { computed, defineAsyncComponent, onActivated, onBeforeUnmount, onDeactivated, onMounted, ref, watch } from 'vue'
import { storeToRefs } from 'pinia'
import { dictationApi } from '@/api/dictation'
import { useDictationStore } from '@/stores/dictation'
import { isEditableTarget } from '@/composables/useReviewShortcuts'
import DictationProgress from '@/components/dictation/DictationProgress.vue'
import DictationProblemHeader from '@/components/dictation/DictationProblemHeader.vue'
import DictationProblemPicker from '@/components/dictation/DictationProblemPicker.vue'
import DictationActions from '@/components/dictation/DictationActions.vue'
import CompletionRing from '@/components/dictation/CompletionRing.vue'
import KeywordPanel from '@/components/dictation/KeywordPanel.vue'
import MistakePanel from '@/components/dictation/MistakePanel.vue'
import AnnotationPanel from '@/components/dictation/AnnotationPanel.vue'
import DictationHistory from '@/components/dictation/DictationHistory.vue'
import RecordDetailDialog from '@/components/dictation/RecordDetailDialog.vue'
import ConfirmDialog from '@/components/common/ConfirmDialog.vue'
import LoadingState from '@/components/common/LoadingState.vue'
import ErrorState from '@/components/common/ErrorState.vue'
import EmptyState from '@/components/common/EmptyState.vue'
import type { DictationRecordDetail } from '@/types/dictation'
import type { CodeAnnotationAnchor, CodeAnnotationInput, ResolvedCodeAnnotation } from '@/types/annotation'
import { useCodeAnnotationStore } from '@/stores/codeAnnotation'

const CodeBlankEditor = defineAsyncComponent({
  loader: () => import('@/components/dictation/CodeBlankEditor.vue'),
  loadingComponent: LoadingState,
  delay: 80,
})

const store = useDictationStore()
const annotationStore = useCodeAnnotationStore()
const {
  todayQueue,
  currentProblemId,
  currentProblem,
  currentAnswers,
  currentAccuracy,
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
} = storeToRefs(store)
const {
  resolvedAnnotations,
  loading: annotationLoading,
  saving: annotationSaving,
  error: annotationError,
} = storeToRefs(annotationStore)
const resetOpen = ref(false)
const recordDetail = ref<DictationRecordDetail | null>(null)
const selectedAnnotationId = ref<number | null>(null)
const deleteAnnotationId = ref<number | null>(null)
const draftAnnotationAnchor = ref<CodeAnnotationAnchor | null>(null)
const visibleAnnotations = computed(() => answerVisible.value ? resolvedAnnotations.value : resolvedAnnotations.value.map((annotation) => ({
  ...annotation,
  resolved: true,
})))
let firstActivation = true
const pickerOpen = ref(false)

onMounted(() => {
  void store.loadQueue()
  window.addEventListener('keydown', handleDictationKeydown)
})
watch(currentProblem, (problem) => {
  draftAnnotationAnchor.value = null
  selectedAnnotationId.value = null
  if (problem) {
    annotationStore.setCode(revealedAnswer.value?.fullCode ?? '')
    void annotationStore.load(problem.problemId, revealedAnswer.value?.fullCode ?? '')
  }
}, { immediate: true })
watch(revealedAnswer, (answer) => {
  annotationStore.setCode(answer?.fullCode ?? '')
})
// 视图被 KeepAlive 缓存：监听必须跟随 activated/deactivated 挂卸，否则会泄漏到复习页。
onActivated(() => {
  window.addEventListener('keydown', handleDictationKeydown)
  if (firstActivation) {
    firstActivation = false
    return
  }
  void store.refreshQueue()
})
onDeactivated(() => window.removeEventListener('keydown', handleDictationKeydown))
onBeforeUnmount(() => window.removeEventListener('keydown', handleDictationKeydown))

/** Ctrl/Cmd+Enter 任何时候都可提交（焦点多半在空位输入框里，提交有防重入保护）；
 *  ←/→/A 仅在焦点不在输入区时生效，避免与打字冲突。 */
function handleDictationKeydown(event: KeyboardEvent): void {
  if ((event.ctrlKey || event.metaKey) && event.key === 'Enter') {
    event.preventDefault()
    void store.submit()
    return
  }
  if (isEditableTarget(event.target)) return
  const key = event.key.toLowerCase()
  if (key === 'arrowright') {
    event.preventDefault()
    void store.move(1)
  } else if (key === 'arrowleft') {
    event.preventDefault()
    void store.move(-1)
  } else if (key === 'a') {
    event.preventDefault()
    void store.toggleAnswer()
  }
}

async function pickProblem(problemId: number): Promise<void> {
  pickerOpen.value = false
  await store.loadProblem(problemId)
}

function confirmReset(): void {
  store.reset()
  resetOpen.value = false
}

function openAnnotationDraft(anchor: CodeAnnotationAnchor): void {
  draftAnnotationAnchor.value = anchor
}

function cancelAnnotationDraft(): void {
  draftAnnotationAnchor.value = null
}

async function saveNewAnnotation(input: CodeAnnotationInput): Promise<void> {
  const created = await annotationStore.create(input)
  if (created) draftAnnotationAnchor.value = null
}

async function saveAnnotation(id: number, input: CodeAnnotationInput): Promise<void> {
  await annotationStore.update(id, input)
}

function requestDeleteAnnotation(id: number): void {
  deleteAnnotationId.value = id
}

async function confirmDeleteAnnotation(): Promise<void> {
  if (deleteAnnotationId.value === null) return
  const deleted = await annotationStore.remove(deleteAnnotationId.value)
  if (!deleted) return
  if (!annotationStore.annotations.some((item) => item.id === selectedAnnotationId.value)) {
    selectedAnnotationId.value = null
  }
  deleteAnnotationId.value = null
}

function selectAnnotation(annotation: ResolvedCodeAnnotation): void {
  if (!annotation.resolved) return
  selectedAnnotationId.value = annotation.id
}

function selectAnnotationById(annotationId: number): void {
  const annotation = resolvedAnnotations.value.find((item) => item.id === annotationId)
  if (annotation) selectAnnotation(annotation)
}

async function openRecord(recordId: number): Promise<void> {
  if (!currentProblem.value) return
  recordDetail.value = await dictationApi.getRecordDetail(currentProblem.value.problemId, recordId)
}
</script>

<template>
  <main class="dictation-page">
    <DictationProgress
      :current="currentIndex + 1"
      :total="todayQueue.length"
      @previous="store.move(-1)"
      @next="store.move(1)"
      @pick="pickerOpen = true"
    />

    <LoadingState v-if="loading" />
    <ErrorState v-else-if="error && !currentProblem" :message="error" @retry="store.loadQueue" />
    <EmptyState
      v-else-if="todayQueue.length === 0"
      title="今天没有待默写题目"
      action-label="随机默写一题"
      @action="store.loadQueue"
    />

    <template v-else-if="currentProblem">
      <div class="dictation-grid">
        <section class="editor-card app-card app-card--raised">
          <LoadingState v-if="detailLoading" />
          <template v-else>
            <DictationProblemHeader
              :number="currentProblem.leetcodeNumber"
              :title="currentProblem.title"
              :tags="currentProblem.tags"
            />
            <CodeBlankEditor
              :template-code="currentProblem.templateCode"
              :answers="currentAnswers"
              :results="submitResult?.resultItems"
              :answer-code="answerVisible ? revealedAnswer?.fullCode : undefined"
              :annotations="visibleAnnotations"
              :active-annotation-id="selectedAnnotationId"
              @update:answers="store.updateAnswers"
              @create-annotation="openAnnotationDraft"
              @select-annotation="selectAnnotationById"
            />
            <div v-if="submitResult" class="score-message" role="status">
              <strong>{{ Math.round(submitResult.accuracy) }}%</strong>
              <span>{{ submitResult.correctCount }} / {{ submitResult.totalCount }} 个空位正确</span>
              <small v-if="submitResult.viewedAnswer">查看过答案，本次最高计 60 分</small>
              <button type="button" class="next-problem" @click="store.move(1)">下一题<kbd>→</kbd></button>
            </div>
            <DictationActions
              :submitting="submitting"
              :viewed-answer="viewedAnswer"
              :answer-visible="answerVisible"
              @reset="resetOpen = true"
              @answer="store.toggleAnswer"
              @submit="store.submit"
            />
          </template>
        </section>

        <aside class="dictation-aside">
          <CompletionRing :accuracy="currentAccuracy" />
          <KeywordPanel :keywords="currentProblem.keywords" />
          <MistakePanel :mistakes="currentProblem.mistakes" />
          <AnnotationPanel
            :annotations="visibleAnnotations"
            :loading="annotationLoading"
            :saving="annotationSaving"
            :error="annotationError"
            :draft-anchor="draftAnnotationAnchor"
            :can-create="answerVisible"
            @cancel-create="cancelAnnotationDraft"
            @save-new="saveNewAnnotation"
            @save="saveAnnotation"
            @delete="requestDeleteAnnotation"
            @select="selectAnnotation"
          />
        </aside>
      </div>
      <DictationHistory class="history" :records="history" @select="openRecord" />
    </template>

    <ConfirmDialog
      :open="deleteAnnotationId !== null"
      title="删除代码批注"
      description="确定删除这条代码批注吗？删除后无法恢复。"
      confirm-label="删除批注"
      @confirm="confirmDeleteAnnotation"
      @cancel="deleteAnnotationId = null"
    />
    <ConfirmDialog
      :open="resetOpen"
      title="重置当前默写"
      description="确定清空当前填写内容吗？此操作不会删除已保存的历史记录。"
      confirm-label="清空内容"
      @confirm="confirmReset"
      @cancel="resetOpen = false"
    />
    <RecordDetailDialog :detail="recordDetail" @close="recordDetail = null" />
    <DictationProblemPicker
      :open="pickerOpen"
      :items="todayQueue"
      :current-problem-id="currentProblemId"
      @select="pickProblem"
      @close="pickerOpen = false"
    />
  </main>
</template>

<style scoped>
.dictation-page { width: min(1220px, calc(100% - 56px)); padding: 30px 0 52px; margin: 0 auto; }
.dictation-grid { display: grid; grid-template-columns: minmax(660px, 1fr) minmax(248px, 286px); gap: 22px; align-items: start; }
.editor-card { min-width: 0; padding: clamp(22px, 2.2vw, 28px); }
.dictation-aside { display: grid; gap: 14px; }
.history { width: calc(100% - 304px); margin-top: 16px; }
.score-message { display: flex; align-items: baseline; gap: 11px; padding: 12px 14px; margin-top: 12px; border: 1px solid var(--border-primary); border-radius: 8px; background: var(--bg-input); box-shadow: inset 3px 0 0 var(--primary); }
.score-message strong { color: var(--primary); font-size: 19px; }.score-message span { color: var(--text-secondary); font-size: 13px; }.score-message small { color: var(--warning); font-size: 11px; }
.score-message .next-problem { display: inline-flex; align-items: center; gap: 7px; min-height: 34px; padding: 0 12px; color: var(--on-primary); border: 1px solid var(--primary); border-radius: 7px; background: var(--primary); }
.score-message .next-problem:hover:not(:disabled) { border-color: var(--primary-hover); background: var(--primary-hover); }
.score-message .next-problem kbd { padding: 1px 5px; color: inherit; font-size: 10px; border: 1px solid currentColor; border-radius: 4px; opacity: 0.62; }
@media (max-width: 1279px) {
  .dictation-page { width: min(1100px, calc(100% - 36px)); }
  .dictation-grid { grid-template-columns: minmax(0, 1fr); }
  .dictation-aside { grid-template-columns: repeat(3, 1fr); }
  .history { width: 100%; }
}
@media (max-width: 760px) { .dictation-page { width: calc(100% - 24px); padding: 20px 0 88px; }.dictation-aside { grid-template-columns: 1fr; }.score-message { align-items: flex-start; flex-direction: column; }.score-message small { margin-left: 0; } }
</style>
