<script setup lang="ts">
import { computed, defineAsyncComponent, nextTick, onActivated, onBeforeUnmount, onDeactivated, onMounted, ref, watch } from 'vue'
import { type RouteLocationNormalized, onBeforeRouteLeave, onBeforeRouteUpdate, useRoute, useRouter } from 'vue-router'
import { storeToRefs } from 'pinia'
import { BrainCircuit, FileText, NotebookPen, SquarePen } from 'lucide-vue-next'
import { useQuickReviewStore } from '@/stores/quickReview'
import { useDictationStore } from '@/stores/dictation'
import { useReviewShortcuts } from '@/composables/useReviewShortcuts'
import { useSettingsMenu } from '@/composables/useSettingsMenu'
import ProblemHeader from '@/components/review/ProblemHeader.vue'
import ProblemDescription from '@/components/review/ProblemDescription.vue'
import ProblemContentEditor from '@/components/review/ProblemContentEditor.vue'
import RecallQuestionList from '@/components/review/RecallQuestionList.vue'
import HintPanel from '@/components/review/HintPanel.vue'
import AnswerPanel from '@/components/review/AnswerPanel.vue'
import ProblemNotePanel from '@/components/review/ProblemNotePanel.vue'
import ReviewResultButtons from '@/components/review/ReviewResultButtons.vue'
import ReviewQueue from '@/components/review/ReviewQueue.vue'
import KeyboardShortcutPanel from '@/components/review/KeyboardShortcutPanel.vue'
import WorkspaceDrawer from '@/components/common/WorkspaceDrawer.vue'
import LoadingState from '@/components/common/LoadingState.vue'
import { readWorkspaceLocation, workspaceTarget, type WorkspaceSection } from '@/utils/workspaceLocation'
import type { MasteryLevel, ProblemContentUpdate } from '@/types/problem'

const DictationView = defineAsyncComponent(() => import('@/views/dictation/DictationView.vue'))
const ProblemImportView = defineAsyncComponent(() => import('@/views/problem-import/ProblemImportView.vue'))
const route = useRoute()
const router = useRouter()
const store = useQuickReviewStore()
const dictationStore = useDictationStore()
const { settingsMenuOpen } = useSettingsMenu()
const { todayQueue, currentProblemId, currentProblem, hintVisible, answerVisible, loading, detailLoading,
  submitting, error, currentDraft, saveState, editing, editContent, editLoading, editSaving, editError, contentRevision } = storeToRefs(store)

const PANELS = [
  { key: 'notes', label: '我的笔记', icon: NotebookPen },
  { key: 'recall', label: '回忆复习', icon: BrainCircuit },
  { key: 'dictation', label: '默写代码', icon: SquarePen },
] as const
type Panel = (typeof PANELS)[number]['key']
const MOBILE_LABELS: Record<Panel, string> = { notes: '笔记', recall: '回忆', dictation: '默写' }
const mobileQuery = window.matchMedia?.('(max-width: 720px)')
const narrow = ref(mobileQuery?.matches ?? false)
function syncWidth(): void { narrow.value = mobileQuery?.matches ?? false }
const location = computed(() => {
  try { return readWorkspaceLocation(route, narrow.value ? 'description' : 'notes') }
  catch { return null }
})
const section = computed(() => location.value?.section ?? 'notes')
const activePanel = computed<Panel>(() => section.value === 'description' ? 'notes' : section.value === 'solution' ? 'dictation' : section.value)
const mobilePanel = computed(() => section.value === 'solution' ? 'dictation' : section.value)
const locationError = ref('')
const locationPending = ref(false)
const locationReady = computed(() => !locationError.value && !!currentProblem.value && currentProblem.value.leetcodeNumber === location.value?.leetcodeNumber)
const active = ref(true)
const importOpen = computed(() => active.value && route.query.import === '1')
const pickerOpen = computed(() => active.value && route.query.picker === '1')
const importVisited = ref(importOpen.value)
const dictationVisited = ref(activePanel.value === 'dictation')
const importing = ref(false)
const notice = ref('')
const statementBody = ref<HTMLElement | null>(null)
const recallBody = ref<HTMLElement | null>(null)
const notePanel = ref<InstanceType<typeof ProblemNotePanel> | null>(null)
const dictationPanel = ref<{ hasDialog: boolean } | null>(null)
const blocked = computed(() => locationPending.value || loading.value || detailLoading.value || submitting.value || dictationStore.submitting || importing.value)
const notesRevision = ref(0)
const templateRevision = ref(0)

watch(activePanel, (panel) => {
  if (panel === 'dictation') dictationVisited.value = true
})
watch(importOpen, (open) => { if (open) importVisited.value = true })
watch(currentProblemId, async () => {
  notice.value = ''
  await nextTick()
  if (statementBody.value) statementBody.value.scrollTop = 0
})
watch(contentRevision, () => { templateRevision.value += 1 })
watch(notesRevision, async () => { await notePanel.value?.reload() })

async function saveNote(): Promise<boolean> {
  if (await notePanel.value?.flush() === false) {
    notice.value = '笔记尚未保存成功，请重试保存后再继续。'
    return false
  }
  return true
}

async function canChangeProblem(): Promise<boolean> {
  if (editing.value) {
    notice.value = '请先保存或取消题目编辑。'
    return false
  }
  return saveNote()
}

let navigationSequence = 0
let queueLoaded = todayQueue.value.length > 0
let queueRequest: Promise<void> | null = null
let locationTask: Promise<void> = Promise.resolve()

async function syncLocation(force = false): Promise<void> {
  if (!route.meta.workspace) return
  const sequence = ++navigationSequence
  if (force) queueLoaded = false
  store.cancelProblemLoad()
  locationPending.value = true
  locationError.value = ''
  error.value = ''
  try {
    const target = readWorkspaceLocation(route, narrow.value ? 'description' : 'notes')
    if (!queueLoaded) {
      queueRequest ??= store.loadQueue({ loadDetail: false })
      await queueRequest
      if (sequence !== navigationSequence) return
      queueRequest = null
      if (error.value) throw new Error(error.value)
      queueLoaded = true
    }
    const item = target.leetcodeNumber === null
      ? todayQueue.value.find(item => item.problemId === currentProblemId.value)
        ?? todayQueue.value.find(item => !item.completed) ?? todayQueue.value[0]
      : todayQueue.value.find(item => item.leetcodeNumber === target.leetcodeNumber)
    if (!item) throw new Error(target.leetcodeNumber === null ? '暂无可学习题目。' : `LeetCode 第 ${target.leetcodeNumber} 题不存在或未启用。`)
    const canonical = workspaceTarget(item.leetcodeNumber, target.section, route.query)
    if (router.resolve(canonical).fullPath !== route.fullPath) {
      await router.replace(canonical)
      return
    }
    if (force || currentProblem.value?.problemId !== item.problemId) {
      if (!await store.loadProblem(item.problemId, { keepPanelState: currentProblem.value?.problemId === item.problemId })) {
        if (sequence === navigationSequence) throw new Error(error.value || '题目加载失败，请重试。')
        return
      }
    }
    if (sequence !== navigationSequence) return
    if (target.section === 'recall') {
      answerVisible.value = target.answer
      if (target.answer) {
        await nextTick()
        const body = recallBody.value
        const answer = body?.querySelector('.answer-panel')
        if (sequence === navigationSequence && body && answer) body.scrollTop += answer.getBoundingClientRect().top - body.getBoundingClientRect().top
      }
    }
  } catch (cause) {
    if (sequence === navigationSequence) locationError.value = cause instanceof Error ? cause.message : '链接加载失败，请重试。'
  } finally {
    if (sequence === navigationSequence) locationPending.value = false
  }
}

function restoreLocation(force = false): void { locationTask = syncLocation(force) }
watch([() => route.path, () => route.query.problem, () => route.query.panel, () => route.query.answer], () => restoreLocation())

async function navigateProblem(problemId: number): Promise<boolean> {
  if (blocked.value || editing.value) return false
  const item = todayQueue.value.find(item => item.problemId === problemId)
  if (!item) return false
  const query = { ...route.query }
  delete query.answer
  const result = await router.push(workspaceTarget(item.leetcodeNumber, section.value === 'solution' ? 'dictation' : section.value, query))
  if (result) return currentProblemId.value === problemId
  await locationTask
  return !locationError.value && currentProblemId.value === problemId
}

function connectNavigation(): void {
  store.setBeforeProblemChange(canChangeProblem)
  store.setProblemNavigator(navigateProblem)
}
function disconnectNavigation(): void {
  store.setBeforeProblemChange()
  store.setProblemNavigator()
  navigationSequence += 1
  store.cancelProblemLoad()
}
onMounted(() => {
  mobileQuery?.addEventListener('change', syncWidth)
  connectNavigation()
  restoreLocation()
})
onActivated(() => { active.value = true; connectNavigation() })
onDeactivated(() => { active.value = false; disconnectNavigation() })
onBeforeUnmount(() => {
  mobileQuery?.removeEventListener('change', syncWidth)
  disconnectNavigation()
})

async function guardLocation(to: RouteLocationNormalized): Promise<boolean> {
  if (importing.value) return false
  if (to.query.import === '1' && route.query.import !== '1') return !blocked.value && await canChangeProblem()
  const contentChanged = to.path !== route.path || to.query.problem !== route.query.problem || to.query.panel !== route.query.panel || to.query.answer !== route.query.answer
  if (!contentChanged) return true
  if (submitting.value || dictationStore.submitting) return false
  if (editing.value) return canChangeProblem()
  let nextNumber: number | null = null
  try { nextNumber = readWorkspaceLocation(to).leetcodeNumber } catch { /* 无效链接也须先保存当前笔记。 */ }
  return nextNumber === currentProblem.value?.leetcodeNumber || !currentProblem.value || await canChangeProblem()
}
onBeforeRouteLeave(async to => to.meta.workspace ? guardLocation(to) : !blocked.value && await canChangeProblem())
onBeforeRouteUpdate(guardLocation)

async function selectPanel(panel: WorkspaceSection): Promise<void> {
  if (blocked.value || editing.value || !currentProblem.value) return
  await router.push(workspaceTarget(currentProblem.value.leetcodeNumber, panel, route.query))
}

function toggleRecallAnswer(): void {
  if (activePanel.value !== 'recall' || blocked.value) return
  const query = { ...route.query }
  if (answerVisible.value) delete query.answer
  else query.answer = '1'
  void router.replace({ path: route.path, query })
}

function panelKeydown(event: KeyboardEvent, index: number): void {
  if (!['ArrowLeft', 'ArrowRight', 'Home', 'End'].includes(event.key)) return
  event.preventDefault()
  event.stopPropagation()
  const next = event.key === 'Home' ? 0 : event.key === 'End' ? PANELS.length - 1 : (index + (event.key === 'ArrowRight' ? 1 : -1) + PANELS.length) % PANELS.length
  const panel = PANELS[next]
  if (panel) {
    selectPanel(panel.key)
    document.getElementById(`tab-${panel.key}`)?.focus()
  }
}

function closeTools(): void {
  if (importing.value) return
  const query = { ...route.query }
  delete query.import
  delete query.picker
  void router.replace({ query })
}

async function pickProblem(problemId: number): Promise<void> {
  if (blocked.value) return
  if (await store.openProblem(problemId)) closeTools()
}

async function imported(problemId: number): Promise<void> {
  await store.refreshQueue({ reloadDetail: false })
  if (problemId !== currentProblemId.value) return
  if (!await saveNote()) return
  await store.loadProblem(problemId, { keepPanelState: true })
  notesRevision.value += 1
  templateRevision.value += 1
}

async function submit(result: Exclude<MasteryLevel, 'NEW'>): Promise<void> {
  if (activePanel.value !== 'recall') return
  try { await store.submit(result) }
  catch (cause) { notice.value = cause instanceof Error ? cause.message : '提交失败，请重试' }
}

function recallAction(action: () => void): void {
  if (activePanel.value === 'recall') action()
}

async function enterEdit(): Promise<void> {
  if (blocked.value || !await saveNote()) return
  await selectPanel('notes')
  await store.enterEdit()
}

async function saveContent(payload: ProblemContentUpdate): Promise<void> {
  if (await saveNote()) await store.saveEdit(payload)
}

useReviewShortcuts({
  onForgot: () => void submit('FORGOT'),
  onFuzzy: () => void submit('FUZZY'),
  onKnown: () => void submit('KNOWN'),
  onToggleHint: () => recallAction(store.toggleHint),
  onToggleAnswer: toggleRecallAnswer,
  onNext: () => void store.move(1),
  onPrevious: () => void store.move(-1),
}, (event) => ((activePanel.value === 'recall' && (!narrow.value || mobilePanel.value === 'recall')) || ['ArrowLeft', 'ArrowRight'].includes(event.key))
  && active.value && !blocked.value && !editing.value && !importOpen.value && !pickerOpen.value && !settingsMenuOpen.value && !dictationPanel.value?.hasDialog
  && !document.activeElement?.closest('[role="dialog"], [role="alertdialog"]'))
</script>

<template>
  <main class="workspace" :class="`mobile-${mobilePanel}`">
    <div v-if="locationError || notice || error" class="workspace-error" role="alert">
      <span>{{ locationError || notice || error }}</span>
      <button v-if="locationError || error" type="button" @click="restoreLocation(true)">重试</button>
      <RouterLink v-if="locationError" to="/problems">返回题目</RouterLink>
    </div>
    <Teleport to="#workspace-tabs-slot" defer>
      <nav class="mobile-tabs" aria-label="学习内容">
        <button type="button" :aria-pressed="mobilePanel === 'description'" aria-label="题目" title="题目" @click="selectPanel('description')"><FileText :size="18" /></button>
        <button v-for="panel in PANELS" :key="panel.key" type="button" :aria-pressed="mobilePanel === panel.key" :aria-label="MOBILE_LABELS[panel.key]" :title="MOBILE_LABELS[panel.key]" @click="selectPanel(panel.key)"><component :is="panel.icon" :size="18" /></button>
      </nav>
    </Teleport>
    <LoadingState v-if="locationPending && !locationReady" />
    <div v-show="locationReady" class="workspace-grid" :aria-busy="locationPending || detailLoading" :inert="blocked">
      <section class="statement-pane">
        <header class="pane-heading"><span><FileText :size="16" /><span class="pane-heading-text">题目描述</span></span><button type="button" :disabled="!currentProblem || editing" aria-label="编辑题目" title="编辑题目" @click="enterEdit"><SquarePen :size="15" /><span class="pane-heading-text">编辑</span></button></header>
        <div ref="statementBody" class="statement-body">
          <template v-if="currentProblem">
            <ProblemHeader :number="currentProblem.leetcodeNumber" :title="currentProblem.title" :difficulty="currentProblem.difficulty" :tags="currentProblem.tags" :updated-at="currentProblem.updatedAt" :external-imported="currentProblem.externalImported" />
            <ProblemDescription :markdown="currentProblem.descriptionMarkdown" />
          </template>
          <LoadingState v-else-if="loading || detailLoading" />
          <p v-else class="empty-message">暂无可学习题目</p>
        </div>
      </section>
      <section class="learning-pane">
        <nav class="study-tabs" role="tablist" aria-label="学习方式">
          <button v-for="(panel, index) in PANELS" :id="`tab-${panel.key}`" :key="panel.key" type="button" role="tab" :aria-selected="activePanel === panel.key" :aria-controls="`panel-${panel.key}`" :tabindex="activePanel === panel.key ? 0 : -1" :disabled="editing" @click="selectPanel(panel.key)" @keydown="panelKeydown($event, index)"><component :is="panel.icon" :size="16" />{{ panel.label }}</button>
        </nav>
        <div v-if="editing" class="edit-body">
          <LoadingState v-if="editLoading" />
          <ProblemContentEditor v-else-if="editContent" :content="editContent" :saving="editSaving" :error-message="editError" @save="saveContent" @cancel="store.cancelEdit" />
          <div v-else role="alert"><p>{{ editError }}</p><button type="button" @click="store.cancelEdit">取消编辑</button></div>
        </div>
        <div v-if="currentProblem" v-show="!editing" class="learning-content">
          <div v-show="activePanel === 'notes'" id="panel-notes" class="study-panel note-body" role="tabpanel" aria-labelledby="tab-notes">
            <ProblemNotePanel ref="notePanel" :problem-id="currentProblem.problemId" />
          </div>
          <div v-show="activePanel === 'recall'" id="panel-recall" class="study-panel recall-body" role="tabpanel" aria-labelledby="tab-recall">
            <div ref="recallBody" class="recall-scroll">
              <RecallQuestionList :questions="currentProblem.recallQuestions" :draft="currentDraft" :answers-visible="answerVisible" :save-state="saveState" @update="store.updateDraft" />
              <HintPanel :visible="hintVisible" :hint="currentProblem.hint" @toggle="store.toggleHint" />
              <AnswerPanel :visible="answerVisible" :core-idea="currentProblem.coreIdea" :mistakes="currentProblem.mistakes" :key-code="currentProblem.keyCode" @toggle="toggleRecallAnswer" />
              <details class="shortcuts-help"><summary>键盘快捷键</summary><KeyboardShortcutPanel /></details>
            </div>
            <ReviewResultButtons :loading="submitting" @select="submit" />
          </div>
          <div v-show="activePanel === 'dictation'" id="panel-dictation" class="study-panel dictation-body" role="tabpanel" aria-labelledby="tab-dictation">
            <DictationView v-if="dictationVisited" ref="dictationPanel" :problem-id="currentProblem.problemId" :active="active && locationReady && !locationPending && activePanel === 'dictation' && !importOpen && !pickerOpen && !editing && !detailLoading && (!narrow || mobilePanel === 'dictation')" :revision="templateRevision" :show-answer="section === 'solution'" @answer="selectPanel($event ? 'solution' : 'dictation')" @next="store.move(1)" />
          </div>
        </div>
        <LoadingState v-else-if="loading || detailLoading" />
      </section>
      <div v-if="detailLoading && currentProblem" class="refresh-indicator" role="status">正在读取题目…</div>
    </div>
    <WorkspaceDrawer v-if="importVisited" :open="importOpen" title="导入学习资料" :busy="importing" @close="closeTools">
      <ProblemImportView :active="importOpen" :initial-number="currentProblem?.leetcodeNumber" :before-import="saveNote" embedded @imported="imported" @busy="importing = $event" />
    </WorkspaceDrawer>
    <WorkspaceDrawer :open="pickerOpen" title="选择题目" compact @close="closeTools">
      <ReviewQueue :items="todayQueue" :current-problem-id="currentProblemId" :active="pickerOpen" @select="pickProblem" />
    </WorkspaceDrawer>
  </main>
</template>

<style scoped>
.workspace { display: flex; height: calc(var(--viewport-height) - var(--topbar-height)); min-height: 0; flex-direction: column; overflow: hidden; background: var(--bg-primary); }
.workspace-grid { position: relative; display: grid; flex: 1; min-height: 0; grid-template-columns: minmax(0, .94fr) minmax(0, 1.06fr); }
.statement-pane, .learning-pane { display: flex; min-width: 0; min-height: 0; flex-direction: column; background: var(--bg-card); }
.statement-pane { border-right: 1px solid var(--border-secondary); }
.pane-heading, .study-tabs { display: flex; height: 46px; min-height: 46px; flex: 0 0 auto; align-items: center; padding: 0 18px; gap: 4px; border-bottom: 1px solid var(--border-secondary); }
.pane-heading { justify-content: space-between; }
.pane-heading span, .pane-heading button, .study-tabs button { display: inline-flex; align-items: center; gap: 7px; font-size: calc(12px * var(--ui-font-ratio)); white-space: nowrap; }
.pane-heading span { color: var(--text-secondary); }
.pane-heading button { min-height: 30px; padding: 0 8px; color: var(--text-muted); border: 0; border-radius: 6px; background: transparent; }
.study-tabs { padding-inline: 12px; overflow-x: auto; }
.study-tabs button { height: 100%; padding: 0 13px; flex: 0 0 auto; color: var(--text-muted); border: 0; border-bottom: 2px solid transparent; background: transparent; }
.study-tabs button[aria-selected="true"] { color: var(--primary-hover); border-bottom-color: var(--primary); }
.study-tabs button:hover, .pane-heading button:hover { background: var(--bg-card-hover); color: var(--text-primary); }
.statement-body, .note-body, .recall-scroll, .edit-body { min-width: 0; min-height: 0; overflow: auto; padding: 20px 24px 28px; overscroll-behavior: contain; scrollbar-gutter: stable; }
.statement-body { flex: 1; }
.learning-content { display: flex; min-height: 0; flex: 1; }
.study-panel { width: 100%; min-width: 0; min-height: 0; flex: 1; }
.recall-body { display: flex; flex-direction: column; overflow: hidden; }
.recall-scroll { flex: 1; }
.recall-body :deep(.result-buttons) { flex: 0 0 auto; min-width: 0; margin: 0; padding: 12px 20px; border-top: 1px solid var(--border-secondary); }
.dictation-body { display: flex; overflow: hidden; }
.edit-body { flex: 1; }
.refresh-indicator { position: absolute; top: 48px; right: 18px; padding: 5px 10px; border-radius: 6px; color: var(--text-secondary); background: var(--bg-input); font-size: calc(12px * var(--ui-font-ratio)); }
.workspace-error { display: flex; flex: 0 0 auto; align-items: center; gap: 10px; padding: 8px 18px; color: var(--danger-strong); background: var(--danger-soft); }
.workspace-error button { color: inherit; border: 1px solid currentColor; background: transparent; border-radius: 5px; }
.empty-message { color: var(--text-muted); }
.shortcuts-help { margin-top: 20px; color: var(--text-muted); font-size: calc(12px * var(--ui-font-ratio)); }
.shortcuts-help summary { cursor: pointer; }
.mobile-tabs { display: none; }
@media (max-width: 1100px) { .statement-body, .note-body, .recall-scroll { padding: 16px; } .study-tabs button { padding-inline: 9px; } }
@media (max-width: 720px) {
  .workspace-grid { grid-template-columns: minmax(0, 1fr); }
  /* 页签由 Teleport 移入顶栏 #workspace-tabs-slot，与题号导航同行 */
  .mobile-tabs { display: flex; height: 44px; flex: 1 1 auto; min-width: 0; align-items: center; }
  .mobile-tabs button { display: inline-flex; align-items: center; justify-content: center; flex: 1 1 0; min-width: 0; height: 44px; padding: 0; color: var(--text-muted); border: 0; border-radius: 8px; background: transparent; }
  .mobile-tabs button[aria-pressed="true"] { color: var(--primary); background: var(--primary-soft); }
  .pane-heading { height: 34px; min-height: 34px; padding: 0 10px; }
  .pane-heading .pane-heading-text { display: none; }
  .statement-pane { display: none; border-right: 0; }
  .mobile-description .statement-pane { display: flex; }
  .mobile-description .learning-pane { display: none; }
  .study-tabs { display: none; }
  .note-body, .statement-body, .recall-scroll { padding: 14px; }
  .refresh-indicator { top: 5px; }
  .recall-body :deep(.result-buttons) { padding: 12px; }
}
</style>
