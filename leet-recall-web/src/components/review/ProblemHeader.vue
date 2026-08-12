<script setup lang="ts">
import { computed } from 'vue'
import BaseTag from '@/components/common/BaseTag.vue'
import type { Difficulty } from '@/types/problem'

const props = defineProps<{ number: number; title: string; difficulty: Difficulty; tags: string[] }>()

const difficultyLabel = computed(() => ({
  EASY: '简单',
  MEDIUM: '中等',
  HARD: '困难',
})[props.difficulty])
</script>

<template>
  <header class="problem-header">
    <h1><span>{{ number }}.</span> {{ title }}</h1>
    <div class="problem-meta">
      <span :class="['difficulty', `difficulty-${difficulty.toLowerCase()}`]">{{ difficultyLabel }}</span>
      <div class="tags" aria-label="题目标签">
        <BaseTag v-for="tag in tags.slice(0, 4)" :key="tag" :label="tag" />
      </div>
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
.difficulty {
  padding: 3px 7px;
  font-size: 10px;
  font-weight: 700;
  border: 1px solid currentColor;
  border-radius: 5px;
}
.difficulty-easy { color: #73d9cd; background: rgba(60, 211, 192, 0.07); }
.difficulty-medium { color: #f3c969; background: rgba(243, 201, 105, 0.07); }
.difficulty-hard { color: #ff9aac; background: rgba(255, 91, 121, 0.07); }
</style>
