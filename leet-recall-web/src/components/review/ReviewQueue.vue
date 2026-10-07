<script setup lang="ts">
import { computed, nextTick, ref, watch } from 'vue'
import { CircleCheck, CircleDot } from 'lucide-vue-next'
import type { ReviewQueueItem } from '@/types/problem'

const props = withDefaults(defineProps<{ items: ReviewQueueItem[]; currentProblemId: number | null; active?: boolean }>(), { active: true })
defineEmits<{ select: [problemId: number] }>()
const queueList = ref<HTMLElement | null>(null)

function scrollCurrentIntoView(block: ScrollLogicalPosition): void {
  if (!props.active) return
  const list = queueList.value
  const current = list?.querySelector<HTMLElement>('[aria-current="true"]')
  if (!list || !current) return
  const container = list.getBoundingClientRect()
  const item = current.getBoundingClientRect()
  if (block === 'center') {
    list.scrollTop += item.top - container.top - (list.clientHeight - item.height) / 2
  } else if (item.top < container.top) {
    list.scrollTop += item.top - container.top
  } else if (item.bottom > container.bottom) {
    list.scrollTop += item.bottom - container.bottom
  }
}

/** 点击/切题：目标题通常已在视口内，最小滚动即可（已可见则不动）。 */
watch(() => props.currentProblemId, async () => {
  await nextTick()
  scrollCurrentIntoView('nearest')
})

/** 列表数据到达（首次渲染或切页回来刷新队列）：当前题滚到列表中部，打开页面即可定位。 */
watch(() => [props.items, props.active], async () => {
  await nextTick()
  scrollCurrentIntoView('center')
}, { immediate: true })

function statusClass(item: ReviewQueueItem): string {
  if (!item.completed) return 'pending'
  return item.todayResult?.toLowerCase() ?? 'completed'
}

function startOfDay(date: Date): number {
  return new Date(date.getFullYear(), date.getMonth(), date.getDate()).getTime()
}

function parseTime(value?: string | null): Date | null {
  if (!value) return null
  const date = new Date(value)
  return Number.isNaN(date.getTime()) ? null : date
}

/** 一周内用相对说法，更早的按日期；跨年补上年份避免误读。 */
function relativeLabel(date: Date): string {
  const now = new Date()
  const days = Math.round((startOfDay(now) - startOfDay(date)) / 86400000)
  if (days <= 0) return '今天'
  if (days === 1) return '昨天'
  if (days < 7) return `${days}天前`
  const month = String(date.getMonth() + 1).padStart(2, '0')
  const day = String(date.getDate()).padStart(2, '0')
  if (date.getFullYear() !== now.getFullYear()) return `${date.getFullYear()}-${month}-${day}`
  return `${month}-${day}`
}

type QueueStamp = { label: string; iso: string | null; updated: boolean }

/**
 * 复习痕迹与内容更新痕迹取最晚的一个展示，并标明是哪一类。
 * 两者同一时刻时算更新——导入会在题目没有笔记时自动写入笔记，
 * 那条笔记的时间与导入时间完全相同，并不代表真的复习过。
 * 都没有则是从未碰过的题目。
 */
function queueStamp(item: ReviewQueueItem): QueueStamp {
  const reviewed = parseTime(item.lastReviewedAt)
  const updated = parseTime(item.contentUpdatedAt)
  if (updated && (!reviewed || updated >= reviewed)) {
    return { label: `已更新 ${relativeLabel(updated)}`, iso: item.contentUpdatedAt ?? null, updated: true }
  }
  if (reviewed) {
    return { label: `复习 ${relativeLabel(reviewed)}`, iso: item.lastReviewedAt ?? null, updated: false }
  }
  return { label: '未复习', iso: null, updated: false }
}

const rows = computed(() => props.items.map((item) => ({ item, stamp: queueStamp(item) })))
</script>

<template>
  <section class="queue app-card" aria-labelledby="queue-title">
    <div class="queue-heading">
      <h2 id="queue-title">今日队列</h2>
      <span>{{ items.filter((item) => item.completed).length }}/{{ items.length }}</span>
    </div>
    <div ref="queueList" class="queue-list" tabindex="0" aria-label="今日复习题目列表">
      <button
        v-for="{ item, stamp } in rows"
        :key="item.problemId"
        type="button"
        :class="[{ current: item.problemId === currentProblemId }, statusClass(item)]"
        :aria-current="item.problemId === currentProblemId ? 'true' : undefined"
        @click="$emit('select', item.problemId)"
      >
        <CircleCheck v-if="item.completed" :size="14" />
        <CircleDot v-else :size="14" />
        <span>{{ item.leetcodeNumber }}. {{ item.title }}</span>
        <time
          v-if="stamp.iso"
          class="queue-time"
          :class="{ updated: stamp.updated }"
          :datetime="stamp.iso"
        >
          {{ stamp.label }}
        </time>
        <span v-else class="queue-time never">{{ stamp.label }}</span>
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
h2 { margin: 0; font-size: calc(15px * var(--ui-font-ratio)); font-weight: 650; }
.queue-heading > span { color: var(--text-muted); font-size: calc(12px * var(--ui-font-ratio)); }
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
  grid-template-columns: 16px minmax(0, 1fr) auto;
  gap: 8px;
  align-items: center;
  width: 100%;
  min-height: 38px;
  padding: 7px 8px;
  color: var(--text-muted);
  font-size: calc(13px * var(--ui-font-ratio));
  line-height: 1.5;
  text-align: left;
  border: 0;
  border-radius: 6px;
  background: transparent;
}
button span { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.queue-time {
  color: var(--text-muted);
  font-size: calc(11px * var(--ui-font-ratio));
  font-variant-numeric: tabular-nums;
  white-space: nowrap;
}
button:hover { color: var(--text-secondary); background: var(--bg-card-hover); }
button.current { color: var(--text-primary); background: var(--bg-card-hover); box-shadow: inset 2px 0 0 var(--primary); }
button.forgot { color: var(--danger); }
button.fuzzy { color: var(--warning); }
button.known, button.completed { color: var(--success); }
</style>
