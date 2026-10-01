<script setup lang="ts">
defineProps<{ submitting: boolean; viewedAnswer: boolean; answerVisible: boolean }>()
defineEmits<{ reset: []; answer: []; submit: [] }>()
</script>

<template>
  <div class="actions">
    <button type="button" @click="$emit('reset')">重置</button>
    <button type="button" @click="$emit('answer')">
      <kbd>A</kbd>{{ answerVisible ? '返回默写' : (viewedAnswer ? '再看答案' : '显示答案') }}
    </button>
    <button type="button" class="primary" :disabled="submitting" @click="$emit('submit')">
      <kbd>Ctrl ↵</kbd>{{ submitting ? '正在评分…' : '提交默写' }}
    </button>
  </div>
</template>

<style scoped>
.actions { display: grid; grid-template-columns: 0.8fr 0.9fr 1.15fr; gap: 12px; margin-top: 15px; }
button { display: inline-flex; align-items: center; justify-content: center; gap: 8px; min-height: 46px; color: var(--text-secondary); border: 1px solid var(--border-primary); border-radius: 8px; background: var(--bg-input); box-shadow: none; }
kbd { padding: 2px 5px; color: inherit; font-size: calc(10px * var(--ui-font-ratio)); border: 1px solid currentColor; border-radius: 4px; opacity: 0.62; }
button:hover:not(:disabled) { color: var(--text-primary); border-color: var(--border-hover); }
button:disabled { opacity: 0.55; }
.primary { color: var(--on-primary); border-color: var(--primary); background: var(--primary); box-shadow: none; }
.primary:hover:not(:disabled) { color: var(--on-primary); border-color: var(--primary-hover); background: var(--primary-hover); }
@media (max-width: 560px) { .actions { grid-template-columns: 1fr; } }
</style>
