<script setup lang="ts">
import { computed } from 'vue'
import BaseTag from '@/components/common/BaseTag.vue'
import type { Difficulty } from '@/types/problem'

const props = defineProps<{
  number: number
  title: string
  difficulty: Difficulty
  tags: string[]
  updatedAt?: string | null
  externalImported?: boolean
}>()

const difficultyLabel = computed(() => ({
  EASY: '简单',
  MEDIUM: '中等',
  HARD: '困难',
})[props.difficulty])

const updatedLabel = computed(() => {
  if (!props.updatedAt) return ''
  const date = new Date(props.updatedAt)
  if (Number.isNaN(date.getTime())) return ''
  return new Intl.DateTimeFormat('zh-CN', {
    year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', hour12: false,
  }).format(date)
})
</script>

<template>
  <header class="problem-header">
    <h1><span>{{ number }}.</span> {{ title }}</h1>
    <div class="problem-meta">
      <span :class="['difficulty', `difficulty-${difficulty.toLowerCase()}`]">{{ difficultyLabel }}</span>
      <div class="tags" aria-label="题目标签">
        <BaseTag v-for="tag in tags.slice(0, 4)" :key="tag" :label="tag" />
      </div>
      <span v-if="externalImported || updatedLabel" class="content-meta">
        <span v-if="externalImported" class="source-badge">外部导入</span>
        <time v-if="updatedLabel" :datetime="updatedAt ?? undefined">{{ updatedLabel }}</time>
      </span>
    </div>
  </header>
</template>

<style scoped>
.problem-header {
  padding-bottom: 12px;
  border-bottom: 1px solid var(--border-secondary);
}

h1 {
  margin: 0 0 8px;
  font-size: clamp(19px, 1.65vw, 23px);
  font-weight: 680;
  letter-spacing: 0;
  line-height: 1.28;
  text-wrap: pretty;
}

h1 span { color: var(--primary); font-weight: 620; }
.problem-meta { display: flex; align-items: center; flex-wrap: wrap; gap: 7px; }
.tags { display: flex; flex-wrap: wrap; gap: 6px; }
.content-meta {
  display: inline-flex;
  align-items: center;
  gap: 7px;
  margin-left: auto;
  color: var(--text-muted);
  font-size: 11px;
  white-space: nowrap;
}
.source-badge {
  padding: 1px 6px;
  font-size: 10px;
  font-weight: 600;
  border: 1px solid var(--border-secondary);
  border-radius: 5px;
  color: var(--text-muted);
}
@media (max-width: 640px) {
  .content-meta { flex-basis: 100%; margin-left: 0; }
}
.difficulty {
  padding: 3px 7px;
  font-size: 10px;
  font-weight: 700;
  border: 1px solid currentColor;
  border-radius: 5px;
}
.difficulty-easy { color: var(--success-strong); background: rgba(60, 211, 192, 0.07); }
.difficulty-medium { color: var(--warning-strong); background: rgba(243, 201, 105, 0.07); }
.difficulty-hard { color: var(--danger-strong); background: var(--danger-soft); }
</style>
