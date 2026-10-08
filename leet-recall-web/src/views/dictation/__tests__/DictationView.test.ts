import { flushPromises, mount } from '@vue/test-utils'
import { createPinia } from 'pinia'
import { dictationApi } from '@/api/dictation'
import { codeAnnotationApi } from '@/api/codeAnnotation'
import { useDictationStore } from '@/stores/dictation'
import DictationView from '../DictationView.vue'
import WorkspaceDrawer from '@/components/common/WorkspaceDrawer.vue'
import RecordDetailDialog from '@/components/dictation/RecordDetailDialog.vue'
import type { DictationRecordDetail } from '@/types/dictation'

function mountView(active = true, mobile = false) {
  const pinia = createPinia()
  const wrapper = mount(DictationView, { attachTo: document.body, props: { active, mobile, problemId: 1, revision: 0 }, global: {
    plugins: [pinia], stubs: { CodeBlankEditor: { template: '<div class="editor-stub" />' }, AnnotationPanel: true, RecordDetailDialog: true },
  } })
  return { wrapper, store: useDictationStore(pinia) }
}

describe('DictationView 工作台面板', () => {
  const wrappers: Array<ReturnType<typeof mount>> = []
  beforeEach(() => {
    document.body.innerHTML = '<div id="workspace-more-slot"></div>'
    localStorage.clear()
    sessionStorage.clear()
    vi.spyOn(dictationApi, 'getProblemDetail').mockImplementation(async (problemId) => ({
      problemId, leetcodeNumber: problemId, title: '两数之和', tags: [], language: 'JAVA', templateCode: 'return {{blank_1}};',
      keywords: [], mistakes: [], difficulty: 'EASY', descriptionMarkdown: '题目', recallQuestions: [], coreIdea: '',
    }))
    vi.spyOn(dictationApi, 'getRecords').mockResolvedValue({ page: 1, pageSize: 2, total: 0, items: [] })
    vi.spyOn(dictationApi, 'getTodayQueue').mockResolvedValue({ total: 0, completed: 0, items: [] })
    vi.spyOn(codeAnnotationApi, 'list').mockResolvedValue([])
    vi.spyOn(dictationApi, 'viewAnswer').mockResolvedValue({ answers: {}, fullCode: 'return 1;' })
    vi.spyOn(dictationApi, 'submit').mockResolvedValue({ correctCount: 1, totalCount: 1, accuracy: 100, viewedAnswer: false, resultItems: [] })
  })
  afterEach(() => { wrappers.forEach(w => w.unmount()); wrappers.length = 0; vi.restoreAllMocks(); document.body.innerHTML = '' })

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
  it('手机不加载批注，入口投进更多且记录正文不占底部；桌面恢复批注加载', async () => {
    const { wrapper } = mountView(true, true)
    wrappers.push(wrapper)
    await flushPromises()
    await wrapper.setProps({ showAnswer: true })
    await flushPromises()
    expect(codeAnnotationApi.list).not.toHaveBeenCalled()
    expect(wrapper.find('.annotation-entry').exists()).toBe(false)
    expect(wrapper.find('.editor-column > .history').exists()).toBe(false)
    expect(document.querySelector('#workspace-more-slot button')?.textContent).toContain('本题记录')
    await wrapper.setProps({ active: false })
    expect(document.querySelector('#workspace-more-slot button')).toBeNull()
    await wrapper.setProps({ active: true, mobile: false })
    await flushPromises()
    expect(codeAnnotationApi.list).toHaveBeenCalledWith(1)
    expect(wrapper.find('.annotation-entry').exists()).toBe(true)
    expect(wrapper.find('.editor-column > .history').exists()).toBe(true)
    expect(document.querySelector('#workspace-more-slot button')).toBeNull()
  })

  it('记录入口直接打开列表并屏蔽提交快捷键，离开手机关闭抽屉', async () => {
    const { wrapper } = mountView(true, true)
    wrappers.push(wrapper)
    await flushPromises()
    document.querySelector<HTMLButtonElement>('#workspace-more-slot button')!.click()
    await flushPromises()
    const drawer = wrapper.findAllComponents(WorkspaceDrawer).find(item => item.props('title') === '本题记录')!
    expect(drawer.props('open')).toBe(true)
    expect(document.querySelector('.history-drawer-content .history-toggle')).toBeNull()
    expect(document.querySelector('.history-drawer-content')?.textContent).toContain('还没有默写记录')
    window.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter', ctrlKey: true }))
    expect(dictationApi.submit).not.toHaveBeenCalled()
    await wrapper.setProps({ mobile: false })
    expect(drawer.props('open')).toBe(false)
  })

  it('记录详情晚响应不能在关闭列表后重新弹出', async () => {
    let finish!: (value: DictationRecordDetail) => void
    vi.spyOn(dictationApi, 'getRecordDetail').mockImplementation(() => new Promise(resolve => { finish = resolve }))
    const { wrapper, store } = mountView(true, true)
    wrappers.push(wrapper)
    await flushPromises()
    store.history = [{ id: 9, createdAt: '2026-10-08T10:00:00', accuracy: 80, durationSeconds: 10, viewedAnswer: false }]
    document.querySelector<HTMLButtonElement>('#workspace-more-slot button')!.click()
    await flushPromises()
    const drawer = wrapper.findAllComponents(WorkspaceDrawer).find(item => item.props('title') === '本题记录')!
    document.querySelector<HTMLButtonElement>('.history-drawer-content .record')!.click()
    await flushPromises()
    drawer.vm.$emit('close')
    await flushPromises()
    finish({ id: 9, submittedAnswers: {}, correctAnswers: {}, incorrectBlankKeys: [], viewedAnswer: false, legacySnapshot: false })
    await flushPromises()
    expect(wrapper.findComponent(RecordDetailDialog).props('detail')).toBeNull()
  })
})
