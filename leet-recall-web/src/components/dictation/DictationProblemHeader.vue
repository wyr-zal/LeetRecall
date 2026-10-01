<script setup lang="ts">
import BaseTag from '@/components/common/BaseTag.vue'
defineProps<{ number: number; title: string; tags: string[]; progress: number }>()
</script>

<template>
  <header class="header">
    <h1><span>{{ number }}.</span> {{ title }}</h1>
    <div class="tags"><BaseTag v-for="tag in tags" :key="tag" :label="tag" /></div>
    <slot />
    <span class="progress" :style="{ width: `${progress}%` }" aria-hidden="true" />
  </header>
</template>

<style scoped>
.header { position: relative; display: flex; align-items: center; gap: 16px; padding-bottom: 17px; margin-bottom: 16px; border-bottom: 1px solid var(--border-secondary); }
h1 { margin: 0; font-size: clamp(calc(20px * var(--ui-font-ratio)), 2vw, calc(25px * var(--ui-font-ratio))); font-weight: 680; letter-spacing: 0; text-wrap: pretty; }
h1 span { color: var(--primary); font-weight: 620; }
.tags { display: flex; gap: 7px; }
.progress { position: absolute; bottom: -1px; left: 0; height: 2px; background: var(--primary); transition: width 220ms ease; }
@media (max-width: 640px) { .header { align-items: flex-start; flex-direction: column; gap: 10px; } }
</style>
