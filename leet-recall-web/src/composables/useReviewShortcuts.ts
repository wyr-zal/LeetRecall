import { onActivated, onBeforeUnmount, onDeactivated, onMounted } from 'vue'

export interface ReviewShortcutHandlers {
  onForgot: () => void
  onFuzzy: () => void
  onKnown: () => void
  onToggleHint: () => void
  onToggleAnswer: () => void
  onNext: () => void
  onPrevious: () => void
}

export function isEditableTarget(target: EventTarget | null): boolean {
  if (!(target instanceof HTMLElement)) return false
  return target.isContentEditable
    || target.tagName === 'INPUT'
    || target.tagName === 'TEXTAREA'
    || target.tagName === 'SELECT'
    || Boolean(target.closest('.monaco-editor'))
}

export function useReviewShortcuts(handlers: ReviewShortcutHandlers, enabled: (event: KeyboardEvent) => boolean = () => true): void {
  function handleKeydown(event: KeyboardEvent): void {
    if (!enabled(event) || event.defaultPrevented || isEditableTarget(event.target)) return
    const action = shortcutAction(event)
    if (!action) return
    event.preventDefault()
    handlers[action]()
  }

  // 视图在 KeepAlive 中缓存，切页只会 deactivate 不会 unmount；
  // 不在 deactivated 时移除监听，快捷键会泄漏到其他页面（如在默写页按 1 会提交复习评分）。
  // 同一函数引用重复 add/removeEventListener 幂等，四组钩子并存安全。
  onMounted(() => window.addEventListener('keydown', handleKeydown))
  onActivated(() => window.addEventListener('keydown', handleKeydown))
  onDeactivated(() => window.removeEventListener('keydown', handleKeydown))
  onBeforeUnmount(() => window.removeEventListener('keydown', handleKeydown))
}

export function shortcutAction(event: Pick<KeyboardEvent, 'key'>): keyof ReviewShortcutHandlers | null {
  switch (event.key.toLowerCase()) {
    case '1': return 'onForgot'
    case '2': return 'onFuzzy'
    case '3': return 'onKnown'
    case 'h': return 'onToggleHint'
    case 'a': return 'onToggleAnswer'
    case 'arrowright': return 'onNext'
    case 'arrowleft': return 'onPrevious'
    default: return null
  }
}

