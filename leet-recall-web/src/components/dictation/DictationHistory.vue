<script setup lang="ts">
import { ref } from 'vue'
import { ChevronRight } from 'lucide-vue-next'
import type { DictationRecord } from '@/types/dictation'

defineProps<{ records: DictationRecord[] }>()
defineEmits<{ select: [recordId: number] }>()

const expanded = ref(false)

function formatDate(value: string): string {
  return new Intl.DateTimeFormat('zh-CN', {
    month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', hour12: false,
  }).format(new Date(value))
}

function formatDuration(seconds: number): string {
  const minutes = Math.floor(seconds / 60)
  const remain = seconds % 60
  return `${minutes} 分 ${remain.toString().padStart(2, '0')} 秒`
}
</script>

<template>
  <section class="history app-card">
    <button class="history-toggle" type="button" :aria-expanded="expanded" @click="expanded = !expanded">
      <ChevronRight class="chevron" :class="{ expanded }" :size="16" />
      <h2>本题记录</h2>
      <span class="count">{{ records.length }}</span>
    </button>
    <template v-if="expanded">
      <div class="history-head"><span>日期</span><span>正确率</span><span>用时</span><span /></div>
      <button v-for="record in records" :key="record.id" class="record" type="button" @click="$emit('select', record.id)">
        <span>{{ formatDate(record.createdAt) }}</span>
        <strong :class="{ low: record.accuracy < 70 }">{{ Math.round(record.accuracy) }}%</strong>
        <span>{{ formatDuration(record.durationSeconds) }}</span>
        <ChevronRight :size="16" />
      </button>
      <p v-if="records.length === 0">还没有默写记录</p>
    </template>
  </section>
</template>

<style scoped>
.history { overflow: hidden; border: 1px solid var(--border-secondary); border-radius: 7px; background: var(--bg-card); }
.history-toggle { display: flex; min-height: 42px; align-items: center; gap: 8px; width: 100%; padding: 0 12px; color: var(--text-primary); text-align: left; border: 0; background: transparent; }
.history-toggle:hover { background: var(--bg-card-hover); }
h2 { margin: 0; font-size: calc(13px * var(--ui-font-ratio)); font-weight: 650; }
.count { color: var(--text-muted); font-size: calc(12px * var(--ui-font-ratio)); font-variant-numeric: tabular-nums; }
.chevron { color: var(--text-muted); transition: transform 150ms ease; }
.chevron.expanded { transform: rotate(90deg); }
.history-head, .record { display: grid; grid-template-columns: 1.4fr 0.8fr 0.9fr 20px; gap: 12px; align-items: center; width: 100%; padding: 10px 20px; text-align: left; }
.history-head { color: var(--text-muted); font-size: calc(12px * var(--ui-font-ratio)); border-bottom: 1px solid var(--border-secondary); }
.record { min-height: 46px; color: var(--text-secondary); font-size: calc(12px * var(--ui-font-ratio)); border: 0; border-bottom: 1px solid var(--border-secondary); background: transparent; }
.record:hover { background: var(--bg-card-hover); }
.record strong { color: var(--success); font-weight: 600; }
.record strong.low { color: var(--warning); }
.record svg { color: var(--text-muted); }
p { padding: 18px 20px 22px; margin: 0; color: var(--text-muted); font-size: calc(13px * var(--ui-font-ratio)); }
@media (max-width: 600px) { .history-head, .record { grid-template-columns: 1fr 0.7fr 20px; }.history-head span:nth-child(3), .record span:nth-child(3) { display: none; } }
</style>
