<script setup lang="ts">
defineProps<{ loading: boolean }>()
const emit = defineEmits<{ select: [result: 'FORGOT' | 'FUZZY' | 'KNOWN'] }>()

function selectResult(event: Event): void {
  const select = event.currentTarget
  if (!(select instanceof HTMLSelectElement)) return

  const result = select.value
  if (result === 'FORGOT' || result === 'FUZZY' || result === 'KNOWN') {
    emit('select', result)
    select.value = ''
  }
}
</script>

<template>
  <div class="result-buttons" aria-label="选择掌握状态">
    <select aria-label="标记本题掌握程度" :disabled="loading" @change="selectResult">
      <option value="" selected disabled>{{ loading ? '保存中…' : '选择掌握程度' }}</option>
      <option value="FORGOT">1 · 不会</option>
      <option value="FUZZY">2 · 模糊</option>
      <option value="KNOWN">3 · 会</option>
    </select>
  </div>
</template>

<style scoped>
.result-buttons { margin-top: 16px; }
select {
  width: 100%;
  min-height: 48px;
  padding: 0 12px;
  color: var(--text-primary);
  font-weight: 620;
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  background: var(--bg-input);
  box-shadow: none;
}
select:focus-visible { outline: 2px solid var(--primary); outline-offset: 2px; }
select:disabled { opacity: 0.55; }
</style>
