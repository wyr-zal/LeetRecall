import { onBeforeUnmount, onMounted } from 'vue'

export interface ReviewShortcutHandlers {
  onForgot: () => void
  onFuzzy: () => void
  onKnown: () => void
  onToggleHint: () => void
  onToggleAnswer: () => void
  onNext: () => void
  onPrevious: () => void
  onEnd: () => void
}

export function isEditableTarget(target: EventTarget | null): boolean {
  if (!(target instanceof HTMLElement)) return false
  return target.isContentEditable
    || target.tagName === 'INPUT'
    || target.tagName === 'TEXTAREA'
    || target.tagName === 'SELECT'
    || Boolean(target.closest('.monaco-editor'))
}

export function useReviewShortcuts(handlers: ReviewShortcutHandlers): void {
  function handleKeydown(event: KeyboardEvent): void {
    if (isEditableTarget(event.target)) return
    const action = shortcutAction(event)
    if (!action) return
    event.preventDefault()
    handlers[action]()
  }

  onMounted(() => window.addEventListener('keydown', handleKeydown))
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
    case 'escape': return 'onEnd'
    default: return null
  }
}

