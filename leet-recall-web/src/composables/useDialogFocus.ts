import { nextTick, onBeforeUnmount, watch, type Ref } from 'vue'

/** 只处理当前弹层的按键，嵌套确认框优先消费 Esc 与 Tab。 */
export function useDialogFocus(
  open: () => boolean,
  root: Ref<HTMLElement | null>,
  close: () => void,
): void {
  let previousFocus: HTMLElement | null = null

  function onKeydown(event: KeyboardEvent): void {
    const dialog = root.value
    if (!open() || !dialog) return
    const targetDialog = event.target instanceof Element ? event.target.closest('[role="dialog"], [role="alertdialog"]') : null
    if (targetDialog !== dialog) return
    if (event.key === 'Escape') {
      event.preventDefault()
      event.stopImmediatePropagation()
      close()
    } else if (event.key === 'Tab') {
      const elements = [...dialog.querySelectorAll<HTMLElement>(
        'button:not(:disabled), a[href], input:not(:disabled), textarea:not(:disabled), select:not(:disabled), [tabindex="0"]',
      )].filter((element) => {
        for (let parent: HTMLElement | null = element; parent && parent !== dialog; parent = parent.parentElement) {
          if (parent.hidden || parent.style.display === 'none' || parent.hasAttribute('inert')) return false
        }
        return true
      })
      const first = elements[0]
      const last = elements[elements.length - 1]
      if (!first) {
        event.preventDefault()
        dialog.focus()
      } else if (event.shiftKey && (document.activeElement === first || document.activeElement === dialog)) {
        event.preventDefault()
        last?.focus()
      } else if (!event.shiftKey && (document.activeElement === last || document.activeElement === dialog)) {
        event.preventDefault()
        first.focus()
      }
    }
  }

  watch(open, async (visible) => {
    document.removeEventListener('keydown', onKeydown)
    if (!visible) {
      if (previousFocus?.isConnected) previousFocus.focus({ preventScroll: true })
      return
    }
    previousFocus = document.activeElement instanceof HTMLElement ? document.activeElement : null
    await nextTick()
    if (!open()) return
    document.addEventListener('keydown', onKeydown)
    const focus = root.value?.querySelector<HTMLElement>('[data-dialog-focus], button, input, [tabindex="0"]')
    ;(focus ?? root.value)?.focus({ preventScroll: true })
  }, { immediate: true, flush: 'post' })

  onBeforeUnmount(() => document.removeEventListener('keydown', onKeydown))
}
