<script setup lang="ts">
defineProps<{ mistakes: string[] }>()
</script>

<template>
  <section class="panel app-card">
    <h2>常错点</h2>
    <ul><li v-for="mistake in mistakes.slice(0, 4)" :key="mistake">{{ mistake }}</li></ul>
  </section>
</template>

<style scoped>
.panel { padding: 18px; background: #222222; }
h2 { margin: 0 0 13px; font-size: 15px; font-weight: 650; }
ul { display: grid; gap: 10px; padding: 0; margin: 0; list-style: none; }
li { position: relative; padding-left: 15px; color: var(--text-secondary); font-size: 12px; line-height: 1.55; }
li::before { position: absolute; top: 7px; left: 0; width: 6px; height: 6px; content: ''; border-radius: 50%; background: var(--warning); }
</style>
