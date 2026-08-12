<script setup lang="ts">
defineProps<{ completed: number; total: number }>()
defineEmits<{ end: [] }>()
</script>

<template>
  <header class="review-progress">
    <div class="progress-copy">
      <div><span>今日复习</span> <strong>{{ completed }}</strong> / {{ total }}</div>
      <div
        class="progress-track"
        role="progressbar"
        aria-label="今日复习进度"
        :aria-valuenow="completed"
        :aria-valuemax="total || 1"
      >
        <span :style="{ width: `${total ? (completed / total) * 100 : 0}%` }" />
      </div>
    </div>
    <button type="button" @click="$emit('end')">结束复习</button>
  </header>
</template>

<style scoped>
.review-progress {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  padding: 0 2px 10px;
  margin-bottom: 10px;
  border-bottom: 1px solid var(--border-secondary);
}

.progress-copy {
  display: grid;
  grid-template-columns: auto minmax(160px, 1fr);
  align-items: center;
  width: min(700px, 76%);
  gap: 12px;
  color: var(--text-secondary);
  font-size: 13px;
}

.progress-copy strong {
  color: var(--primary);
  font-size: 16px;
  font-weight: 650;
}

.progress-track {
  height: 3px;
  overflow: hidden;
  border-radius: 99px;
  background: var(--border-primary);
}

.progress-track span {
  display: block;
  height: 100%;
  border-radius: inherit;
  background: var(--primary);
  box-shadow: none;
  transition: width 240ms ease;
}

button {
  min-height: 34px;
  padding: 0 13px;
  color: var(--text-secondary);
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  background: var(--bg-card);
  box-shadow: none;
  white-space: nowrap;
}

button:hover { color: var(--text-primary); border-color: var(--primary); background: var(--bg-card-hover); }

@media (max-width: 560px) {
  .review-progress { gap: 12px; }
  .progress-copy { display: block; flex: 1; width: auto; }
  .progress-track { margin-top: 8px; }
  button { padding-inline: 12px; }
}
</style>
