<script setup lang="ts">
import { Shuffle } from 'lucide-vue-next'

defineProps<{ title: string; actionLabel: string }>()
defineEmits<{ action: [] }>()
</script>

<template>
  <div class="state">
    <span class="mark" aria-hidden="true"><Shuffle :size="22" /></span>
    <h2>{{ title }}</h2>
    <button type="button" @click="$emit('action')">{{ actionLabel }}</button>
  </div>
</template>

<style scoped>
.state {
  display: grid;
  min-height: 340px;
  place-content: center;
  justify-items: center;
  text-align: center;
}

.mark {
  display: grid;
  width: 48px;
  height: 48px;
  margin-bottom: 15px;
  color: var(--primary);
  border: 1px solid rgba(255, 161, 22, 0.26);
  border-radius: 12px;
  place-items: center;
  background: var(--primary-soft);
}

h2 {
  margin: 0 0 20px;
  font-size: 18px;
  font-weight: 580;
}

button {
  min-height: 42px;
  padding: 0 17px;
  color: var(--on-primary);
  border: 1px solid var(--primary);
  border-radius: 8px;
  background: var(--primary);
}
</style>
