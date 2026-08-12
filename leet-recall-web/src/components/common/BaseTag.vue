<script setup lang="ts">
defineProps<{ label: string }>()
</script>

<template>
  <span class="tag">{{ label }}</span>
</template>

<style scoped>
.tag {
  display: inline-flex;
  align-items: center;
  min-height: 26px;
  padding: 3px 9px;
  color: var(--text-secondary);
  font-size: 12px;
  border: 1px solid var(--border-secondary);
  border-radius: 6px;
  background: #333333;
  box-shadow: none;
}
</style>
