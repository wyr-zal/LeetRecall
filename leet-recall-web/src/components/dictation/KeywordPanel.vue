<script setup lang="ts">
defineProps<{ keywords: string[] }>()
</script>

<template>
  <section class="panel app-card">
    <h2>关键词提示</h2>
    <div class="keywords"><span v-for="keyword in keywords" :key="keyword">{{ keyword }}</span></div>
  </section>
</template>

<style scoped>
.panel { padding: 18px; background: #222222; }
h2 { margin: 0 0 14px; font-size: 15px; font-weight: 650; }
.keywords { display: flex; flex-wrap: wrap; gap: 8px; }
.keywords span { padding: 6px 9px; color: var(--text-secondary); font-size: 12px; border: 1px solid var(--border-primary); border-radius: 6px; background: var(--bg-input); box-shadow: none; }
</style>
