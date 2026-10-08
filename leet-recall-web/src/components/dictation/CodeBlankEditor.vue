<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import * as monaco from 'monaco-editor/esm/vs/editor/editor.api'
import EditorWorker from 'monaco-editor/esm/vs/editor/editor.worker?worker'
import 'monaco-editor/esm/vs/basic-languages/java/java.contribution'
import { Copy, Maximize2, Minus, Plus } from 'lucide-vue-next'
import { codeFontSize, stepCodeFontSize } from '@/composables/useFontScale'
import type { DictationResultItem } from '@/types/dictation'
import type { CodeAnnotationAnchor, ResolvedCodeAnnotation } from '@/types/annotation'
import { renderMarkdown } from '@/utils/markdown'
import { stripJavaComments } from '@/utils/stripJavaComments'

interface MonacoEnvironmentConfig {
  getWorker: () => Worker
}

const workerScope = self as typeof self & { MonacoEnvironment?: MonacoEnvironmentConfig }
workerScope.MonacoEnvironment = { getWorker: () => new EditorWorker() }

const props = defineProps<{
  templateCode: string
  answers: Record<string, string>
  results?: DictationResultItem[]
  answerCode?: string
  annotations?: ResolvedCodeAnnotation[]
  activeAnnotationId?: number | null
}>()
const emit = defineEmits<{
  'update:answers': [answers: Record<string, string>]
  'create-annotation': [anchor: CodeAnnotationAnchor]
  'select-annotation': [annotationId: number]
}>()

const shellRef = ref<HTMLElement | null>(null)
const editorRef = ref<HTMLElement | null>(null)
const fullscreen = ref(false)
const copied = ref(false)
let editor: monaco.editor.IStandaloneCodeEditor | null = null
let resizeObserver: ResizeObserver | null = null
let widgets: monaco.editor.IContentWidget[] = []
let widgetInputs = new Map<string, HTMLTextAreaElement>()
let widgetLines = new Map<string, number>()
let blankLineZoneIds = new Map<number, string>()
let annotationDecorations: monaco.editor.IEditorDecorationsCollection | null = null
let selectionAction: monaco.editor.IContentWidget | null = null
let pendingSelection: CodeAnnotationAnchor | null = null
let annotationCard: monaco.editor.IContentWidget | null = null
let editorDisposables: monaco.IDisposable[] = []

const resultMap = computed(() => new Map(props.results?.map((item) => [item.blankKey, item])))

const BRACKET_PAIRS: Record<string, string> = { '(': ')', '[': ']', '{': '}', '"': '"', "'": "'" }
const CLOSING_CHARS = new Set([')', ']', '}'])
let measureContext: CanvasRenderingContext2D | null = null

function measureTextWidth(text: string, font: string): number {
  measureContext ??= document.createElement('canvas').getContext('2d')
  if (!measureContext) return text.length * 9
  measureContext.font = font
  return measureContext.measureText(text).width
}

function fitInputWidth(input: HTMLTextAreaElement): void {
  const text = input.value.length > 0 ? input.value : input.placeholder
  const font = getComputedStyle(input).font || '12px monospace'
  const editorWidth = editorRef.value?.clientWidth ?? 600
  const maxWidth = Math.max(260, editorWidth - 160)
  const widestLine = text.split('\n').reduce((widest, line) => Math.max(widest, measureTextWidth(line, font)), 0)
  input.style.width = `${Math.min(Math.max(90, Math.ceil(widestLine) + 30), maxWidth)}px`
}

function syncInput(key: string, input: HTMLTextAreaElement): void {
  fitInputWidth(input)
  updateBlankLineZones()
  emit('update:answers', { ...props.answers, [key]: input.value })
}

function handleBlankKeydown(event: KeyboardEvent, key: string, input: HTMLTextAreaElement): void {
  // 保留 Ctrl/Cmd+Enter 提交快捷键，其余按键留在当前空位内处理。
  if (!((event.ctrlKey || event.metaKey) && event.key === 'Enter')) event.stopPropagation()
  const { selectionStart, selectionEnd, value } = input
  if (selectionStart === null || selectionEnd === null) return
  const collapsed = selectionStart === selectionEnd

  if (event.key === 'Backspace' && collapsed && selectionStart > 0) {
    const previous = value[selectionStart - 1] ?? ''
    if (BRACKET_PAIRS[previous] && value[selectionStart] === BRACKET_PAIRS[previous]) {
      event.preventDefault()
      input.setRangeText('', selectionStart - 1, selectionStart + 1, 'start')
      syncInput(key, input)
    }
    return
  }
  if (collapsed && (CLOSING_CHARS.has(event.key) || event.key === '"' || event.key === "'")
      && value[selectionStart] === event.key) {
    event.preventDefault()
    input.setSelectionRange(selectionStart + 1, selectionStart + 1)
    return
  }
  const closing = BRACKET_PAIRS[event.key]
  if (closing) {
    event.preventDefault()
    const selected = value.slice(selectionStart, selectionEnd)
    input.setRangeText(event.key + selected + closing, selectionStart, selectionEnd, 'start')
    input.setSelectionRange(selectionStart + 1, selectionStart + 1 + selected.length)
    syncInput(key, input)
  }
}

onMounted(() => {
  if (!editorRef.value) return
  updateEditorTheme()
  editor = monaco.editor.create(editorRef.value, {
    language: 'java',
    readOnly: true,
    domReadOnly: true,
    theme: 'leetRecall',
    fontFamily: '"JetBrains Mono", "Cascadia Code", Consolas, monospace',
    fontLigatures: false,
    fontSize: codeFontSize.value,
    lineHeight: codeFontSize.value + 10,
    minimap: { enabled: false },
    lineNumbersMinChars: 3,
    padding: { top: 16, bottom: 16 },
    scrollBeyondLastLine: false,
    automaticLayout: false,
    tabSize: 4,
    insertSpaces: true,
    wordWrap: 'off',
    quickSuggestions: false,
    suggestOnTriggerCharacters: false,
    wordBasedSuggestions: 'off',
    parameterHints: { enabled: false },
    hover: { enabled: false },
    codeLens: false,
    lightbulb: { enabled: monaco.editor.ShowLightbulbIconMode.Off },
    glyphMargin: Boolean(props.answerCode),
    showFoldingControls: 'never',
    overviewRulerBorder: false,
    hideCursorInOverviewRuler: true,
    scrollbar: { verticalScrollbarSize: 10, horizontalScrollbarSize: 10 },
  })
  renderModel()
  editorDisposables = [
    editor.onDidChangeCursorSelection(() => updateSelectionAction()),
    editor.onMouseDown((event) => {
      const target = event.target
      if (target.type !== monaco.editor.MouseTargetType.GUTTER_GLYPH_MARGIN) return
      const className = target.element?.className ?? ''
      const match = className.match(/code-annotation-glyph-(\d+)/)
      const annotationId = Number(match?.[1])
      if (Number.isInteger(annotationId) && annotationId > 0) {
        emit('select-annotation', annotationId)
        showAnnotationCard(annotationId)
      }
    }),
  ]
  resizeObserver = new ResizeObserver(() => editor?.layout())
  resizeObserver.observe(editorRef.value)
  document.addEventListener('fullscreenchange', handleFullscreenChange)
  document.addEventListener('leet-recall:theme-change', updateEditorTheme)
})

function updateEditorTheme(): void {
  const styles = getComputedStyle(document.documentElement)
  monaco.editor.defineTheme('leetRecall', {
    base: document.documentElement.dataset.theme === 'light' ? 'vs' : 'vs-dark',
    inherit: true,
    rules: [
      { token: 'keyword', foreground: document.documentElement.dataset.theme === 'light' ? '7C3AED' : 'C084FC' },
      { token: 'type.identifier', foreground: document.documentElement.dataset.theme === 'light' ? '0F766E' : '5EEAD4' },
      { token: 'identifier', foreground: styles.getPropertyValue('--code-text').trim() },
      { token: 'number', foreground: document.documentElement.dataset.theme === 'light' ? 'B45309' : 'F59E0B' },
    ],
    colors: {
      'editor.background': styles.getPropertyValue('--code-surface').trim(),
      'editor.foreground': styles.getPropertyValue('--code-text').trim(),
      'editorLineNumber.foreground': '#728096',
      'editorLineNumber.activeForeground': '#465062',
      'editor.lineHighlightBackground': styles.getPropertyValue('--code-surface-raised').trim(),
      'editorCursor.foreground': styles.getPropertyValue('--primary').trim(),
      'editor.selectionBackground': '#d9e1eb',
      'editorIndentGuide.background1': styles.getPropertyValue('--border-primary').trim(),
    },
  })
  monaco.editor.setTheme('leetRecall')
}

onBeforeUnmount(() => {
  disposeWidgets()
  editorDisposables.forEach((disposable) => disposable.dispose())
  editorDisposables = []
  resizeObserver?.disconnect()
  editor?.dispose()
  document.removeEventListener('fullscreenchange', handleFullscreenChange)
  document.removeEventListener('leet-recall:theme-change', updateEditorTheme)
})

watch(() => [props.templateCode, props.answerCode], () => {
  if (editor) renderModel()
})

watch(() => props.annotations, () => {
  if (editor && props.answerCode) applyAnnotationDecorations()
}, { deep: true })

watch(() => props.activeAnnotationId, (annotationId) => {
  if (annotationId) showAnnotationCard(annotationId)
  else removeAnnotationCard()
})

watch(() => props.answers, (answers) => {
  for (const [key, input] of widgetInputs) {
    if (input.value !== (answers[key] ?? '')) {
      input.value = answers[key] ?? ''
      fitInputWidth(input)
    }
  }
  updateBlankLineZones()
}, { deep: true })

watch(resultMap, applyResultStyles)

function renderModel(): void {
  if (!editor) return
  const focused = document.activeElement
  if (props.answerCode && focused instanceof HTMLElement && editorRef.value?.contains(focused)) {
    focused.blur()
  }
  disposeWidgets()
  annotationDecorations?.clear()
  annotationDecorations = null
  removeSelectionAction()
  removeAnnotationCard()
  if (props.answerCode) {
    editor.setValue(props.answerCode)
    editor.updateOptions({ readOnly: true, glyphMargin: true })
    applyAnnotationDecorations()
    return
  }
  editor.updateOptions({ readOnly: true, glyphMargin: false })
  const templateCode = stripJavaComments(props.templateCode)
  const tokenRegex = /{{(blank_\d+)}}/g
  const placeholders: Array<{ key: string; offset: number }> = []
  let output = ''
  let lastIndex = 0
  for (const match of templateCode.matchAll(tokenRegex)) {
    if (match.index === undefined) continue
    output += templateCode.slice(lastIndex, match.index)
    const offset = output.length
    output += '              '
    placeholders.push({ key: match[1] ?? '', offset })
    lastIndex = match.index + match[0].length
  }
  output += templateCode.slice(lastIndex)
  editor.setValue(output)
  const model = editor.getModel()
  if (!model) return
  for (const placeholder of placeholders) {
    const position = model.getPositionAt(placeholder.offset)
    const widget = createWidget(placeholder.key, position)
    widgets.push(widget)
    editor.addContentWidget(widget)
  }
  nextTick(() => {
    applyResultStyles()
    for (const input of widgetInputs.values()) fitInputWidth(input)
    updateBlankLineZones()
  })
}

function updateBlankLineZones(): void {
  if (!editor) return
  const lineHeight = editor.getOption(monaco.editor.EditorOption.lineHeight)
  const extraLinesByLine = new Map<number, number>()
  for (const [key, input] of widgetInputs) {
    const line = widgetLines.get(key)
    if (line === undefined) continue
    const extraLines = Math.max(0, input.value.split('\n').length - 1)
    extraLinesByLine.set(line, Math.max(extraLinesByLine.get(line) ?? 0, extraLines))
    input.style.height = `${(extraLines + 1) * lineHeight}px`
  }
  editor.changeViewZones((accessor) => {
    for (const id of blankLineZoneIds.values()) accessor.removeZone(id)
    blankLineZoneIds = new Map()
    for (const [line, extraLines] of extraLinesByLine) {
      if (extraLines === 0) continue
      const id = accessor.addZone({
        afterLineNumber: line,
        heightInPx: extraLines * lineHeight,
        domNode: document.createElement('div'),
      })
      blankLineZoneIds.set(line, id)
    }
  })
}

function applyAnnotationDecorations(): void {
  if (!editor || !props.answerCode) return
  const model = editor.getModel()
  if (!model) return
  const decorations: monaco.editor.IModelDeltaDecoration[] = []
  for (const annotation of props.annotations ?? []) {
    if (!annotation.resolved) continue
    const range = new monaco.Range(
      annotation.startLine,
      annotation.startColumn,
      annotation.endLine,
      annotation.endColumn,
    )
    decorations.push({
      range,
      options: {
        inlineClassName: 'code-annotation-range',
        glyphMarginClassName: `code-annotation-glyph code-annotation-glyph-${annotation.id}`,
        glyphMarginHoverMessage: { value: annotation.label || '代码批注' },
        hoverMessage: { value: annotation.label || '代码批注' },
      },
    })
  }
  annotationDecorations ??= editor.createDecorationsCollection()
  annotationDecorations.set(decorations)
}

function removeSelectionAction(): void {
  if (editor && selectionAction) editor.removeContentWidget(selectionAction)
  selectionAction = null
  pendingSelection = null
}

function removeAnnotationCard(): void {
  if (editor && annotationCard) editor.removeContentWidget(annotationCard)
  annotationCard = null
}

function showAnnotationCard(annotationId: number): void {
  if (!editor || !props.answerCode) return
  const annotation = (props.annotations ?? []).find((item) => item.id === annotationId && item.resolved)
  if (!annotation) return
  removeAnnotationCard()
  const node = document.createElement('aside')
  node.className = 'annotation-floating-card'
  const title = document.createElement('strong')
  title.textContent = annotation.label || '未命名批注'
  const code = document.createElement('code')
  code.textContent = annotation.anchorText
  const body = document.createElement('div')
  body.className = 'annotation-floating-content'
  body.innerHTML = renderMarkdown(annotation.contentMarkdown)
  node.append(title, code, body)
  annotationCard = {
    getId: () => 'code-annotation-floating-card',
    getDomNode: () => node,
    getPosition: () => ({
      position: new monaco.Position(annotation.startLine, annotation.endColumn),
      preference: [monaco.editor.ContentWidgetPositionPreference.BELOW],
    }),
  }
  editor.addContentWidget(annotationCard)
}

function updateSelectionAction(): void {
  if (!editor || !props.answerCode) {
    removeSelectionAction()
    return
  }
  const selection = editor.getSelection()
  const model = editor.getModel()
  if (!selection || selection.isEmpty() || !model) {
    removeSelectionAction()
    return
  }
  const selectedText = model.getValueInRange(selection)
  if (!selectedText.trim() || selectedText.length > 500) {
    removeSelectionAction()
    return
  }
  removeSelectionAction()
  const occurrenceIndex = countOccurrences(model.getValue(), selectedText, model.getOffsetAt(selection.getStartPosition()))
  pendingSelection = {
    anchorText: selectedText,
    occurrenceIndex,
    startLine: selection.startLineNumber,
    startColumn: selection.startColumn,
    endLine: selection.endLineNumber,
    endColumn: selection.endColumn,
  }
  const node = document.createElement('button')
  node.type = 'button'
  node.className = 'annotation-selection-action'
  node.textContent = '＋批注'
  node.addEventListener('mousedown', (event) => event.preventDefault())
  node.addEventListener('click', () => {
    if (pendingSelection) emit('create-annotation', pendingSelection)
    removeSelectionAction()
  })
  selectionAction = {
    getId: () => 'code-annotation-selection-action',
    getDomNode: () => node,
    getPosition: () => ({
      position: selection.getEndPosition(),
      preference: [monaco.editor.ContentWidgetPositionPreference.BELOW],
    }),
  }
  editor.addContentWidget(selectionAction)
}

function countOccurrences(code: string, text: string, offset: number): number {
  let occurrenceIndex = 0
  let from = 0
  while (true) {
    const found = code.indexOf(text, from)
    if (found < 0 || found >= offset) return occurrenceIndex
    occurrenceIndex += 1
    from = found + Math.max(text.length, 1)
  }
}

function createWidget(key: string, position: monaco.Position): monaco.editor.IContentWidget {
  const node = document.createElement('div')
  node.className = 'dictation-blank-widget'
  const input = document.createElement('textarea')
  input.rows = 1
  input.value = props.answers[key] ?? ''
  input.placeholder = key.replace('blank_', '空位 ')
  input.setAttribute('aria-label', `${key} 默写空位`)
  input.spellcheck = false
  input.addEventListener('input', () => syncInput(key, input))
  input.addEventListener('keydown', (event) => handleBlankKeydown(event, key, input))
  node.append(input)
  widgetInputs.set(key, input)
  widgetLines.set(key, position.lineNumber)
  return {
    getId: () => `blank-widget-${key}`,
    getDomNode: () => node,
    getPosition: () => ({
      position,
      preference: [monaco.editor.ContentWidgetPositionPreference.EXACT],
    }),
  }
}

function disposeWidgets(): void {
  if (editor) widgets.forEach((widget) => editor?.removeContentWidget(widget))
  widgets = []
  widgetInputs = new Map()
  widgetLines = new Map()
  if (editor && blankLineZoneIds.size > 0) {
    editor.changeViewZones((accessor) => {
      for (const id of blankLineZoneIds.values()) accessor.removeZone(id)
    })
  }
  blankLineZoneIds = new Map()
}

function applyResultStyles(): void {
  for (const [key, input] of widgetInputs) {
    input.classList.remove('is-correct', 'is-incorrect')
    const result = resultMap.value.get(key)
    if (result) input.classList.add(result.correct ? 'is-correct' : 'is-incorrect')
  }
}

// 设置页与工具条共用同一份代码字号，任一处改动都会同步到 Monaco 与空位输入框。
function changeFontSize(delta: number): void {
  stepCodeFontSize(delta)
}

watch(codeFontSize, (size) => {
  editor?.updateOptions({ fontSize: size, lineHeight: size + 10 })
  for (const input of widgetInputs.values()) fitInputWidth(input)
  updateBlankLineZones()
})

async function copyCode(): Promise<void> {
  await navigator.clipboard.writeText(editor?.getValue() ?? '')
  copied.value = true
  setTimeout(() => { copied.value = false }, 1200)
}

async function toggleFullscreen(): Promise<void> {
  if (!shellRef.value) return
  if (document.fullscreenElement) await document.exitFullscreen()
  else await shellRef.value.requestFullscreen()
}

function handleFullscreenChange(): void {
  fullscreen.value = document.fullscreenElement === shellRef.value
  nextTick(() => editor?.layout())
}
</script>

<template>
  <section ref="shellRef" class="editor-shell" :class="{ fullscreen }">
    <header class="editor-toolbar">
      <span class="language">Java</span>
      <div class="toolbar-actions">
        <span v-if="copied" class="copied">已复制</span>
        <button type="button" aria-label="缩小代码字号" @click="changeFontSize(-1)"><Minus :size="15" /></button>
        <span class="font-size">{{ codeFontSize }}</span>
        <button type="button" aria-label="增大代码字号" @click="changeFontSize(1)"><Plus :size="15" /></button>
        <button type="button" aria-label="复制代码" @click="copyCode"><Copy :size="16" /></button>
        <button type="button" aria-label="全屏编辑器" @click="toggleFullscreen"><Maximize2 :size="16" /></button>
      </div>
    </header>
    <div ref="editorRef" class="editor" />
  </section>
</template>

<style scoped>
.editor-shell {
  display: flex;
  min-height: 0;
  flex-direction: column;
  overflow: hidden;
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  background: var(--code-surface);
  box-shadow: none;
}
.editor-shell:fullscreen { width: var(--viewport-width); height: var(--viewport-height); border: 0; border-radius: 0; }
.editor-shell:fullscreen .editor { height: calc(var(--viewport-height) - 48px); }
.editor-toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 46px;
  padding: 0 12px 0 15px;
  border-bottom: 1px solid var(--border-secondary);
  background: var(--code-surface-raised);
  box-shadow: none;
}
.language { color: var(--text-secondary); font-size: calc(13px * var(--ui-font-ratio)); font-weight: 560; }
.toolbar-actions { display: flex; align-items: center; gap: 4px; }
.toolbar-actions button {
  display: grid;
  width: 30px;
  height: 30px;
  color: var(--text-muted);
  border: 0;
  border-radius: 6px;
  place-items: center;
  background: transparent;
}
.toolbar-actions button:hover { color: var(--text-primary); background: var(--bg-card-hover); }
.font-size, .copied { color: var(--text-muted); font-size: calc(11px * var(--ui-font-ratio)); }
.copied { margin-right: 5px; color: var(--success); }
/* 高度交给父容器（默写页右栏）撑满，Monaco 已挂 ResizeObserver，会自动 layout()。 */
.editor { min-height: 0; flex: 1; }
:deep(.dictation-blank-widget) {
  transform: translateY(-2px);
}
:deep(.code-annotation-range) {
  text-decoration: underline wavy var(--primary) 1.5px;
  text-decoration-skip-ink: none;
}
:deep(.code-annotation-glyph) {
  width: 12px !important;
  background: var(--primary);
  border-radius: 50%;
  transform: scale(.58);
}
:deep(.annotation-floating-card) {
  display: grid;
  width: min(360px, calc(100vw - 48px));
  max-height: 280px;
  gap: 7px;
  padding: 12px;
  overflow: auto;
  color: var(--text-primary);
  font-size: calc(12px * var(--ui-font-ratio));
  border: 1px solid var(--primary);
  border-radius: 7px;
  background: var(--bg-card);
  box-shadow: 0 8px 24px rgba(0, 0, 0, .3);
}
:deep(.annotation-floating-card code) {
  padding: 5px 7px;
  overflow: hidden;
  color: var(--text-muted);
  font-family: "JetBrains Mono", Consolas, monospace;
  font-size: var(--code-font-size);
  line-height: 1.5;
  text-overflow: ellipsis;
  white-space: nowrap;
  border-radius: 4px;
  background: var(--code-surface);
}
:deep(.annotation-floating-content) { color: var(--text-secondary); line-height: 1.65; }
:deep(.annotation-floating-content > :first-child) { margin-top: 0; }
:deep(.annotation-floating-content > :last-child) { margin-bottom: 0; }
:deep(.annotation-floating-content pre) { max-height: 130px; overflow: auto; }
:deep(.annotation-selection-action) {
  padding: 4px 8px;
  color: var(--text-primary);
  font-size: calc(11px * var(--ui-font-ratio));
  border: 1px solid var(--primary);
  border-radius: 5px;
  background: var(--bg-card);
  box-shadow: 0 4px 12px rgba(0, 0, 0, .28);
}
:deep(.dictation-blank-widget textarea) {
  display: block;
  box-sizing: border-box;
  width: 112px;
  height: calc(var(--code-font-size) + 9px);
  padding: 0 7px;
  overflow: hidden;
  color: var(--text-primary);
  font-family: "JetBrains Mono", "Cascadia Code", Consolas, monospace;
  font-size: var(--code-font-size);
  font-variant-ligatures: none;
  font-feature-settings: "liga" 0, "calt" 0;
  line-height: calc(var(--code-font-size) + 9px);
  white-space: pre;
  resize: none;
  border: 1px solid var(--primary);
  border-radius: 4px;
  outline: none;
  background: var(--primary-soft);
  box-shadow: 0 0 0 2px rgba(255, 161, 22, 0.08);
}
:deep(.dictation-blank-widget textarea:focus) { border-color: var(--primary-hover); background: var(--primary-soft); }
:deep(.dictation-blank-widget textarea.is-correct) { color: var(--success-strong); border-color: var(--success); background: rgba(34, 197, 94, 0.16); }
:deep(.dictation-blank-widget textarea.is-incorrect) { color: var(--danger-strong); border-color: var(--danger); background: var(--danger-soft); }
@media (max-width: 720px) {
  .editor-toolbar { padding-inline: 8px; }
  .toolbar-actions { gap: 2px; }
  .toolbar-actions button { width: 44px; height: 44px; }
}
</style>
