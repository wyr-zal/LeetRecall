import { mount } from '@vue/test-utils'
import { vi } from 'vitest'

const editorState = vi.hoisted(() => ({
  widgets: [] as Array<{ getDomNode: () => HTMLElement }>,
  zoneHeights: [] as number[],
  host: null as HTMLElement | null,
  fontLigatures: true,
  readOnly: false,
  domReadOnly: false,
  modelValue: '',
  options: {} as Record<string, unknown>,
  selectionChanged: () => {},
  decorationWrites: 0,
  modelWrites: 0,
}))

vi.mock('monaco-editor/esm/vs/editor/editor.api', () => {
  let value = ''
  const model = {
    getValue: () => value,
    getValueInRange: () => 'return',
    getOffsetAt: () => 0,
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
    createDecorationsCollection: () => ({ clear: () => { editorState.decorationWrites = 0 }, set: (items: unknown[]) => { editorState.decorationWrites = items.length } }),
    dispose: vi.fn(),
    getModel: () => model,
    getSelection: () => ({ isEmpty: () => false, startLineNumber: 1, startColumn: 1, endLineNumber: 1, endColumn: 7, getStartPosition: () => ({ lineNumber: 1, column: 1 }), getEndPosition: () => ({ lineNumber: 1, column: 7 }) }),
    getOption: () => 24,
    layout: vi.fn(),
    onDidChangeCursorSelection: (callback: () => void) => { editorState.selectionChanged = callback; return { dispose: vi.fn() } },
    onMouseDown: () => ({ dispose: vi.fn() }),
    removeContentWidget: (widget: { getDomNode: () => HTMLElement }) => {
      editorState.widgets = editorState.widgets.filter(item => item !== widget)
      widget.getDomNode().remove()
    },
    setValue: (next: string) => {
      editorState.modelWrites += 1
      value = next
      editorState.modelValue = next
    },
    updateOptions: (options: { readOnly?: boolean; domReadOnly?: boolean }) => {
      Object.assign(editorState.options, options)
      if (options.readOnly !== undefined) editorState.readOnly = options.readOnly
      if (options.domReadOnly !== undefined) editorState.domReadOnly = options.domReadOnly
    },
  }
  return {
    Range: class {},
    editor: {
      create: (host: HTMLElement, options: { fontLigatures: boolean; readOnly?: boolean; domReadOnly?: boolean }) => {
        editorState.options = { ...options }
        editorState.host = host
        editorState.fontLigatures = options.fontLigatures
        editorState.readOnly = options.readOnly ?? false
        editorState.domReadOnly = options.domReadOnly ?? false
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
    editorState.readOnly = false
    editorState.domReadOnly = false
    editorState.modelValue = ''
    editorState.options = {}
    editorState.decorationWrites = 0
    editorState.modelWrites = 0
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

  it('完整答案同时启用模型与原生输入框只读，避免手机唤起键盘', async () => {
    const code = 'class Solution { /* 原样展示 */ }'
    const wrapper = mount(CodeBlankEditor, {
      props: { templateCode: '{{blank_1}}', answers: {}, answerCode: code },
    })
    await wrapper.vm.$nextTick()

    expect(editorState.modelValue).toBe(code)
    expect(editorState.readOnly).toBe(true)
    expect(editorState.domReadOnly).toBe(true)
    expect(wrapper.find('.dictation-blank-widget textarea').exists()).toBe(false)
    wrapper.unmount()
  })

  it('进入答案前释放空位焦点，返回默写保留草稿并恢复输入', async () => {
    const wrapper = mount(CodeBlankEditor, {
      props: { templateCode: 'return {{blank_1}};', answers: { blank_1: 'draft' } },
      attachTo: document.body,
    })
    await wrapper.vm.$nextTick()
    const input = wrapper.get('.dictation-blank-widget textarea').element as HTMLTextAreaElement
    const blur = vi.spyOn(input, 'blur')
    input.focus()
    expect(document.activeElement).toBe(input)

    await wrapper.setProps({ answerCode: 'return answer;' })
    expect(blur).toHaveBeenCalledOnce()
    expect(document.activeElement).not.toBe(input)
    expect(wrapper.find('.dictation-blank-widget textarea').exists()).toBe(false)

    await wrapper.setProps({ answerCode: undefined })
    const restored = wrapper.get('.dictation-blank-widget textarea').element as HTMLTextAreaElement
    expect(restored.value).toBe('draft')
    expect(restored.readOnly).toBe(false)
    expect(restored.disabled).toBe(false)
    restored.value = 'continued'
    restored.dispatchEvent(new Event('input', { bubbles: true }))
    const updates = wrapper.emitted('update:answers')
    expect(updates?.[updates.length - 1]?.[0]).toEqual({ blank_1: 'continued' })
    wrapper.unmount()
  })
  it('手机答案零批注也不留 gutter，答案更新不会重新启用', async () => {
    const wrapper = mount(CodeBlankEditor, { props: { templateCode: '{{blank_1}}', answers: {}, answerCode: 'return 1;', mobile: true } })
    await wrapper.vm.$nextTick()
    expect(editorState.options).toMatchObject({ glyphMargin: false, lineNumbersMinChars: 2, lineDecorationsWidth: 4, folding: false, readOnly: true, domReadOnly: true })
    await wrapper.setProps({ answerCode: 'return 2;' })
    expect(editorState.options.glyphMargin).toBe(false)
    editorState.selectionChanged()
    expect(wrapper.find('.annotation-selection-action').exists()).toBe(false)
    wrapper.unmount()
  })

  it('桌面切手机清理批注和选区动作，但不重建模型；恢复桌面功能', async () => {
    const annotation = { id: 1, problemId: 1, anchorText: 'return', occurrenceIndex: 0, startLine: 1, startColumn: 1, endLine: 1, endColumn: 7, contentMarkdown: '说明', createdAt: '', updatedAt: '', resolved: true, relocated: false }
    const wrapper = mount(CodeBlankEditor, { props: { templateCode: '{{blank_1}}', answers: {}, answerCode: 'return 1;', annotations: [annotation] } })
    await wrapper.vm.$nextTick()
    editorState.selectionChanged()
    expect(wrapper.find('.annotation-selection-action').exists()).toBe(true)
    expect(editorState.decorationWrites).toBe(1)
    const writes = editorState.modelWrites
    await wrapper.setProps({ mobile: true })
    expect(editorState.options.glyphMargin).toBe(false)
    expect(editorState.decorationWrites).toBe(0)
    expect(wrapper.find('.annotation-selection-action').exists()).toBe(false)
    expect(editorState.modelWrites).toBe(writes)
    await wrapper.setProps({ mobile: false })
    expect(editorState.options).toMatchObject({ glyphMargin: true, lineNumbersMinChars: 3, folding: true })
    expect(editorState.decorationWrites).toBe(1)
    wrapper.unmount()
  })

})
