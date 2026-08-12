<script setup lang="ts">
defineProps<{ loading: boolean }>()
defineEmits<{ select: [result: 'FORGOT' | 'FUZZY' | 'KNOWN'] }>()
</script>

<template>
  <div class="result-buttons" aria-label="选择掌握状态">
    <button type="button" class="forgot" :disabled="loading" @click="$emit('select', 'FORGOT')">
      <kbd>1</kbd><span>不会</span>
    </button>
    <button type="button" class="fuzzy" :disabled="loading" @click="$emit('select', 'FUZZY')">
      <kbd>2</kbd><span>模糊</span>
    </button>
    <button type="button" class="known" :disabled="loading" @click="$emit('select', 'KNOWN')">
      <kbd>3</kbd><span>{{ loading ? '保存中' : '会' }}</span>
    </button>
  </div>
</template>

<style scoped>
.result-buttons { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; margin-top: 16px; }
button {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 9px;
  min-height: 48px;
  font-weight: 620;
  border: 1px solid currentColor;
  border-radius: 8px;
  background: var(--bg-input);
  box-shadow: none;
}
button:hover:not(:disabled) { transform: translateY(-1px); }
button:active:not(:disabled) { transform: translateY(0); }
button:disabled { opacity: 0.55; }
.forgot { color: var(--danger); border-color: rgba(255, 55, 95, 0.5); }
.fuzzy { color: var(--warning); border-color: rgba(255, 192, 30, 0.5); }
.known { color: var(--success); border-color: rgba(0, 184, 163, 0.5); }
.forgot:hover:not(:disabled) { background: rgba(255, 55, 95, 0.1); }
.fuzzy:hover:not(:disabled) { background: rgba(255, 192, 30, 0.1); }
.known:hover:not(:disabled) { background: rgba(0, 184, 163, 0.1); }
kbd { padding: 2px 5px; color: inherit; font-size: 10px; border: 1px solid currentColor; border-radius: 4px; opacity: 0.62; }
@media (max-width: 560px) {
  .result-buttons { grid-template-columns: 1fr; }
}
</style>
