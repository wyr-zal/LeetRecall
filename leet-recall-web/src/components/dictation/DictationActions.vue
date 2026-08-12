<script setup lang="ts">
defineProps<{ submitting: boolean; viewedAnswer: boolean }>()
defineEmits<{ reset: []; answer: []; submit: [] }>()
</script>

<template>
  <div class="actions">
    <button type="button" @click="$emit('reset')">重置</button>
    <button type="button" :disabled="viewedAnswer" @click="$emit('answer')">
      {{ viewedAnswer ? '已显示答案' : '显示答案' }}
    </button>
    <button type="button" class="primary" :disabled="submitting" @click="$emit('submit')">
      {{ submitting ? '正在评分…' : '提交默写' }}
    </button>
  </div>
</template>

<style scoped>
.actions { display: grid; grid-template-columns: 0.8fr 0.9fr 1.15fr; gap: 12px; margin-top: 15px; }
button { min-height: 46px; color: var(--text-secondary); border: 1px solid var(--border-primary); border-radius: 8px; background: var(--bg-input); box-shadow: none; }
button:hover:not(:disabled) { color: var(--text-primary); border-color: #505050; }
button:disabled { opacity: 0.55; }
.primary { color: #1a1a1a; border-color: var(--primary); background: var(--primary); box-shadow: none; }
.primary:hover:not(:disabled) { color: #1a1a1a; border-color: var(--primary-hover); background: var(--primary-hover); }
@media (max-width: 560px) { .actions { grid-template-columns: 1fr; } }
</style>
