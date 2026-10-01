import { ref, watch } from 'vue'

export type ThemeMode = 'dark' | 'light'

const THEME_STORAGE_KEY = 'leet-recall:theme'
export const themeMode = ref<ThemeMode>(readStoredTheme())

function readStoredTheme(): ThemeMode {
  try {
    return localStorage.getItem(THEME_STORAGE_KEY) === 'dark' ? 'dark' : 'light'
  } catch {
    return 'light'
  }
}

export function applyTheme(mode: ThemeMode = themeMode.value): void {
  if (typeof document === 'undefined') return
  document.documentElement.dataset.theme = mode
  document.documentElement.style.colorScheme = mode
  document.dispatchEvent(new CustomEvent<ThemeMode>('leet-recall:theme-change', { detail: mode }))
}

export function initializeTheme(): void {
  applyTheme()
}

watch(themeMode, (mode) => {
  try {
    localStorage.setItem(THEME_STORAGE_KEY, mode)
  } catch {
    // Private browsing or disabled storage should not block theme switching.
  }
  applyTheme(mode)
})

export function useTheme() {
  function toggleTheme(): void {
    themeMode.value = themeMode.value === 'dark' ? 'light' : 'dark'
  }

  return { themeMode, toggleTheme }
}

initializeTheme()
