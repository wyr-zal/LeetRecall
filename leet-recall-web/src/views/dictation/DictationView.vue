<script setup lang="ts">
import { computed, defineAsyncComponent, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { Highlighter } from 'lucide-vue-next'
import { storeToRefs } from 'pinia'
import { dictationApi } from '@/api/dictation'
import { useDictationStore } from '@/stores/dictation'
import { useCodeAnnotationStore } from '@/stores/codeAnnotation'
import { isEditableTarget } from '@/composables/useReviewShortcuts'
import DictationActions from '@/components/dictation/DictationActions.vue'
import AnnotationPanel from '@/components/dictation/AnnotationPanel.vue'
import DictationHistory from '@/components/dictation/DictationHistory.vue'
import RecordDetailDialog from '@/components/dictation/RecordDetailDialog.vue'
import ConfirmDialog from '@/components/common/ConfirmDialog.vue'
import WorkspaceDrawer from '@/components/common/WorkspaceDrawer.vue'
import LoadingState from '@/components/common/LoadingState.vue'
import type { DictationRecordDetail } from '@/types/dictation'
import type { CodeAnnotationAnchor, CodeAnnotationInput, ResolvedCodeAnnotation } from '@/types/annotation'

const props = defineProps<{ problemId: number; active: boolean; revision: number }>()
const emit = defineEmits<{ next: [] }>()
const CodeBlankEditor = defineAsyncComponent({
  loader: () => import('@/components/dictation/CodeBlankEditor.vue'),
  loadingComponent: LoadingState,
  delay: 80,
})
const store = useDictationStore()
const annotationStore = useCodeAnnotationStore()
const { currentProblem, currentAnswers, viewedAnswer, answerVisible, revealedAnswer, submitResult, history, detailLoading, submitting, error } = storeToRefs(store)
const { resolvedAnnotations, loading: annotationLoading, saving: annotationSaving, error: annotationError } = storeToRefs(annotationStore)
const loadedRevision = ref(-1)
const resetOpen = ref(false)
const recordDetail = ref<DictationRecordDetail | null>(null)
const selectedAnnotationId = ref<number | null>(null)
const deleteAnnotationId = ref<number | null>(null)
const draftAnnotationAnchor = ref<CodeAnnotationAnchor | null>(null)
const drawerOpen = ref(false)
const actionError = ref('')
const visibleAnnotations = computed(() => answerVisible.value ? resolvedAnnotations.value : [])
const ready = computed(() => currentProblem.value?.problemId === props.problemId && loadedRevision.value === props.revision)
const hasDialog = computed(() => props.active && (resetOpen.value || recordDetail.value !== null || deleteAnnotationId.value !== null || drawerOpen.value))
defineExpose({ hasDialog })
let request = 0

async function ensureProblem(force = false): Promise<void> {
  if (!props.active || (!force && ready.value)) return
  const sequence = ++request
  const revision = props.revision
  await store.loadProblem(props.problemId)
  if (sequence === request && currentProblem.value?.problemId === props.problemId && !error.value) loadedRevision.value = revision
}
watch(() => [props.active, props.problemId, props.revision], () => { void ensureProblem() }, { immediate: true })
watch(currentProblem, (problem) => {
  draftAnnotationAnchor.value = null
  selectedAnnotationId.value = null
  recordDetail.value = null
  drawerOpen.value = false
  if (problem) void annotationStore.load(problem.problemId, revealedAnswer.value?.fullCode ?? '')
})
watch(revealedAnswer, (answer) => annotationStore.setCode(answer?.fullCode ?? ''))
watch(answerVisible, (visible) => { if (!visible) drawerOpen.value = false })
watch(draftAnnotationAnchor, (anchor) => { if (anchor && answerVisible.value) drawerOpen.value = true })

async function perform(action: () => Promise<unknown>): Promise<void> {
  if (!props.active || !ready.value || detailLoading.value || submitting.value) return
  actionError.value = ''
  try { await action() }
  catch (cause) { actionError.value = cause instanceof Error ? cause.message : '操作失败，请重试' }
}

function handleKeydown(event: KeyboardEvent): void {
  if (!props.active || !ready.value || hasDialog.value || detailLoading.value || submitting.value || event.defaultPrevented) return
  if (document.activeElement?.closest('[role="dialog"], [role="alertdialog"]')) return
  if ((event.ctrlKey || event.metaKey) && event.key === 'Enter') {
    event.preventDefault()
    void perform(store.submit)
  } else if (!isEditableTarget(event.target) && event.key.toLowerCase() === 'a') {
    event.preventDefault()
    void perform(store.toggleAnswer)
  }
}
onMounted(() => window.addEventListener('keydown', handleKeydown))
onBeforeUnmount(() => window.removeEventListener('keydown', handleKeydown))

function confirmReset(): void { store.reset(); resetOpen.value = false }
function openAnnotationDraft(anchor: CodeAnnotationAnchor): void { draftAnnotationAnchor.value = anchor }
async function saveNewAnnotation(input: CodeAnnotationInput): Promise<void> {
  if (await annotationStore.create(input)) draftAnnotationAnchor.value = null
}
async function saveAnnotation(id: number, input: CodeAnnotationInput): Promise<void> { await annotationStore.update(id, input) }
async function confirmDeleteAnnotation(): Promise<void> {
  if (deleteAnnotationId.value === null) return
  if (!await annotationStore.remove(deleteAnnotationId.value)) return
  if (!annotationStore.annotations.some((item) => item.id === selectedAnnotationId.value)) selectedAnnotationId.value = null
  deleteAnnotationId.value = null
}
function selectAnnotation(annotation: ResolvedCodeAnnotation): void { if (annotation.resolved) selectedAnnotationId.value = annotation.id }
function selectAnnotationById(id: number): void {
  const annotation = resolvedAnnotations.value.find((item) => item.id === id)
  if (annotation) selectAnnotation(annotation)
}
async function openRecord(recordId: number): Promise<void> {
  const problemId = props.problemId
  await perform(async () => {
    const record = await dictationApi.getRecordDetail(problemId, recordId)
    if (props.active && problemId === props.problemId) recordDetail.value = record
  })
}
</script>

<template>
  <section class="dictation-panel" :aria-busy="detailLoading">
    <p v-if="actionError || error" class="panel-error" role="alert">{{ actionError || error }} <button v-if="error" type="button" @click="ensureProblem(true)">重试</button></p>
    <LoadingState v-if="!ready && !error" />
    <div v-if="currentProblem" v-show="ready" class="editor-column" :inert="!active || detailLoading || submitting">
      <button v-if="answerVisible" class="annotation-entry" type="button" @click="drawerOpen = true"><Highlighter :size="15" />批注 {{ resolvedAnnotations.length }}</button>
      <CodeBlankEditor class="editor-slot" :template-code="currentProblem.templateCode" :answers="currentAnswers" :results="submitResult?.resultItems" :answer-code="answerVisible ? revealedAnswer?.fullCode : undefined" :annotations="visibleAnnotations" :active-annotation-id="selectedAnnotationId" @update:answers="store.updateAnswers" @create-annotation="openAnnotationDraft" @select-annotation="selectAnnotationById" />
      <div v-if="submitResult" class="score-message" role="status">
        <strong>{{ Math.round(submitResult.accuracy) }}%</strong>
        <span>{{ submitResult.correctCount }} / {{ submitResult.totalCount }} 个空位正确</span>
        <small v-if="submitResult.viewedAnswer">查看过答案，本次最高计 60 分</small>
        <button type="button" @click="emit('next')">下一题</button>
      </div>
      <DictationActions :submitting="submitting" :viewed-answer="viewedAnswer" :answer-visible="answerVisible" @reset="resetOpen = true" @answer="perform(store.toggleAnswer)" @submit="perform(store.submit)" />
      <DictationHistory class="history" :records="history" @select="openRecord" />
    </div>
    <WorkspaceDrawer :open="active && drawerOpen && answerVisible" title="代码批注" compact @close="drawerOpen = false">
      <AnnotationPanel :annotations="visibleAnnotations" :loading="annotationLoading" :saving="annotationSaving" :error="annotationError" :draft-anchor="draftAnnotationAnchor" :can-create="answerVisible" @cancel-create="draftAnnotationAnchor = null" @save-new="saveNewAnnotation" @save="saveAnnotation" @delete="deleteAnnotationId = $event" @select="selectAnnotation" />
    </WorkspaceDrawer>
    <ConfirmDialog :open="active && deleteAnnotationId !== null" title="删除代码批注" description="确定删除这条代码批注吗？删除后无法恢复。" confirm-label="删除批注" @confirm="confirmDeleteAnnotation" @cancel="deleteAnnotationId = null" />
    <ConfirmDialog :open="active && resetOpen" title="重置当前默写" description="确定清空当前填写内容吗？此操作不会删除已保存的历史记录。" confirm-label="清空内容" @confirm="confirmReset" @cancel="resetOpen = false" />
    <RecordDetailDialog :detail="active ? recordDetail : null" @close="recordDetail = null" />
  </section>
</template>

<style scoped>
.dictation-panel { display: flex; flex: 1; min-width: 0; min-height: 0; flex-direction: column; }
.editor-column { display: flex; min-width: 0; min-height: 0; flex: 1; flex-direction: column; padding: 12px; gap: 8px; overflow: hidden; }
.editor-slot { flex: 1; min-height: 160px; }
.history { flex: 0 0 auto; max-height: min(180px, 25%); margin-top: 0; overflow-y: auto; }
.annotation-entry { display: inline-flex; align-items: center; align-self: flex-end; gap: 6px; min-height: 32px; padding: 0 10px; color: var(--text-secondary); border: 1px solid var(--border-primary); border-radius: 7px; background: var(--bg-card); }
.score-message { display: flex; flex-wrap: wrap; align-items: center; gap: 8px; padding: 8px 12px; border: 1px solid var(--border-primary); border-radius: 8px; background: var(--bg-input); }
.score-message strong { color: var(--primary); font-size: calc(18px * var(--ui-font-ratio)); }
.score-message span, .score-message small { font-size: calc(12px * var(--ui-font-ratio)); }
.score-message small { color: var(--warning); }
.score-message button { min-height: 34px; margin-left: auto; color: var(--on-primary); border: 0; border-radius: 6px; padding: 0 10px; background: var(--primary); }
.panel-error { padding: 8px 12px; color: var(--danger-strong); background: var(--danger-soft); }
@media (max-width: 720px) { .editor-column { padding: 8px; overflow-y: auto; } .annotation-entry { min-height: 44px; } }
</style>
