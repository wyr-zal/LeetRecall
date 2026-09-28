<script setup lang="ts">
import { computed, ref, watch } from 'vue'
import { Eye, FilePenLine, LoaderCircle, Plus, Save, X } from 'lucide-vue-next'
import MarkdownContent from '@/components/common/MarkdownContent.vue'
import { MAX_RECALL_QUESTIONS } from '@/types/problem'
import type {
  Difficulty,
  ProblemContent,
  ProblemContentRecallQuestionInput,
  ProblemContentUpdate,
} from '@/types/problem'

const props = defineProps<{
  content: ProblemContent
  saving: boolean
  errorMessage: string
}>()
const emit = defineEmits<{ save: [payload: ProblemContentUpdate]; cancel: [] }>()

type DescriptionMode = 'edit' | 'preview'

const DIFFICULTY_OPTIONS: { value: Difficulty; label: string }[] = [
  { value: 'EASY', label: '简单' },
  { value: 'MEDIUM', label: '中等' },
  { value: 'HARD', label: '困难' },
]

const title = ref('')
const difficulty = ref<Difficulty>('MEDIUM')
const descriptionMarkdown = ref('')
const tags = ref<string[]>([])
const tagInput = ref('')
const questions = ref<ProblemContentRecallQuestionInput[]>([])
const hint = ref('')
const coreIdea = ref('')
const mistakes = ref<string[]>([])
const keyCode = ref('')
const descriptionMode = ref<DescriptionMode>('edit')
const localError = ref('')

const canAddQuestion = computed(() => questions.value.length < MAX_RECALL_QUESTIONS)

watch(() => props.content, (content) => {
  title.value = content.title
  difficulty.value = content.difficulty
  descriptionMarkdown.value = content.descriptionMarkdown
  tags.value = [...content.tags]
  tagInput.value = ''
  questions.value = content.recallQuestions.map((question) => ({
    id: question.id,
    question: question.question,
    answer: question.answer,
  }))
  hint.value = content.hint
  coreIdea.value = content.coreIdea
  mistakes.value = [...content.mistakes]
  keyCode.value = content.keyCode
  descriptionMode.value = 'edit'
  localError.value = ''
}, { immediate: true, deep: false })

function addTag(): void {
  const value = tagInput.value.trim()
  if (!value) return
  if (value.length > 50) {
    localError.value = '单个标签不能超过 50 个字符'
    return
  }
  if (tags.value.includes(value)) {
    tagInput.value = ''
    return
  }
  if (tags.value.length >= 10) {
    localError.value = '最多 10 个标签'
    return
  }
  tags.value = [...tags.value, value]
  tagInput.value = ''
  localError.value = ''
}

function removeTag(target: string): void {
  tags.value = tags.value.filter((tag) => tag !== target)
}

function addQuestion(): void {
  if (!canAddQuestion.value) return
  questions.value = [...questions.value, { id: null, question: '', answer: '' }]
}

function removeQuestion(index: number): void {
  questions.value = questions.value.filter((_, current) => current !== index)
}

function moveQuestion(index: number, delta: -1 | 1): void {
  const target = index + delta
  if (target < 0 || target >= questions.value.length) return
  const next = [...questions.value]
  const [moved] = next.splice(index, 1)
  if (!moved) return
  next.splice(target, 0, moved)
  questions.value = next
}

function addMistake(): void {
  mistakes.value = [...mistakes.value, '']
}

function removeMistake(index: number): void {
  mistakes.value = mistakes.value.filter((_, current) => current !== index)
}

function validate(): string {
  if (!title.value.trim()) return '标题不能为空'
  if (title.value.trim().length > 255) return '标题不能超过 255 个字符'
  if (!descriptionMarkdown.value.trim()) return '题目描述不能为空'
  if (!hint.value.trim()) return '提示不能为空'
  if (!coreIdea.value.trim()) return '核心思路不能为空'
  if (!keyCode.value.trim()) return '关键代码不能为空'
  if (questions.value.length === 0) return '至少需要 1 组回忆问答'
  if (questions.value.length > MAX_RECALL_QUESTIONS) return `最多 ${MAX_RECALL_QUESTIONS} 组回忆问答`
  for (const [index, item] of questions.value.entries()) {
    if (!item.question.trim()) return `第 ${index + 1} 组回忆问答的问题不能为空`
    if (item.question.trim().length > 500) return `第 ${index + 1} 组回忆问答的问题不能超过 500 个字符`
    if (!item.answer.trim()) return `第 ${index + 1} 组回忆问答的答案不能为空`
  }
  for (const [index, mistake] of mistakes.value.entries()) {
    if (!mistake.trim()) return `第 ${index + 1} 条易错点不能为空`
    if (mistake.trim().length > 500) return `第 ${index + 1} 条易错点不能超过 500 个字符`
  }
  return ''
}

function save(): void {
  const message = validate()
  localError.value = message
  if (message) return
  emit('save', {
    title: title.value.trim(),
    difficulty: difficulty.value,
    descriptionMarkdown: descriptionMarkdown.value.trim(),
    tags: tags.value,
    recallQuestions: questions.value.map((item) => ({
      id: item.id,
      question: item.question.trim(),
      answer: item.answer.trim(),
    })),
    hint: hint.value.trim(),
    coreIdea: coreIdea.value.trim(),
    mistakes: mistakes.value.map((item) => item.trim()),
    keyCode: keyCode.value,
  })
}
</script>

<template>
  <form class="content-editor" @submit.prevent="save">
    <header class="editor-bar">
      <div>
        <h2>编辑题目内容</h2>
        <p>第 {{ content.leetcodeNumber }} 题 · 修改后立即对复习与默写生效</p>
      </div>
      <div class="editor-actions">
        <button class="ghost-button" type="button" :disabled="saving" @click="emit('cancel')">
          取消
        </button>
        <button class="primary-button" type="submit" :disabled="saving">
          <LoaderCircle v-if="saving" class="spin" :size="14" />
          <Save v-else :size="14" />
          保存
        </button>
      </div>
    </header>

    <p v-if="localError || errorMessage" class="editor-error" role="alert">
      {{ localError || errorMessage }}
    </p>

    <section class="editor-block">
      <label class="field">
        <span>标题</span>
        <input v-model="title" type="text" maxlength="255" placeholder="题目标题" />
      </label>
      <label class="field field--narrow">
        <span>难度</span>
        <select v-model="difficulty">
          <option v-for="option in DIFFICULTY_OPTIONS" :key="option.value" :value="option.value">
            {{ option.label }}
          </option>
        </select>
      </label>
    </section>

    <section class="editor-block editor-block--column">
      <span class="block-label">标签</span>
      <div class="tag-row">
        <span v-for="tag in tags" :key="tag" class="tag-chip">
          {{ tag }}
          <button type="button" :aria-label="`删除标签 ${tag}`" @click="removeTag(tag)">
            <X :size="12" />
          </button>
        </span>
        <input
          v-model="tagInput"
          class="tag-input"
          type="text"
          maxlength="50"
          placeholder="输入后回车添加"
          @keydown.enter.prevent="addTag"
        />
      </div>
    </section>

    <section class="editor-block editor-block--column">
      <div class="block-heading">
        <span class="block-label">题目描述（Markdown）</span>
        <div class="mode-tabs" role="tablist" aria-label="题面显示方式">
          <button
            type="button"
            role="tab"
            :aria-selected="descriptionMode === 'edit'"
            :class="{ active: descriptionMode === 'edit' }"
            @click="descriptionMode = 'edit'"
          >
            <FilePenLine :size="14" /> 编辑
          </button>
          <button
            type="button"
            role="tab"
            :aria-selected="descriptionMode === 'preview'"
            :class="{ active: descriptionMode === 'preview' }"
            @click="descriptionMode = 'preview'"
          >
            <Eye :size="14" /> 预览
          </button>
        </div>
      </div>
      <textarea
        v-if="descriptionMode === 'edit'"
        v-model="descriptionMarkdown"
        class="markdown-area"
        rows="14"
        placeholder="支持 Markdown，代码围栏必须成对闭合"
      />
      <div v-else class="markdown-preview">
        <MarkdownContent v-if="descriptionMarkdown.trim()" :markdown="descriptionMarkdown" />
        <p v-else class="preview-empty">还没有题面内容</p>
      </div>
    </section>

    <section class="editor-block editor-block--column">
      <div class="block-heading">
        <span class="block-label">回忆问答（{{ questions.length }} / {{ MAX_RECALL_QUESTIONS }}）</span>
        <button
          class="ghost-button"
          type="button"
          :disabled="!canAddQuestion"
          :title="canAddQuestion ? '' : `最多 ${MAX_RECALL_QUESTIONS} 组，超出会导致复习提交失败`"
          @click="addQuestion"
        >
          <Plus :size="14" /> 添加一组
        </button>
      </div>
      <div v-for="(item, index) in questions" :key="item.id ?? `new-${index}`" class="question-editor">
        <div class="question-editor-head">
          <span>第 {{ index + 1 }} 组</span>
          <div class="question-editor-tools">
            <button type="button" :disabled="index === 0" aria-label="上移" @click="moveQuestion(index, -1)">↑</button>
            <button
              type="button"
              :disabled="index === questions.length - 1"
              aria-label="下移"
              @click="moveQuestion(index, 1)"
            >
              ↓
            </button>
            <button type="button" aria-label="删除这组问答" @click="removeQuestion(index)">
              <X :size="13" />
            </button>
          </div>
        </div>
        <textarea v-model="item.question" rows="2" maxlength="500" placeholder="问题" />
        <textarea v-model="item.answer" rows="3" placeholder="标准答案" />
      </div>
    </section>

    <section class="editor-block editor-block--column">
      <label class="field field--stacked">
        <span>提示</span>
        <textarea v-model="hint" rows="2" placeholder="给自己的行动提示" />
      </label>
      <label class="field field--stacked">
        <span>核心思路</span>
        <textarea v-model="coreIdea" rows="4" placeholder="状态、不变量、关键操作与正确性理由" />
      </label>
    </section>

    <section class="editor-block editor-block--column">
      <div class="block-heading">
        <span class="block-label">易错点（{{ mistakes.length }}）</span>
        <button class="ghost-button" type="button" @click="addMistake">
          <Plus :size="14" /> 添加一条
        </button>
      </div>
      <div v-for="(_, index) in mistakes" :key="`mistake-${index}`" class="mistake-row">
        <textarea v-model="mistakes[index]" rows="2" maxlength="500" placeholder="一条真实踩过的坑" />
        <button type="button" aria-label="删除这条易错点" @click="removeMistake(index)">
          <X :size="13" />
        </button>
      </div>
    </section>

    <section class="editor-block editor-block--column">
      <label class="field field--stacked">
        <span>关键代码</span>
        <textarea v-model="keyCode" class="code-area" rows="8" placeholder="最能体现解法的片段" />
      </label>
    </section>
  </form>
</template>

<style scoped>
.content-editor { display: grid; gap: 16px; padding: 18px 2px 12px; }
.editor-bar {
  position: sticky;
  top: 0;
  z-index: 2;
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  gap: 12px;
  padding-bottom: 12px;
  border-bottom: 1px solid var(--border-secondary);
  background: var(--surface-raised);
}
.editor-bar h2 { margin: 0; font-size: 15px; font-weight: 650; }
.editor-bar p { margin: 4px 0 0; color: var(--text-muted); font-size: 12px; }
.editor-actions { display: flex; align-items: center; gap: 8px; }
.editor-error {
  margin: 0;
  padding: 9px 12px;
  color: var(--danger-strong);
  font-size: 12px;
  line-height: 1.6;
  border: 1px solid var(--danger-strong);
  border-radius: 6px;
  background: var(--danger-soft);
}
.editor-block { display: flex; align-items: flex-end; flex-wrap: wrap; gap: 12px; }
.editor-block--column { align-items: stretch; flex-direction: column; gap: 9px; }
.block-heading { display: flex; align-items: center; justify-content: space-between; gap: 10px; }
.block-label { color: var(--text-secondary); font-size: 12px; font-weight: 620; }
.field { display: grid; flex: 1; min-width: 220px; gap: 6px; }
.field--narrow { flex: 0 0 120px; min-width: 120px; }
.field--stacked { min-width: 0; }
.field > span { color: var(--text-secondary); font-size: 12px; font-weight: 620; }
input, select, textarea {
  width: 100%;
  padding: 8px 10px;
  color: var(--text-primary);
  font-size: 13px;
  font-family: inherit;
  line-height: 1.6;
  border: 1px solid var(--border-primary);
  border-radius: 6px;
  background: var(--bg-input);
}
input:focus, select:focus, textarea:focus { outline: 2px solid var(--primary); outline-offset: -1px; }
textarea { resize: vertical; }
.markdown-area, .code-area { font-family: var(--font-mono, ui-monospace, monospace); font-size: 12px; }
.markdown-preview {
  min-height: 220px;
  padding: 12px;
  border: 1px solid var(--border-primary);
  border-radius: 6px;
  background: var(--bg-card);
}
.preview-empty { margin: 0; color: var(--text-muted); font-size: 12px; }
.tag-row {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 6px;
  padding: 7px 8px;
  border: 1px solid var(--border-primary);
  border-radius: 6px;
  background: var(--bg-input);
}
.tag-chip {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 3px 6px 3px 8px;
  color: var(--text-secondary);
  font-size: 11px;
  border: 1px solid var(--border-secondary);
  border-radius: 5px;
  background: var(--border-highlight);
}
.tag-chip button { padding: 0; color: var(--text-muted); border: 0; background: transparent; }
.tag-chip button:hover { color: var(--danger-strong); }
.tag-input { flex: 1; min-width: 140px; padding: 2px 0; border: 0; background: transparent; }
.tag-input:focus { outline: none; }
.question-editor {
  display: grid;
  gap: 7px;
  padding: 11px 12px;
  border: 1px solid var(--border-primary);
  border-radius: 7px;
  background: var(--bg-card);
}
.question-editor-head { display: flex; align-items: center; justify-content: space-between; }
.question-editor-head > span { color: var(--text-muted); font-size: 11px; font-weight: 620; }
.question-editor-tools { display: flex; align-items: center; gap: 4px; }
.question-editor-tools button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 22px;
  height: 22px;
  padding: 0;
  color: var(--text-muted);
  font-size: 12px;
  border: 1px solid var(--border-secondary);
  border-radius: 5px;
  background: transparent;
}
.question-editor-tools button:hover:not(:disabled) { color: var(--text-primary); border-color: var(--border-hover); }
.question-editor-tools button:disabled { opacity: 0.4; }
.mistake-row { display: grid; grid-template-columns: minmax(0, 1fr) 28px; gap: 7px; align-items: start; }
.mistake-row button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  height: 28px;
  color: var(--text-muted);
  border: 1px solid var(--border-secondary);
  border-radius: 5px;
  background: transparent;
}
.mistake-row button:hover { color: var(--danger-strong); border-color: var(--danger-strong); }
.ghost-button, .primary-button {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 7px 13px;
  font-size: 12px;
  font-weight: 620;
  border-radius: 6px;
}
.ghost-button {
  color: var(--text-secondary);
  border: 1px solid var(--border-primary);
  background: transparent;
}
.ghost-button:hover:not(:disabled) { color: var(--text-primary); border-color: var(--border-hover); }
.primary-button { color: #1a1205; border: 0; background: var(--primary); }
.primary-button:hover:not(:disabled) { background: var(--primary-hover); }
.ghost-button:disabled, .primary-button:disabled { opacity: 0.55; }
.spin { animation: editor-spin 900ms linear infinite; }
@keyframes editor-spin { to { transform: rotate(360deg); } }
@media (max-width: 640px) {
  .editor-bar { align-items: stretch; flex-direction: column; }
  .field--narrow { flex: 1 1 100%; }
  input, select, textarea { min-height: 44px; }
  .question-editor-tools button { width: 40px; height: 40px; }
  .mistake-row { grid-template-columns: minmax(0, 1fr) 40px; }
  .mistake-row button { height: 40px; }
  .tag-chip button { display: inline-grid; width: 36px; height: 36px; place-items: center; }
  .ghost-button, .primary-button { min-height: 44px; justify-content: center; }
}
</style>
