<script setup lang="ts">
import { FileQuestion } from 'lucide-vue-next'
import MarkdownContent from '@/components/common/MarkdownContent.vue'

defineProps<{ markdown: string }>()
</script>

<template>
  <section class="description-panel">
    <MarkdownContent v-if="markdown.trim()" :markdown="markdown" />
    <div v-else class="description-empty" role="status">
      <FileQuestion :size="26" />
      <strong>这道题还没有题目描述</strong>
      <span>请在题目导入页补充完整题面后再复习。</span>
    </div>
  </section>
</template>

<style scoped>
.description-panel {
  /* 中文长文 35~45 字/行最舒适；不限宽时主栏最宽 860px，一行可达 60 字。 */
  max-width: 700px;
  min-height: 360px;
  padding: 22px 3px 8px;
}

.description-empty {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  min-height: 320px;
  gap: 8px;
  color: var(--text-muted);
  border: 1px dashed var(--border-primary);
  border-radius: 8px;
  background: var(--border-highlight);
}
.description-empty svg { color: var(--primary); }
.description-empty strong { color: var(--text-secondary); font-size: calc(14px * var(--ui-font-ratio)); }
.description-empty span { font-size: calc(11px * var(--ui-font-ratio)); }
</style>
