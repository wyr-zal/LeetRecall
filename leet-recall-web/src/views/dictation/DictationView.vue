<script setup lang="ts">
import { computed, defineAsyncComponent, onActivated, onBeforeUnmount, onDeactivated, onMounted, ref, watch } from 'vue'
import { ArrowLeft, FileInput, Moon, Sun, Zap } from 'lucide-vue-next'
import { storeToRefs } from 'pinia'
import { dictationApi } from '@/api/dictation'
import { useDictationStore } from '@/stores/dictation'
import { isEditableTarget } from '@/composables/useReviewShortcuts'
import { useTheme } from '@/composables/useTheme'
import DictationProgress from '@/components/dictation/DictationProgress.vue'
import DictationProblemHeader from '@/components/dictation/DictationProblemHeader.vue'
import DictationProblemPanel from '@/components/dictation/DictationProblemPanel.vue'
import DictationProblemPicker from '@/components/dictation/DictationProblemPicker.vue'
import DictationActions from '@/components/dictation/DictationActions.vue'
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
const { themeMode, toggleTheme } = useTheme()
const {
  todayQueue,
  currentProblemId,
  currentProblem,
  currentAnswers,
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
const visibleAnnotations = computed(() => answerVisible.value ? resolvedAnnotations.value : [])
let firstActivation = true
const pickerOpen = ref(false)
const drawerOpen = ref(false)
// 窄屏（≤720px）在题目/代码两栏间二选一；宽屏两栏并排，该值由 CSS 忽略。
const activeView = ref<'problem' | 'code'>('problem')
const themeToggleLabel = computed(() => themeMode.value === 'dark' ? '切换浅色主题' : '切换深色主题')

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
watch(answerVisible, (visible) => {
  if (!visible) drawerOpen.value = false
  else if (draftAnnotationAnchor.value) drawerOpen.value = true
})
// 选中代码发起批注时抽屉自动展开，省掉手动点开的一步。
watch(draftAnnotationAnchor, (anchor) => {
  if (anchor) drawerOpen.value = true
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
  if (event.key === 'Escape' && drawerOpen.value) {
    drawerOpen.value = false
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

function toggleAnnotations(): void {
  if (!answerVisible.value) return
  drawerOpen.value = !drawerOpen.value
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
    <header class="dictation-session-bar">
      <div class="session-start">
        <RouterLink class="back-link" to="/quick-review" aria-label="返回工作台" title="返回工作台">
          <ArrowLeft :size="17" aria-hidden="true" />
          <span>返回</span>
        </RouterLink>
        <span class="session-divider" aria-hidden="true" />
        <div class="session-brand">
          <strong>LeetRecall</strong>
          <span>默写训练</span>
        </div>
      </div>

      <DictationProgress
        v-if="currentProblem"
        class="session-controls"
        :current="currentIndex + 1"
        :total="todayQueue.length"
        :annotation-count="answerVisible ? resolvedAnnotations.length : 0"
        :annotations-visible="answerVisible"
        @previous="store.move(-1)"
        @next="store.move(1)"
        @pick="pickerOpen = true"
        @annotations="toggleAnnotations"
      />

      <div class="session-tools">
        <RouterLink class="session-link" to="/quick-review" aria-label="快速复习" title="快速复习">
          <Zap :size="17" aria-hidden="true" />
        </RouterLink>
        <RouterLink class="session-link" to="/problem-import" aria-label="导入题目" title="导入题目">
          <FileInput :size="17" aria-hidden="true" />
        </RouterLink>
        <button
          class="theme-toggle"
          type="button"
          :aria-label="themeToggleLabel"
          :title="themeToggleLabel"
          :aria-pressed="themeMode === 'light'"
          @click="toggleTheme"
        >
          <Sun v-if="themeMode === 'dark'" :size="17" aria-hidden="true" />
          <Moon v-else :size="17" aria-hidden="true" />
          <span>{{ themeMode === 'dark' ? '浅色' : '深色' }}</span>
        </button>
      </div>
    </header>

    <LoadingState v-if="loading" />
    <ErrorState v-else-if="error && !currentProblem" :message="error" @retry="store.loadQueue" />
    <EmptyState
      v-else-if="todayQueue.length === 0"
      title="今天没有待默写题目"
      action-label="随机默写一题"
      @action="store.loadQueue"
    />

    <template v-else-if="currentProblem">
      <LoadingState v-if="detailLoading" />
      <template v-else>
        <nav class="view-switch" role="tablist" aria-label="默写视图">
          <button
            type="button"
            role="tab"
            :aria-selected="activeView === 'problem'"
            :class="{ active: activeView === 'problem' }"
            @click="activeView = 'problem'"
          >
            题目
          </button>
          <button
            type="button"
            role="tab"
            :aria-selected="activeView === 'code'"
            :class="{ active: activeView === 'code' }"
            @click="activeView = 'code'"
          >
            代码
          </button>
        </nav>

        <div class="dictation-layout" :class="`view-${activeView}`">
          <DictationProblemPanel
            class="problem-column"
            :problem-id="currentProblem.problemId"
            :description-markdown="currentProblem.descriptionMarkdown"
            :recall-questions="currentProblem.recallQuestions"
          >
            <template #header>
              <DictationProblemHeader
                :number="currentProblem.leetcodeNumber"
                :title="currentProblem.title"
                :difficulty="currentProblem.difficulty"
                :tags="currentProblem.tags"
              />
            </template>
          </DictationProblemPanel>

          <section class="editor-column">
            <CodeBlankEditor
              class="editor-slot"
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
            <DictationHistory class="history" :records="history" @select="openRecord" />
          </section>
        </div>
      </template>

      <aside v-if="drawerOpen && answerVisible" class="annotation-drawer" aria-label="代码批注">
        <AnnotationPanel
          closable
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
          @close="drawerOpen = false"
        />
      </aside>
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
.dictation-page {
  --dictation-session-height: 54px;
  display: flex;
  height: var(--viewport-height);
  flex-direction: column;
  overflow: hidden;
  background: var(--bg-primary);
}

.dictation-session-bar {
  z-index: 10;
  display: flex;
  height: var(--dictation-session-height);
  flex: 0 0 auto;
  align-items: center;
  padding: 0 16px;
  gap: 12px;
  border-bottom: 1px solid var(--border-primary);
  background: var(--bg-card);
  box-shadow: var(--shadow-low);
}

.session-start { display: flex; min-width: 0; flex: 0 0 auto; align-items: center; gap: 12px; }
.back-link { display: inline-flex; min-height: 38px; align-items: center; padding: 0 10px; gap: 6px; color: var(--text-secondary); text-decoration: none; border: 1px solid var(--border-primary); border-radius: 7px; background: var(--bg-card); }
.back-link:hover { color: var(--text-primary); border-color: var(--border-hover); background: var(--bg-card-hover); }
.session-divider { width: 1px; height: 24px; background: var(--border-secondary); }
.session-brand { display: grid; gap: 1px; white-space: nowrap; }
.session-brand strong { font-size: calc(13px * var(--ui-font-ratio)); font-weight: 680; line-height: 1.2; }
.session-brand span { color: var(--text-muted); font-size: calc(10px * var(--ui-font-ratio)); }
.theme-toggle { display: inline-flex; min-width: 38px; min-height: 38px; flex: 0 0 auto; align-items: center; justify-content: center; padding: 0 9px; gap: 6px; color: var(--text-secondary); border: 1px solid var(--border-primary); border-radius: 7px; background: var(--bg-card); }
.theme-toggle:hover { color: var(--text-primary); border-color: var(--border-hover); background: var(--bg-card-hover); }
.session-tools { display: flex; min-width: 0; flex: 0 0 auto; align-items: center; margin-left: auto; gap: 6px; }
.session-link { display: inline-flex; width: 38px; min-height: 38px; flex: 0 0 auto; align-items: center; justify-content: center; color: var(--text-secondary); border: 1px solid var(--border-primary); border-radius: 7px; background: var(--bg-card); }
.session-link:hover { color: var(--text-primary); border-color: var(--border-hover); background: var(--bg-card-hover); }
.session-link:focus-visible { outline: 2px solid var(--primary); outline-offset: 2px; }
.session-controls { min-width: 0; }

/* 左题面右代码，两栏各自滚动撑满视口，页面本身不滚动。 */
.dictation-layout {
  display: grid;
  min-height: 0;
  flex: 1;
  grid-template-columns: minmax(0, 0.96fr) minmax(0, 1.04fr);
  grid-template-rows: minmax(0, 1fr);
}

.problem-column { min-width: 0; min-height: 0; border-right: 1px solid var(--border-secondary); }

.editor-column { display: flex; min-width: 0; min-height: 0; flex-direction: column; padding: 12px 14px 10px; gap: 8px; overflow: hidden; }
.editor-column > .editor-slot { min-height: 0; flex: 1; }
.editor-column > .history { flex: 0 0 auto; max-height: min(240px, 30%); margin-top: 0; overflow-y: auto; }

.annotation-drawer { position: fixed; z-index: 40; top: var(--dictation-session-height); right: 0; bottom: 0; width: min(380px, 92vw); overflow: auto; padding: 16px; border-left: 1px solid var(--border-primary); background: var(--bg-primary); box-shadow: var(--shadow-high); }
.score-message { display: flex; align-items: baseline; gap: 11px; padding: 12px 14px; border: 1px solid var(--border-primary); border-radius: 8px; background: var(--bg-input); box-shadow: inset 3px 0 0 var(--primary); }
.score-message strong { color: var(--primary); font-size: calc(19px * var(--ui-font-ratio)); }.score-message span { color: var(--text-secondary); font-size: calc(13px * var(--ui-font-ratio)); }.score-message small { color: var(--warning); font-size: calc(11px * var(--ui-font-ratio)); }
.score-message .next-problem { display: inline-flex; align-items: center; gap: 7px; min-height: 34px; padding: 0 12px; color: var(--on-primary); border: 1px solid var(--primary); border-radius: 7px; background: var(--primary); }
.score-message .next-problem:hover:not(:disabled) { border-color: var(--primary-hover); background: var(--primary-hover); }
.score-message .next-problem kbd { padding: 1px 5px; color: inherit; font-size: calc(10px * var(--ui-font-ratio)); border: 1px solid currentColor; border-radius: 4px; opacity: 0.62; }
/* 窄屏用页签在题目/代码间二选一，宽屏由上方 .dictation-layout 并排接管。 */
.view-switch { display: none; }
@media (max-width: 1279px) {
  .dictation-layout { grid-template-columns: minmax(0, 1fr) minmax(0, 1fr); }
}
@media (max-width: 720px) {
  .dictation-page { --dictation-session-height: calc(50px + env(safe-area-inset-top)); }
  .dictation-session-bar { padding: env(safe-area-inset-top) 8px 0; gap: 6px; }
  .session-start { gap: 5px; }
  .back-link { width: 40px; min-height: 40px; justify-content: center; padding: 0; }
  .back-link span, .session-divider, .session-brand { display: none; }
  .theme-toggle { width: 40px; min-height: 40px; padding: 0; }
  .theme-toggle span { display: none; }
  /* 窄屏顶栏放不下额外入口：快速复习由「返回」承担，导入题目走底部导航。 */
  .session-link { display: none; }
  .view-switch { display: flex; flex: 0 0 auto; padding: 8px 10px 0; gap: 6px; }
  .view-switch button { min-height: 42px; flex: 1; color: var(--text-muted); font-size: calc(13px * var(--ui-font-ratio)); font-weight: 620; border: 1px solid var(--border-primary); border-radius: 7px; background: transparent; }
  .view-switch button.active { color: var(--on-primary); border-color: var(--primary); background: var(--primary); }
  /* 单栏栅格：隐藏的那一栏不能继续占轨道，否则可见栏只剩半宽。 */
  .dictation-layout { padding: 8px 10px 10px; gap: 8px; grid-template-columns: minmax(0, 1fr); }
  .problem-column { display: none; border-right: 0; }
  .editor-column { display: none; padding: 0; }
  .dictation-layout.view-problem .problem-column { display: flex; }
  .dictation-layout.view-code .editor-column { display: flex; }
  .annotation-drawer { top: var(--dictation-session-height); bottom: env(safe-area-inset-bottom); }
  .score-message { align-items: flex-start; flex-direction: column; }.score-message small { margin-left: 0; }
}
</style>
