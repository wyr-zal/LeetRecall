import { ref } from 'vue'

/** 顶栏设置下拉的展开状态；工作台据此暂停全局快捷键。 */
export const settingsMenuOpen = ref(false)

export function setSettingsMenuOpen(open: boolean): void {
  settingsMenuOpen.value = open
}

export function useSettingsMenu() {
  return { settingsMenuOpen, setSettingsMenuOpen }
}
