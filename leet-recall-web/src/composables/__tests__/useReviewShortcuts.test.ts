import { defineComponent, h } from 'vue'
import { mount } from '@vue/test-utils'
import {
  isEditableTarget,
  shortcutAction,
  useReviewShortcuts,
  type ReviewShortcutHandlers,
} from '@/composables/useReviewShortcuts'

describe('useReviewShortcuts', () => {
  it('maps review shortcut keys', () => {
    expect(shortcutAction({ key: '1' })).toBe('onForgot')
    expect(shortcutAction({ key: 'H' })).toBe('onToggleHint')
    expect(shortcutAction({ key: 'ArrowRight' })).toBe('onNext')
  })

  it('recognizes focused text fields as editable targets', () => {
    expect(isEditableTarget(document.createElement('input'))).toBe(true)
    expect(isEditableTarget(document.createElement('textarea'))).toBe(true)
    expect(isEditableTarget(document.createElement('div'))).toBe(false)
  })

  it('triggers digits globally but not while an input is focused', async () => {
    const onForgot = vi.fn()
    const handlers: ReviewShortcutHandlers = {
      onForgot,
      onFuzzy: vi.fn(),
      onKnown: vi.fn(),
      onToggleHint: vi.fn(),
      onToggleAnswer: vi.fn(),
      onNext: vi.fn(),
      onPrevious: vi.fn(),
      onEnd: vi.fn(),
    }
    const Harness = defineComponent({
      setup() {
        useReviewShortcuts(handlers)
        return () => h('input', { id: 'answer' })
      },
    })
    const wrapper = mount(Harness, { attachTo: document.body })
    window.dispatchEvent(new KeyboardEvent('keydown', { key: '1', bubbles: true }))
    expect(onForgot).toHaveBeenCalledTimes(1)

    const input = wrapper.get('input').element
    input.dispatchEvent(new KeyboardEvent('keydown', { key: '1', bubbles: true }))
    expect(onForgot).toHaveBeenCalledTimes(1)
    wrapper.unmount()
  })
})

