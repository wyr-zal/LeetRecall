<script setup lang="ts">
const shortcuts = [
  ['1', '不会'], ['2', '模糊'], ['3', '会'], ['H', '提示'], ['A', '答案'], ['← →', '切题'],
]
</script>

<template>
  <section class="shortcuts app-card" aria-labelledby="shortcuts-title">
    <h2 id="shortcuts-title">快捷键</h2>
    <dl>
      <div v-for="shortcut in shortcuts" :key="shortcut[0]">
        <dt><kbd>{{ shortcut[0] }}</kbd></dt>
        <dd>{{ shortcut[1] }}</dd>
      </div>
    </dl>
  </section>
</template>

<style scoped>
.shortcuts { padding: 18px; background: #222222; }
h2 { margin: 0 0 14px; font-size: 15px; font-weight: 650; }
dl { display: grid; grid-template-columns: 1fr 1fr; gap: 9px 12px; margin: 0; }
dl > div { display: flex; align-items: center; gap: 8px; }
dt, dd { margin: 0; }
kbd {
  display: inline-grid;
  min-width: 30px;
  height: 28px;
  padding: 0 6px;
  color: var(--text-secondary);
  font-size: 11px;
  border: 1px solid var(--border-primary);
  border-radius: 6px;
  place-items: center;
  background: var(--bg-input);
}
dd { color: var(--text-muted); font-size: 12px; }
</style>
