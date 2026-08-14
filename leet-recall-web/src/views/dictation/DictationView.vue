<script setup lang="ts">
import { defineAsyncComponent, onActivated, onMounted, ref } from 'vue'
import { storeToRefs } from 'pinia'
import { dictationApi } from '@/api/dictation'
import { useDictationStore } from '@/stores/dictation'
import DictationProgress from '@/components/dictation/DictationProgress.vue'
import DictationProblemHeader from '@/components/dictation/DictationProblemHeader.vue'
import DictationActions from '@/components/dictation/DictationActions.vue'
import CompletionRing from '@/components/dictation/CompletionRing.vue'
import KeywordPanel from '@/components/dictation/KeywordPanel.vue'
import MistakePanel from '@/components/dictation/MistakePanel.vue'
import DictationHistory from '@/components/dictation/DictationHistory.vue'
import RecordDetailDialog from '@/components/dictation/RecordDetailDialog.vue'
import ConfirmDialog from '@/components/common/ConfirmDialog.vue'
import LoadingState from '@/components/common/LoadingState.vue'
import ErrorState from '@/components/common/ErrorState.vue'
import EmptyState from '@/components/common/EmptyState.vue'
import type { DictationRecordDetail } from '@/types/dictation'

const CodeBlankEditor = defineAsyncComponent({
  loader: () => import('@/components/dictation/CodeBlankEditor.vue'),
  loadingComponent: LoadingState,
  delay: 80,
})

const store = useDictationStore()
const {
  todayQueue,
  currentProblem,
  currentAnswers,
  currentAccuracy,
  viewedAnswer,
  revealedAnswer,
  submitResult,
  history,
  loading,
  detailLoading,
  submitting,
  error,
  currentIndex,
} = storeToRefs(store)
const resetOpen = ref(false)
const recordDetail = ref<DictationRecordDetail | null>(null)
let firstActivation = true

onMounted(() => store.loadQueue())
onActivated(() => {
  if (firstActivation) {
    firstActivation = false
    return
  }
  void store.refreshQueue()
})

function confirmReset(): void {
  store.reset()
  resetOpen.value = false
}

async function openRecord(recordId: number): Promise<void> {
  if (!currentProblem.value) return
  recordDetail.value = await dictationApi.getRecordDetail(currentProblem.value.problemId, recordId)
}
</script>

<template>
  <main class="dictation-page">
    <DictationProgress
      :current="currentIndex + 1"
      :total="todayQueue.length"
      @previous="store.move(-1)"
      @next="store.move(1)"
      @list="store.loadQueue"
    />

    <LoadingState v-if="loading" />
    <ErrorState v-else-if="error && !currentProblem" :message="error" @retry="store.loadQueue" />
    <EmptyState
      v-else-if="todayQueue.length === 0"
      title="今天没有待默写题目"
      action-label="随机默写一题"
      @action="store.loadQueue"
    />

    <template v-else-if="currentProblem">
      <div class="dictation-grid">
        <section class="editor-card app-card app-card--raised">
          <LoadingState v-if="detailLoading" />
          <template v-else>
            <DictationProblemHeader
              :number="currentProblem.leetcodeNumber"
              :title="currentProblem.title"
              :tags="currentProblem.tags"
            />
            <CodeBlankEditor
              :template-code="currentProblem.templateCode"
              :answers="currentAnswers"
              :results="submitResult?.resultItems"
              :answer-code="revealedAnswer?.fullCode"
              @update:answers="store.updateAnswers"
            />
            <div v-if="submitResult" class="score-message" role="status">
              <strong>{{ Math.round(submitResult.accuracy) }}%</strong>
              <span>{{ submitResult.correctCount }} / {{ submitResult.totalCount }} 个空位正确</span>
              <small v-if="submitResult.viewedAnswer">查看过答案，本次最高计 60 分</small>
            </div>
            <DictationActions
              :submitting="submitting"
              :viewed-answer="viewedAnswer"
              @reset="resetOpen = true"
              @answer="store.showAnswer"
              @submit="store.submit"
            />
          </template>
        </section>

        <aside class="dictation-aside">
          <CompletionRing :accuracy="currentAccuracy" />
          <KeywordPanel :keywords="currentProblem.keywords" />
          <MistakePanel :mistakes="currentProblem.mistakes" />
        </aside>
      </div>
      <DictationHistory class="history" :records="history" @select="openRecord" />
    </template>

    <ConfirmDialog
      :open="resetOpen"
      title="重置当前默写"
      description="确定清空当前填写内容吗？此操作不会删除已保存的历史记录。"
      confirm-label="清空内容"
      @confirm="confirmReset"
      @cancel="resetOpen = false"
    />
    <RecordDetailDialog :detail="recordDetail" @close="recordDetail = null" />
  </main>
</template>

<style scoped>
.dictation-page { width: min(1220px, calc(100% - 56px)); padding: 30px 0 52px; margin: 0 auto; }
.dictation-grid { display: grid; grid-template-columns: minmax(660px, 1fr) minmax(248px, 286px); gap: 22px; align-items: start; }
.editor-card { min-width: 0; padding: clamp(22px, 2.2vw, 28px); }
.dictation-aside { display: grid; gap: 14px; }
.history { width: calc(100% - 304px); margin-top: 16px; }
.score-message { display: flex; align-items: baseline; gap: 11px; padding: 12px 14px; margin-top: 12px; border: 1px solid var(--border-primary); border-radius: 8px; background: var(--bg-input); box-shadow: inset 3px 0 0 var(--primary); }
.score-message strong { color: var(--primary); font-size: 19px; }.score-message span { color: var(--text-secondary); font-size: 13px; }.score-message small { margin-left: auto; color: var(--warning); font-size: 11px; }
@media (max-width: 1279px) {
  .dictation-page { width: min(1100px, calc(100% - 36px)); }
  .dictation-grid { grid-template-columns: minmax(0, 1fr); }
  .dictation-aside { grid-template-columns: repeat(3, 1fr); }
  .history { width: 100%; }
}
@media (max-width: 760px) { .dictation-page { width: calc(100% - 24px); padding: 20px 0 88px; }.dictation-aside { grid-template-columns: 1fr; }.score-message { align-items: flex-start; flex-direction: column; }.score-message small { margin-left: 0; } }
</style>
