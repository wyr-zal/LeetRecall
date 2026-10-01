import { flushPromises, mount } from '@vue/test-utils'
import { afterEach, beforeEach, describe, expect, it } from 'vitest'
import SettingsView from '@/views/settings/SettingsView.vue'
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

describe('SettingsView font controls', () => {
  beforeEach(() => {
    setUiFontSize(DEFAULT_UI_FONT_SIZE)
    setCodeFontSize(DEFAULT_CODE_FONT_SIZE)
  })

  afterEach(() => {
    localStorage.clear()
    setUiFontSize(DEFAULT_UI_FONT_SIZE)
    setCodeFontSize(DEFAULT_CODE_FONT_SIZE)
    applyFontSettings()
  })

  it('shows the current interface and code sizes in pixels', () => {
    const wrapper = mount(SettingsView)
    const { ui, code } = sizeControls(wrapper)

    expect(ui?.get('.size-value').text()).toBe('16 px')
    expect(code?.get('.size-value').text()).toBe('14 px')
  })

  it('steps each size independently and syncs the root variables', async () => {
    const wrapper = mount(SettingsView)
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
  })

  it('disables the buttons once the size reaches the allowed bounds', async () => {
    const wrapper = mount(SettingsView)
    const buttons = sizeControls(wrapper).code!.findAll('button')

    setCodeFontSize(FONT_SIZE_MAX)
    await flushPromises()
    expect(buttons[1]!.attributes('disabled')).toBeDefined()
    expect(buttons[0]!.attributes('disabled')).toBeUndefined()

    setCodeFontSize(FONT_SIZE_MIN)
    await flushPromises()
    expect(buttons[0]!.attributes('disabled')).toBeDefined()
    expect(buttons[1]!.attributes('disabled')).toBeUndefined()
  })

  it('keeps the font preferences when local drafts are cleared', async () => {
    localStorage.setItem('leet-recall:dictation-draft-1', '{"a":"b"}')
    localStorage.setItem('leet-recall:review-draft-3', '{"c":"d"}')
    setUiFontSize(18)
    setCodeFontSize(15)
    const wrapper = mount(SettingsView)

    await wrapper.findAll('button').filter((button) => button.text() === '清除草稿')[0]!.trigger('click')
    await flushPromises()
    const confirm = Array.from(document.querySelectorAll('button'))
      .find((button) => button.textContent === '确认清除')
    confirm?.click()
    await flushPromises()

    expect(localStorage.getItem('leet-recall:dictation-draft-1')).toBeNull()
    expect(localStorage.getItem('leet-recall:review-draft-3')).toBeNull()
    expect(localStorage.getItem('leet-recall:ui-font-size')).toBe('18')
    expect(localStorage.getItem('leet-recall:code-font-size')).toBe('15')
  })
})
