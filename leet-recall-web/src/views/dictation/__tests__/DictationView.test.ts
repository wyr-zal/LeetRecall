import { flushPromises, mount } from '@vue/test-utils'
import { createPinia } from 'pinia'
import { createMemoryHistory, createRouter } from 'vue-router'
import { dictationApi } from '@/api/dictation'
import DictationView from '../DictationView.vue'

function buildRouter() {
  return createRouter({
    history: createMemoryHistory(),
    routes: [
      { path: '/', redirect: '/quick-review' },
      { path: '/quick-review', component: { template: '<div />' } },
      { path: '/dictation', component: DictationView },
      { path: '/problem-import', component: { template: '<div />' } },
    ],
  })
}

async function mountView() {
  const router = buildRouter()
  await router.push('/dictation')
  await router.isReady()
  const wrapper = mount(DictationView, { global: { plugins: [router, createPinia()] } })
  await flushPromises()
  return { wrapper, router }
}

describe('DictationView 会话栏入口', () => {
  beforeEach(() => {
    vi.spyOn(dictationApi, 'getTodayQueue').mockResolvedValue({ total: 0, completed: 0, items: [] })
  })

  afterEach(() => vi.restoreAllMocks())

  it('提供快速复习与导入题目入口，且带可访问名称', async () => {
    const { wrapper } = await mountView()
    const [quickReview, importEntry] = wrapper.findAll('.session-link')

    expect(quickReview?.attributes('href')).toBe('/quick-review')
    expect(quickReview?.attributes('aria-label')).toBe('快速复习')
    expect(importEntry?.attributes('href')).toBe('/problem-import')
    expect(importEntry?.attributes('aria-label')).toBe('导入题目')
  })

  it('点击入口跳转到对应页面', async () => {
    const { wrapper, router } = await mountView()

    await wrapper.findAll('.session-link')[0]?.trigger('click')
    await flushPromises()
    expect(router.currentRoute.value.path).toBe('/quick-review')

    await wrapper.findAll('.session-link')[1]?.trigger('click')
    await flushPromises()
    expect(router.currentRoute.value.path).toBe('/problem-import')
  })
})
