import { mount } from '@vue/test-utils'
import DictationProgress from '@/components/dictation/DictationProgress.vue'

describe('DictationProgress', () => {
  it('hides the annotation entry until the answer is visible', async () => {
    const wrapper = mount(DictationProgress, {
      props: { current: 1, total: 5, annotationCount: 2 },
    })

    expect(wrapper.find('.annotate').exists()).toBe(false)
    await wrapper.setProps({ annotationsVisible: true })
    expect(wrapper.find('.annotate').exists()).toBe(true)
    expect(wrapper.find('.badge').text()).toBe('2')
  })
})
