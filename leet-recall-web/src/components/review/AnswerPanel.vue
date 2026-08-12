<script setup lang="ts">
import { ChevronDown, Code2 } from 'lucide-vue-next'

defineProps<{
  visible: boolean
  coreIdea: string
  mistakes: string[]
  keyCode: string
}>()
defineEmits<{ toggle: [] }>()
</script>

<template>
  <section class="answer-panel" :class="{ open: visible }">
    <button class="answer-toggle" type="button" :aria-expanded="visible" @click="$emit('toggle')">
      <span><Code2 :size="17" /> {{ visible ? '收起答案' : '显示答案' }}</span>
      <ChevronDown :size="17" />
    </button>
    <div v-if="visible" class="answer-content">
      <article>
        <h3>核心思路</h3>
        <p>{{ coreIdea }}</p>
      </article>
      <article>
        <h3>易错点</h3>
        <ul>
          <li v-for="mistake in mistakes" :key="mistake">{{ mistake }}</li>
        </ul>
      </article>
      <article class="code-article">
        <h3>关键代码</h3>
        <pre><code>{{ keyCode }}</code></pre>
      </article>
    </div>
  </section>
</template>

<style scoped>
.answer-panel {
  margin-top: 12px;
  overflow: hidden;
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  background: #222222;
  box-shadow: none;
}
.answer-panel:hover { border-color: #505050; }
.answer-toggle {
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
.answer-toggle span { display: flex; align-items: center; gap: 8px; }
.answer-toggle span svg { color: var(--primary); }
.answer-toggle > svg { transition: transform 160ms ease; }
.open .answer-toggle > svg { transform: rotate(180deg); }
.answer-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  border-top: 1px solid var(--border-secondary);
}
article { min-width: 0; padding: 17px; }
article + article { border-left: 1px solid var(--border-secondary); }
.code-article { grid-column: 1 / -1; border-top: 1px solid var(--border-secondary); border-left: 0 !important; }
h3 { margin: 0 0 9px; color: var(--text-primary); font-size: 13px; font-weight: 650; }
p, ul { margin: 0; color: var(--text-secondary); font-size: 13px; line-height: 1.75; }
ul { display: grid; gap: 4px; padding-left: 17px; }
pre {
  max-height: 230px;
  padding: 13px;
  margin: 0;
  overflow: auto;
  color: #c8d4e7;
  font-size: 12px;
  line-height: 1.65;
  border-radius: 6px;
  border: 1px solid var(--border-secondary);
  background: #1e1e1e;
}
@media (max-width: 640px) {
  .answer-content { grid-template-columns: 1fr; }
  article + article { border-top: 1px solid var(--border-secondary); border-left: 0; }
  .code-article { grid-column: auto; }
}
</style>
