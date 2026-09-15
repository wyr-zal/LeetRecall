<script setup lang="ts">
import { nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { CircleCheck, CircleDot, List, X } from 'lucide-vue-next'
import type { DictationQueueItem } from '@/types/dictation'

const props = defineProps<{
  open: boolean
  items: DictationQueueItem[]
  currentProblemId: number | null
}>()
const emit = defineEmits<{ select: [problemId: number]; close: [] }>()
const listRef = ref<HTMLElement | null>(null)
const closeButtonRef = ref<HTMLButtonElement | null>(null)

function onKeydown(event: KeyboardEvent): void {
  if (event.key === 'Escape' && props.open) emit('close')
}

onMounted(() => window.addEventListener('keydown', onKeydown))
onBeforeUnmount(() => window.removeEventListener('keydown', onKeydown))

// 打开时聚焦关闭按钮（键盘可达），并把当前题滚到列表中部，与快速复习队列定位一致。
watch(() => props.open, async (open) => {
  if (!open) return
  await nextTick()
  closeButtonRef.value?.focus()
  listRef.value
    ?.querySelector<HTMLElement>('[aria-current="true"]')
    ?.scrollIntoView({ block: 'center' })
})

function statusLabel(item: DictationQueueItem): string {
  if (!item.completed) return '未默写'
  return item.accuracy === undefined ? '已完成' : `正确率 ${Math.round(item.accuracy)}%`
}
</script>

<template>
  <Teleport to="body">
    <div v-if="open" class="picker-backdrop" role="presentation" @click.self="emit('close')">
      <section class="picker" role="dialog" aria-modal="true" aria-labelledby="dictation-picker-title">
        <header class="picker-header">
          <div>
            <h2 id="dictation-picker-title"><List :size="17" /> 选择默写题目</h2>
            <p>点击题目直接开始默写，进度和记录不受影响。</p>
          </div>
          <button ref="closeButtonRef" type="button" aria-label="关闭选题" @click="emit('close')"><X :size="19" /></button>
        </header>
        <div ref="listRef" class="picker-list" role="listbox" aria-label="默写题目列表">
          <button
            v-for="item in items"
            :key="item.problemId"
            type="button"
            role="option"
            :class="{ current: item.problemId === currentProblemId, done: item.completed }"
            :aria-current="item.problemId === currentProblemId ? 'true' : undefined"
            @click="emit('select', item.problemId)"
          >
            <CircleCheck v-if="item.completed" :size="14" />
            <CircleDot v-else :size="14" />
            <span>{{ item.leetcodeNumber }}. {{ item.title }}</span>
            <span class="status">{{ statusLabel(item) }}</span>
          </button>
          <p v-if="!items.length" class="empty">今天没有可默写的题目。</p>
        </div>
      </section>
    </div>
  </Teleport>
</template>

<style scoped>
.picker-backdrop {
  position: fixed;
  z-index: 110;
  display: grid;
  inset: 0;
  padding: 24px;
  place-items: center;
  background: rgba(3, 6, 11, 0.72);
  backdrop-filter: blur(4px);
}
.picker {
  display: flex;
  width: min(560px, 100%);
  max-height: min(640px, calc(100vh - 48px));
  overflow: hidden;
  flex-direction: column;
  padding: 20px;
  color: var(--text-primary);
  border: 1px solid var(--border-primary);
  border-radius: 10px;
  background: var(--bg-card);
  box-shadow: var(--shadow-high);
}
.picker-header { display: flex; align-items: flex-start; justify-content: space-between; gap: 16px; }
.picker-header h2 { display: flex; align-items: center; gap: 8px; margin: 0 0 5px; font-size: 17px; }
.picker-header h2 svg { color: var(--primary); }
.picker-header p { margin: 0; color: var(--text-muted); font-size: 12px; }
.picker-header button {
  display: grid;
  width: 38px;
  height: 38px;
  flex: 0 0 auto;
  color: var(--text-muted);
  border: 1px solid var(--border-secondary);
  border-radius: 8px;
  cursor: pointer;
  place-items: center;
  background: transparent;
}
.picker-header button:hover, .picker-header button:focus-visible { color: var(--text-primary); background: var(--bg-card-hover); }
.picker-list {
  display: grid;
  min-height: 0;
  margin-top: 16px;
  padding-right: 5px;
  overflow-y: auto;
  overscroll-behavior: contain;
  scrollbar-gutter: stable;
  gap: 3px;
}
.picker-list button {
  display: grid;
  grid-template-columns: 16px minmax(0, 1fr) auto;
  gap: 9px;
  align-items: center;
  width: 100%;
  min-height: 40px;
  padding: 7px 10px;
  color: var(--text-muted);
  font-size: 13px;
  text-align: left;
  border: 0;
  border-radius: 6px;
  background: transparent;
}
.picker-list button > span:first-of-type { overflow: hidden; color: var(--text-secondary); text-overflow: ellipsis; white-space: nowrap; }
.picker-list button:hover { color: var(--text-secondary); background: var(--bg-card-hover); }
.picker-list button.current { color: var(--text-primary); background: var(--bg-card-hover); box-shadow: inset 2px 0 0 var(--primary); }
.picker-list button.current > span:first-of-type { color: var(--text-primary); }
.picker-list button.done > span:first-of-type { color: var(--success); }
.picker-list .status { color: var(--text-muted); font-size: 11px; font-variant-numeric: tabular-nums; white-space: nowrap; }
.picker-list .empty { padding: 18px 10px; margin: 0; color: var(--text-muted); font-size: 13px; }
</style>
