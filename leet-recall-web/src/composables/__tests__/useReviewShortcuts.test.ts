import { defineComponent, h, KeepAlive, nextTick, ref } from 'vue'
import { mount } from '@vue/test-utils'
import {
  isEditableTarget,
  shortcutAction,
  useReviewShortcuts,
  type ReviewShortcutHandlers,
} from '@/composables/useReviewShortcuts'

function createHandlers(onForgot: () => void): ReviewShortcutHandlers {
  return {
    onForgot,
    onFuzzy: vi.fn(),
    onKnown: vi.fn(),
    onToggleHint: vi.fn(),
    onToggleAnswer: vi.fn(),
    onNext: vi.fn(),
    onPrevious: vi.fn(),
  }
}

// 文件内只定义这一个组件（vue/one-component-per-file），handlers 由各用例注入。
let mountedHandlers: ReviewShortcutHandlers
const ShortcutHarness = defineComponent({
  setup() {
    useReviewShortcuts(mountedHandlers)
    return () => h('div', [h('input', { id: 'answer' })])
  },
})

describe('useReviewShortcuts', () => {
  it('maps review shortcut keys', () => {
    expect(shortcutAction({ key: '1' })).toBe('onForgot')
    expect(shortcutAction({ key: 'H' })).toBe('onToggleHint')
    expect(shortcutAction({ key: 'ArrowRight' })).toBe('onNext')
    expect(shortcutAction({ key: 'Escape' })).toBeNull()
  })

  it('recognizes focused text fields as editable targets', () => {
    expect(isEditableTarget(document.createElement('input'))).toBe(true)
    expect(isEditableTarget(document.createElement('textarea'))).toBe(true)
    expect(isEditableTarget(document.createElement('div'))).toBe(false)
  })

  it('triggers digits globally but not while an input is focused', () => {
    const onForgot = vi.fn()
    mountedHandlers = createHandlers(onForgot)
    const wrapper = mount(ShortcutHarness, { attachTo: document.body })

    window.dispatchEvent(new KeyboardEvent('keydown', { key: '1', bubbles: true }))
    expect(onForgot).toHaveBeenCalledTimes(1)

    const input = wrapper.get('input').element
    input.dispatchEvent(new KeyboardEvent('keydown', { key: '1', bubbles: true }))
    expect(onForgot).toHaveBeenCalledTimes(1)
    wrapper.unmount()
  })

  // 修复回归：视图被 KeepAlive 缓存时，切走（deactivated）后快捷键必须失效，
  // 否则在默写页按 1 会静默给复习页的当前题评分。
  it('stops listening after the kept-alive view is deactivated', async () => {
    const onForgot = vi.fn()
    mountedHandlers = createHandlers(onForgot)
    const active = ref(true)
    const wrapper = mount(KeepAlive, {
      attachTo: document.body,
      slots: { default: () => (active.value ? h(ShortcutHarness) : null) },
    })

    window.dispatchEvent(new KeyboardEvent('keydown', { key: '1', bubbles: true }))
    expect(onForgot).toHaveBeenCalledTimes(1)

    active.value = false
    await nextTick()
    window.dispatchEvent(new KeyboardEvent('keydown', { key: '1', bubbles: true }))
    expect(onForgot).toHaveBeenCalledTimes(1)
    wrapper.unmount()
  })
})
