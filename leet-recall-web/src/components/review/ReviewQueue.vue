<script setup lang="ts">
import { nextTick, ref, watch } from 'vue'
import { CircleCheck, CircleDot } from 'lucide-vue-next'
import type { ReviewQueueItem } from '@/types/problem'

const props = defineProps<{ items: ReviewQueueItem[]; currentProblemId: number | null }>()
defineEmits<{ select: [problemId: number] }>()
const queueList = ref<HTMLElement | null>(null)

watch(
  () => props.currentProblemId,
  async () => {
    await nextTick()
    queueList.value
      ?.querySelector<HTMLElement>('[aria-current="true"]')
      ?.scrollIntoView({ block: 'nearest' })
  },
  { immediate: true },
)

function statusClass(item: ReviewQueueItem): string {
  if (!item.completed) return 'pending'
  return item.todayResult?.toLowerCase() ?? 'completed'
}
</script>

<template>
  <section class="queue app-card" aria-labelledby="queue-title">
    <div class="queue-heading">
      <h2 id="queue-title">今日队列</h2>
      <span>{{ items.filter((item) => item.completed).length }}/{{ items.length }}</span>
    </div>
    <div ref="queueList" class="queue-list" tabindex="0" aria-label="今日复习题目列表">
      <button
        v-for="item in items"
        :key="item.problemId"
        type="button"
        :class="[{ current: item.problemId === currentProblemId }, statusClass(item)]"
        :aria-current="item.problemId === currentProblemId ? 'true' : undefined"
        @click="$emit('select', item.problemId)"
      >
        <CircleCheck v-if="item.completed" :size="14" />
        <CircleDot v-else :size="14" />
        <span>{{ item.leetcodeNumber }}. {{ item.title }}</span>
      </button>
    </div>
  </section>
</template>

<style scoped>
.queue {
  display: flex;
  min-height: 0;
  padding: 18px 12px 12px 18px;
  overflow: hidden;
  background: var(--bg-card);
  flex-direction: column;
}
.queue-heading {
  display: flex;
  flex: 0 0 auto;
  align-items: center;
  justify-content: space-between;
  padding-right: 6px;
  margin-bottom: 13px;
}
h2 { margin: 0; font-size: 15px; font-weight: 650; }
.queue-heading > span { color: var(--text-muted); font-size: 12px; }
.queue-list {
  display: grid;
  min-height: 0;
  padding-right: 5px;
  overflow-y: auto;
  overscroll-behavior: contain;
  scrollbar-gutter: stable;
  gap: 3px;
}
.queue-list:focus-visible { outline-offset: -2px; }
button {
  display: grid;
  grid-template-columns: 16px minmax(0, 1fr);
  gap: 8px;
  align-items: center;
  width: 100%;
  min-height: 38px;
  padding: 7px 8px;
  color: var(--text-muted);
  font-size: 13px;
  text-align: left;
  border: 0;
  border-radius: 6px;
  background: transparent;
}
button span { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
button:hover { color: var(--text-secondary); background: var(--bg-card-hover); }
button.current { color: var(--text-primary); background: var(--bg-card-hover); box-shadow: inset 2px 0 0 var(--primary); }
button.forgot { color: var(--danger); }
button.fuzzy { color: var(--warning); }
button.known, button.completed { color: var(--success); }
</style>
