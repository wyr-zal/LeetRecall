<script setup lang="ts">
import { computed, onMounted, ref } from 'vue'
import { Flame, Search, UserRound } from 'lucide-vue-next'
import { useRoute, useRouter } from 'vue-router'
import { reviewApi } from '@/api/review'
import { useQuickReviewStore } from '@/stores/quickReview'
import type { ProblemSearchItem } from '@/types/problem'

const router = useRouter()
const route = useRoute()
const reviewStore = useQuickReviewStore()
const keyword = ref('')
const results = ref<ProblemSearchItem[]>([])
const searchOpen = ref(false)
const searching = ref(false)
const streak = ref(0)
let searchTimer: ReturnType<typeof setTimeout> | undefined

const routeTitle = computed(() => ({
  '/quick-review': '快速复习',
  '/dictation': '默写训练',
  '/problem-import': '题目导入',
  '/settings': '设置',
}[route.path] ?? '学习工作台'))

onMounted(async () => {
  try {
    streak.value = await reviewApi.getReviewStreak()
  } catch {
    streak.value = 0
  }
})

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
      <div class="search-wrap">
        <Search class="search-icon" :size="18" aria-hidden="true" />
        <label class="screen-reader-only" for="global-search">搜索题目</label>
        <input
          id="global-search"
          v-model="keyword"
          type="search"
          autocomplete="off"
          placeholder="搜索题号或题目"
          @input="handleInput"
          @focus="searchOpen = results.length > 0"
          @keydown.esc="searchOpen = false"
        >
        <span v-if="searching" class="searching">检索中</span>
        <div v-if="searchOpen" class="search-results" role="listbox" aria-label="题目搜索结果">
          <button
            v-for="result in results"
            :key="result.problemId"
            type="button"
            role="option"
            @click="selectProblem(result)"
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
      <div class="avatar" aria-label="个人用户"><UserRound :size="20" /></div>
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
  font-size: 9px;
  font-weight: 700;
  letter-spacing: 0.08em;
}

.route-context strong {
  font-size: 13px;
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
  box-shadow: inset 0 1px 2px rgba(0, 0, 0, 0.3);
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
  font-size: 12px;
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
.search-results button:focus-visible {
  color: var(--text-primary);
  background: var(--bg-card-hover);
}

.search-results button span {
  color: var(--primary);
}

.search-results p {
  margin: 10px;
  color: var(--text-muted);
  font-size: 14px;
}

.topbar-actions,
.streak {
  display: flex;
  align-items: center;
}

.topbar-actions {
  gap: 18px;
}

.streak {
  gap: 8px;
  color: var(--text-secondary);
  font-size: 14px;
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
  font-size: 16px;
  font-weight: 650;
}

.avatar {
  display: grid;
  width: 34px;
  height: 34px;
  color: var(--text-secondary);
  border: 1px solid var(--border-primary);
  border-radius: 50%;
  place-items: center;
  border-color: var(--border-primary);
  background: var(--bg-card-hover);
  box-shadow: none;
}

@media (max-width: 720px) {
  .topbar {
    padding-inline: 14px;
  }

  .search-wrap {
    width: min(65vw, 320px);
  }

  .route-context { display: none; }

  .streak span {
    display: none;
  }

  .topbar-actions {
    gap: 8px;
  }

  .streak { padding: 7px; }
}
</style>
