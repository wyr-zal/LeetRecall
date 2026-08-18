<script setup lang="ts">
import { computed } from 'vue'
const props = defineProps<{ accuracy: number }>()
const safeAccuracy = computed(() => Math.max(0, Math.min(100, Math.round(props.accuracy))))
</script>

<template>
  <section class="completion app-card">
    <h2>本题完成情况</h2>
    <div class="ring" :style="{ '--accuracy': `${safeAccuracy * 3.6}deg` }">
      <div><strong>{{ safeAccuracy }}</strong><span>%</span></div>
    </div>
    <p>本题默写正确率</p>
  </section>
</template>

<style scoped>
.completion { display: grid; padding: 18px; justify-items: center; background: var(--bg-card); }
h2 { justify-self: start; margin: 0 0 18px; font-size: 15px; font-weight: 650; }
.ring { position: relative; display: grid; width: 118px; height: 118px; border-radius: 50%; place-items: center; background: conic-gradient(var(--primary) var(--accuracy), var(--border-primary) 0); box-shadow: none; }
.ring::before { position: absolute; width: 90px; height: 90px; content: ''; border: 1px solid var(--border-secondary); border-radius: 50%; background: var(--bg-card); }
.ring > div { z-index: 1; }
strong { font-size: 30px; font-weight: 650; }
.ring span { color: var(--text-secondary); font-size: 14px; }
p { margin: 12px 0 0; color: var(--text-muted); font-size: 12px; }
</style>
