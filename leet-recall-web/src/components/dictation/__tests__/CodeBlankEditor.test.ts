import { mount } from '@vue/test-utils'
import { vi } from 'vitest'

const editorState = vi.hoisted(() => ({
  widgets: [] as Array<{ getDomNode: () => HTMLElement }>,
  zoneHeights: [] as number[],
  host: null as HTMLElement | null,
  fontLigatures: true,
  modelValue: '',
}))

vi.mock('monaco-editor/esm/vs/editor/editor.api', () => {
  let value = ''
  const model = {
    getPositionAt(offset: number) {
      return { lineNumber: value.slice(0, offset).split('\n').length, column: 1 }
    },
  }
  const editor = {
    addContentWidget(widget: { getDomNode: () => HTMLElement }) {
      editorState.widgets.push(widget)
      editorState.host?.append(widget.getDomNode())
    },
    changeViewZones(callback: (accessor: {
      addZone: (zone: { heightInPx: number }) => string
      removeZone: (id: string) => void
    }) => void) {
      const nextHeights: number[] = []
      callback({
        addZone: ({ heightInPx }) => {
          nextHeights.push(heightInPx)
          return `zone-${nextHeights.length}`
        },
        removeZone: () => undefined,
      })
      editorState.zoneHeights = nextHeights
    },
    createDecorationsCollection: () => ({ clear: vi.fn(), set: vi.fn() }),
    dispose: vi.fn(),
    getModel: () => model,
    getOption: () => 24,
    layout: vi.fn(),
    onDidChangeCursorSelection: () => ({ dispose: vi.fn() }),
    onMouseDown: () => ({ dispose: vi.fn() }),
    removeContentWidget: vi.fn(),
    setValue: (next: string) => {
      value = next
      editorState.modelValue = next
    },
    updateOptions: vi.fn(),
  }
  return {
    editor: {
      create: (host: HTMLElement, options: { fontLigatures: boolean }) => {
        editorState.host = host
        editorState.fontLigatures = options.fontLigatures
        return editor
      },
      defineTheme: vi.fn(),
      setTheme: vi.fn(),
      EditorOption: { lineHeight: 'lineHeight' },
      ShowLightbulbIconMode: { Off: 0 },
      MouseTargetType: { GUTTER_GLYPH_MARGIN: 1 },
      ContentWidgetPositionPreference: { EXACT: 0, BELOW: 1 },
    },
  }
})
vi.mock('monaco-editor/esm/vs/editor/editor.worker?worker', () => ({ default: class EditorWorker {} }))
vi.mock('monaco-editor/esm/vs/basic-languages/java/java.contribution', () => ({}))

import CodeBlankEditor from '@/components/dictation/CodeBlankEditor.vue'

describe('CodeBlankEditor', () => {
  beforeEach(() => {
    editorState.widgets = []
    editorState.zoneHeights = []
    editorState.host = null
    editorState.fontLigatures = true
    editorState.modelValue = ''
    vi.stubGlobal('ResizeObserver', class {
      observe() {}
      disconnect() {}
    })
    vi.spyOn(HTMLCanvasElement.prototype, 'getContext').mockReturnValue({
      measureText: (text: string) => ({ width: text.length * 8 }),
    } as CanvasRenderingContext2D)
  })

  afterEach(() => {
    vi.restoreAllMocks()
    vi.unstubAllGlobals()
  })

  it('accepts multiline answers and reserves Monaco rows for them', async () => {
    const wrapper = mount(CodeBlankEditor, {
      props: {
        templateCode: 'class Solution {\n    {{blank_1}}\n}',
        answers: {},
      },
    })
    await wrapper.vm.$nextTick()

    const answer = wrapper.get('textarea').element as HTMLTextAreaElement
    expect(editorState.fontLigatures).toBe(false)
    const enter = new KeyboardEvent('keydown', { key: 'Enter', bubbles: true, cancelable: true })
    answer.dispatchEvent(enter)
    expect(enter.defaultPrevented).toBe(false)

    answer.value = 'if (value >= target) {\n    return result;\n}'
    answer.dispatchEvent(new Event('input', { bubbles: true }))

    const updates = wrapper.emitted('update:answers')
    expect(updates?.[updates.length - 1]?.[0]).toEqual({
      blank_1: 'if (value >= target) {\n    return result;\n}',
    })
    expect(editorState.zoneHeights).toEqual([48])
  })

  it('lets Ctrl+Enter bubble to the dictation submit shortcut', async () => {
    const wrapper = mount(CodeBlankEditor, {
      props: { templateCode: '{{blank_1}}', answers: {} },
      attachTo: document.body,
    })
    await wrapper.vm.$nextTick()
    const answer = wrapper.get('textarea').element
    const bubbled = vi.fn()
    document.addEventListener('keydown', bubbled, { once: true })
    answer.dispatchEvent(new KeyboardEvent('keydown', {
      key: 'Enter', ctrlKey: true, bubbles: true, cancelable: true,
    }))
    expect(bubbled).toHaveBeenCalledOnce()
    wrapper.unmount()
  })

  it('hides source comments while dictating and preserves them when showing the answer', async () => {
    const sourceCode = 'class Solution {\n  String marker = "// keep"; // hide\n  {{blank_1}} /* hide too */\n}'
    const dictation = mount(CodeBlankEditor, {
      props: { templateCode: sourceCode, answers: {} },
    })
    await dictation.vm.$nextTick()
    expect(editorState.modelValue).toBe(`class Solution {\n  String marker = "// keep"; \n  ${' '.repeat(14)} \n}`)
    dictation.unmount()

    const answer = mount(CodeBlankEditor, {
      props: { templateCode: sourceCode, answers: {}, answerCode: sourceCode },
    })
    await answer.vm.$nextTick()
    expect(editorState.modelValue).toBe(sourceCode)
    answer.unmount()
  })
})
