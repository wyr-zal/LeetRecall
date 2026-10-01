import { ref, watch } from 'vue'

/**
 * 界面文字基准：main.css 中正文写死为 13px，其余字号按同比例缩放。
 * 用户选择的界面字号除以该基准即为 --ui-font-ratio，13px 正文因此正好等于所选值。
 */
export const UI_FONT_BASE = 13
export const FONT_SIZE_MIN = 12
export const FONT_SIZE_MAX = 24
export const DEFAULT_UI_FONT_SIZE = 16
export const DEFAULT_CODE_FONT_SIZE = 14

const UI_SIZE_STORAGE_KEY = 'leet-recall:ui-font-size'
const CODE_SIZE_STORAGE_KEY = 'leet-recall:code-font-size'

function clampFontSize(value: number, fallback: number): number {
  if (!Number.isFinite(value)) return fallback
  return Math.min(FONT_SIZE_MAX, Math.max(FONT_SIZE_MIN, Math.round(value)))
}

function readStoredFontSize(key: string, fallback: number): number {
  try {
    const raw = localStorage.getItem(key)
    return raw === null ? fallback : clampFontSize(Number(raw), fallback)
  } catch {
    return fallback
  }
}

export const uiFontSize = ref(readStoredFontSize(UI_SIZE_STORAGE_KEY, DEFAULT_UI_FONT_SIZE))
export const codeFontSize = ref(readStoredFontSize(CODE_SIZE_STORAGE_KEY, DEFAULT_CODE_FONT_SIZE))

export function applyFontSettings(): void {
  if (typeof document === 'undefined') return
  const root = document.documentElement
  root.style.setProperty('--ui-font-size', `${uiFontSize.value}px`)
  root.style.setProperty('--code-font-size', `${codeFontSize.value}px`)
  root.style.setProperty('--ui-font-ratio', String(uiFontSize.value / UI_FONT_BASE))
  root.dataset.uiFontSize = String(uiFontSize.value)
  root.dataset.codeFontSize = String(codeFontSize.value)
}

export function setUiFontSize(size: number): void {
  uiFontSize.value = clampFontSize(size, DEFAULT_UI_FONT_SIZE)
}

export function setCodeFontSize(size: number): void {
  codeFontSize.value = clampFontSize(size, DEFAULT_CODE_FONT_SIZE)
}

export function stepUiFontSize(delta: number): void {
  setUiFontSize(uiFontSize.value + delta)
}

export function stepCodeFontSize(delta: number): void {
  setCodeFontSize(codeFontSize.value + delta)
}

export function initializeFontScale(): void {
  applyFontSettings()
}

watch([uiFontSize, codeFontSize], () => {
  try {
    localStorage.setItem(UI_SIZE_STORAGE_KEY, String(uiFontSize.value))
    localStorage.setItem(CODE_SIZE_STORAGE_KEY, String(codeFontSize.value))
  } catch {
    // Private browsing or disabled storage should not block font sizing.
  }
  applyFontSettings()
})

export function useFontScale() {
  return {
    uiFontSize,
    codeFontSize,
    minFontSize: FONT_SIZE_MIN,
    maxFontSize: FONT_SIZE_MAX,
    setUiFontSize,
    setCodeFontSize,
    stepUiFontSize,
    stepCodeFontSize,
  }
}

initializeFontScale()
