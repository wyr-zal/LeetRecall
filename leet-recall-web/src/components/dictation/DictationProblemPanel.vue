<script setup lang="ts">
import { computed, ref } from 'vue'
import { BrainCircuit, FileText, Lightbulb } from 'lucide-vue-next'
import MarkdownContent from '@/components/common/MarkdownContent.vue'
import type { RecallQuestion } from '@/types/problem'

const props = defineProps<{
  descriptionMarkdown: string
  recallQuestions: RecallQuestion[]
  coreIdea: string
}>()

const TABS = [
  { key: 'description', label: '题目描述', icon: FileText },
  { key: 'recall', label: '回忆问答', icon: BrainCircuit },
  { key: 'coreIdea', label: '核心思路', icon: Lightbulb },
] as const

type TabKey = (typeof TABS)[number]['key']

const activeTab = ref<TabKey>('description')
// 回忆问答默认只出题，答案点开才给——默写时进来直接看到答案就没有默写的意义了。
const revealedAnswers = ref<number[]>([])

const emptyHint = computed(() => {
  if (activeTab.value === 'description') return '这道题还没有题目描述'
  if (activeTab.value === 'recall') return '这道题还没有回忆问答'
  return '这道题还没有核心思路'
})

function toggleAnswer(id: number): void {
  revealedAnswers.value = revealedAnswers.value.includes(id)
    ? revealedAnswers.value.filter((item) => item !== id)
    : [...revealedAnswers.value, id]
}
</script>

<template>
  <div class="problem-pane">
    <nav class="pane-tabs" role="tablist" aria-label="题目内容">
      <button
        v-for="tab in TABS"
        :id="`dictation-tab-${tab.key}`"
        :key="tab.key"
        type="button"
        role="tab"
        :aria-selected="activeTab === tab.key"
        :tabindex="activeTab === tab.key ? 0 : -1"
        :class="{ active: activeTab === tab.key }"
        @click="activeTab = tab.key"
      >
        <component :is="tab.icon" :size="15" />{{ tab.label }}
      </button>
    </nav>

    <div
      class="pane-body"
      role="tabpanel"
      :aria-labelledby="`dictation-tab-${activeTab}`"
      tabindex="0"
    >
      <MarkdownContent
        v-if="activeTab === 'description' && props.descriptionMarkdown.trim()"
        :markdown="props.descriptionMarkdown"
      />
      <ul v-else-if="activeTab === 'recall' && props.recallQuestions.length" class="recall-list">
        <li v-for="(item, index) in props.recallQuestions" :key="item.id" class="recall-item">
          <p class="recall-question"><span class="recall-index">{{ index + 1 }}</span>{{ item.question }}</p>
          <button
            v-if="!revealedAnswers.includes(item.id)"
            class="reveal"
            type="button"
            @click="toggleAnswer(item.id)"
          >
            显示答案
          </button>
          <MarkdownContent v-else :markdown="item.answer ?? ''" />
        </li>
      </ul>
      <MarkdownContent
        v-else-if="activeTab === 'coreIdea' && props.coreIdea.trim()"
        :markdown="props.coreIdea"
      />
      <p v-else class="pane-empty">{{ emptyHint }}</p>
    </div>
  </div>
</template>

<style scoped>
.problem-pane {
  display: flex;
  min-width: 0;
  min-height: 0;
  flex-direction: column;
  overflow: hidden;
}

.pane-tabs {
  display: flex;
  min-height: 40px;
  flex: 0 0 auto;
  padding: 0 20px;
  overflow-x: auto;
  border-bottom: 1px solid var(--border-secondary);
}

.pane-tabs button {
  position: relative;
  display: inline-flex;
  flex: 0 0 auto;
  align-items: center;
  min-height: 40px;
  padding: 0 13px;
  gap: 7px;
  color: var(--text-muted);
  font-size: calc(12px * var(--ui-font-ratio));
  font-weight: 620;
  white-space: nowrap;
  border: 0;
  background: transparent;
}

.pane-tabs button::after {
  position: absolute;
  right: 13px;
  bottom: -1px;
  left: 13px;
  height: 2px;
  content: '';
  background: transparent;
  transition: background-color 180ms ease;
}

.pane-tabs button:hover { color: var(--text-secondary); background: var(--border-highlight); }
.pane-tabs button.active { color: var(--primary-hover); }
.pane-tabs button.active::after { background: var(--primary); }
.pane-tabs button:focus-visible { z-index: 1; outline: 2px solid var(--primary); outline-offset: -2px; }

.pane-body {
  min-height: 0;
  flex: 1;
  padding: 18px 20px 30px;
  overflow: auto;
}

.pane-empty {
  margin: 0;
  padding: 30px 0;
  color: var(--text-muted);
  font-size: calc(12px * var(--ui-font-ratio));
  text-align: center;
}

.recall-list {
  display: grid;
  margin: 0;
  padding: 0;
  gap: 16px;
  list-style: none;
}

.recall-item {
  padding: 12px 14px;
  border: 1px solid var(--border-secondary);
  border-radius: 8px;
  background: var(--border-highlight);
}

.recall-question {
  display: flex;
  margin: 0 0 8px;
  gap: 8px;
  color: var(--text-primary);
  font-size: calc(13px * var(--ui-font-ratio));
  font-weight: 560;
  line-height: 1.65;
}

.recall-index {
  flex: 0 0 auto;
  min-width: 18px;
  height: 18px;
  margin-top: 2px;
  color: var(--primary);
  font-size: calc(11px * var(--ui-font-ratio));
  border: 1px solid color-mix(in srgb, var(--primary) 42%, transparent);
  border-radius: 5px;
  text-align: center;
}

.reveal {
  min-height: 30px;
  padding: 0 12px;
  color: var(--text-secondary);
  font-size: calc(12px * var(--ui-font-ratio));
  border: 1px solid var(--border-primary);
  border-radius: 7px;
  background: transparent;
}

.reveal:hover { color: var(--text-primary); border-color: var(--border-hover); background: var(--bg-card-hover); }
</style>
