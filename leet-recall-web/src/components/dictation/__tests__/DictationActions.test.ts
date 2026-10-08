import { mount } from '@vue/test-utils'
import DictationActions from '../DictationActions.vue'

describe('DictationActions', () => {
  it.each([
    [false, false, '显示答案', 'lucide-eye-icon'],
    [false, true, '再看答案', 'lucide-eye-icon'],
    [true, true, '返回默写', 'lucide-undo2-icon'],
  ])('答案状态 %s/%s 保留动作含义和无障碍标签', (answerVisible, viewedAnswer, label, icon) => {
    const wrapper = mount(DictationActions, { props: { submitting: false, answerVisible, viewedAnswer } })
    const buttons = wrapper.findAll('button')
    expect(buttons).toHaveLength(3)
    expect(buttons.map(button => button.attributes('aria-label'))).toEqual(['重置', label, '提交默写'])
    expect(buttons[1]!.find(`.${icon}`).exists()).toBe(true)
    buttons.forEach(button => expect(button.find('.action-label').exists()).toBe(true))
    buttons.forEach(button => button.element.click())
    expect(wrapper.emitted('reset')).toHaveLength(1)
    expect(wrapper.emitted('answer')).toHaveLength(1)
    expect(wrapper.emitted('submit')).toHaveLength(1)
    wrapper.unmount()
  })

  it('评分中使用加载图标和标签，busy 不允许提交', async () => {
    const wrapper = mount(DictationActions, { props: { submitting: true, answerVisible: false, viewedAnswer: false } })
    expect(wrapper.get('.primary').attributes('aria-label')).toBe('正在评分…')
    expect(wrapper.find('.lucide-loader-circle-icon').exists()).toBe(true)
    await wrapper.get('.primary').trigger('click')
    expect(wrapper.emitted('submit')).toBeUndefined()
    await wrapper.setProps({ submitting: false, busy: true })
    expect(wrapper.get('.primary').attributes('disabled')).toBeDefined()
    wrapper.unmount()
  })
})
