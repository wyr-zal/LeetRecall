import { nextTick } from 'vue'
import { afterEach, describe, expect, it, vi } from 'vitest'
import {
  DEFAULT_CODE_FONT_SIZE,
  DEFAULT_UI_FONT_SIZE,
  FONT_SIZE_MAX,
  FONT_SIZE_MIN,
  UI_FONT_BASE,
  applyFontSettings,
  codeFontSize,
  setCodeFontSize,
  setUiFontSize,
  stepCodeFontSize,
  stepUiFontSize,
  uiFontSize,
} from '@/composables/useFontScale'

describe('font size preferences', () => {
  afterEach(() => {
    localStorage.clear()
    setUiFontSize(DEFAULT_UI_FONT_SIZE)
    setCodeFontSize(DEFAULT_CODE_FONT_SIZE)
    applyFontSettings()
  })

  it('defaults to 16px interface text and 14px code', () => {
    expect(DEFAULT_UI_FONT_SIZE).toBe(16)
    expect(DEFAULT_CODE_FONT_SIZE).toBe(14)
    expect(document.documentElement.dataset.uiFontSize).toBe('16')
    expect(document.documentElement.dataset.codeFontSize).toBe('14')
  })

  it('applies both sizes and the derived ratio to the root element', async () => {
    setUiFontSize(20)
    setCodeFontSize(18)
    await nextTick()

    expect(document.documentElement.style.getPropertyValue('--ui-font-size')).toBe('20px')
    expect(document.documentElement.style.getPropertyValue('--code-font-size')).toBe('18px')
    expect(Number(document.documentElement.style.getPropertyValue('--ui-font-ratio')))
      .toBeCloseTo(20 / UI_FONT_BASE)
    expect(localStorage.getItem('leet-recall:ui-font-size')).toBe('20')
    expect(localStorage.getItem('leet-recall:code-font-size')).toBe('18')
  })

  it('steps one pixel at a time and clamps to the allowed range', () => {
    setUiFontSize(FONT_SIZE_MAX)
    stepUiFontSize(1)
    expect(uiFontSize.value).toBe(FONT_SIZE_MAX)

    setCodeFontSize(FONT_SIZE_MIN)
    stepCodeFontSize(-1)
    expect(codeFontSize.value).toBe(FONT_SIZE_MIN)

    stepCodeFontSize(1)
    expect(codeFontSize.value).toBe(FONT_SIZE_MIN + 1)
  })

  it('rejects values outside the range and non numeric input', () => {
    setUiFontSize(99)
    expect(uiFontSize.value).toBe(FONT_SIZE_MAX)

    setCodeFontSize(2)
    expect(codeFontSize.value).toBe(FONT_SIZE_MIN)

    setUiFontSize(Number.NaN)
    expect(uiFontSize.value).toBe(DEFAULT_UI_FONT_SIZE)
  })

  it('reads stored sizes on startup and ignores invalid entries', async () => {
    localStorage.setItem('leet-recall:ui-font-size', 'not-a-number')
    localStorage.setItem('leet-recall:code-font-size', '30')
    vi.resetModules()

    const fresh = await import('@/composables/useFontScale')
    expect(fresh.uiFontSize.value).toBe(fresh.DEFAULT_UI_FONT_SIZE)
    expect(fresh.codeFontSize.value).toBe(fresh.FONT_SIZE_MAX)
  })
})
