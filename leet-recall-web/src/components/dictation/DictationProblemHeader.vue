<script setup lang="ts">
import BaseTag from '@/components/common/BaseTag.vue'
defineProps<{ number: number; title: string; tags: string[] }>()
</script>

<template>
  <header class="header">
    <h1><span>{{ number }}.</span> {{ title }}</h1>
    <div class="tags"><BaseTag v-for="tag in tags" :key="tag" :label="tag" /></div>
  </header>
</template>

<style scoped>
.header { display: flex; align-items: center; gap: 16px; padding-bottom: 17px; margin-bottom: 16px; border-bottom: 1px solid var(--border-secondary); }
h1 { margin: 0; font-size: clamp(20px, 2vw, 25px); font-weight: 680; letter-spacing: 0; text-wrap: pretty; }
h1 span { color: var(--primary); font-weight: 620; }
.tags { display: flex; gap: 7px; }
@media (max-width: 640px) { .header { align-items: flex-start; flex-direction: column; gap: 10px; } }
</style>
