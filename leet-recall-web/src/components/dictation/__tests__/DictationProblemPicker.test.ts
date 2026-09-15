import { mount } from '@vue/test-utils'
import DictationProblemPicker from '@/components/dictation/DictationProblemPicker.vue'
import type { DictationQueueItem } from '@/types/dictation'

const items: DictationQueueItem[] = [
  { problemId: 1, leetcodeNumber: 1, title: '两数之和', completed: false },
  { problemId: 8, leetcodeNumber: 236, title: '二叉树的最近公共祖先', completed: true, accuracy: 87.5 },
  { problemId: 12, leetcodeNumber: 5, title: '最长回文子串', completed: false },
]

/** 弹窗经 Teleport 渲染到 body，wrapper 查询不可见，统一从 body 取。 */
function bodyPickerButtons(): HTMLElement[] {
  return Array.from(document.body.querySelectorAll<HTMLButtonElement>('.picker-list button'))
}

describe('DictationProblemPicker', () => {
  beforeEach(() => {
    // jsdom 不实现 scrollIntoView，打开时定位当前题会直接抛错。
    Element.prototype.scrollIntoView = vi.fn()
  })

  it('renders only when open and marks the current problem', async () => {
    const wrapper = mount(DictationProblemPicker, {
      props: { open: false, items, currentProblemId: 8 },
    })
    expect(document.body.querySelector('.picker')).toBeNull()

    await wrapper.setProps({ open: true })

    const buttons = bodyPickerButtons()
    expect(buttons).toHaveLength(3)
    expect(buttons[1]?.getAttribute('aria-current')).toBe('true')
    expect(buttons[1]?.textContent).toContain('正确率 88%')
    expect(buttons[0]?.textContent).toContain('未默写')
    wrapper.unmount()
  })

  it('emits select with the problem id and closes from the backdrop', async () => {
    const wrapper = mount(DictationProblemPicker, {
      props: { open: true, items, currentProblemId: 1 },
    })

    bodyPickerButtons()[2]?.click()
    await Promise.resolve()
    expect(wrapper.emitted('select')).toEqual([[12]])

    ;(document.body.querySelector('.picker-backdrop') as HTMLElement).click()
    await Promise.resolve()
    expect(wrapper.emitted('close')).toHaveLength(1)
    wrapper.unmount()
  })

  it('closes on Escape while open', () => {
    const wrapper = mount(DictationProblemPicker, {
      props: { open: true, items, currentProblemId: 1 },
    })

    window.dispatchEvent(new KeyboardEvent('keydown', { key: 'Escape', bubbles: true }))
    expect(wrapper.emitted('close')).toHaveLength(1)
    wrapper.unmount()
  })
})
