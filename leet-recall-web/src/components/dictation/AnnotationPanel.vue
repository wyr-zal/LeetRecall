<script setup lang="ts">
import { computed, ref } from 'vue'
import { Highlighter, LoaderCircle, X } from 'lucide-vue-next'
import AnnotationCard from './AnnotationCard.vue'
import type { CodeAnnotationAnchor, CodeAnnotationInput, ResolvedCodeAnnotation } from '@/types/annotation'

const props = defineProps<{
  annotations: ResolvedCodeAnnotation[]
  loading?: boolean
  saving?: boolean
  error?: string
  draftAnchor?: CodeAnnotationAnchor | null
  canCreate?: boolean
  closable?: boolean
}>()
const emit = defineEmits<{
  cancelCreate: []
  saveNew: [input: CodeAnnotationInput]
  save: [id: number, input: CodeAnnotationInput]
  delete: [id: number]
  select: [annotation: ResolvedCodeAnnotation]
  close: []
}>()

const selectedAnnotationId = ref<number | null>(null)
const draftLabel = ref('')
const draftContent = ref('')
const visibleAnnotations = computed(() => props.annotations)

function saveNew(): void {
  if (!props.draftAnchor || !draftContent.value.trim()) return
  emit('saveNew', {
    ...props.draftAnchor,
    label: draftLabel.value.trim() || null,
    contentMarkdown: draftContent.value,
  })
  draftLabel.value = ''
  draftContent.value = ''
}
</script>

<template>
  <section class="annotation-panel app-card" :aria-busy="loading">
    <header class="panel-header">
      <div class="panel-title">
        <span class="panel-icon"><Highlighter :size="16" /></span>
        <h2>代码批注</h2>
      </div>
      <button v-if="closable" class="close-button" type="button" aria-label="关闭批注面板" @click="emit('close')"><X :size="16" /></button>
    </header>
    <p class="panel-description">选中答案代码后添加说明，默写时只展开自己需要的提示。</p>
    <div v-if="loading" class="panel-state"><LoaderCircle class="spin" :size="16" />正在读取批注…</div>
    <div v-else-if="error" class="panel-state error">{{ error }}</div>
    <form v-else-if="draftAnchor" class="new-annotation" @submit.prevent="saveNew">
      <div class="new-anchor"><code>{{ draftAnchor.anchorText || '请在答案代码中选择一段代码' }}</code></div>
      <input v-model="draftLabel" maxlength="60" placeholder="批注标题（可选）" aria-label="批注标题" />
      <textarea v-model="draftContent" maxlength="100000" rows="6" placeholder="写下这段代码为什么这样写…" aria-label="批注内容"></textarea>
      <div class="new-actions">
        <button type="submit" class="primary-button" :disabled="saving || !draftContent.trim()">保存批注</button>
        <button type="button" @click="emit('cancelCreate')">取消</button>
      </div>
    </form>
    <div v-else-if="visibleAnnotations.length === 0" class="panel-empty">
      <Highlighter :size="22" />
      <strong>还没有代码批注</strong>
      <span>{{ canCreate === false ? '显示答案后选中关键代码即可添加。' : '选中关键代码即可添加。' }}</span>
    </div>
    <div v-else class="annotation-list">
      <AnnotationCard
        v-for="annotation in visibleAnnotations"
        :key="annotation.id"
        :annotation="annotation"
        :saving="saving && selectedAnnotationId === annotation.id"
        @save="selectedAnnotationId = annotation.id; emit('save', annotation.id, $event)"
        @delete="selectedAnnotationId = annotation.id; emit('delete', annotation.id)"
        @select="emit('select', annotation)"
      />
    </div>
  </section>
</template>

<style scoped>
.annotation-panel { padding: 16px; background: var(--bg-card); }
.panel-header, .panel-title, .panel-state, .panel-empty { display: flex; align-items: center; }
.panel-header { justify-content: space-between; gap: 8px; }
.panel-title { gap: 8px; }
.panel-icon { display: grid; width: 28px; height: 28px; color: var(--primary); place-items: center; border: 1px solid rgba(255, 161, 22, .2); border-radius: 6px; background: var(--primary-soft); }
h2 { margin: 0; font-size: calc(14px * var(--ui-font-ratio)); }
.close-button { display: grid; width: 28px; height: 28px; flex: 0 0 auto; color: var(--text-muted); border: 1px solid var(--border-secondary); border-radius: 6px; place-items: center; background: transparent; }
.close-button:hover:not(:disabled) { color: var(--text-primary); border-color: var(--border-hover); background: var(--bg-card-hover); }
.add-button { gap: 4px; padding: 5px 7px; color: var(--primary-hover); font-size: calc(11px * var(--ui-font-ratio)); border: 1px solid var(--border-primary); border-radius: 5px; background: transparent; }
.add-button:hover:not(:disabled) { border-color: var(--primary); background: var(--primary-soft); }
.add-button:disabled { cursor: not-allowed; opacity: .45; }
.panel-description { margin: 9px 0 12px; color: var(--text-muted); font-size: calc(11px * var(--ui-font-ratio)); line-height: 1.6; }
.annotation-list { display: grid; gap: 7px; }
.new-annotation { display: grid; gap: 8px; }
.new-anchor { padding: 7px; overflow: hidden; color: var(--text-muted); text-overflow: ellipsis; white-space: nowrap; border: 1px solid var(--border-secondary); border-radius: 5px; background: var(--code-surface); }
.new-anchor code { font-family: "JetBrains Mono", Consolas, monospace; font-size: var(--code-font-size); line-height: 1.5; }
.new-annotation input, .new-annotation textarea { width: 100%; padding: 8px; color: var(--text-primary); font: inherit; font-size: calc(12px * var(--ui-font-ratio)); border: 1px solid var(--border-primary); border-radius: 5px; outline: none; background: var(--bg-input); }
.new-annotation textarea { resize: vertical; line-height: 1.6; }
.new-annotation input:focus, .new-annotation textarea:focus { border-color: var(--primary); }
.new-actions { display: flex; gap: 7px; }
.new-actions button { padding: 6px 9px; color: var(--text-muted); font-size: calc(11px * var(--ui-font-ratio)); border: 1px solid var(--border-primary); border-radius: 5px; background: transparent; }
.new-actions button:hover { color: var(--text-primary); border-color: var(--primary); }
.new-actions .primary-button { color: var(--text-on-primary); border-color: var(--primary); background: var(--primary); }
.new-actions button:disabled { cursor: not-allowed; opacity: .55; }
.panel-state { justify-content: center; min-height: 72px; gap: 7px; color: var(--text-muted); font-size: calc(11px * var(--ui-font-ratio)); }
.panel-state.error { color: var(--danger-strong); }
.panel-empty { flex-direction: column; justify-content: center; min-height: 100px; gap: 5px; color: var(--text-muted); text-align: center; }
.panel-empty strong { color: var(--text-secondary); font-size: calc(12px * var(--ui-font-ratio)); }
.panel-empty span { font-size: calc(10px * var(--ui-font-ratio)); }
.spin { animation: spin 1s linear infinite; }
@keyframes spin { to { transform: rotate(360deg); } }
</style>
