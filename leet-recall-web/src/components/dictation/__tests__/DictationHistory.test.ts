import { mount } from '@vue/test-utils'
import DictationHistory from '../DictationHistory.vue'

const records = [{ id: 8, createdAt: '2026-10-08T10:00:00', accuracy: 80, durationSeconds: 90, viewedAnswer: false }]

describe('DictationHistory', () => {
  it('桌面仍默认折叠，点击展开后可查看记录', async () => {
    const wrapper = mount(DictationHistory, { props: { records } })
    expect(wrapper.find('.record').exists()).toBe(false)
    await wrapper.get('.history-toggle').trigger('click')
    await wrapper.get('.record').trigger('click')
    expect(wrapper.emitted('select')).toEqual([[8]])
    wrapper.unmount()
  })

  it('抽屉模式直接展示列表，不重复显示折叠标题', async () => {
    const wrapper = mount(DictationHistory, { props: { records, standalone: true } })
    expect(wrapper.find('.history-toggle').exists()).toBe(false)
    expect(wrapper.get('.record').text()).toContain('80%')
    await wrapper.get('.record').trigger('click')
    expect(wrapper.emitted('select')).toEqual([[8]])
    await wrapper.setProps({ records: [] })
    expect(wrapper.text()).toContain('还没有默写记录')
    wrapper.unmount()
  })
})
