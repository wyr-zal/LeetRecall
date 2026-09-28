<script setup lang="ts">
import { onActivated, onMounted, ref, watch } from 'vue'
import { storeToRefs } from 'pinia'
import { BrainCircuit, FileText, NotebookPen, SquarePen } from 'lucide-vue-next'
import { useQuickReviewStore } from '@/stores/quickReview'
import { useReviewShortcuts } from '@/composables/useReviewShortcuts'
import ProblemHeader from '@/components/review/ProblemHeader.vue'
import ProblemDescription from '@/components/review/ProblemDescription.vue'
import ProblemContentEditor from '@/components/review/ProblemContentEditor.vue'
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
import type { MasteryLevel, ProblemContentUpdate } from '@/types/problem'

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
  currentDraft,
  saveState,
  editing,
  editContent,
  editLoading,
  editSaving,
  editError,
} = storeToRefs(store)
const activeTab = ref<StudyTab>('description')
let firstActivation = true

onMounted(() => store.loadQueue())
onActivated(() => {
  if (firstActivation) {
    firstActivation = false
    return
  }
  void store.refreshQueue()
})

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

function saveContent(payload: ProblemContentUpdate): void {
  void store.saveEdit(payload)
}

// 编辑态必须挂起全部快捷键：焦点不在输入框时，←/→ 会切题，都会丢弃未保存内容。
function whenNotEditing(action: () => void): () => void {
  return () => {
    if (editing.value) return
    action()
  }
}

useReviewShortcuts({
  onForgot: whenNotEditing(() => submit('FORGOT')),
  onFuzzy: whenNotEditing(() => submit('FUZZY')),
  onKnown: whenNotEditing(() => submit('KNOWN')),
  onToggleHint: whenNotEditing(() => showRecall(store.toggleHint)),
  onToggleAnswer: whenNotEditing(() => showRecall(store.toggleAnswer)),
  onNext: whenNotEditing(() => void store.move(1)),
  onPrevious: whenNotEditing(() => void store.move(-1)),
})
</script>

<template>
  <main class="review-page">
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
              :updated-at="currentProblem.updatedAt"
              :external-imported="currentProblem.externalImported"
            />

            <template v-if="editing">
              <LoadingState v-if="editLoading" />
              <ErrorState
                v-else-if="!editContent"
                :message="editError || '读取题目内容失败'"
                @retry="store.enterEdit"
              />
              <ProblemContentEditor
                v-else
                :content="editContent"
                :saving="editSaving"
                :error-message="editError"
                @save="saveContent"
                @cancel="store.cancelEdit"
              />
            </template>

            <template v-else>
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
                <button class="edit-entry" type="button" aria-label="编辑题目" @click="store.enterEdit">
                  <SquarePen :size="15" />编辑
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
                  :save-state="saveState"
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
            </template>
          </div>
          <ReviewResultButtons v-if="!editing" :loading="submitting" @select="submit" />
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
  grid-template-rows: minmax(0, 1fr);
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
.study-tabs button:hover { color: var(--text-secondary); background: var(--border-highlight); }
.study-tabs button.active { color: var(--primary-hover); }
.study-tabs button.active::after { background: var(--primary); }
.study-tabs button:focus-visible { z-index: 1; outline: 2px solid var(--primary); outline-offset: -2px; }
.study-tabs .edit-entry {
  min-width: 0;
  min-height: 30px;
  padding: 0 11px;
  margin: 4px 0 4px auto;
  color: var(--text-muted);
  font-size: 12px;
  border: 1px solid var(--border-primary);
  border-radius: 6px;
}
.study-tabs .edit-entry::after { content: none; }
.study-tabs .edit-entry:hover {
  color: var(--primary-hover);
  border-color: var(--primary);
  background: transparent;
}
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
  box-shadow: 0 -10px 24px var(--shadow-low);
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
  .review-page {
    width: calc(100% - 24px);
    padding: 20px 0 calc(88px + env(safe-area-inset-bottom));
  }

  .review-aside { grid-template-columns: 1fr; }

  .study-tabs > button:not(.edit-entry) {
    flex: 1 1 0;
    flex-direction: column;
    justify-content: center;
    min-width: 0;
    min-height: 52px;
    gap: 3px;
    padding: 4px 2px;
    font-size: 11px;
  }

  .study-tabs .edit-entry {
    flex: 0 0 44px;
    width: 44px;
    min-width: 44px;
    min-height: 44px;
    justify-content: center;
    gap: 0;
    padding: 0;
    margin: 4px 0 4px 4px;
    font-size: 0;
  }
}
</style>
