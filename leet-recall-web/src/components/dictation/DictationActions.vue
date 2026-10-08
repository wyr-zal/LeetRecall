<script setup lang="ts">
import { computed } from 'vue'
import { Eye, LoaderCircle, RotateCcw, Send, Undo2 } from 'lucide-vue-next'

const props = defineProps<{ submitting: boolean; busy?: boolean; viewedAnswer: boolean; answerVisible: boolean }>()
defineEmits<{ reset: []; answer: []; submit: [] }>()
const answerLabel = computed(() => props.answerVisible ? '返回默写' : (props.viewedAnswer ? '再看答案' : '显示答案'))
const submitLabel = computed(() => props.submitting ? '正在评分…' : '提交默写')
</script>

<template>
  <div class="actions">
    <button type="button" aria-label="重置" title="重置" @click="$emit('reset')">
      <RotateCcw class="action-icon" :size="19" aria-hidden="true" /><span class="action-label">重置</span>
    </button>
    <button type="button" :aria-label="answerLabel" :title="answerLabel" @click="$emit('answer')">
      <Undo2 v-if="answerVisible" class="action-icon" :size="19" aria-hidden="true" /><Eye v-else class="action-icon" :size="19" aria-hidden="true" />
      <kbd>A</kbd><span class="action-label">{{ answerLabel }}</span>
    </button>
    <button type="button" class="primary" :aria-label="submitLabel" :title="submitLabel" :disabled="submitting || busy" @click="$emit('submit')">
      <LoaderCircle v-if="submitting" class="action-icon spin" :size="19" aria-hidden="true" /><Send v-else class="action-icon" :size="19" aria-hidden="true" />
      <kbd>Ctrl ↵</kbd><span class="action-label">{{ submitLabel }}</span>
    </button>
  </div>
</template>

<style scoped>
.actions { display: grid; grid-template-columns: 0.8fr 0.9fr 1.15fr; gap: 8px; margin-top: 0; }
button { display: inline-flex; align-items: center; justify-content: center; gap: 7px; min-height: 44px; padding: 0 8px; color: var(--text-secondary); border: 1px solid var(--border-primary); border-radius: 7px; background: var(--bg-input); box-shadow: none; }
.action-icon { display: none; }
.spin { animation: spin 1s linear infinite; }
@keyframes spin { to { transform: rotate(360deg); } }
@media (prefers-reduced-motion: reduce) { .spin { animation: none; } }
kbd { padding: 2px 5px; color: inherit; font-size: calc(10px * var(--ui-font-ratio)); border: 1px solid currentColor; border-radius: 4px; opacity: 0.62; }
button:hover:not(:disabled) { color: var(--text-primary); border-color: var(--border-hover); }
button:disabled { opacity: 0.55; }
.primary { color: var(--on-primary); border-color: var(--primary); background: var(--primary); box-shadow: none; }
.primary:hover:not(:disabled) { color: var(--on-primary); border-color: var(--primary-hover); background: var(--primary-hover); }
@media (max-width: 720px) {
  .actions { display: flex; flex: 0 0 auto; justify-content: flex-end; gap: 8px; }
  button { flex: 0 0 44px; width: 44px; height: 44px; padding: 0; border-radius: 50%; }
  .action-icon { display: block; }
  .action-label, kbd { display: none; }
}
</style>
