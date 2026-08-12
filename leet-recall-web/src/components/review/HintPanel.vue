<script setup lang="ts">
import { ChevronDown, Lightbulb } from 'lucide-vue-next'

defineProps<{ visible: boolean; hint: string }>()
defineEmits<{ toggle: [] }>()
</script>

<template>
  <section class="hint-panel" :class="{ open: visible }">
    <button type="button" :aria-expanded="visible" @click="$emit('toggle')">
      <span><Lightbulb :size="17" /> {{ visible ? '提示' : '查看提示' }}</span>
      <ChevronDown :size="17" />
    </button>
    <p v-if="visible">{{ hint }}</p>
  </section>
</template>

<style scoped>
.hint-panel {
  margin-top: 12px;
  overflow: hidden;
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  background: #222222;
  box-shadow: none;
}

.hint-panel:hover { border-color: #505050; }

button {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  min-height: 46px;
  padding: 0 15px;
  color: var(--text-secondary);
  border: 0;
  background: transparent;
}

button > span { display: flex; align-items: center; gap: 8px; }
button > span svg { color: var(--warning); }
button > svg { transition: transform 160ms ease; }
.open button > svg { transform: rotate(180deg); }
p { margin: 0; padding: 0 15px 15px; color: var(--text-secondary); font-size: 14px; line-height: 1.7; }
</style>
