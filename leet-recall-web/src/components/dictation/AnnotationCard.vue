<script setup lang="ts">
import { computed, ref } from 'vue'
import { AlertCircle, ChevronDown, ChevronRight, FilePenLine, LoaderCircle, Trash2 } from 'lucide-vue-next'
import MarkdownContent from '@/components/common/MarkdownContent.vue'
import type { CodeAnnotationInput, ResolvedCodeAnnotation } from '@/types/annotation'

const props = defineProps<{
  annotation: ResolvedCodeAnnotation
  saving?: boolean
}>()
const emit = defineEmits<{
  save: [input: CodeAnnotationInput]
  delete: []
  select: []
}>()

const expanded = ref(false)
const anchorRevealed = ref(false)
const editing = ref(false)
const label = ref(props.annotation.label ?? '')
const contentMarkdown = ref(props.annotation.contentMarkdown)
const hasContent = computed(() => contentMarkdown.value.trim().length > 0)

function beginEdit(): void {
  label.value = props.annotation.label ?? ''
  contentMarkdown.value = props.annotation.contentMarkdown
  editing.value = true
  expanded.value = true
}

function save(): void {
  emit('save', {
    label: label.value.trim() || null,
    anchorText: props.annotation.anchorText,
    occurrenceIndex: props.annotation.occurrenceIndex,
    startLine: props.annotation.startLine,
    startColumn: props.annotation.startColumn,
    endLine: props.annotation.endLine,
    endColumn: props.annotation.endColumn,
    contentMarkdown: contentMarkdown.value,
  })
  editing.value = false
}
</script>

<template>
  <article class="annotation-card" :class="{ stale: !annotation.resolved }">
    <button class="annotation-heading" type="button" @click="expanded = !expanded">
      <AlertCircle v-if="!annotation.resolved" class="stale-icon" :size="15" />
      <ChevronDown v-else-if="expanded" :size="15" />
      <ChevronRight v-else :size="15" />
      <span class="annotation-label">{{ annotation.label || '未命名批注' }}</span>
      <span class="annotation-line">{{ annotation.resolved ? `第 ${annotation.startLine} 行` : '代码已变化' }}</span>
    </button>

    <div v-if="expanded" class="annotation-body">
      <button class="anchor-preview" type="button" :title="annotation.anchorText" @click="anchorRevealed = !anchorRevealed; emit('select')">
        <code v-if="anchorRevealed">{{ annotation.anchorText }}</code>
        <span v-else>点击显示代码片段</span>
      </button>

      <template v-if="editing">
        <label>标题<input v-model="label" maxlength="60" placeholder="例如：循环边界" /></label>
        <label>批注内容<textarea v-model="contentMarkdown" maxlength="100000" rows="7" /></label>
        <div class="edit-actions">
          <button type="button" class="primary-button" :disabled="saving || !contentMarkdown.trim()" @click="save">
            <LoaderCircle v-if="saving" class="spin" :size="14" />保存
          </button>
          <button type="button" @click="editing = false">取消</button>
        </div>
      </template>
      <template v-else>
        <MarkdownContent v-if="hasContent" :markdown="annotation.contentMarkdown" />
        <div class="annotation-actions">
          <button type="button" @click="beginEdit"><FilePenLine :size="13" />编辑</button>
          <button type="button" class="danger-button" @click="emit('delete')"><Trash2 :size="13" />删除</button>
        </div>
      </template>
    </div>
  </article>
</template>

<style scoped>
.annotation-card { overflow: hidden; border: 1px solid var(--border-primary); border-radius: 7px; background: var(--bg-input); }
.annotation-card.stale { border-color: var(--warning); }
.annotation-heading { display: flex; align-items: center; width: 100%; gap: 7px; min-height: 39px; padding: 7px 9px; color: var(--text-secondary); text-align: left; background: transparent; }
.annotation-heading:hover { color: var(--text-primary); background: var(--bg-card-hover); }
.annotation-label { min-width: 0; overflow: hidden; color: var(--text-primary); font-size: calc(12px * var(--ui-font-ratio)); font-weight: 600; text-overflow: ellipsis; white-space: nowrap; }
.annotation-line { margin-left: auto; color: var(--text-muted); font-size: calc(10px * var(--ui-font-ratio)); white-space: nowrap; }.stale-icon { color: var(--warning); }
.annotation-body { display: grid; gap: 10px; padding: 0 10px 10px; border-top: 1px solid var(--border-secondary); }
.anchor-preview { width: 100%; padding: 7px; overflow: hidden; color: var(--text-muted); text-align: left; text-overflow: ellipsis; white-space: nowrap; border: 1px solid var(--border-secondary); border-radius: 5px; background: var(--code-surface); }
.anchor-preview:hover { color: var(--primary-hover); border-color: var(--primary); }.anchor-preview code { font-family: "JetBrains Mono", Consolas, monospace; font-size: var(--code-font-size); line-height: 1.5; }
.annotation-body :deep(.markdown-content) { font-size: calc(12px * var(--ui-font-ratio)); }.annotation-body label { display: grid; gap: 5px; color: var(--text-muted); font-size: calc(11px * var(--ui-font-ratio)); }
.annotation-body input, .annotation-body textarea { width: 100%; padding: 7px 8px; color: var(--text-primary); font: inherit; border: 1px solid var(--border-primary); border-radius: 5px; outline: none; background: var(--bg-card); }.annotation-body textarea { resize: vertical; line-height: 1.6; }.annotation-body input:focus, .annotation-body textarea:focus { border-color: var(--primary); }
.edit-actions, .annotation-actions { display: flex; align-items: center; gap: 8px; }.edit-actions button, .annotation-actions button { display: inline-flex; align-items: center; gap: 4px; padding: 5px 7px; color: var(--text-muted); font-size: calc(11px * var(--ui-font-ratio)); border: 0; border-radius: 4px; background: transparent; }.edit-actions button:hover, .annotation-actions button:hover { color: var(--text-primary); background: var(--bg-card-hover); }.primary-button { color: var(--text-on-primary) !important; background: var(--primary) !important; }.danger-button:hover { color: var(--danger-strong) !important; }.spin { animation: spin 1s linear infinite; }@keyframes spin { to { transform: rotate(360deg); } }
</style>
