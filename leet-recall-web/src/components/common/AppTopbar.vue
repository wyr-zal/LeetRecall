<script setup lang="ts">
import { computed, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { Flame, Moon, Search, Settings, Sun } from 'lucide-vue-next'
import { useRoute, useRouter } from 'vue-router'
import { reviewApi } from '@/api/review'
import { useQuickReviewStore } from '@/stores/quickReview'
import { useTheme } from '@/composables/useTheme'
import type { ProblemSearchItem } from '@/types/problem'

const router = useRouter()
const route = useRoute()
const reviewStore = useQuickReviewStore()
const { themeMode, toggleTheme } = useTheme()
const keyword = ref('')
const results = ref<ProblemSearchItem[]>([])
const searchOpen = ref(false)
const searching = ref(false)
const activeIndex = ref(-1)
const searchWrap = ref<HTMLElement | null>(null)
const streak = ref(0)
let searchTimer: ReturnType<typeof setTimeout> | undefined

const routeTitle = computed(() => ({
  '/quick-review': '快速复习',
  '/dictation': '默写训练',
  '/problem-import': '题目导入',
  '/settings': '设置',
}[route.path] ?? '学习工作台'))

onMounted(async () => {
  document.addEventListener('click', closeSearchWhenClickedOutside)
  try {
    streak.value = await reviewApi.getReviewStreak()
  } catch {
    streak.value = 0
  }
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
  keyword.value = ''
  searchOpen.value = false
  await router.push('/quick-review')
  await reviewStore.openProblem(problem.problemId)
}
</script>

<template>
  <header class="topbar">
    <div class="topbar-start">
      <div class="route-context">
        <span>LEETRECALL</span>
        <strong>{{ routeTitle }}</strong>
      </div>
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
      <RouterLink class="settings-link" to="/settings" aria-label="设置" title="设置">
        <Settings :size="20" aria-hidden="true" />
      </RouterLink>
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
  align-items: center;
  min-width: 0;
  gap: clamp(20px, 3vw, 40px);
}

.route-context {
  display: grid;
  flex: 0 0 auto;
  gap: 2px;
}

.route-context span {
  color: var(--text-muted);
  font-size: calc(9px * var(--ui-font-ratio));
  font-weight: 700;
  letter-spacing: 0.08em;
}

.route-context strong {
  font-size: calc(13px * var(--ui-font-ratio));
  font-weight: 650;
}

.search-wrap {
  position: relative;
  width: min(320px, 34vw);
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

.settings-link {
  display: grid;
  flex: 0 0 34px;
  width: 34px;
  height: 34px;
  color: var(--text-secondary);
  border: 1px solid var(--border-primary);
  border-radius: 50%;
  place-items: center;
  background: var(--bg-card-hover);
  text-decoration: none;
}

.settings-link:hover,
.settings-link.router-link-active {
  color: var(--text-primary);
  border-color: var(--primary);
}

.settings-link:focus-visible {
  outline: 2px solid var(--primary);
  outline-offset: 2px;
}

@media (max-width: 720px) {
  .topbar {
    padding-inline: 12px;
  }

  .topbar-start {
    flex: 1 1 auto;
    gap: 8px;
  }

  .search-wrap {
    width: auto;
    min-width: 0;
    max-width: 320px;
    flex: 1 1 0;
  }

  .search-wrap input {
    height: 40px;
  }

  .route-context { display: none; }

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
