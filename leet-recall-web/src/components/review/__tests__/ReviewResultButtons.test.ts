import { mount } from '@vue/test-utils'
import ReviewResultButtons from '@/components/review/ReviewResultButtons.vue'

describe('ReviewResultButtons', () => {
  it('shows the three mastery choices in one dropdown', () => {
    const wrapper = mount(ReviewResultButtons, { props: { loading: false } })

    expect(wrapper.findAll('button')).toHaveLength(0)
    expect(wrapper.get('select').attributes('aria-label')).toBe('标记本题掌握程度')
    expect(wrapper.findAll('option').map((option) => option.text())).toEqual([
      '选择掌握程度',
      '1 · 不会',
      '2 · 模糊',
      '3 · 会',
    ])
  })

  it('emits the selected mastery result and resets to the placeholder', async () => {
    const wrapper = mount(ReviewResultButtons, { props: { loading: false } })
    const select = wrapper.get('select')

    await select.setValue('FORGOT')
    await select.setValue('FUZZY')
    await select.setValue('KNOWN')

    expect(wrapper.emitted('select')).toEqual([['FORGOT'], ['FUZZY'], ['KNOWN']])
    expect((select.element as HTMLSelectElement).value).toBe('')
  })

  it('disables the dropdown and shows saving state while submitting', () => {
    const wrapper = mount(ReviewResultButtons, { props: { loading: true } })

    expect(wrapper.get('select').attributes('disabled')).toBeDefined()
    expect(wrapper.get('option').text()).toBe('保存中…')
  })
})
