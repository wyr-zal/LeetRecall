import { nextTick } from 'vue'
import { afterEach, describe, expect, it } from 'vitest'
import { applyTheme, themeMode } from '@/composables/useTheme'

describe('theme preference', () => {
  afterEach(() => {
    localStorage.clear()
    themeMode.value = 'dark'
    applyTheme('dark')
  })

  it('applies and persists the selected light theme', async () => {
    themeMode.value = 'light'
    await nextTick()

    expect(document.documentElement.dataset.theme).toBe('light')
    expect(document.documentElement.style.colorScheme).toBe('light')
    expect(localStorage.getItem('leet-recall:theme')).toBe('light')
  })
})
