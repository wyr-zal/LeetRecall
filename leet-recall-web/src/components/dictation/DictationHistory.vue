<script setup lang="ts">
import { ChevronRight } from 'lucide-vue-next'
import type { DictationRecord } from '@/types/dictation'

defineProps<{ records: DictationRecord[] }>()
defineEmits<{ select: [recordId: number] }>()

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
    <h2>本题记录</h2>
    <div class="history-head"><span>日期</span><span>正确率</span><span>用时</span><span /></div>
    <button v-for="record in records" :key="record.id" type="button" @click="$emit('select', record.id)">
      <span>{{ formatDate(record.createdAt) }}</span>
      <strong :class="{ low: record.accuracy < 70 }">{{ Math.round(record.accuracy) }}%</strong>
      <span>{{ formatDuration(record.durationSeconds) }}</span>
      <ChevronRight :size="16" />
    </button>
    <p v-if="records.length === 0">还没有默写记录</p>
  </section>
</template>

<style scoped>
.history { overflow: hidden; background: var(--bg-card); }
h2 { padding: 18px 20px 12px; margin: 0; font-size: 15px; font-weight: 650; }
.history-head, button { display: grid; grid-template-columns: 1.4fr 0.8fr 0.9fr 20px; gap: 12px; align-items: center; width: 100%; padding: 10px 20px; text-align: left; }
.history-head { color: var(--text-muted); font-size: 12px; border-bottom: 1px solid var(--border-secondary); }
button { min-height: 46px; color: var(--text-secondary); font-size: 12px; border: 0; border-bottom: 1px solid var(--border-secondary); background: transparent; }
button:hover { background: var(--bg-card-hover); }
button strong { color: var(--success); font-weight: 600; }
button strong.low { color: var(--warning); }
button svg { color: var(--text-muted); }
p { padding: 18px 20px 22px; margin: 0; color: var(--text-muted); font-size: 13px; }
@media (max-width: 600px) { .history-head, button { grid-template-columns: 1fr 0.7fr 20px; } .history-head span:nth-child(3), button span:nth-child(3) { display: none; } }
</style>
