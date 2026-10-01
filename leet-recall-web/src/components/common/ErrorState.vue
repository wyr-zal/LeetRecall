<script setup lang="ts">
import { RotateCcw } from 'lucide-vue-next'

withDefaults(defineProps<{ message?: string }>(), {
  message: '加载失败，请重试',
})
defineEmits<{ retry: [] }>()
</script>

<template>
  <div class="state" role="alert">
    <h2>{{ message }}</h2>
    <button type="button" @click="$emit('retry')">
      <RotateCcw :size="16" />
      重新加载
    </button>
  </div>
</template>

<style scoped>
.state {
  display: grid;
  min-height: 280px;
  place-content: center;
  justify-items: center;
  text-align: center;
}

.state h2 {
  margin: 0 0 18px;
  font-size: calc(17px * var(--ui-font-ratio));
  font-weight: 560;
}

.state button {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  min-height: 40px;
  padding: 0 15px;
  color: var(--text-primary);
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  background: var(--bg-card);
}
</style>

