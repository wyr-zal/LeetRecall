<script setup lang="ts">
import { onMounted, ref, watch } from 'vue'
import { storeToRefs } from 'pinia'
import { BrainCircuit, FileText, NotebookPen } from 'lucide-vue-next'
import { useQuickReviewStore } from '@/stores/quickReview'
import { useReviewShortcuts } from '@/composables/useReviewShortcuts'
import ReviewProgress from '@/components/review/ReviewProgress.vue'
import ProblemHeader from '@/components/review/ProblemHeader.vue'
import ProblemDescription from '@/components/review/ProblemDescription.vue'
import RecallQuestionList from '@/components/review/RecallQuestionList.vue'
import HintPanel from '@/components/review/HintPanel.vue'
import AnswerPanel from '@/components/review/AnswerPanel.vue'
import ProblemNotePanel from '@/components/review/ProblemNotePanel.vue'
import ReviewResultButtons from '@/components/review/ReviewResultButtons.vue'
import ReviewQueue from '@/components/review/ReviewQueue.vue'
import KeyboardShortcutPanel from '@/components/review/KeyboardShortcutPanel.vue'
import LoadingState from '@/components/common/LoadingState.vue'
import ErrorState from '@/components/common/ErrorState.vue'
import EmptyState from '@/components/common/EmptyState.vue'
import type { MasteryLevel } from '@/types/problem'

type StudyTab = 'description' | 'recall' | 'notes'

const store = useQuickReviewStore()
const {
  todayQueue,
  currentProblemId,
  currentProblem,
  hintVisible,
  answerVisible,
  loading,
  detailLoading,
  submitting,
  error,
  completedCount,
  currentDraft,
} = storeToRefs(store)
const activeTab = ref<StudyTab>('description')

onMounted(() => store.loadQueue())

watch(currentProblemId, () => {
  activeTab.value = 'description'
})

function submit(result: Exclude<MasteryLevel, 'NEW'>): void {
  void store.submit(result)
}

function showRecall(action: () => void): void {
  activeTab.value = 'recall'
  action()
}

useReviewShortcuts({
  onForgot: () => submit('FORGOT'),
  onFuzzy: () => submit('FUZZY'),
  onKnown: () => submit('KNOWN'),
  onToggleHint: () => showRecall(store.toggleHint),
  onToggleAnswer: () => showRecall(store.toggleAnswer),
  onNext: () => void store.move(1),
  onPrevious: () => void store.move(-1),
  onEnd: () => void store.endReview(),
})
</script>

<template>
  <main class="review-page">
    <ReviewProgress
      :completed="completedCount"
      :total="todayQueue.length"
      @end="store.endReview"
    />

    <LoadingState v-if="loading" />
    <ErrorState v-else-if="error && !currentProblem" :message="error" @retry="store.loadQueue" />
    <EmptyState
      v-else-if="todayQueue.length === 0 && !currentProblem"
      title="今天没有待复习题目"
      action-label="随机复习一题"
      @action="store.loadQueue"
    />

    <div v-else class="review-grid">
      <section class="review-main app-card app-card--raised">
        <LoadingState v-if="detailLoading || !currentProblem" />
        <template v-else>
          <div class="review-scroll">
            <ProblemHeader
              :number="currentProblem.leetcodeNumber"
              :title="currentProblem.title"
              :difficulty="currentProblem.difficulty"
              :tags="currentProblem.tags"
            />

            <nav class="study-tabs" role="tablist" aria-label="题目学习内容">
              <button
                id="tab-description"
                type="button"
                role="tab"
                :aria-selected="activeTab === 'description'"
                aria-controls="panel-description"
                :tabindex="activeTab === 'description' ? 0 : -1"
                :class="{ active: activeTab === 'description' }"
                @click="activeTab = 'description'"
              >
                <FileText :size="16" />题目描述
              </button>
              <button
                id="tab-recall"
                type="button"
                role="tab"
                :aria-selected="activeTab === 'recall'"
                aria-controls="panel-recall"
                :tabindex="activeTab === 'recall' ? 0 : -1"
                :class="{ active: activeTab === 'recall' }"
                @click="activeTab = 'recall'"
              >
                <BrainCircuit :size="16" />回忆复习
              </button>
              <button
                id="tab-notes"
                type="button"
                role="tab"
                :aria-selected="activeTab === 'notes'"
                aria-controls="panel-notes"
                :tabindex="activeTab === 'notes' ? 0 : -1"
                :class="{ active: activeTab === 'notes' }"
                @click="activeTab = 'notes'"
              >
                <NotebookPen :size="16" />我的笔记
              </button>
            </nav>

            <div
              v-show="activeTab === 'description'"
              id="panel-description"
              class="study-panel"
              role="tabpanel"
              aria-labelledby="tab-description"
              tabindex="0"
            >
              <ProblemDescription :markdown="currentProblem.descriptionMarkdown" />
            </div>

            <div
              v-show="activeTab === 'recall'"
              id="panel-recall"
              class="study-panel recall-panel"
              role="tabpanel"
              aria-labelledby="tab-recall"
              tabindex="0"
            >
              <RecallQuestionList
                :questions="currentProblem.recallQuestions"
                :draft="currentDraft"
                :answers-visible="answerVisible"
                @update="store.updateDraft"
              />
              <HintPanel
                :visible="hintVisible"
                :hint="currentProblem.hint"
                @toggle="store.toggleHint"
              />
              <AnswerPanel
                :visible="answerVisible"
                :core-idea="currentProblem.coreIdea"
                :mistakes="currentProblem.mistakes"
                :key-code="currentProblem.keyCode"
                @toggle="store.toggleAnswer"
              />
            </div>

            <div
              v-show="activeTab === 'notes'"
              id="panel-notes"
              class="study-panel notes-panel"
              role="tabpanel"
              aria-labelledby="tab-notes"
              tabindex="0"
            >
              <ProblemNotePanel :problem-id="currentProblem.problemId" />
            </div>
          </div>
          <ReviewResultButtons :loading="submitting" @select="submit" />
        </template>
      </section>

      <aside class="review-aside">
        <ReviewQueue
          :items="todayQueue"
          :current-problem-id="currentProblemId"
          @select="store.loadProblem"
        />
        <KeyboardShortcutPanel />
      </aside>
    </div>
  </main>
</template>

<style scoped>
.review-page {
  width: min(1220px, calc(100% - 56px));
  height: calc(100dvh - var(--topbar-height));
  padding: 14px 0;
  margin: 0 auto;
  display: grid;
  grid-template-rows: auto minmax(0, 1fr);
  overflow: hidden;
}

.review-grid {
  display: grid;
  grid-template-columns: minmax(620px, 860px) minmax(248px, 286px);
  min-height: 0;
  gap: 22px;
  align-items: stretch;
}

.review-main {
  display: grid;
  min-width: 0;
  min-height: 0;
  overflow: hidden;
  grid-template-rows: minmax(0, 1fr) auto;
}
.review-scroll {
  min-height: 0;
  padding: 18px clamp(18px, 2vw, 24px) 8px;
  overflow-y: auto;
  overscroll-behavior: contain;
  scrollbar-gutter: stable;
  scroll-padding-block: 12px 72px;
}
.study-tabs {
  display: flex;
  min-height: 40px;
  margin-top: 2px;
  border-bottom: 1px solid var(--border-secondary);
}
.study-tabs button {
  position: relative;
  display: inline-flex;
  align-items: center;
  min-width: 116px;
  min-height: 40px;
  padding: 0 14px;
  gap: 7px;
  color: var(--text-muted);
  font-size: 12px;
  font-weight: 620;
  border: 0;
  background: transparent;
  transition: color 180ms ease, background-color 180ms ease;
}
.study-tabs button::after {
  position: absolute;
  right: 15px;
  bottom: -1px;
  left: 15px;
  height: 2px;
  content: '';
  background: transparent;
  transition: background-color 180ms ease;
}
.study-tabs button:hover { color: var(--text-secondary); background: rgba(255, 255, 255, 0.018); }
.study-tabs button.active { color: var(--primary-hover); }
.study-tabs button.active::after { background: var(--primary); }
.study-tabs button:focus-visible { z-index: 1; outline: 2px solid var(--primary); outline-offset: -2px; }
.study-panel {
  padding-right: 8px;
  outline: none;
  animation: reveal-panel 180ms ease;
}
.recall-panel { padding-top: 2px; }
.notes-panel { padding-top: 20px; }
.review-main :deep(.result-buttons) {
  padding: 12px clamp(18px, 2vw, 24px) 16px;
  margin-top: 0;
  border-top: 1px solid var(--border-secondary);
  background: var(--surface-raised);
  box-shadow: 0 -10px 24px rgba(0, 0, 0, 0.12);
}
@keyframes reveal-panel {
  from { opacity: 0; transform: translateY(3px); }
  to { opacity: 1; transform: translateY(0); }
}
.review-aside {
  display: grid;
  min-height: 0;
  overflow: hidden;
  grid-template-rows: minmax(0, 1fr) auto;
  gap: 16px;
}

@media (max-width: 1279px) {
  .review-page {
    width: min(1100px, calc(100% - 36px));
    height: auto;
    min-height: calc(100dvh - var(--topbar-height));
    overflow: visible;
  }
  .review-grid { grid-template-columns: minmax(0, 1fr); }
  .review-main { min-height: 720px; }
  .review-aside {
    grid-template-columns: minmax(0, 1fr) minmax(260px, 0.7fr);
    grid-template-rows: minmax(360px, 52dvh);
    overflow: visible;
  }
}

@media (max-width: 720px) {
  .review-page { width: calc(100% - 24px); padding: 20px 0 88px; }
  .review-aside { grid-template-columns: 1fr; }
}
</style>
