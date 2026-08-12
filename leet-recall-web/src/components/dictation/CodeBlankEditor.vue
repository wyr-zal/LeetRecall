<script setup lang="ts">
import { computed, nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import * as monaco from 'monaco-editor/esm/vs/editor/editor.api'
import EditorWorker from 'monaco-editor/esm/vs/editor/editor.worker?worker'
import 'monaco-editor/esm/vs/basic-languages/java/java.contribution'
import { Copy, Maximize2, Minus, Plus } from 'lucide-vue-next'
import type { DictationResultItem } from '@/types/dictation'

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
}>()
const emit = defineEmits<{ 'update:answers': [answers: Record<string, string>] }>()

const shellRef = ref<HTMLElement | null>(null)
const editorRef = ref<HTMLElement | null>(null)
const fontSize = ref(14)
const fullscreen = ref(false)
const copied = ref(false)
let editor: monaco.editor.IStandaloneCodeEditor | null = null
let resizeObserver: ResizeObserver | null = null
let widgets: monaco.editor.IContentWidget[] = []
let widgetInputs = new Map<string, HTMLInputElement>()

const resultMap = computed(() => new Map(props.results?.map((item) => [item.blankKey, item])))

onMounted(() => {
  if (!editorRef.value) return
  monaco.editor.defineTheme('leetRecallDark', {
    base: 'vs-dark',
    inherit: true,
    rules: [
      { token: 'keyword', foreground: 'C084FC' },
      { token: 'type.identifier', foreground: '5EEAD4' },
      { token: 'identifier', foreground: 'D8DEE9' },
      { token: 'number', foreground: 'F59E0B' },
    ],
    colors: {
      'editor.background': '#1e1e1e',
      'editor.foreground': '#d8dee9',
      'editorLineNumber.foreground': '#465062',
      'editorLineNumber.activeForeground': '#8490a2',
      'editor.lineHighlightBackground': '#252526',
      'editorCursor.foreground': '#ffa116',
      'editor.selectionBackground': '#4a3a20',
      'editorIndentGuide.background1': '#333333',
    },
  })
  editor = monaco.editor.create(editorRef.value, {
    language: 'java',
    theme: 'leetRecallDark',
    fontFamily: '"JetBrains Mono", "Cascadia Code", Consolas, monospace',
    fontSize: fontSize.value,
    lineHeight: 24,
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
    folding: false,
    renderLineHighlight: 'line',
    overviewRulerBorder: false,
    hideCursorInOverviewRuler: true,
    scrollbar: { verticalScrollbarSize: 10, horizontalScrollbarSize: 10 },
  })
  renderModel()
  resizeObserver = new ResizeObserver(() => editor?.layout())
  resizeObserver.observe(editorRef.value)
  document.addEventListener('fullscreenchange', handleFullscreenChange)
})

onBeforeUnmount(() => {
  disposeWidgets()
  resizeObserver?.disconnect()
  editor?.dispose()
  document.removeEventListener('fullscreenchange', handleFullscreenChange)
})

watch(() => [props.templateCode, props.answerCode], () => {
  if (editor) renderModel()
})

watch(() => props.answers, (answers) => {
  for (const [key, input] of widgetInputs) {
    if (input.value !== (answers[key] ?? '')) input.value = answers[key] ?? ''
  }
}, { deep: true })

watch(resultMap, applyResultStyles)

function renderModel(): void {
  if (!editor) return
  disposeWidgets()
  if (props.answerCode) {
    editor.setValue(props.answerCode)
    editor.updateOptions({ readOnly: true })
    return
  }
  editor.updateOptions({ readOnly: true })
  const tokenRegex = /{{(blank_\d+)}}/g
  const placeholders: Array<{ key: string; offset: number }> = []
  let output = ''
  let lastIndex = 0
  for (const match of props.templateCode.matchAll(tokenRegex)) {
    if (match.index === undefined) continue
    output += props.templateCode.slice(lastIndex, match.index)
    const offset = output.length
    output += '______________'
    placeholders.push({ key: match[1] ?? '', offset })
    lastIndex = match.index + match[0].length
  }
  output += props.templateCode.slice(lastIndex)
  editor.setValue(output)
  const model = editor.getModel()
  if (!model) return
  for (const placeholder of placeholders) {
    const position = model.getPositionAt(placeholder.offset)
    const widget = createWidget(placeholder.key, position)
    widgets.push(widget)
    editor.addContentWidget(widget)
  }
  nextTick(applyResultStyles)
}

function createWidget(key: string, position: monaco.Position): monaco.editor.IContentWidget {
  const node = document.createElement('div')
  node.className = 'dictation-blank-widget'
  const input = document.createElement('input')
  input.type = 'text'
  input.value = props.answers[key] ?? ''
  input.placeholder = key.replace('blank_', '空位 ')
  input.setAttribute('aria-label', `${key} 默写空位`)
  input.autocomplete = 'off'
  input.spellcheck = false
  input.addEventListener('input', () => {
    input.style.width = `${Math.max(90, Math.min(260, input.value.length * 9 + 38))}px`
    emit('update:answers', { ...props.answers, [key]: input.value })
  })
  input.addEventListener('keydown', (event) => event.stopPropagation())
  node.append(input)
  widgetInputs.set(key, input)
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
}

function applyResultStyles(): void {
  for (const [key, input] of widgetInputs) {
    input.classList.remove('is-correct', 'is-incorrect')
    const result = resultMap.value.get(key)
    if (result) input.classList.add(result.correct ? 'is-correct' : 'is-incorrect')
  }
}

function changeFontSize(delta: number): void {
  fontSize.value = Math.min(20, Math.max(12, fontSize.value + delta))
  editor?.updateOptions({ fontSize: fontSize.value, lineHeight: fontSize.value + 10 })
}

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
        <span class="font-size">{{ fontSize }}</span>
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
  overflow: hidden;
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  background: #1e1e1e;
  box-shadow: none;
}
.editor-shell:fullscreen { width: 100vw; height: 100vh; border: 0; border-radius: 0; }
.editor-shell:fullscreen .editor { height: calc(100vh - 48px); }
.editor-toolbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 46px;
  padding: 0 12px 0 15px;
  border-bottom: 1px solid var(--border-secondary);
  background: #252526;
  box-shadow: none;
}
.language { color: var(--text-secondary); font-size: 13px; font-weight: 560; }
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
.font-size, .copied { color: var(--text-muted); font-size: 11px; }
.copied { margin-right: 5px; color: #4ade80; }
.editor { height: 470px; }
:deep(.dictation-blank-widget) {
  transform: translateY(-2px);
}
:deep(.dictation-blank-widget input) {
  width: 112px;
  height: 23px;
  padding: 0 7px;
  color: #eff2f6;
  font: 12px/21px "JetBrains Mono", "Cascadia Code", Consolas, monospace;
  border: 1px solid var(--primary);
  border-radius: 4px;
  outline: none;
  background: #3a2c18;
  box-shadow: 0 0 0 2px rgba(255, 161, 22, 0.08);
}
:deep(.dictation-blank-widget input:focus) { border-color: #ffd08a; background: #46351d; }
:deep(.dictation-blank-widget input.is-correct) { color: #bbf7d0; border-color: var(--success); background: rgba(34, 197, 94, 0.16); }
:deep(.dictation-blank-widget input.is-incorrect) { color: #fecaca; border-color: var(--danger); background: rgba(239, 68, 68, 0.15); }
@media (max-width: 720px) { .editor { height: 420px; } }
</style>
