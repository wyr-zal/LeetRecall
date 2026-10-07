import { flushPromises, mount } from '@vue/test-utils'
import { afterEach, beforeEach, describe, expect, it } from 'vitest'
import SettingsMenu from '@/components/common/SettingsMenu.vue'
import {
  DEFAULT_CODE_FONT_SIZE,
  DEFAULT_UI_FONT_SIZE,
  FONT_SIZE_MAX,
  FONT_SIZE_MIN,
  applyFontSettings,
  codeFontSize,
  setCodeFontSize,
  setUiFontSize,
  uiFontSize,
} from '@/composables/useFontScale'

function sizeControls(wrapper: ReturnType<typeof mount>) {
  const groups = wrapper.findAll('.size-control')
  return {
    ui: groups[0],
    code: groups[1],
  }
}

describe('SettingsMenu', () => {
  beforeEach(() => {
    setUiFontSize(DEFAULT_UI_FONT_SIZE)
    setCodeFontSize(DEFAULT_CODE_FONT_SIZE)
  })

  afterEach(() => {
    localStorage.clear()
    setUiFontSize(DEFAULT_UI_FONT_SIZE)
    setCodeFontSize(DEFAULT_CODE_FONT_SIZE)
    applyFontSettings()
    document.body.innerHTML = ''
  })

  it('关闭时不渲染面板，点击按钮请求展开', async () => {
    const wrapper = mount(SettingsMenu, { props: { open: false } })

    expect(wrapper.find('.settings-panel').exists()).toBe(false)
    expect(wrapper.get('.menu-trigger').attributes('aria-expanded')).toBe('false')
    await wrapper.get('.menu-trigger').trigger('click')
    expect(wrapper.emitted('toggle')).toHaveLength(1)
    wrapper.unmount()
  })

  it('展开后聚焦首个控件，Esc 与外部点击都请求关闭', async () => {
    const wrapper = mount(SettingsMenu, { props: { open: false }, attachTo: document.body })
    await wrapper.setProps({ open: true })
    await flushPromises()

    expect(wrapper.get('.menu-trigger').attributes('aria-expanded')).toBe('true')
    expect(document.activeElement?.getAttribute('aria-label')).toBe('减小界面文字')

    const outside = document.createElement('button')
    document.body.appendChild(outside)
    outside.click()
    await flushPromises()
    expect(wrapper.emitted('close')).toHaveLength(1)

    document.dispatchEvent(new KeyboardEvent('keydown', { key: 'Escape' }))
    await flushPromises()
    expect(wrapper.emitted('close')).toHaveLength(2)
    wrapper.unmount()
  })

  it('显示当前界面与代码字号', async () => {
    const wrapper = mount(SettingsMenu, { props: { open: true } })
    const { ui, code } = sizeControls(wrapper)

    expect(ui?.get('.size-value').text()).toBe('16 px')
    expect(code?.get('.size-value').text()).toBe('14 px')
    wrapper.unmount()
  })

  it('两组字号独立步进并同步根变量', async () => {
    const wrapper = mount(SettingsMenu, { props: { open: true } })
    const { ui, code } = sizeControls(wrapper)

    await ui!.findAll('button')[1]!.trigger('click')
    await flushPromises()

    expect(uiFontSize.value).toBe(17)
    expect(codeFontSize.value).toBe(14)
    expect(ui!.get('.size-value').text()).toBe('17 px')
    expect(code!.get('.size-value').text()).toBe('14 px')
    expect(document.documentElement.style.getPropertyValue('--ui-font-size')).toBe('17px')
    expect(document.documentElement.style.getPropertyValue('--code-font-size')).toBe('14px')
    expect(localStorage.getItem('leet-recall:ui-font-size')).toBe('17')
    wrapper.unmount()
  })

  it('到达边界后禁用对应按钮', async () => {
    const wrapper = mount(SettingsMenu, { props: { open: true } })
    const buttons = sizeControls(wrapper).code!.findAll('button')

    setCodeFontSize(FONT_SIZE_MAX)
    await flushPromises()
    expect(buttons[1]!.attributes('disabled')).toBeDefined()
    expect(buttons[0]!.attributes('disabled')).toBeUndefined()

    setCodeFontSize(FONT_SIZE_MIN)
    await flushPromises()
    expect(buttons[0]!.attributes('disabled')).toBeDefined()
    expect(buttons[1]!.attributes('disabled')).toBeUndefined()
    wrapper.unmount()
  })

  it('清除本地草稿时不动字号偏好', async () => {
    localStorage.setItem('leet-recall:dictation-draft-1', '{"a":"b"}')
    localStorage.setItem('leet-recall:review-draft-3', '{"c":"d"}')
    setUiFontSize(18)
    setCodeFontSize(15)
    const wrapper = mount(SettingsMenu, { props: { open: true }, attachTo: document.body })

    await wrapper.get('.danger').trigger('click')
    await flushPromises()
    const confirm = Array.from(document.querySelectorAll('button'))
      .find((button) => button.textContent === '确认清除')
    confirm?.click()
    await flushPromises()

    expect(localStorage.getItem('leet-recall:dictation-draft-1')).toBeNull()
    expect(localStorage.getItem('leet-recall:review-draft-3')).toBeNull()
    expect(localStorage.getItem('leet-recall:ui-font-size')).toBe('18')
    expect(localStorage.getItem('leet-recall:code-font-size')).toBe('15')
    expect(wrapper.get('.cleared').text()).toContain('本地草稿已清除')
    wrapper.unmount()
  })
})
