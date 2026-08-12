import { flushPromises, mount } from '@vue/test-utils'
import { problemNoteApi } from '@/api/problemNote'
import ProblemNotePanel from '@/components/review/ProblemNotePanel.vue'

describe('ProblemNotePanel', () => {
  beforeEach(() => {
    vi.spyOn(problemNoteApi, 'get').mockResolvedValue({
      problemId: 1,
      markdown: '',
      updatedAt: null,
    })
    vi.spyOn(problemNoteApi, 'save').mockImplementation(async (problemId, markdown) => ({
      problemId,
      markdown,
      updatedAt: '2026-07-28T12:00:00',
    }))
  })

  afterEach(() => {
    vi.useRealTimers()
    vi.restoreAllMocks()
  })

  it('automatically saves markdown after editing', async () => {
    vi.useFakeTimers()
    const wrapper = mount(ProblemNotePanel, { props: { problemId: 1 } })
    await flushPromises()

    await wrapper.get('textarea').setValue('## 核心思路\n\n使用 **哈希表**。')
    expect(wrapper.text()).toContain('尚未保存')

    await vi.advanceTimersByTimeAsync(900)
    await flushPromises()

    expect(problemNoteApi.save).toHaveBeenCalledWith(1, '## 核心思路\n\n使用 **哈希表**。')
    expect(wrapper.text()).toContain('已保存')
  })

  it('renders markdown but never executes raw html', async () => {
    vi.mocked(problemNoteApi.get).mockResolvedValue({
      problemId: 1,
      markdown: '## 解题思路\n\n**关键点**\n\n<script>alert(1)</script>',
      updatedAt: '2026-07-28T12:00:00',
    })
    const wrapper = mount(ProblemNotePanel, { props: { problemId: 1 } })
    await flushPromises()

    expect(wrapper.find('.markdown-preview h2').text()).toBe('解题思路')
    expect(wrapper.find('.markdown-preview strong').text()).toBe('关键点')
    expect(wrapper.find('.markdown-preview script').exists()).toBe(false)
    expect(wrapper.find('.markdown-preview').text()).toContain('<script>alert(1)</script>')
  })

  it('blocks editing after a load failure and can retry safely', async () => {
    vi.mocked(problemNoteApi.get)
      .mockRejectedValueOnce(new Error('网络不可用'))
      .mockResolvedValueOnce({ problemId: 1, markdown: '', updatedAt: null })
    const wrapper = mount(ProblemNotePanel, { props: { problemId: 1 } })
    await flushPromises()

    expect(wrapper.find('textarea').exists()).toBe(false)
    expect(wrapper.text()).toContain('网络不可用')

    await wrapper.get('.note-load-error button').trigger('click')
    await flushPromises()
    expect(wrapper.find('textarea').exists()).toBe(true)
  })

  it('shows save failures and retries the latest draft', async () => {
    vi.useFakeTimers()
    vi.mocked(problemNoteApi.save)
      .mockRejectedValueOnce(new Error('保存接口不可用'))
      .mockResolvedValueOnce({
        problemId: 1,
        markdown: '易错点',
        updatedAt: '2026-07-28T12:00:00',
      })
    const wrapper = mount(ProblemNotePanel, { props: { problemId: 1 } })
    await flushPromises()

    await wrapper.get('textarea').setValue('易错点')
    await vi.advanceTimersByTimeAsync(900)
    await flushPromises()
    expect(wrapper.text()).toContain('保存失败')

    await wrapper.get('.save-status .retry-button').trigger('click')
    await flushPromises()
    expect(problemNoteApi.save).toHaveBeenLastCalledWith(1, '易错点')
    expect(wrapper.text()).toContain('已保存')
  })
})
