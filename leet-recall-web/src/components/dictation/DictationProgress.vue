<script setup lang="ts">
import { ChevronLeft, ChevronRight } from 'lucide-vue-next'

defineProps<{ current: number; total: number }>()
defineEmits<{ previous: []; next: []; list: [] }>()
</script>

<template>
  <header class="dictation-progress">
    <button class="back" type="button" @click="$emit('list')"><ChevronLeft :size="17" />返回默写列表</button>
    <div class="center-progress">
      <div>默写训练 <strong>{{ current }}</strong> / {{ total }}</div>
      <div class="track"><span :style="{ width: `${total ? (current / total) * 100 : 0}%` }" /></div>
    </div>
    <div class="navigation">
      <button type="button" @click="$emit('previous')"><ChevronLeft :size="16" />上一题</button>
      <button type="button" class="primary" @click="$emit('next')">下一题<ChevronRight :size="16" /></button>
    </div>
  </header>
</template>

<style scoped>
.dictation-progress { display: grid; grid-template-columns: 1fr minmax(240px, 340px) 1fr; align-items: center; gap: 24px; padding: 0 2px 18px; margin-bottom: 18px; border-bottom: 1px solid var(--border-secondary); }
button { display: inline-flex; align-items: center; justify-content: center; gap: 6px; min-height: 40px; padding: 0 14px; color: var(--text-secondary); border: 1px solid var(--border-primary); border-radius: 8px; background: var(--bg-card); box-shadow: none; }
.back { justify-self: start; padding-left: 0; border-color: transparent; background: transparent; }
.center-progress { color: var(--text-secondary); font-size: 14px; text-align: center; }
.center-progress strong { color: var(--primary); font-size: 17px; }
.track { height: 4px; margin-top: 10px; overflow: hidden; border-radius: 99px; background: var(--border-primary); }
.track span { display: block; height: 100%; border-radius: inherit; background: var(--primary); box-shadow: none; transition: width 220ms ease; }
.navigation { display: flex; justify-content: flex-end; gap: 10px; }
.navigation .primary { color: #1a1a1a; border-color: var(--primary); background: var(--primary); box-shadow: none; }
@media (max-width: 900px) {
  .dictation-progress { grid-template-columns: 1fr 1fr; }
  .center-progress { grid-row: 2; grid-column: 1 / -1; }
}
@media (max-width: 560px) {
  .dictation-progress { grid-template-columns: 1fr; }
  .back, .navigation { justify-self: stretch; }
  .navigation button { flex: 1; }
  .center-progress { grid-row: auto; grid-column: auto; }
}
</style>
