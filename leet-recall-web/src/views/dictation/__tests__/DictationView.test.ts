import { flushPromises, mount } from '@vue/test-utils'
import { createPinia } from 'pinia'
import { dictationApi } from '@/api/dictation'
import { codeAnnotationApi } from '@/api/codeAnnotation'
import { useDictationStore } from '@/stores/dictation'
import DictationView from '../DictationView.vue'

function mountView(active = true) {
  const pinia = createPinia()
  const wrapper = mount(DictationView, { props: { active, problemId: 1, revision: 0 }, global: {
    plugins: [pinia], stubs: { CodeBlankEditor: { template: '<div class="editor-stub" />' }, AnnotationPanel: true, DictationHistory: true, RecordDetailDialog: true },
  } })
  return { wrapper, store: useDictationStore(pinia) }
}

describe('DictationView 工作台面板', () => {
  const wrappers: Array<ReturnType<typeof mount>> = []
  beforeEach(() => {
    localStorage.clear()
    sessionStorage.clear()
    vi.spyOn(dictationApi, 'getProblemDetail').mockImplementation(async (problemId) => ({
      problemId, leetcodeNumber: problemId, title: '两数之和', tags: [], language: 'JAVA', templateCode: 'return {{blank_1}};',
      keywords: [], mistakes: [], difficulty: 'EASY', descriptionMarkdown: '题目', recallQuestions: [], coreIdea: '',
    }))
    vi.spyOn(dictationApi, 'getRecords').mockResolvedValue({ page: 1, pageSize: 2, total: 0, items: [] })
    vi.spyOn(dictationApi, 'getTodayQueue').mockResolvedValue({ total: 0, completed: 0, items: [] })
    vi.spyOn(codeAnnotationApi, 'list').mockResolvedValue([])
    vi.spyOn(dictationApi, 'submit').mockResolvedValue({ correctCount: 1, totalCount: 1, accuracy: 100, viewedAnswer: false, resultItems: [] })
  })
  afterEach(() => { wrappers.forEach(w => w.unmount()); wrappers.length = 0; vi.restoreAllMocks() })

  it('不再创建会话导航栏，也不自主加载或选择队列', async () => {
    const { wrapper } = mountView()
    wrappers.push(wrapper)
    await flushPromises()
    expect(wrapper.find('.dictation-session-bar').exists()).toBe(false)
    expect(wrapper.find('.editor-stub').exists()).toBe(true)
    expect(dictationApi.getTodayQueue).not.toHaveBeenCalled()
    expect(dictationApi.getProblemDetail).toHaveBeenCalledWith(1)
  })

  it('同题隐藏再显示不重拉模板，不重置草稿与评分', async () => {
    const { wrapper, store } = mountView()
    wrappers.push(wrapper)
    await flushPromises()
    store.updateAnswers({ blank_1: 'root' })
    await store.submit()
    const editor = wrapper.get('.editor-stub').element
    await wrapper.setProps({ active: false })
    await wrapper.setProps({ active: true })
    await flushPromises()
    expect(dictationApi.getProblemDetail).toHaveBeenCalledTimes(1)
    expect(store.currentAnswers.blank_1).toBe('root')
    expect(store.submitResult?.accuracy).toBe(100)
    expect(wrapper.get('.editor-stub').element).toBe(editor)
  })

  it('导入修订使旧模板失效，隐藏期间不加载，显示时重拉并撤销旧评分', async () => {
    const { wrapper, store } = mountView()
    wrappers.push(wrapper)
    await flushPromises()
    await store.submit()
    store.updateAnswers({ blank_1: 'draft' })
    await wrapper.setProps({ active: false, revision: 1 })
    expect(dictationApi.getProblemDetail).toHaveBeenCalledTimes(1)
    await wrapper.setProps({ active: true })
    await flushPromises()
    expect(dictationApi.getProblemDetail).toHaveBeenCalledTimes(2)
    expect(store.submitResult).toBeNull()
    expect(store.currentAnswers.blank_1).toBe('draft')
  })

  it('隐藏面板不响应 Ctrl+Enter，显示后只提交一次', async () => {
    const { wrapper } = mountView()
    wrappers.push(wrapper)
    await flushPromises()
    await wrapper.setProps({ active: false })
    window.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', ctrlKey: true }))
    expect(dictationApi.submit).not.toHaveBeenCalled()
    await wrapper.setProps({ active: true })
    window.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', ctrlKey: true }))
    await flushPromises()
    expect(dictationApi.submit).toHaveBeenCalledTimes(1)
  })
})
