import { mount } from '@vue/test-utils'
import DictationProblemPanel from '@/components/dictation/DictationProblemPanel.vue'

const QUESTIONS = [
  { id: 1, question: '窗口何时收缩？', answer: 'cnt 出现负数时' },
  { id: 2, question: '何时更新答案？', answer: '窗口合法时' },
]

function mountPanel(overrides: Record<string, unknown> = {}) {
  return mount(DictationProblemPanel, {
    props: {
      problemId: 1,
      descriptionMarkdown: '给定两个字符串 s 和 p',
      recallQuestions: QUESTIONS,
      ...overrides,
    },
  })
}

async function selectTab(wrapper: ReturnType<typeof mountPanel>, label: string): Promise<void> {
  const tab = wrapper.findAll('[role="tab"]').find((item) => item.text().includes(label))
  expect(tab).toBeDefined()
  await tab?.trigger('click')
}

describe('DictationProblemPanel', () => {
  it('opens on the description tab by default', () => {
    const wrapper = mountPanel()

    expect(wrapper.get('[role="tabpanel"]').text()).toContain('给定两个字符串 s 和 p')
  })

  it('replaces core idea with the current problem notes tab', async () => {
    const wrapper = mount(DictationProblemPanel, {
      props: { problemId: 438, descriptionMarkdown: '题目描述', recallQuestions: QUESTIONS },
      global: {
        stubs: {
          ProblemNotePanel: {
            props: ['problemId'],
            template: '<div data-test="problem-note-panel" :data-problem-id="problemId" />',
          },
        },
      },
    })

    const tabLabels = wrapper.findAll('[role="tab"]').map((tab) => tab.text())
    expect(tabLabels).toContain('我的笔记')
    expect(tabLabels).not.toContain('核心思路')
    expect(wrapper.find('[data-test="problem-note-panel"]').exists()).toBe(false)

    await selectTab(wrapper, '我的笔记')

    expect(wrapper.get('[data-test="problem-note-panel"]').attributes('data-problem-id')).toBe('438')
  })

  it('renders the problem heading between the tabs and scrollable statement', () => {
    const wrapper = mount(DictationProblemPanel, {
      props: {
        problemId: 438,
        descriptionMarkdown: '题目正文',
        recallQuestions: QUESTIONS,
      },
      slots: { header: '<header class="problem-heading">438. 题目标题</header>' },
    })
    const html = wrapper.html()

    expect(html.indexOf('pane-tabs')).toBeLessThan(html.indexOf('problem-heading'))
    expect(html.indexOf('problem-heading')).toBeLessThan(html.indexOf('pane-body'))
    expect(html).toContain('438. 题目标题')
  })

  it('keeps recall answers hidden until they are asked for', async () => {
    const wrapper = mountPanel()
    await selectTab(wrapper, '回忆问答')

    expect(wrapper.text()).toContain('窗口何时收缩？')
    expect(wrapper.text()).not.toContain('cnt 出现负数时')

    await wrapper.get('.reveal').trigger('click')
    expect(wrapper.text()).toContain('cnt 出现负数时')
    // 只展开被点的那一条
    expect(wrapper.text()).not.toContain('窗口合法时')
  })

  it('explains which tab is empty instead of showing a blank pane', async () => {
    const wrapper = mountPanel({ descriptionMarkdown: '', recallQuestions: [] })

    expect(wrapper.get('.pane-empty').text()).toBe('这道题还没有题目描述')

    await selectTab(wrapper, '回忆问答')
    expect(wrapper.get('.pane-empty').text()).toBe('这道题还没有回忆问答')
  })
})
