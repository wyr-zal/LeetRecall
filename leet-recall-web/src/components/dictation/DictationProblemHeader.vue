<script setup lang="ts">
import BaseTag from '@/components/common/BaseTag.vue'
import type { Difficulty } from '@/types/problem'

defineProps<{ number: number; title: string; difficulty: Difficulty; tags: string[] }>()

const difficultyLabels: Record<Difficulty, string> = {
  EASY: '简单',
  MEDIUM: '中等',
  HARD: '困难',
}
</script>

<template>
  <header class="problem-heading">
    <h1><span>{{ number }}.</span> {{ title }}</h1>
    <div class="problem-meta">
      <span :class="['difficulty', `difficulty-${difficulty.toLowerCase()}`]">{{ difficultyLabels[difficulty] }}</span>
      <div class="tags" aria-label="题目标签">
        <BaseTag v-for="tag in tags" :key="tag" :label="tag" />
      </div>
    </div>
  </header>
</template>

<style scoped>
.problem-heading { display: grid; flex: 0 0 auto; padding: 20px 22px 16px; gap: 12px; border-bottom: 1px solid var(--border-secondary); }
h1 { margin: 0; font-size: clamp(calc(20px * var(--ui-font-ratio)), 1.8vw, calc(26px * var(--ui-font-ratio))); font-weight: 680; line-height: 1.28; text-wrap: pretty; }
h1 span { color: var(--primary); font-weight: 620; }
.problem-meta { display: flex; align-items: center; flex-wrap: wrap; gap: 8px; }
.difficulty { display: inline-flex; min-height: 24px; align-items: center; padding: 0 9px; font-size: calc(12px * var(--ui-font-ratio)); font-weight: 620; border-radius: 999px; background: var(--bg-card-hover); }
.difficulty-easy { color: var(--success); }
.difficulty-medium { color: var(--warning); }
.difficulty-hard { color: var(--danger); }
.tags { display: flex; flex-wrap: wrap; gap: 6px; }
@media (max-width: 720px) { .problem-heading { padding: 16px 16px 13px; gap: 9px; } h1 { font-size: calc(20px * var(--ui-font-ratio)); } }
</style>
