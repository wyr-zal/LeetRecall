/* eslint-disable vue/one-component-per-file -- 集成测试使用轻量面板替身 */
import { createPinia } from 'pinia'
import { defineComponent, ref } from 'vue'
import { createMemoryHistory, createRouter, RouterView } from 'vue-router'
import { flushPromises, mount } from '@vue/test-utils'
import { reviewApi } from '@/api/review'
import { dictationApi } from '@/api/dictation'
import { codeAnnotationApi } from '@/api/codeAnnotation'
import { problemNoteApi } from '@/api/problemNote'
import { useQuickReviewStore } from '@/stores/quickReview'
import QuickReviewView from '@/views/quick-review/QuickReviewView.vue'

const DictationStub = defineComponent({
  props: { active: Boolean, mobile: Boolean, problemId: { type: Number, required: true }, revision: { type: Number, default: 0 } },
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

async function mountView(path = '/quick-review', realDictation = false) {
  if (!document.getElementById('workspace-tabs-slot')) {
    const slot = document.createElement('div')
    slot.id = 'workspace-tabs-slot'
    document.body.appendChild(slot)
  }
  if (!document.getElementById('workspace-more-slot')) {
    const slot = document.createElement('div')
    slot.id = 'workspace-more-slot'
    document.body.appendChild(slot)
  }
  const pinia = createPinia()
  const router = createRouter({ history: createMemoryHistory(), routes: [
    { path: '/problems/:leetcodeNumber?/:section?', component: QuickReviewView, meta: { workspace: true } },
    { path: '/quick-review', redirect: to => ({ path: '/problems', query: to.query }) },
    { path: '/other', component: { template: '<p>其他</p>' } },
  ] })
  await router.push(path)
  await router.isReady()
  const wrapper = mount(RouterView, { attachTo: document.body, global: { plugins: [pinia, router], stubs: {
    DictationView: realDictation ? false : DictationStub, ProblemImportView: ImportStub,
    CodeBlankEditor: { props: ['answerCode'], template: '<pre data-test="full-code">{{ answerCode }}</pre>' }, AnnotationPanel: true, DictationHistory: true,
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
  afterEach(async () => { wrappers.forEach(w => w.unmount()); wrappers.length = 0; await flushPromises(); vi.restoreAllMocks() })

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
    expect(router.currentRoute.value.path).toBe('/problems/1/notes')
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

  it('链接题号优先于本地历史，题号不同于内部 ID，刷新也不变', async () => {
    localStorage.setItem('leet-recall:active-problem', '1')
    vi.mocked(reviewApi.getTodayQueue).mockResolvedValue({ total: 2, completed: 0, items: [
      { ...detail(1), masteryLevel: 'NEW', completed: false },
      { ...detail(101), leetcodeNumber: 5, masteryLevel: 'NEW', completed: false },
    ] })
    vi.mocked(reviewApi.getProblemDetail).mockImplementation(async id => ({ ...detail(id), leetcodeNumber: id === 101 ? 5 : 1 }))
    const { wrapper, store, router } = await mountView('/problems/5/notes')
    wrappers.push(wrapper)
    expect(store.currentProblemId).toBe(101)
    expect(reviewApi.getProblemDetail).toHaveBeenCalledExactlyOnceWith(101)
    expect(router.currentRoute.value.path).toBe('/problems/5/notes')
    wrapper.unmount(); wrappers.pop()
    vi.mocked(reviewApi.getProblemDetail).mockClear()
    const fresh = await mountView('/problems/5/notes')
    wrappers.push(fresh.wrapper)
    expect(fresh.store.currentProblemId).toBe(101)
    expect(reviewApi.getProblemDetail).toHaveBeenCalledExactlyOnceWith(101)
  })

  it('手机题面、答案和前后题同步路径；历史能恢复题目与面板', async () => {
    const { wrapper, router, store } = await mountView('/problems/1/recall?answer=1')
    wrappers.push(wrapper)
    expect(store.answerVisible).toBe(true)
    const description = document.querySelector<HTMLButtonElement>('[aria-label="题目"]')!
    description.click()
    await flushPromises()
    expect(router.currentRoute.value.path).toBe('/problems/1/description')
    await store.move(1); await flushPromises()
    expect(router.currentRoute.value.path).toBe('/problems/2/description')
    router.back(); await flushPromises()
    expect(store.currentProblemId).toBe(1)
    router.back(); await flushPromises()
    expect(router.currentRoute.value.fullPath).toBe('/problems/1/recall?answer=1')
    expect(store.answerVisible).toBe(true)
  })

  it.each(['/problems/999/notes', '/problems/abc/solution', '/problems/1/oops'])('错误链接不回退本地题：%s', async path => {
    const { wrapper, store } = await mountView(path)
    wrappers.push(wrapper)
    expect(store.currentProblem).toBeNull()
    expect(reviewApi.getProblemDetail).not.toHaveBeenCalled()
    expect(wrapper.get('[role="alert"]').text()).toMatch(/不存在|无效/)
  })

  it('浏览器切题也执行笔记保存守卫，失败时 URL 和原题都保留', async () => {
    const { wrapper, router, store } = await mountView('/problems/1/notes')
    wrappers.push(wrapper)
    vi.mocked(problemNoteApi.save).mockRejectedValue(new Error('保存失败'))
    await wrapper.get('#panel-notes textarea').setValue('不可丢失')
    await router.push('/problems/2/notes'); await flushPromises()
    expect(router.currentRoute.value.path).toBe('/problems/1/notes')
    expect(store.currentProblemId).toBe(1)
    expect(wrapper.get('#panel-notes textarea').element).toHaveProperty('value', '不可丢失')
  })

  it('solution 经过真实默写面板直接展示完整代码，只用接收方会话、不自动评分', async () => {
    sessionStorage.setItem('leet-recall:dictation-session', 'receiver-session')
    vi.spyOn(dictationApi, 'getProblemDetail').mockResolvedValue({ ...detail(2), language: 'JAVA', templateCode: 'return {{blank_1}};', keywords: [], mistakes: [] })
    vi.spyOn(dictationApi, 'getRecords').mockResolvedValue({ page: 1, pageSize: 2, total: 0, items: [] })
    vi.spyOn(codeAnnotationApi, 'list').mockResolvedValue([])
    vi.spyOn(dictationApi, 'viewAnswer').mockResolvedValue({ answers: { blank_1: '42' }, fullCode: '// 完整注释\nreturn 42;' })
    const submit = vi.spyOn(dictationApi, 'submit')
    const { wrapper, router } = await mountView('/problems/2/solution', true)
    wrappers.push(wrapper)
    await flushPromises()
    await vi.waitFor(() => expect(wrapper.find('[data-test="full-code"]').exists()).toBe(true), { timeout: 3000 })
    expect(wrapper.get('[data-test="full-code"]').text()).toContain('// 完整注释')
    expect(dictationApi.viewAnswer).toHaveBeenCalledExactlyOnceWith(2, 'receiver-session')
    expect(submit).not.toHaveBeenCalled()
    expect(reviewApi.submit).not.toHaveBeenCalled()
    window.dispatchEvent(new KeyboardEvent('keydown', { key: 'a' }))
    await flushPromises()
    expect(router.currentRoute.value.path).toBe('/problems/2/dictation')
    expect(wrapper.get('[data-test="full-code"]').text()).toBe('')
  })


  it('历史快速返回时，迟到的详情不覆盖 URL 的当前题', async () => {
    const { wrapper, router, store } = await mountView('/problems/1/notes')
    wrappers.push(wrapper)
    let resolve!: (value: ReturnType<typeof detail>) => void
    vi.mocked(reviewApi.getProblemDetail).mockReturnValueOnce(new Promise(done => { resolve = done }))
    await router.push('/problems/2/notes'); await flushPromises()
    expect(wrapper.get('.workspace-grid').isVisible()).toBe(false)
    await router.push('/problems/1/notes'); await flushPromises()
    resolve(detail(2)); await flushPromises()
    expect(store.currentProblemId).toBe(1)
    expect(router.currentRoute.value.path).toBe('/problems/1/notes')
    expect(wrapper.get('.workspace-grid').isVisible()).toBe(true)
  })

  it('详情失败不展示旧题，重试仍加载分享的目标', async () => {
    const { wrapper, router, store } = await mountView('/problems/1/notes')
    wrappers.push(wrapper)
    vi.mocked(reviewApi.getProblemDetail).mockRejectedValueOnce(new Error('网络失败'))
    await router.push('/problems/2/notes'); await flushPromises()
    expect(wrapper.get('.workspace-grid').isVisible()).toBe(false)
    expect(wrapper.get('[role="alert"]').text()).toContain('网络失败')
    await wrapper.get('[role="alert"] button').trigger('click'); await flushPromises()
    expect(store.currentProblemId).toBe(2)
    expect(router.currentRoute.value.path).toBe('/problems/2/notes')
    expect(wrapper.get('.workspace-grid').isVisible()).toBe(true)
  })

  it('solution 状态下普通下一题回到默写，回忆提交后也同步题目路径', async () => {
    const { wrapper, router, store } = await mountView('/problems/1/solution')
    wrappers.push(wrapper)
    await store.move(1); await flushPromises()
    expect(router.currentRoute.value.path).toBe('/problems/2/dictation')
    await router.push('/problems/2/recall'); await flushPromises()
    await store.submit('KNOWN'); await flushPromises()
    expect(router.currentRoute.value.path).toBe('/problems/1/recall')
    expect(store.currentProblemId).toBe(1)
  })

  it('向默写传递同一个手机断点状态', async () => {
    const query = { matches: true, addEventListener: vi.fn(), removeEventListener: vi.fn() }
    vi.stubGlobal('matchMedia', () => query)
    try {
      const { wrapper } = await mountView('/problems/1/dictation')
      wrappers.push(wrapper)
      expect(wrapper.findComponent(DictationStub).props('mobile')).toBe(true)
      const change = query.addEventListener.mock.calls[0]?.[1] as () => void
      query.matches = false
      change()
      await flushPromises()
      expect(wrapper.findComponent(DictationStub).props('mobile')).toBe(false)
    } finally { vi.unstubAllGlobals() }
  })
})
