import { mount } from '@vue/test-utils'
import RecallQuestionList from '@/components/review/RecallQuestionList.vue'

describe('RecallQuestionList', () => {
  const baseProps = {
    questions: [{ id: 1, question: '哈希表中保存什么？', answer: '数字到下标。' }],
    draft: {},
    answersVisible: false,
  }

  it('never renders a source link for externally imported content', () => {
    const wrapper = mount(RecallQuestionList, {
      props: {
        ...baseProps,
      },
    })

    expect(wrapper.find('a').exists()).toBe(false)
    expect(wrapper.text()).toContain('哈希表中保存什么？')
  })

  it('hides the source link for non Hot100 content without provenance', () => {
    const wrapper = mount(RecallQuestionList, { props: baseProps })
    expect(wrapper.find('a').exists()).toBe(false)
  })

  it('shows the saved confirmation when the store reports a fresh save', () => {
    const wrapper = mount(RecallQuestionList, { props: { ...baseProps, saveState: 'saved' } })

    expect(wrapper.get('.save-hint').text()).toBe('已保存')
    expect(wrapper.get('.save-hint').classes()).toContain('saved')
  })

  it('shows the autosave hint by default', () => {
    const wrapper = mount(RecallQuestionList, { props: baseProps })

    expect(wrapper.get('.save-hint').text()).toBe('输入会自动保存')
    expect(wrapper.get('.save-hint').classes()).not.toContain('saved')
  })
})
