/* eslint-disable vue/one-component-per-file -- 集成测试使用轻量面板替身 */
import { createPinia } from 'pinia'
import { defineComponent, ref } from 'vue'
import { createMemoryHistory, createRouter, RouterView } from 'vue-router'
import { flushPromises, mount } from '@vue/test-utils'
import { reviewApi } from '@/api/review'
import { problemNoteApi } from '@/api/problemNote'
import { useQuickReviewStore } from '@/stores/quickReview'
import QuickReviewView from '@/views/quick-review/QuickReviewView.vue'

const DictationStub = defineComponent({
  props: { active: Boolean, problemId: { type: Number, required: true }, revision: { type: Number, default: 0 } },
  setup: () => ({ value: ref('') }),
  template: '<div data-test="dictation"><textarea v-model="value" /></div>',
})
const ImportStub = defineComponent({
  props: { active: Boolean }, emits: ['imported'],
  setup: () => ({ value: ref('') }),
  template: '<div data-test="import"><textarea v-model="value" /></div>',
})

function detail(problemId: number) {
  return { problemId, leetcodeNumber: problemId, title: `题目${problemId}`, difficulty: 'EASY' as const,
    descriptionMarkdown: '**给定**一个整数数组和目标值。', tags: ['哈希表'],
    recallQuestions: [{ id: 1, question: '保存什么？', answer: '下标。' }],
    hint: '先查后存', coreIdea: '查询补数', mistakes: ['边界'], keyCode: 'return 1;' }
}

async function mountView(path = '/quick-review') {
  if (!document.getElementById('workspace-tabs-slot')) {
    const slot = document.createElement('div')
    slot.id = 'workspace-tabs-slot'
    document.body.appendChild(slot)
  }
  const pinia = createPinia()
  const router = createRouter({ history: createMemoryHistory(), routes: [
    { path: '/quick-review', component: QuickReviewView },
    { path: '/other', component: { template: '<p>其他</p>' } },
  ] })
  await router.push(path)
  await router.isReady()
  const wrapper = mount(RouterView, { attachTo: document.body, global: { plugins: [pinia, router], stubs: {
    DictationView: DictationStub, ProblemImportView: ImportStub,
    RecallQuestionList: true, HintPanel: true, AnswerPanel: true, KeyboardShortcutPanel: true,
  } } })
  await flushPromises()
  return { wrapper, router, store: useQuickReviewStore(pinia) }
}

describe('统一学习工作台', () => {
  const wrappers: Array<ReturnType<typeof mount>> = []
  beforeEach(() => {
    localStorage.clear()
    sessionStorage.clear()
    vi.spyOn(reviewApi, 'getTodayQueue').mockResolvedValue({ total: 2, completed: 0, items: [1, 2].map((id) => ({
      problemId: id, leetcodeNumber: id, title: `题目${id}`, difficulty: 'EASY', tags: [], masteryLevel: 'NEW', completed: false,
    })) })
    vi.spyOn(reviewApi, 'getProblemDetail').mockImplementation(async (id) => detail(id))
    vi.spyOn(problemNoteApi, 'get').mockImplementation(async (id) => ({ problemId: id, markdown: '', updatedAt: null }))
    vi.spyOn(problemNoteApi, 'save').mockImplementation(async (id, markdown) => ({ problemId: id, markdown, updatedAt: null }))
    vi.spyOn(reviewApi, 'submit').mockResolvedValue({ nextIntervalDays: 1, nextReviewAt: '' })
  })
  afterEach(() => { wrappers.forEach(w => w.unmount()); wrappers.length = 0; vi.restoreAllMocks() })

  it('默认同时展示题面和笔记，页签切换不重建题面或笔记', async () => {
    const { wrapper } = await mountView()
    wrappers.push(wrapper)
    const statement = wrapper.get('.statement-body').element
    const note = wrapper.get('#panel-notes textarea').element
    expect(wrapper.get('.statement-body strong').text()).toBe('给定')
    expect(wrapper.get('#panel-notes').isVisible()).toBe(true)
    await wrapper.get('#tab-recall').trigger('click')
    await flushPromises()
    expect(wrapper.get('#panel-recall').isVisible()).toBe(true)
    await wrapper.get('#tab-notes').trigger('click')
    await flushPromises()
    expect(wrapper.get('.statement-body').element).toBe(statement)
    expect(wrapper.get('#panel-notes textarea').element).toBe(note)
    expect(reviewApi.getTodayQueue).toHaveBeenCalledTimes(1)
    expect(reviewApi.getProblemDetail).toHaveBeenCalledTimes(1)
  })

  it('默写只在首次打开时创建，隐藏后再打开保留输入与实例', async () => {
    const { wrapper } = await mountView()
    wrappers.push(wrapper)
    expect(wrapper.find('[data-test="dictation"]').exists()).toBe(false)
    await wrapper.get('#tab-dictation').trigger('click')
    await flushPromises()
    const editor = wrapper.get('[data-test="dictation"] textarea')
    await editor.setValue('return answer;')
    await wrapper.get('#tab-notes').trigger('click')
    await flushPromises()
    expect(wrapper.findComponent(DictationStub).props('active')).toBe(false)
    await wrapper.get('#tab-dictation').trigger('click')
    await flushPromises()
    expect(wrapper.get('[data-test="dictation"] textarea').element).toBe(editor.element)
    expect((editor.element as HTMLTextAreaElement).value).toBe('return answer;')
  })

  it('导入抽屉关闭再打开保留 JSON 和当前学习页签', async () => {
    const { wrapper, router } = await mountView('/quick-review?panel=recall&import=1')
    wrappers.push(wrapper)
    const input = wrapper.getComponent(ImportStub).get('textarea')
    await input.setValue('{"draft":1}')
    await router.replace('/quick-review?panel=recall')
    await flushPromises()
    expect(wrapper.findComponent(ImportStub).props('active')).toBe(false)
    await router.push('/quick-review?panel=recall&import=1')
    await flushPromises()
    expect(wrapper.getComponent(ImportStub).get('textarea').element).toBe(input.element)
    expect((input.element as HTMLTextAreaElement).value).toBe('{"draft":1}')
    expect(wrapper.get('#tab-recall').attributes('aria-selected')).toBe('true')
  })

  it('笔记保存失败时阻止切题和离开，原文仍然保留', async () => {
    const { wrapper, router, store } = await mountView()
    wrappers.push(wrapper)
    vi.mocked(problemNoteApi.save).mockRejectedValue(new Error('保存失败'))
    await wrapper.get('#panel-notes textarea').setValue('不能丢的笔记')
    expect(await store.loadProblem(2)).toBe(false)
    expect(store.currentProblemId).toBe(1)
    await router.push('/other')
    await flushPromises()
    expect(router.currentRoute.value.path).toBe('/quick-review')
    expect((wrapper.get('#panel-notes textarea').element as HTMLTextAreaElement).value).toBe('不能丢的笔记')
    vi.mocked(problemNoteApi.save).mockResolvedValue({ problemId: 1, markdown: '不能丢的笔记', updatedAt: null })
    expect(await store.loadProblem(2)).toBe(true)
  })

  it('笔记或默写页签不触发复习评分，回忆页签才响应 1/2/3', async () => {
    const { wrapper } = await mountView()
    wrappers.push(wrapper)
    window.dispatchEvent(new KeyboardEvent('keydown', { key: '1' }))
    expect(reviewApi.submit).not.toHaveBeenCalled()
    await wrapper.get('#tab-dictation').trigger('click')
    await flushPromises()
    window.dispatchEvent(new KeyboardEvent('keydown', { key: '1' }))
    expect(reviewApi.submit).not.toHaveBeenCalled()
    await wrapper.get('#tab-recall').trigger('click')
    await flushPromises()
    window.dispatchEvent(new KeyboardEvent('keydown', { key: '1' }))
    await flushPromises()
    expect(reviewApi.submit).toHaveBeenCalledTimes(1)
  })
})
