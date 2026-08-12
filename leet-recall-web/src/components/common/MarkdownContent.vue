<script setup lang="ts">
import { computed } from 'vue'
import { renderMarkdown } from '@/utils/markdown'

const props = defineProps<{ markdown: string }>()
const html = computed(() => renderMarkdown(props.markdown))
</script>

<template>
  <!-- markdown-it 禁用原始 HTML 并校验链接协议，此处只渲染其受控输出。 -->
  <!-- eslint-disable-next-line vue/no-v-html -->
  <article class="markdown-content markdown-preview" v-html="html"></article>
</template>

<style scoped>
.markdown-content {
  color: var(--text-secondary);
  font-size: 13px;
  line-height: 1.82;
  overflow-wrap: anywhere;
}

.markdown-content :deep(> :first-child) { margin-top: 0; }
.markdown-content :deep(> :last-child) { margin-bottom: 0; }
.markdown-content :deep(h1),
.markdown-content :deep(h2),
.markdown-content :deep(h3),
.markdown-content :deep(h4) {
  margin: 1.5em 0 0.55em;
  color: var(--text-primary);
  line-height: 1.35;
}
.markdown-content :deep(h1) { font-size: 20px; }
.markdown-content :deep(h2) { font-size: 17px; }
.markdown-content :deep(h3) { font-size: 14px; }
.markdown-content :deep(p),
.markdown-content :deep(ul),
.markdown-content :deep(ol),
.markdown-content :deep(blockquote),
.markdown-content :deep(pre),
.markdown-content :deep(table) { margin: 0 0 12px; }
.markdown-content :deep(ul),
.markdown-content :deep(ol) { padding-left: 23px; }
.markdown-content :deep(ul) { list-style: disc; }
.markdown-content :deep(ol) { list-style: decimal; }
.markdown-content :deep(li + li) { margin-top: 3px; }
.markdown-content :deep(strong) { color: var(--text-primary); }
.markdown-content :deep(a) { color: var(--primary-hover); text-underline-offset: 3px; }
.markdown-content :deep(img) {
  display: block;
  max-width: 100%;
  height: auto;
  margin: 14px auto;
  border-radius: 7px;
}
.markdown-content :deep(blockquote) {
  padding: 8px 12px;
  color: var(--text-muted);
  border-left: 3px solid var(--primary);
  background: rgba(255, 161, 22, 0.055);
}
.markdown-content :deep(code) {
  padding: 2px 5px;
  color: #ffd08a;
  font-size: 0.92em;
  border: 1px solid var(--border-secondary);
  border-radius: 4px;
  background: #252525;
}
.markdown-content :deep(pre) {
  max-height: 420px;
  padding: 14px;
  overflow: auto;
  color: #d4d4d4;
  line-height: 1.65;
  border: 1px solid var(--border-secondary);
  border-radius: 6px;
  background: #1e1e1e;
}
.markdown-content :deep(pre code) { padding: 0; color: inherit; border: 0; background: none; }
.markdown-content :deep(table) { width: 100%; border-collapse: collapse; }
.markdown-content :deep(th),
.markdown-content :deep(td) { padding: 8px 10px; text-align: left; border: 1px solid var(--border-primary); }
.markdown-content :deep(th) { color: var(--text-primary); background: #252525; }
.markdown-content :deep(hr) { margin: 20px 0; border: 0; border-top: 1px solid var(--border-primary); }
</style>
