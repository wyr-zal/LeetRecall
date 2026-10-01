<script setup lang="ts">
import type { RecallQuestion } from '@/types/problem'

defineProps<{
  questions: RecallQuestion[]
  draft: Record<number, string>
  answersVisible: boolean
  saveState?: 'idle' | 'saved'
}>()
defineEmits<{ update: [questionId: number, answer: string] }>()
</script>

<template>
  <section class="recall-section" aria-labelledby="recall-heading">
    <div class="section-heading">
      <h2 id="recall-heading">请先回忆</h2>
      <div class="heading-meta">
        <span class="save-hint" :class="{ saved: saveState === 'saved' }" aria-live="polite">
          {{ saveState === 'saved' ? '已保存' : '输入会自动保存' }}
        </span>
      </div>
    </div>
    <div class="questions">
      <label v-for="(question, index) in questions" :key="question.id" class="question-card">
        <span>{{ index + 1 }}. {{ question.question }}</span>
        <textarea
          :value="draft[question.id] ?? ''"
          rows="2"
          :aria-label="question.question"
          placeholder="输入你的回忆，可留空"
          @input="$emit('update', question.id, ($event.target as HTMLTextAreaElement).value)"
        />
        <div v-if="answersVisible" class="correct-answer">
          <strong>正确答案</strong>
          <p>{{ question.answer?.trim() || '暂无标准答案' }}</p>
        </div>
      </label>
    </div>
  </section>
</template>

<style scoped>
.recall-section { margin-top: 22px; }
.section-heading { display: flex; align-items: center; justify-content: space-between; margin-bottom: 12px; }
h2 { margin: 0; font-size: calc(16px * var(--ui-font-ratio)); font-weight: 620; }
.heading-meta { display: flex; align-items: center; gap: 12px; }
.heading-meta span { color: var(--text-muted); font-size: calc(12px * var(--ui-font-ratio)); }
.save-hint { transition: color 150ms ease; }
.save-hint.saved { color: var(--success-strong); }
.heading-meta a { display: inline-flex; align-items: center; gap: 4px; color: var(--primary); font-size: calc(12px * var(--ui-font-ratio)); text-decoration: none; }
.heading-meta a:hover { text-decoration: underline; }
.questions {
  overflow: hidden;
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  background: var(--bg-input);
  box-shadow: none;
}
.question-card {
  display: grid;
  gap: 9px;
  padding: 14px 16px 12px;
  border-bottom: 1px solid var(--border-secondary);
  background: transparent;
  transition: background-color 150ms ease, box-shadow 150ms ease;
}
.question-card:last-child { border-bottom: 0; }
.question-card:focus-within { background: var(--bg-card-hover); box-shadow: inset 3px 0 0 var(--primary); }
.question-card > span { color: var(--text-secondary); font-size: calc(14px * var(--ui-font-ratio)); font-weight: 560; line-height: 1.45; }
textarea {
  width: 100%;
  min-height: 38px;
  padding: 0;
  resize: vertical;
  color: var(--text-primary);
  line-height: 1.55;
  border: 0;
  outline: 0;
  background: transparent;
}
textarea::placeholder { color: var(--placeholder); }
.correct-answer {
  display: grid;
  grid-template-columns: max-content minmax(0, 1fr);
  gap: 10px;
  align-items: start;
  padding-top: 10px;
  border-top: 1px solid var(--border-secondary);
}
.correct-answer strong {
  color: var(--success);
  font-size: calc(12px * var(--ui-font-ratio));
  font-weight: 650;
  line-height: 1.65;
}
.correct-answer p {
  margin: 0;
  color: var(--text-primary);
  font-size: calc(13px * var(--ui-font-ratio));
  line-height: 1.65;
  overflow-wrap: anywhere;
}
@media (max-width: 640px) {
  .section-heading { align-items: flex-start; gap: 8px; }
  .heading-meta { align-items: flex-end; flex-direction: column; gap: 4px; }
}
</style>
