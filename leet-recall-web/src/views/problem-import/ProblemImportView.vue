<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { useDialogFocus } from '@/composables/useDialogFocus'
import { CheckCircle2, ChevronDown, Clipboard, Download, FileJson, FileText, ListFilter, RefreshCw, Search, X } from 'lucide-vue-next'
import { problemImportApi } from '@/api/problemImport'
import MarkdownContent from '@/components/common/MarkdownContent.vue'
import ConfirmDialog from '@/components/common/ConfirmDialog.vue'
import importSpecMarkdown from '@/content/external-import-spec.md?raw'
import type { Difficulty } from '@/types/problem'
import type { ExternalImportDraft, ExternalImportTaskPack, Hot100Manifest, Hot100Problem, ProblemCreated } from '@/types/import'

const props = withDefaults(defineProps<{
  active?: boolean
  embedded?: boolean
  initialNumber?: number
  beforeImport?: () => Promise<boolean>
}>(), { active: true, embedded: false, initialNumber: undefined, beforeImport: undefined })
const emit = defineEmits<{ imported: [problemId: number]; busy: [value: boolean] }>()
const importSpec = importSpecMarkdown
const browserDialog = ref<HTMLElement | null>(null)

const manifest = ref<Hot100Manifest | null>(null)
const task = ref<ExternalImportTaskPack | null>(null)
const selectedNumber = ref<number | null>(null)
const problemQuery = ref('')
const pickerOpen = ref(false)
const pickerRoot = ref<HTMLElement | null>(null)
const browserOpen = ref(false)
const browserQuery = ref('')
const browserSearchInput = ref<HTMLInputElement | null>(null)
const selectedGroup = ref('全部')
const selectedDifficulty = ref<'ALL' | Difficulty>('ALL')
const recentProblemNumbers = ref<number[]>([])
const solutionNotes = ref('')
const difficultyNotes = ref('')
const json = ref('')
const jsonFileInput = ref<HTMLInputElement | null>(null)
const lineNumbersRef = ref<HTMLElement | null>(null)
const draft = ref<ExternalImportDraft | null>(null)
const created = ref<ProblemCreated | null>(null)
const error = ref('')
const busy = ref(false)
const readingJsonFile = ref(false)
const confirming = ref(false)
const copied = ref(false)
const overwriteDialogOpen = ref(false)
useDialogFocus(() => props.active && browserOpen.value, browserDialog, closeProblemBrowser)
watch(() => props.active, (active) => {
  if (active) document.addEventListener('click', closePickerWhenClickedOutside)
  else {
    document.removeEventListener('click', closePickerWhenClickedOutside)
    pickerOpen.value = false
    browserOpen.value = false
    overwriteDialogOpen.value = false
  }
}, { immediate: true })
watch([busy, confirming, readingJsonFile], () => emit('busy', busy.value || confirming.value || readingJsonFile.value))
watch(() => [manifest.value, props.active, props.initialNumber], () => {
  if (!props.active || selectedNumber.value !== null || json.value.trim()) return
  const problem = manifest.value?.problems.find((item) => item.leetcodeNumber === props.initialNumber)
  if (problem) void selectProblem(problem)
})

const MAX_JSON_FILE_BYTES = 200_000
const RECENT_PROBLEMS_KEY = 'leetrecall.problem-import.recent'
const MAX_RECENT_PROBLEMS = 5
const difficultyOptions: Array<{ value: 'ALL' | Difficulty; label: string }> = [
  { value: 'ALL', label: '全部' },
  { value: 'EASY', label: '简单' },
  { value: 'MEDIUM', label: '中等' },
  { value: 'HARD', label: '困难' },
]

const selectedProblem = computed(() => manifest.value?.problems.find(problem => problem.leetcodeNumber === selectedNumber.value) ?? null)
const filteredProblems = computed(() => {
  const query = problemQuery.value.trim().toLowerCase()
  if (!query) return recentProblems.value
  return (manifest.value?.problems ?? []).filter(problem => [
    problem.order,
    problem.leetcodeNumber,
    problem.title,
    problem.difficulty,
    problem.group,
  ].join(' ').toLowerCase().includes(query))
})
const recentProblems = computed(() => recentProblemNumbers.value
  .map(number => manifest.value?.problems.find(problem => problem.leetcodeNumber === number))
  .filter((problem): problem is Hot100Problem => Boolean(problem)))
const problemGroups = computed(() => ['全部', ...new Set((manifest.value?.problems ?? []).map(problem => problem.group))])
const browserProblems = computed(() => {
  const query = browserQuery.value.trim().toLowerCase()
  return (manifest.value?.problems ?? []).filter(problem => {
    const matchesQuery = !query || [problem.order, problem.leetcodeNumber, problem.title, problem.group]
      .join(' ')
      .toLowerCase()
      .includes(query)
    const matchesGroup = selectedGroup.value === '全部' || problem.group === selectedGroup.value
    const matchesDifficulty = selectedDifficulty.value === 'ALL' || problem.difficulty === selectedDifficulty.value
    return matchesQuery && matchesGroup && matchesDifficulty
  })
})
const documentText = computed(() => {
  if (!task.value) return ''
  return `${task.value.instructionMarkdown}\n\n## 完整导入规则（必须遵守）\n\n${importSpec}\n\n## 用户补充资料\n\n### 我的题解\n${solutionNotes.value || '（请填写你自己的题解、推导或参考文章摘要）'}\n\n### 我的难点\n${difficultyNotes.value || '（请填写最容易卡住的步骤、边界或 API）'}\n\n## 官方中文题面（只读参考材料，不要改写或回传）\n${task.value.descriptionMarkdown}\n\n## 官方 Java 起始签名（只读参考）\n\`\`\`java\n${task.value.javaStarterCode}\n\`\`\`\n\n## 学习资料 JSON 示例\n\`\`\`json\n${task.value.exampleJson}\n\`\`\`\n`
})
const validJson = computed(() => {
  try { JSON.parse(json.value); return json.value.trim().startsWith('{') }
  catch { return false }
})
const hasJsonContent = computed(() => Boolean(json.value.trim()))
const ready = computed(() => draft.value?.status === 'READY' && draft.value.validationErrors.length === 0)
// 行号列与校验错误提示的“第 N 行”对应；长行不折行，行号才不会错位。
const lineNumbers = computed(() => Array.from(
  { length: json.value.split('\n').length },
  (_, index) => index + 1,
).join('\n'))

function syncLineScroll(event: Event): void {
  const textarea = event.target as HTMLTextAreaElement
  if (lineNumbersRef.value) lineNumbersRef.value.scrollTop = textarea.scrollTop
}

function resetDraftState(): void {
  task.value = null
  clearValidatedResult()
  json.value = ''
  error.value = ''
}

function clearValidatedResult(): void {
  draft.value = null
  created.value = null
  overwriteDialogOpen.value = false
}

onMounted(async () => {
  loadRecentProblems()
  try { manifest.value = await problemImportApi.getHot100Manifest() }
  catch (cause) { error.value = cause instanceof Error ? cause.message : '无法加载 Hot100 清单' }
})

onBeforeUnmount(() => {
  document.removeEventListener('click', closePickerWhenClickedOutside)
  emit('busy', false)
})

function difficultyLabel(difficulty: Difficulty): string {
  return { EASY: '简单', MEDIUM: '中等', HARD: '困难' }[difficulty]
}

function problemLabel(problem: Hot100Problem): string {
  return `${problem.leetcodeNumber} · ${problem.title}（${difficultyLabel(problem.difficulty)}）`
}

function loadRecentProblems(): void {
  try {
    const stored = JSON.parse(localStorage.getItem(RECENT_PROBLEMS_KEY) ?? '[]')
    if (Array.isArray(stored)) {
      recentProblemNumbers.value = stored.filter(value => Number.isInteger(value)).slice(0, MAX_RECENT_PROBLEMS)
    }
  } catch {
    recentProblemNumbers.value = []
  }
}

function rememberProblem(problem: Hot100Problem): void {
  recentProblemNumbers.value = [
    problem.leetcodeNumber,
    ...recentProblemNumbers.value.filter(number => number !== problem.leetcodeNumber),
  ].slice(0, MAX_RECENT_PROBLEMS)
  try {
    localStorage.setItem(RECENT_PROBLEMS_KEY, JSON.stringify(recentProblemNumbers.value))
  } catch {
    // Browsers may disable storage; selecting and loading the problem should still work.
  }
}

async function selectProblem(problem: Hot100Problem): Promise<void> {
  selectedNumber.value = problem.leetcodeNumber
  problemQuery.value = problemLabel(problem)
  pickerOpen.value = false
  browserOpen.value = false
  rememberProblem(problem)
  resetDraftState()
  await loadTask()
}

async function openProblemBrowser(): Promise<void> {
  pickerOpen.value = false
  browserOpen.value = true
  await nextTick()
  browserSearchInput.value?.focus()
}

function closeProblemBrowser(): void {
  browserOpen.value = false
}

function onSearchInput(): void {
  if (selectedProblem.value && problemQuery.value !== problemLabel(selectedProblem.value)) {
    selectedNumber.value = null
    resetDraftState()
  }
  pickerOpen.value = true
}

function clearProblem(): void {
  selectedNumber.value = null
  problemQuery.value = ''
  pickerOpen.value = true
  resetDraftState()
}

function closePickerWhenClickedOutside(event: MouseEvent): void {
  if (pickerRoot.value && !pickerRoot.value.contains(event.target as Node)) pickerOpen.value = false
}

function handlePickerKeydown(event: KeyboardEvent): void {
  if (event.key === 'Escape') pickerOpen.value = false
  const onlyProblem = filteredProblems.value.length === 1 ? filteredProblems.value[0] : null
  if (event.key === 'Enter' && pickerOpen.value && onlyProblem) {
    event.preventDefault()
    selectProblem(onlyProblem)
  }
}

function onJsonInput(): void {
  clearValidatedResult()
  error.value = ''
}

function openJsonFilePicker(): void {
  jsonFileInput.value?.click()
}

function isJsonFile(file: File): boolean {
  return file.name.toLowerCase().endsWith('.json') || file.type === 'application/json'
}

async function readJsonFile(event: Event): Promise<void> {
  const input = event.target as HTMLInputElement
  const file = input.files?.[0]
  input.value = ''

  if (!file) return
  clearValidatedResult()
  if (!isJsonFile(file)) {
    error.value = '仅支持选择 .json 文件或 application/json 类型文件。'
    return
  }
  if (file.size === 0) {
    error.value = 'JSON 文件不能为空。'
    return
  }
  if (file.size > MAX_JSON_FILE_BYTES) {
    error.value = 'JSON 文件不能超过 200 KB。'
    return
  }

  readingJsonFile.value = true
  error.value = ''
  try {
    const content = await file.text()
    if (!content.trim()) {
      error.value = 'JSON 文件不能为空。'
      return
    }
    json.value = content
    clearValidatedResult()
  } catch {
    error.value = 'JSON 文件读取失败，请重新选择。'
  } finally {
    readingJsonFile.value = false
  }
}

async function loadTask(): Promise<void> {
  if (!selectedProblem.value) return
  busy.value = true; error.value = ''; draft.value = null; created.value = null
  try { task.value = await problemImportApi.getExternalImportTask(selectedProblem.value.leetcodeNumber) }
  catch (cause) { error.value = cause instanceof Error ? cause.message : '无法加载任务包' }
  finally { busy.value = false }
}

async function validateJson(): Promise<void> {
  if (!task.value || !json.value.trim()) return
  busy.value = true; error.value = ''; created.value = null
  try {
    draft.value = await problemImportApi.createExternalDraft({ hot100Number: task.value.leetcodeNumber, content: json.value })
  } catch (cause) { error.value = cause instanceof Error ? cause.message : 'JSON 校验失败' }
  finally { busy.value = false }
}

async function revalidate(): Promise<void> {
  if (!draft.value || !task.value || !json.value.trim()) return
  busy.value = true; error.value = ''
  try { draft.value = await problemImportApi.updateExternalDraft(draft.value.id, { hot100Number: task.value.leetcodeNumber, content: json.value }) }
  catch (cause) { error.value = cause instanceof Error ? cause.message : 'JSON 校验失败' }
  finally { busy.value = false }
}

async function confirmImport(): Promise<void> {
  if (!draft.value || !ready.value) return
  if (draft.value.impact.requiresConfirmation) {
    overwriteDialogOpen.value = true
    return
  }
  await runImport()
}

async function runImport(): Promise<void> {
  if (!draft.value || !ready.value || confirming.value) return
  const overwrite = draft.value.impact.requiresConfirmation
  const draftId = draft.value.id
  overwriteDialogOpen.value = false
  confirming.value = true; error.value = ''
  try {
    if (props.beforeImport && !await props.beforeImport()) {
      error.value = '笔记保存失败，请先保存笔记再导入。'
      return
    }
    const result = await problemImportApi.confirmExternalDraft(draftId, overwrite)
    draft.value = result
    created.value = result.publishedProblemId ? { problemId: result.publishedProblemId, leetcodeNumber: result.leetcodeNumber, title: task.value?.title ?? '' } : null
    if (result.publishedProblemId) emit('imported', result.publishedProblemId)
  } catch (cause) { error.value = cause instanceof Error ? cause.message : '确认导入失败' }
  finally { confirming.value = false }
}

async function copyDocument(): Promise<void> {
  if (!documentText.value) return
  try {
    await navigator.clipboard.writeText(documentText.value)
    copied.value = true
    window.setTimeout(() => { copied.value = false }, 1600)
  } catch {
    error.value = '当前浏览器无法复制，请直接从下方预览复制任务文档。'
  }
}

function downloadDocument(): void {
  if (!documentText.value || !task.value) return
  const blob = new Blob([documentText.value], { type: 'text/markdown;charset=utf-8' })
  const url = URL.createObjectURL(blob); const link = document.createElement('a')
  link.href = url; link.download = `leetrecall-${task.value.leetcodeNumber}-${task.value.title}-外部AI任务包.md`; link.click(); URL.revokeObjectURL(url)
}

function downloadJsonExample(): void {
  if (!task.value?.exampleJson) return
  const blob = new Blob([task.value.exampleJson], { type: 'application/json;charset=utf-8' })
  const url = URL.createObjectURL(blob); const link = document.createElement('a')
  link.href = url; link.download = `leetrecall-${task.value.leetcodeNumber}-${task.value.title}-JSON示例.json`; link.click(); URL.revokeObjectURL(url)
}
</script>

<template>
  <main class="import-page" :class="{ embedded }" :inert="!active || confirming">
    <header v-if="!embedded" class="page-header">
      <div><p>EXTERNAL JSON IMPORT</p><h1>外部 AI 学习资料导入</h1><span>系统不调用 AI。你负责生成，LeetRecall 只检查能否安全导入和正常使用。</span></div>
    </header>

    <section class="panel app-card app-card--raised">
      <div class="section-heading"><div><h2>1. 选择题目并准备任务文档</h2><p>选中 Hot100 题目后自动加载任务包，包含中文题面、官方 Java 签名、字段说明和 JSON 示例。</p></div></div>
      <div ref="pickerRoot" class="field problem-picker">
        <label for="hot100-search">Hot100 题目</label>
        <div class="picker-row">
          <div class="search-control" :class="{ open: pickerOpen }">
            <Search :size="17" aria-hidden="true" />
            <input
              id="hot100-search"
              v-model="problemQuery"
              type="search"
              autocomplete="off"
              placeholder="搜索题号或名称，如：146 / LRU"
              role="combobox"
              aria-autocomplete="list"
              aria-controls="hot100-results"
              :aria-expanded="pickerOpen"
              :disabled="!manifest"
              @focus="pickerOpen = true"
              @input="onSearchInput"
              @keydown="handlePickerKeydown"
            />
            <button v-if="problemQuery" class="clear-search" type="button" aria-label="清空题目搜索" @click="clearProblem"><X :size="16" /></button>
            <ChevronDown v-else class="picker-chevron" :class="{ rotated: pickerOpen }" :size="17" aria-hidden="true" />
          </div>
          <button data-test="browse-problems" class="secondary browse-button" type="button" :disabled="!manifest" @click="openProblemBrowser">
            <ListFilter :size="16" />浏览全部
          </button>
        </div>
        <div v-if="pickerOpen" id="hot100-results" class="search-results" role="listbox" aria-label="Hot100 搜索结果">
          <p v-if="!problemQuery.trim() && filteredProblems.length" class="result-section-label">最近选择</p>
          <button v-for="problem in filteredProblems" :key="problem.leetcodeNumber" class="search-result" type="button" :class="{ selected: selectedNumber === problem.leetcodeNumber }" @click="selectProblem(problem)">
            <span class="result-order">{{ problem.leetcodeNumber }}</span>
            <span class="result-title"><strong>{{ problem.title }}</strong><small>{{ problem.group }} · {{ difficultyLabel(problem.difficulty) }} · Hot100 {{ problem.order }}</small></span>
          </button>
          <p v-if="!problemQuery.trim() && !filteredProblems.length" class="no-results">输入题号或名称开始搜索，也可以点击“浏览全部”按分类查找。</p>
          <p v-else-if="!filteredProblems.length" class="no-results">没有匹配的 Hot100 题目，请检查题号或关键词。</p>
        </div>
      </div>
      <p v-if="busy" class="loading-task"><RefreshCw :size="15" class="spin" />正在加载任务包…</p>
      <div v-if="task" class="task-meta"><a :href="task.problemUrl" target="_blank" rel="noreferrer">打开力扣中文题面</a><span>题号、标题、难度和官方 Java 签名已锁定；题面可改写，但 Markdown 代码围栏必须闭合。</span></div>
      <details v-if="task" class="optional-notes">
        <summary>补充题解或难点（可选）</summary>
        <div class="notes-grid">
          <label class="field"><span>我的题解 / 参考摘要（可选）</span><textarea v-model="solutionNotes" rows="5" placeholder="把你找到的题解、自己的推导或关键代码思路贴在这里，再复制任务文档给外部 AI。" /></label>
          <label class="field"><span>我的难点（可选）</span><textarea v-model="difficultyNotes" rows="5" placeholder="例如：不理解更新顺序、边界条件、复杂度优化或设计题 API。" /></label>
        </div>
      </details>
      <div v-if="task" class="doc-actions"><button class="secondary" @click="copyDocument"><Clipboard :size="16" />{{ copied ? '已复制' : '复制完整任务文档' }}</button><button class="secondary" @click="downloadDocument"><Download :size="16" />下载完整 Markdown</button><button class="secondary" @click="downloadJsonExample"><FileJson :size="16" />下载 JSON 示例</button></div>
      <details v-if="task" class="preview"><summary>预览将交给外部 AI 的任务文档</summary><pre>{{ documentText }}</pre></details>
    </section>

    <section class="panel app-card app-card--raised">
      <div class="section-heading"><div><h2>2. 粘贴或选择外部 AI 返回的 JSON</h2><p>只接受一个 JSON 对象；额外字段会在保存草稿时自动忽略，不影响导入。</p></div><button class="primary" type="button" :disabled="!task || !hasJsonContent || busy || readingJsonFile" @click="draft ? revalidate() : validateJson()">{{ busy ? '校验中…' : readingJsonFile ? '读取中…' : draft ? '重新校验' : '保存并校验' }}</button></div>
      <div class="json-actions">
        <input ref="jsonFileInput" data-test="json-file-input" class="json-file-input" type="file" accept=".json,application/json" :disabled="!task || busy || readingJsonFile" @change="readJsonFile" />
        <button data-test="json-file-picker" class="secondary" type="button" :disabled="!task || busy || readingJsonFile" @click="openJsonFilePicker"><FileJson :size="16" />{{ readingJsonFile ? '正在读取 JSON…' : '选择 JSON 文件' }}</button>
        <span>仅本地读取；支持单个 .json 文件，最大 200 KB。</span>
      </div>
      <label class="field"><span>标准 JSON</span>
        <div class="json-editor-wrap">
          <div ref="lineNumbersRef" class="line-numbers" aria-hidden="true">{{ lineNumbers }}</div>
          <textarea
            v-model="json"
            class="font-code json-editor"
            rows="20"
            wrap="off"
            placeholder="把外部 AI 的 JSON 原样粘贴到这里，或通过上方选择本地 JSON 文件。&#10;格式示例可在上方任务文档中复制。"
            @input="onJsonInput"
            @scroll="syncLineScroll"
          />
        </div>
      </label>
      <p v-if="!validJson && json.trim()" class="inline-error">当前内容不是合法的纯 JSON 对象。</p>
      <div v-if="draft" class="draft-result">
        <div class="status-line"><strong>状态：{{ draft.status }}</strong><span v-if="draft.compilePassed" class="passed">Java 21 编译通过</span><span v-else class="failed">Java 编译未通过</span></div>
        <ul v-if="draft.validationErrors.length" class="errors"><li v-for="item in draft.validationErrors" :key="item">{{ item }}</li></ul>
        <div class="impact"><strong>{{ draft.impact.overwriteExisting ? '学习资料覆盖影响' : '无法导入' }}</strong><span>保留：{{ draft.impact.preserved.join('、') }}</span><span>替换：{{ draft.impact.replaced.join('、') }}</span></div>
        <button class="primary confirm" :disabled="!ready || !draft.impact.overwriteExisting || confirming" @click="confirmImport"><CheckCircle2 :size="17" />{{ confirming ? '导入中…' : draft.impact.overwriteExisting ? '确认更新学习资料' : '官方题目不存在' }}</button>
      </div>
    </section>

    <div v-if="error" class="feedback error" role="alert">{{ error }}</div>
    <div v-if="created" class="feedback success" role="status"><CheckCircle2 :size="18" />已导入 {{ created.leetcodeNumber }} · {{ created.title }}；历史进度和记录已保留。</div>
    <details class="format-help app-card">
      <summary><FileText :size="18" /><span><strong>外部 AI 生成与导入规范</strong><small>点击展开字段定义、建议格式与必要校验</small></span><ChevronDown :size="18" aria-hidden="true" /></summary>
      <div class="rules-content"><MarkdownContent :markdown="importSpec" /></div>
    </details>

    <ConfirmDialog
      :open="active && overwriteDialogOpen"
      title="确认更新学习资料"
      :description="`题号 ${draft?.leetcodeNumber ?? ''} 已对应官方题目。本次只替换学习资料，保留题目 ID、官方标题、难度、题面、标签、学习进度、已有笔记、复习记录和历史默写记录；JSON 笔记只在现有笔记为空时填入。确定继续吗？`"
      confirm-label="确认更新学习资料"
      @confirm="runImport"
      @cancel="overwriteDialogOpen = false"
    />

    <Teleport to="body">
      <div v-if="active && browserOpen" class="problem-browser-backdrop" role="presentation" @click.self="closeProblemBrowser">
        <section ref="browserDialog" class="problem-browser" role="dialog" aria-modal="true" aria-labelledby="problem-browser-title">
          <header class="problem-browser-header">
            <div><h2 id="problem-browser-title">浏览 Hot100 题目</h2><p>按分类和难度缩小范围，选择后自动加载任务包。</p></div>
            <button class="icon-button" type="button" aria-label="关闭题目浏览" @click="closeProblemBrowser"><X :size="19" /></button>
          </header>
          <div class="browser-search">
            <Search :size="17" aria-hidden="true" />
            <input ref="browserSearchInput" v-model="browserQuery" type="search" autocomplete="off" placeholder="在全部题目中搜索题号或名称" />
            <button v-if="browserQuery" class="clear-search" type="button" aria-label="清空浏览搜索" @click="browserQuery = ''"><X :size="16" /></button>
          </div>
          <div class="filter-block">
            <span>分类</span>
            <div class="filter-options">
              <button v-for="group in problemGroups" :key="group" type="button" :class="{ active: selectedGroup === group }" :data-test="`group-${group}`" @click="selectedGroup = group">{{ group }}</button>
            </div>
          </div>
          <div class="filter-block">
            <span>难度</span>
            <div class="filter-options">
              <button v-for="option in difficultyOptions" :key="option.value" type="button" :class="{ active: selectedDifficulty === option.value }" :data-test="`difficulty-${option.value}`" @click="selectedDifficulty = option.value">{{ option.label }}</button>
            </div>
          </div>
          <div class="browser-result-heading"><strong>{{ browserProblems.length }} 道题</strong><span>LeetCode 题号 · Hot100 序号</span></div>
          <div class="browser-results" role="listbox" aria-label="Hot100 全部题目">
            <button v-for="problem in browserProblems" :key="problem.leetcodeNumber" class="browser-result" type="button" :class="{ selected: selectedNumber === problem.leetcodeNumber }" @click="selectProblem(problem)">
              <span class="browser-result-order">{{ problem.leetcodeNumber }}</span>
              <span class="browser-result-main"><strong>{{ problem.title }}</strong><small>{{ problem.group }} · Hot100 {{ problem.order }}</small></span>
              <span :class="['difficulty-badge', `difficulty-${problem.difficulty.toLowerCase()}`]">{{ difficultyLabel(problem.difficulty) }}</span>
            </button>
            <p v-if="!browserProblems.length" class="no-results browser-empty">当前筛选条件下没有题目。</p>
          </div>
        </section>
      </div>
    </Teleport>
  </main>
</template>

<style scoped>
.import-page { padding: 34px 22px 64px; }
.import-page.embedded { padding: 16px 18px 24px; }
.embedded .panel { padding: 18px; }
.embedded .doc-actions { flex-wrap: wrap; }
.optional-notes { margin-top: 14px; color: var(--text-secondary); font-size: calc(12px * var(--ui-font-ratio)); }
.optional-notes summary { cursor: pointer; }
.page-header { padding: 0 2px 22px; margin-bottom: 20px; border-bottom: 1px solid var(--border-secondary); }.page-header p { margin: 0 0 8px; color: var(--primary); font-size: calc(11px * var(--ui-font-ratio)); font-weight: 700; letter-spacing: .1em; }.page-header h1 { margin: 0 0 8px; font-size: calc(26px * var(--ui-font-ratio)); }.page-header span, .section-heading p { color: var(--text-muted); font-size: calc(13px * var(--ui-font-ratio)); }
.panel { padding: 22px; margin-bottom: 18px; }.section-heading { display: flex; align-items: flex-start; justify-content: space-between; gap: 16px; margin-bottom: 16px; }.section-heading h2 { margin: 0 0 5px; font-size: calc(17px * var(--ui-font-ratio)); }.section-heading p { margin: 0; line-height: 1.5; }.primary, .secondary { display: inline-flex; align-items: center; justify-content: center; gap: 7px; min-height: 40px; padding: 0 15px; border-radius: 8px; cursor: pointer; }.primary { color: var(--on-primary); border: 1px solid var(--primary); background: var(--primary); }.secondary { color: var(--text-primary); border: 1px solid var(--border-primary); background: var(--bg-input); }.primary:disabled, .secondary:disabled { opacity: .5; cursor: not-allowed; }
.field { display: grid; gap: 7px; color: var(--text-secondary); font-size: calc(12px * var(--ui-font-ratio)); }.field textarea { width: 100%; color: var(--text-primary); border: 1px solid var(--border-primary); border-radius: 8px; outline: none; background: var(--bg-input); }.field textarea { padding: 11px; resize: vertical; line-height: 1.6; }.problem-picker { position: relative; z-index: 2; }.picker-row { display: grid; grid-template-columns: minmax(0, 1fr) auto; gap: 10px; }.search-control { display: flex; align-items: center; min-height: 42px; padding: 0 11px; color: var(--text-muted); border: 1px solid var(--border-primary); border-radius: 8px; background: var(--bg-input); transition: border-color 150ms ease, box-shadow 150ms ease; }.search-control:focus-within, .search-control.open { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(255, 161, 22, .1); }.search-control input { width: 100%; min-width: 0; padding: 0 9px; color: var(--text-primary); border: 0; outline: 0; background: transparent; }.search-control input:disabled { cursor: wait; }.clear-search { display: grid; width: 28px; height: 28px; flex: 0 0 auto; color: var(--text-muted); border: 0; border-radius: 5px; place-items: center; background: transparent; }.clear-search:hover { color: var(--text-primary); background: var(--bg-card-hover); }.picker-chevron { flex: 0 0 auto; transition: transform 150ms ease; }.picker-chevron.rotated { transform: rotate(180deg); }.browse-button { white-space: nowrap; }.search-results { position: absolute; z-index: 10; top: calc(100% + 6px); right: 118px; left: 0; max-height: 280px; overflow: auto; padding: 5px; border: 1px solid var(--border-primary); border-radius: 8px; background: var(--surface-overlay); box-shadow: var(--shadow-high); }.result-section-label { padding: 7px 10px 5px; margin: 0; color: var(--text-muted); font-size: calc(11px * var(--ui-font-ratio)); font-weight: 700; }.search-result { display: grid; width: 100%; min-height: 52px; padding: 7px 10px; color: var(--text-secondary); border: 0; border-radius: 6px; grid-template-columns: auto minmax(0, 1fr); gap: 9px; align-items: center; text-align: left; background: transparent; }.search-result:hover, .search-result:focus-visible, .search-result.selected { color: var(--text-primary); background: var(--bg-card-hover); }.search-result.selected { box-shadow: inset 2px 0 0 var(--primary); }.result-order { display: grid; min-width: 28px; height: 28px; padding: 0 5px; color: var(--text-muted); border: 1px solid var(--border-secondary); border-radius: 6px; place-items: center; font-size: calc(11px * var(--ui-font-ratio)); font-variant-numeric: tabular-nums; }.result-title { display: grid; min-width: 0; gap: 2px; }.result-title strong { overflow: hidden; color: var(--text-primary); font-size: calc(12px * var(--ui-font-ratio)); font-weight: 600; text-overflow: ellipsis; white-space: nowrap; }.result-title small { color: var(--text-muted); font-size: calc(11px * var(--ui-font-ratio)); }.no-results { padding: 14px 10px; margin: 0; color: var(--text-muted); font-size: calc(12px * var(--ui-font-ratio)); line-height: 1.6; }.task-meta { display: flex; flex-wrap: wrap; align-items: center; gap: 12px; margin-top: 12px; color: var(--text-muted); font-size: calc(12px * var(--ui-font-ratio)); }.task-meta a { color: var(--primary); text-decoration: none; }.loading-task { display: flex; align-items: center; gap: 7px; margin: 12px 0 0; color: var(--text-muted); font-size: calc(12px * var(--ui-font-ratio)); }.spin { animation: spin 900ms linear infinite; }@keyframes spin { to { transform: rotate(360deg); } }.notes-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; margin-top: 16px; }.doc-actions { display: flex; gap: 10px; margin-top: 14px; }.preview { margin-top: 16px; border-top: 1px solid var(--border-secondary); padding-top: 12px; }.preview summary { cursor: pointer; color: var(--text-secondary); font-size: calc(12px * var(--ui-font-ratio)); }.preview pre { max-height: 500px; overflow: auto; padding: 14px; margin-top: 10px; color: var(--text-secondary); background: var(--bg-input); border-radius: 8px; white-space: pre-wrap; font-family: var(--font-mono, monospace); font-size: var(--code-font-size); line-height: 1.65; }.json-actions { display: flex; flex-wrap: wrap; align-items: center; gap: 10px; margin: 0 0 12px; }.json-actions > span { color: var(--text-muted); font-size: calc(12px * var(--ui-font-ratio)); }.json-file-input { position: absolute; width: 1px; height: 1px; overflow: hidden; clip: rect(0 0 0 0); clip-path: inset(50%); white-space: nowrap; }.json-editor-wrap { display: grid; grid-template-columns: 44px minmax(0, 1fr); overflow: hidden; border: 1px solid var(--border-primary); border-radius: 8px; background: var(--bg-input); }.json-editor-wrap:focus-within { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(255, 161, 22, .1); }.json-editor-wrap .line-numbers { overflow: hidden; padding: 11px 8px 11px 0; color: var(--text-muted); font-family: var(--font-mono, monospace); font-size: var(--code-font-size); line-height: 1.6; text-align: right; user-select: none; border-right: 1px solid var(--border-secondary); background: var(--code-surface-raised); }.json-editor-wrap textarea { min-height: 360px; border: 0; border-radius: 0; background: transparent; }.json-editor-wrap textarea:focus { border: 0 !important; box-shadow: none !important; }.json-editor { font-family: var(--font-mono, monospace); font-size: var(--code-font-size); line-height: 1.6; }.inline-error { margin: 8px 0 0; color: var(--danger); font-size: calc(12px * var(--ui-font-ratio)); }.draft-result { padding-top: 16px; margin-top: 16px; border-top: 1px solid var(--border-secondary); }.status-line { display: flex; gap: 14px; align-items: center; color: var(--text-secondary); font-size: calc(13px * var(--ui-font-ratio)); }.passed { color: var(--success); }.failed { color: var(--danger); }.errors { padding: 11px 12px 11px 28px; margin: 12px 0; color: var(--danger-strong); border: 1px solid rgba(239,68,68,.34); border-radius: 8px; background: var(--danger-soft); font-size: calc(12px * var(--ui-font-ratio)); line-height: 1.7; }.impact { display: grid; gap: 4px; padding: 12px; margin-top: 12px; color: var(--text-muted); border: 1px solid var(--border-primary); border-radius: 8px; font-size: calc(12px * var(--ui-font-ratio)); }.impact strong { color: var(--text-primary); }.confirm { margin-top: 14px; }.feedback { display: flex; gap: 8px; align-items: center; padding: 12px 14px; margin-top: 14px; border-radius: 8px; font-size: calc(13px * var(--ui-font-ratio)); }.feedback.error { color: var(--danger-strong); background: var(--danger-soft); }.feedback.success { color: var(--success-strong); background: rgba(34,197,94,.08); }.format-help { padding: 0; color: var(--primary); }.format-help summary { display: flex; align-items: center; gap: 12px; padding: 16px 18px; cursor: pointer; list-style: none; }.format-help summary::-webkit-details-marker { display: none; }.format-help summary span { display: grid; gap: 3px; flex: 1; }.format-help summary strong { color: var(--text-primary); font-size: calc(15px * var(--ui-font-ratio)); }.format-help summary small { color: var(--text-muted); font-size: calc(12px * var(--ui-font-ratio)); }.format-help summary > svg:last-child { transition: transform 150ms ease; }.format-help[open] summary > svg:last-child { transform: rotate(180deg); }.rules-content { padding: 16px 18px 18px; color: var(--text-muted); border-top: 1px solid var(--border-secondary); font-size: calc(12px * var(--ui-font-ratio)); line-height: 1.65; }
.problem-browser-backdrop { position: fixed; z-index: 110; display: grid; inset: 0; padding: 24px; place-items: center; background: rgba(3, 6, 11, .72); backdrop-filter: blur(4px); }.problem-browser { display: flex; width: min(920px, 100%); max-height: min(760px, calc(100vh - 48px)); overflow: hidden; padding: 22px; color: var(--text-primary); border: 1px solid var(--border-primary); border-radius: 10px; flex-direction: column; background: var(--bg-card); box-shadow: var(--shadow-high); }.problem-browser-header { display: flex; align-items: flex-start; justify-content: space-between; gap: 16px; }.problem-browser-header h2 { margin: 0 0 5px; font-size: calc(18px * var(--ui-font-ratio)); }.problem-browser-header p { margin: 0; color: var(--text-muted); font-size: calc(12px * var(--ui-font-ratio)); }.icon-button { display: grid; width: 40px; height: 40px; flex: 0 0 auto; color: var(--text-muted); border: 1px solid var(--border-secondary); border-radius: 8px; cursor: pointer; place-items: center; background: transparent; }.icon-button:hover, .icon-button:focus-visible { color: var(--text-primary); background: var(--bg-card-hover); }.browser-search { display: flex; min-height: 42px; align-items: center; padding: 0 11px; margin-top: 18px; color: var(--text-muted); border: 1px solid var(--border-primary); border-radius: 8px; background: var(--bg-input); }.browser-search:focus-within { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(255, 161, 22, .1); }.browser-search input { width: 100%; min-width: 0; padding: 0 9px; color: var(--text-primary); border: 0; outline: 0; background: transparent; }.filter-block { display: grid; grid-template-columns: 42px minmax(0, 1fr); gap: 10px; align-items: start; margin-top: 14px; }.filter-block > span { padding-top: 7px; color: var(--text-muted); font-size: calc(11px * var(--ui-font-ratio)); font-weight: 700; }.filter-options { display: flex; flex-wrap: wrap; gap: 6px; }.filter-options button { min-height: 32px; padding: 0 10px; color: var(--text-secondary); border: 1px solid transparent; border-radius: 6px; cursor: pointer; background: transparent; }.filter-options button:hover, .filter-options button:focus-visible { color: var(--text-primary); background: var(--bg-card-hover); }.filter-options button.active { color: var(--primary); border-color: color-mix(in srgb, var(--primary) 42%, transparent); background: color-mix(in srgb, var(--primary) 10%, transparent); }.browser-result-heading { display: flex; justify-content: space-between; gap: 12px; padding: 14px 2px 8px; margin-top: 6px; color: var(--text-muted); border-top: 1px solid var(--border-secondary); font-size: calc(11px * var(--ui-font-ratio)); }.browser-result-heading strong { color: var(--text-secondary); }.browser-results { display: grid; min-height: 0; overflow: auto; padding: 4px 4px 4px 0; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 6px; }.browser-result { display: grid; min-height: 60px; padding: 8px 10px; color: var(--text-secondary); border: 1px solid var(--border-secondary); border-radius: 7px; grid-template-columns: auto minmax(0, 1fr) auto; gap: 9px; align-items: center; text-align: left; cursor: pointer; background: var(--bg-input); }.browser-result:hover, .browser-result:focus-visible { border-color: var(--border-primary); background: var(--bg-card-hover); }.browser-result.selected { border-color: var(--primary); box-shadow: inset 2px 0 0 var(--primary); }.browser-result-order { display: grid; min-width: 30px; height: 30px; padding: 0 5px; color: var(--text-muted); border: 1px solid var(--border-primary); border-radius: 6px; place-items: center; font-size: calc(11px * var(--ui-font-ratio)); font-variant-numeric: tabular-nums; }.browser-result-main { display: grid; min-width: 0; gap: 3px; }.browser-result-main strong { overflow: hidden; color: var(--text-primary); font-size: calc(12px * var(--ui-font-ratio)); text-overflow: ellipsis; white-space: nowrap; }.browser-result-main small { color: var(--text-muted); font-size: calc(11px * var(--ui-font-ratio)); }.difficulty-badge { padding: 4px 7px; border-radius: 5px; font-size: calc(10px * var(--ui-font-ratio)); white-space: nowrap; }.difficulty-easy { color: var(--success-strong); background: rgba(60, 211, 192, .08); }.difficulty-medium { color: var(--warning-strong); background: rgba(243, 201, 105, .08); }.difficulty-hard { color: var(--danger-strong); background: var(--danger-soft); }.browser-empty { grid-column: 1 / -1; }
@media (max-width: 700px) { .import-page { padding-inline: 12px; padding-top: 20px; }.section-heading { flex-direction: column; }.section-heading .primary { width: 100%; }.picker-row { grid-template-columns: 1fr; }.browse-button { width: 100%; }.search-results { right: 0; top: 58px; }.notes-grid { grid-template-columns: 1fr; }.doc-actions { flex-direction: column; }.doc-actions button { width: 100%; }.problem-browser-backdrop { padding: 10px; align-items: stretch; }.problem-browser { max-height: calc(100vh - 20px); padding: 16px; }.filter-block { grid-template-columns: 1fr; gap: 4px; }.filter-block > span { padding-top: 0; }.browser-results { grid-template-columns: 1fr; }.browser-result-heading span { display: none; } }

@media (max-width: 700px) {
  .import-page { padding-bottom: calc(88px + env(safe-area-inset-bottom)); }
  .panel { padding: 18px; }
  .search-control, .browser-search { min-height: 44px; }
  .primary, .secondary, .filter-options button { min-height: 44px; }
  .problem-browser-backdrop {
    padding: max(10px, env(safe-area-inset-top)) 10px max(10px, env(safe-area-inset-bottom));
  }
  .problem-browser {
    max-height: calc(100dvh - 20px - env(safe-area-inset-top) - env(safe-area-inset-bottom));
  }
}
</style>
