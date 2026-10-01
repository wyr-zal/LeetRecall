<script setup lang="ts">
import { ChevronLeft, ChevronRight, Highlighter, List } from 'lucide-vue-next'

defineProps<{ current: number; total: number; annotationCount?: number; annotationsVisible?: boolean }>()
defineEmits<{ previous: []; next: []; pick: []; annotations: [] }>()
</script>

<template>
  <div class="dictation-controls">
    <button v-if="annotationsVisible" class="annotate" type="button" @click="$emit('annotations')">
      <Highlighter :size="15" />批注
      <span v-if="annotationCount" class="badge">{{ annotationCount }}</span>
    </button>
    <button class="pick" type="button" @click="$emit('pick')"><List :size="15" />选题</button>
    <span class="counter"><strong>{{ current }}</strong> / {{ total }}</span>
    <button class="nav" type="button" aria-label="上一题" @click="$emit('previous')"><ChevronLeft :size="16" /></button>
    <button class="nav primary" type="button" aria-label="下一题" @click="$emit('next')"><ChevronRight :size="16" /></button>
  </div>
</template>

<style scoped>
.dictation-controls { display: flex; align-items: center; gap: 8px; margin-left: auto; }
button { display: inline-flex; align-items: center; justify-content: center; gap: 6px; min-height: 34px; padding: 0 11px; color: var(--text-secondary); border: 1px solid var(--border-primary); border-radius: 8px; background: var(--bg-card); box-shadow: none; white-space: nowrap; }
button:hover { color: var(--text-primary); border-color: var(--border-hover); }
.badge { display: inline-grid; min-width: 18px; height: 18px; padding: 0 5px; color: var(--on-primary); font-size: calc(10px * var(--ui-font-ratio)); font-variant-numeric: tabular-nums; border-radius: 9px; place-items: center; background: var(--primary); }
.counter { color: var(--text-secondary); font-size: calc(13px * var(--ui-font-ratio)); font-variant-numeric: tabular-nums; white-space: nowrap; }
.counter strong { color: var(--primary); }
.nav { width: 34px; padding: 0; }
.nav.primary { color: var(--on-primary); border-color: var(--primary); background: var(--primary); }
.nav.primary:hover { color: var(--on-primary); border-color: var(--primary-hover); background: var(--primary-hover); }
@media (max-width: 900px) { .dictation-controls { margin-left: 0; } }
@media (max-width: 640px) { .dictation-controls { width: 100%; }.annotate, .pick { flex: 1 1 0; }.annotate, .pick, .nav { min-height: 44px; }.nav { width: 44px; } }
</style>
