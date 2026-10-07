<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { Braces, ChevronLeft, ChevronRight, FileInput, Flame, List, Moon, Search, Sun } from 'lucide-vue-next'
import { useRoute, useRouter } from 'vue-router'
import { reviewApi } from '@/api/review'
import { useQuickReviewStore } from '@/stores/quickReview'
import { useTheme } from '@/composables/useTheme'
import { useDictationStore } from '@/stores/dictation'
import { useSettingsMenu } from '@/composables/useSettingsMenu'
import SettingsMenu from '@/components/common/SettingsMenu.vue'
import type { ProblemSearchItem } from '@/types/problem'

const router = useRouter()
const route = useRoute()
const reviewStore = useQuickReviewStore()
const dictationStore = useDictationStore()
const { settingsMenuOpen, setSettingsMenuOpen } = useSettingsMenu()
const isWorkspace = computed(() => route.path === '/quick-review')
const navigationBusy = computed(() => reviewStore.loading || reviewStore.detailLoading || reviewStore.submitting || reviewStore.editing || dictationStore.submitting)

function openTool(tool: 'picker' | 'import'): void {
  setSettingsMenuOpen(false)
  const query = isWorkspace.value ? { ...route.query } : {}
  delete query.picker
  delete query.import
  void router.push({ path: '/quick-review', query: { ...query, [tool]: '1' } })
}

function toggleSettings(): void {
  setSettingsMenuOpen(!settingsMenuOpen.value)
}

/** 旧 /settings 地址只用来打开一次下拉，随即把参数从地址栏清掉。 */
function applySettingsQuery(): void {
  if (route.query.settings !== '1') return
  setSettingsMenuOpen(true)
  const query = { ...route.query }
  delete query.settings
  void router.replace({ query })
}
const { themeMode, toggleTheme } = useTheme()
const keyword = ref('')
const results = ref<ProblemSearchItem[]>([])
const searchOpen = ref(false)
const searching = ref(false)
const activeIndex = ref(-1)
const searchWrap = ref<HTMLElement | null>(null)
const streak = ref(0)
let searchTimer: ReturnType<typeof setTimeout> | undefined

onMounted(async () => {
  document.addEventListener('click', closeSearchWhenClickedOutside)
  try {
    streak.value = await reviewApi.getReviewStreak()
  } catch {
    streak.value = 0
  }
  await router.isReady()
  applySettingsQuery()
})

watch(() => route.query.settings, (value) => {
  if (value === '1') applySettingsQuery()
})

onBeforeUnmount(() => document.removeEventListener('click', closeSearchWhenClickedOutside))

function handleInput(): void {
  if (searchTimer) clearTimeout(searchTimer)
  const query = keyword.value.trim()
  if (!query) {
    results.value = []
    searchOpen.value = false
    return
  }
  searchTimer = setTimeout(async () => {
    searching.value = true
    try {
      results.value = await reviewApi.searchProblems(query)
      searchOpen.value = true
    } finally {
      searching.value = false
    }
  }, 220)
}

// 结果集变化后重置键盘高亮，避免沿用上一轮搜索的下标。
watch(results, () => {
  activeIndex.value = -1
})

/** ↑↓ 在结果间循环移动，Enter 选择高亮项（未移动过则选第一项）。 */
function handleSearchKeydown(event: KeyboardEvent): void {
  if (!searchOpen.value || results.value.length === 0) return
  if (event.key === 'ArrowDown') {
    event.preventDefault()
    activeIndex.value = (activeIndex.value + 1) % results.value.length
  } else if (event.key === 'ArrowUp') {
    event.preventDefault()
    activeIndex.value = (activeIndex.value <= 0 ? results.value.length : activeIndex.value) - 1
  } else if (event.key === 'Enter') {
    event.preventDefault()
    const result = results.value[activeIndex.value >= 0 ? activeIndex.value : 0]
    if (result) void selectProblem(result)
  }
}

function closeSearchWhenClickedOutside(event: MouseEvent): void {
  if (searchWrap.value && !searchWrap.value.contains(event.target as Node)) searchOpen.value = false
}

async function selectProblem(problem: ProblemSearchItem): Promise<void> {
  if (navigationBusy.value) return
  if (!isWorkspace.value) await router.push('/quick-review')
  if (!await reviewStore.loadProblem(problem.problemId)) return
  keyword.value = ''
  searchOpen.value = false
}
</script>

<template>
  <header class="topbar">
    <div class="topbar-start">
      <RouterLink class="topbar-brand" to="/quick-review" aria-label="LeetRecall 学习工作台">
        <Braces :size="21" aria-hidden="true" />
        <strong>LeetRecall</strong>
      </RouterLink>
      <nav v-if="isWorkspace" class="workspace-controls" aria-label="题目导航">
        <button type="button" aria-label="选择题目" title="选择题目" :disabled="navigationBusy" @click="openTool('picker')"><List :size="18" /><span>选题</span></button>
        <span class="problem-counter">{{ Math.max(0, reviewStore.currentIndex + 1) }} / {{ reviewStore.todayQueue.length }}</span>
        <button type="button" aria-label="上一题" :disabled="navigationBusy || !reviewStore.todayQueue.length" @click="reviewStore.move(-1)"><ChevronLeft :size="18" /></button>
        <button type="button" aria-label="下一题" :disabled="navigationBusy || !reviewStore.todayQueue.length" @click="reviewStore.move(1)"><ChevronRight :size="18" /></button>
      </nav>
      <div ref="searchWrap" class="search-wrap">
        <Search class="search-icon" :size="18" aria-hidden="true" />
        <label class="screen-reader-only" for="global-search">搜索题目</label>
        <input
          id="global-search"
          v-model="keyword"
          type="search"
          autocomplete="off"
          placeholder="搜索题号或题目"
          :aria-activedescendant="activeIndex >= 0 ? `global-search-option-${activeIndex}` : undefined"
          @input="handleInput"
          @focus="searchOpen = results.length > 0"
          @keydown.esc="searchOpen = false"
          @keydown="handleSearchKeydown"
        >
        <span v-if="searching" class="searching">检索中</span>
        <div v-if="searchOpen" class="search-results" role="listbox" aria-label="题目搜索结果">
          <button
            v-for="(result, index) in results"
            :id="`global-search-option-${index}`"
            :key="result.problemId"
            type="button"
            role="option"
            :aria-selected="index === activeIndex"
            :class="{ active: index === activeIndex }"
            @click="selectProblem(result)"
            @mouseenter="activeIndex = index"
          >
            <span>{{ result.leetcodeNumber }}.</span>
            {{ result.title }}
          </button>
          <p v-if="results.length === 0">没有匹配题目</p>
        </div>
      </div>
    </div>

    <div class="topbar-actions">
      <button class="tool-button" type="button" aria-label="导入题目" title="导入题目" :disabled="navigationBusy" @click="openTool('import')"><FileInput :size="18" /><span>导入</span></button>
      <SettingsMenu :open="settingsMenuOpen" @toggle="toggleSettings" @close="setSettingsMenuOpen(false)" />
      <div class="streak" aria-label="连续复习天数">
        <Flame :size="19" :stroke-width="2" />
        <span>连续 <strong>{{ streak }}</strong> 天</span>
      </div>
      <button
        class="theme-toggle"
        type="button"
        :aria-label="themeMode === 'dark' ? '切换浅色模式' : '切换深色模式'"
        :title="themeMode === 'dark' ? '切换浅色模式' : '切换深色模式'"
        :aria-pressed="themeMode === 'light'"
        @click="toggleTheme"
      >
        <Sun v-if="themeMode === 'dark'" :size="17" aria-hidden="true" />
        <Moon v-else :size="17" aria-hidden="true" />
        <span>{{ themeMode === 'dark' ? '浅色' : '深色' }}</span>
      </button>
    </div>
  </header>
</template>

<style scoped>
.topbar {
  position: sticky;
  top: 0;
  z-index: 20;
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: var(--topbar-height);
  padding: 0 clamp(18px, 2.5vw, 36px);
  border-bottom: 1px solid var(--border-primary);
  background: var(--bg-card);
  box-shadow: var(--shadow-low);
}

.topbar-start {
  display: flex;
  flex: 1 1 auto;
  align-items: center;
  min-width: 0;
  gap: clamp(12px, 1.6vw, 22px);
}

.topbar-brand {
  display: inline-flex;
  flex: 0 0 auto;
  align-items: center;
  gap: 8px;
  color: var(--text-primary);
  text-decoration: none;
}

.topbar-brand svg {
  color: var(--primary);
}

.topbar-brand strong {
  font-size: calc(15px * var(--ui-font-ratio));
  font-weight: 680;
  letter-spacing: 0.01em;
}

.topbar-brand:hover svg {
  color: var(--primary-hover);
}

.topbar-brand:focus-visible {
  outline: 2px solid var(--primary);
  outline-offset: 2px;
  border-radius: 6px;
}

.workspace-controls { display: flex; flex: 0 0 auto; align-items: center; gap: 5px; }
.workspace-controls button, .tool-button { display: inline-flex; align-items: center; justify-content: center; flex: 0 0 auto; min-width: 34px; height: 34px; padding: 0 8px; gap: 6px; color: var(--text-secondary); border: 1px solid var(--border-primary); border-radius: 7px; background: var(--bg-card); text-decoration: none; white-space: nowrap; }
.workspace-controls button:hover, .tool-button:hover { color: var(--text-primary); background: var(--bg-card-hover); }
.problem-counter { min-width: 66px; text-align: center; color: var(--text-muted); font-size: calc(12px * var(--ui-font-ratio)); font-variant-numeric: tabular-nums; white-space: nowrap; }
@media (max-width: 1100px) { .streak span, .tool-button span, .topbar-brand strong, .theme-toggle span { display: none; } }

@media (max-width: 480px) { .problem-counter { display: none; } }

.search-wrap {
  position: relative;
  flex: 0 1 auto;
  width: min(320px, 34vw);
  min-width: 150px;
}

.search-wrap input {
  width: 100%;
  height: 34px;
  padding: 0 72px 0 42px;
  color: var(--text-primary);
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  outline: none;
  background: var(--bg-primary);
  box-shadow: inset 0 1px 2px var(--border-highlight);
}

.search-wrap input:focus {
  border-color: var(--primary);
  background: var(--bg-input);
}

.search-wrap input::placeholder {
  color: var(--text-muted);
}

.search-icon {
  position: absolute;
  top: 8px;
  left: 13px;
  z-index: 1;
  color: var(--text-muted);
}

.searching {
  position: absolute;
  top: 10px;
  right: 12px;
  color: var(--text-muted);
  font-size: calc(12px * var(--ui-font-ratio));
}

.search-results {
  position: absolute;
  top: 40px;
  right: 0;
  left: 0;
  display: grid;
  padding: 6px;
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  background: var(--bg-card);
  box-shadow: var(--shadow-high);
}

.search-results button {
  padding: 10px 12px;
  color: var(--text-secondary);
  text-align: left;
  border: 0;
  border-radius: 6px;
  background: transparent;
}

.search-results button:hover,
.search-results button:focus-visible,
.search-results button.active {
  color: var(--text-primary);
  background: var(--bg-card-hover);
}

.search-results button span {
  color: var(--primary);
}

.search-results p {
  margin: 10px;
  color: var(--text-muted);
  font-size: calc(14px * var(--ui-font-ratio));
}

.topbar-actions,
.streak {
  display: flex;
  align-items: center;
}

.topbar-actions {
  gap: 18px;
}

.theme-toggle {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  min-height: 34px;
  padding: 0 10px;
  color: var(--text-secondary);
  border: 1px solid var(--border-secondary);
  border-radius: 7px;
  background: var(--bg-input);
}

.theme-toggle:hover {
  color: var(--text-primary);
  border-color: var(--border-primary);
  background: var(--bg-card-hover);
}

.streak {
  gap: 8px;
  color: var(--text-secondary);
  font-size: calc(14px * var(--ui-font-ratio));
  min-height: 34px;
  padding: 5px 9px;
  border: 1px solid var(--border-secondary);
  border-radius: 7px;
  background: var(--bg-input);
}

.streak svg {
  color: var(--warning);
}

.streak strong {
  color: var(--primary);
  font-size: calc(16px * var(--ui-font-ratio));
  font-weight: 650;
}

@media (max-width: 720px) {
  .topbar {
    flex-wrap: wrap;
    padding: env(safe-area-inset-top) 10px 6px;
    align-content: center;
    gap: 6px;
  }

  .topbar-start { flex: 1 1 100%; gap: 8px; }
  .workspace-controls button, .tool-button { min-width: 44px; height: 44px; }
  .workspace-controls button span { display: none; }
  .problem-counter { min-width: 60px; }
  .topbar-actions { width: 100%; justify-content: flex-end; }

  .search-wrap {
    width: auto;
    min-width: 0;
    max-width: 320px;
    flex: 1 1 0;
  }

  .search-wrap input {
    height: 40px;
  }

  .topbar-brand { display: none; }

  .streak span {
    display: none;
  }

  .topbar-actions {
    flex: 0 0 auto;
    gap: 6px;
  }

  .theme-toggle span {
    display: none;
  }

  .theme-toggle {
    justify-content: center;
    min-width: 40px;
    min-height: 40px;
    padding: 0;
  }

  .streak {
    min-height: 36px;
    padding: 7px;
  }
}
</style>
