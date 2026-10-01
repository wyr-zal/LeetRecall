import { mount } from '@vue/test-utils'
import DictationProblemPanel from '@/components/dictation/DictationProblemPanel.vue'

const QUESTIONS = [
  { id: 1, question: '窗口何时收缩？', answer: 'cnt 出现负数时' },
  { id: 2, question: '何时更新答案？', answer: '窗口合法时' },
]

function mountPanel(overrides: Record<string, unknown> = {}) {
  return mount(DictationProblemPanel, {
    props: {
      descriptionMarkdown: '给定两个字符串 s 和 p',
      recallQuestions: QUESTIONS,
      coreIdea: '滑动窗口',
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
  it('opens on the description tab and switches to the other panes', async () => {
    const wrapper = mountPanel()

    expect(wrapper.get('[role="tabpanel"]').text()).toContain('给定两个字符串 s 和 p')

    await selectTab(wrapper, '核心思路')
    expect(wrapper.get('[role="tabpanel"]').text()).toContain('滑动窗口')
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
    const wrapper = mountPanel({ descriptionMarkdown: '', recallQuestions: [], coreIdea: '   ' })

    expect(wrapper.get('.pane-empty').text()).toBe('这道题还没有题目描述')

    await selectTab(wrapper, '回忆问答')
    expect(wrapper.get('.pane-empty').text()).toBe('这道题还没有回忆问答')
  })
})
