<script setup lang="ts">
import { computed, onBeforeUnmount, ref, watch } from 'vue'
import {
  AlertCircle,
  Check,
  Eye,
  FilePenLine,
  LoaderCircle,
  NotebookPen,
  Save,
} from 'lucide-vue-next'
import { problemNoteApi } from '@/api/problemNote'
import MarkdownContent from '@/components/common/MarkdownContent.vue'

type NoteMode = 'edit' | 'preview'
type SaveState = 'loading' | 'load-error' | 'idle' | 'dirty' | 'saving' | 'saved' | 'error'

const props = defineProps<{ problemId: number }>()

const markdown = ref('')
const mode = ref<NoteMode>('edit')
const saveState = ref<SaveState>('loading')
const errorMessage = ref('')
const updatedAt = ref<string | null>(null)

const hasContent = computed(() => markdown.value.trim().length > 0)
const canSave = computed(() => saveState.value === 'dirty' || saveState.value === 'error')
const statusText = computed(() => {
  switch (saveState.value) {
    case 'loading': return '正在读取笔记'
    case 'load-error': return '读取失败'
    case 'dirty': return '尚未保存'
    case 'saving': return '正在保存'
    case 'saved': return '已保存'
    case 'error': return '保存失败'
    default: return updatedAt.value ? '已同步' : '新笔记'
  }
})

let debounceTimer: ReturnType<typeof setTimeout> | undefined
let editVersion = 0
let loadVersion = 0
let hydrating = false
let saveQueue: Promise<void> = Promise.resolve()

function clearDebounce(): void {
  if (debounceTimer !== undefined) {
    clearTimeout(debounceTimer)
    debounceTimer = undefined
  }
}

function replaceMarkdown(value: string): void {
  hydrating = true
  markdown.value = value
  hydrating = false
}

async function loadNote(problemId: number): Promise<void> {
  const version = ++loadVersion
  clearDebounce()
  editVersion = 0
  replaceMarkdown('')
  errorMessage.value = ''
  updatedAt.value = null
  saveState.value = 'loading'
  try {
    const note = await problemNoteApi.get(problemId)
    if (version !== loadVersion || problemId !== props.problemId) return
    replaceMarkdown(note.markdown)
    updatedAt.value = note.updatedAt ?? null
    mode.value = note.markdown.trim() ? 'preview' : 'edit'
    saveState.value = 'idle'
  } catch (cause) {
    if (version !== loadVersion || problemId !== props.problemId) return
    errorMessage.value = cause instanceof Error ? cause.message : '笔记读取失败，请重试'
    saveState.value = 'load-error'
  }
}

function enqueueSave(
  problemId: number,
  content: string,
  version: number,
  reflectState: boolean,
): Promise<void> {
  clearDebounce()
  if (reflectState && problemId === props.problemId) {
    saveState.value = 'saving'
    errorMessage.value = ''
  }

  const request = saveQueue
    .catch(() => undefined)
    .then(async () => {
      const note = await problemNoteApi.save(problemId, content)
      if (reflectState && problemId === props.problemId && version === editVersion) {
        updatedAt.value = note.updatedAt ?? null
        saveState.value = 'saved'
      }
    })

  saveQueue = request
  request.catch((cause: unknown) => {
    if (reflectState && problemId === props.problemId && version === editVersion) {
      errorMessage.value = cause instanceof Error ? cause.message : '保存失败，请重试'
      saveState.value = 'error'
    }
  })
  return request
}

function saveNow(): void {
  if (saveState.value === 'loading' || saveState.value === 'saving') return
  void enqueueSave(props.problemId, markdown.value, editVersion, true)
}

function scheduleSave(): void {
  clearDebounce()
  debounceTimer = setTimeout(saveNow, 900)
}

function switchMode(nextMode: NoteMode): void {
  mode.value = nextMode
}

watch(markdown, () => {
  if (hydrating || saveState.value === 'loading') return
  editVersion += 1
  saveState.value = 'dirty'
  errorMessage.value = ''
  scheduleSave()
}, { flush: 'sync' })

watch(() => props.problemId, (nextProblemId, previousProblemId) => {
  if (previousProblemId !== undefined && canSave.value) {
    void enqueueSave(previousProblemId, markdown.value, editVersion, false)
  }
  void loadNote(nextProblemId)
}, { immediate: true })

onBeforeUnmount(() => {
  if (canSave.value) {
    void enqueueSave(props.problemId, markdown.value, editVersion, false)
  } else {
    clearDebounce()
  }
})
</script>

<template>
  <section class="note-panel" :aria-busy="saveState === 'loading'">
    <header class="note-header">
      <div class="note-heading">
        <span class="note-icon" aria-hidden="true"><NotebookPen :size="18" /></span>
        <div>
          <div class="note-title-line">
            <h2>解题笔记</h2>
            <span class="markdown-badge">Markdown</span>
          </div>
          <p>记录自己的解题思路、易错点和复杂度。</p>
        </div>
      </div>

      <div class="note-actions">
        <div class="mode-tabs" role="tablist" aria-label="笔记显示方式">
          <button
            type="button"
            role="tab"
            :aria-selected="mode === 'edit'"
            :class="{ active: mode === 'edit' }"
            @click="switchMode('edit')"
          >
            <FilePenLine :size="14" /> 编辑
          </button>
          <button
            type="button"
            role="tab"
            :aria-selected="mode === 'preview'"
            :class="{ active: mode === 'preview' }"
            @click="switchMode('preview')"
          >
            <Eye :size="14" /> 预览
          </button>
        </div>
        <button
          class="save-button"
          type="button"
          :disabled="!canSave || saveState === 'saving'"
          @click="saveNow"
        >
          <LoaderCircle v-if="saveState === 'saving'" class="spin" :size="14" />
          <Save v-else :size="14" />
          保存
        </button>
      </div>
    </header>

    <div id="problem-note-content">
      <div v-if="saveState === 'loading'" class="note-loading">
        <LoaderCircle class="spin" :size="18" /> 正在读取这道题的笔记…
      </div>


      <div v-else-if="saveState === 'load-error'" class="note-load-error" role="alert">
        <AlertCircle :size="20" />
        <div>
          <strong>笔记读取失败</strong>
          <span>{{ errorMessage }}</span>
        </div>
        <button type="button" class="retry-button" @click="loadNote(problemId)">重新读取</button>
      </div>

      <template v-else>
        <div v-if="mode === 'edit'" class="editor-shell" role="tabpanel">
          <label class="screen-reader-only" :for="`problem-note-${problemId}`">Markdown 笔记</label>
          <textarea
            :id="`problem-note-${problemId}`"
            v-model="markdown"
            maxlength="100000"
            spellcheck="false"
            placeholder="## 解题思路\n\n- 核心关键点\n- 容易写错的边界\n\n```java\n// 关键代码\n```"
            @keydown.ctrl.s.prevent="saveNow"
            @keydown.meta.s.prevent="saveNow"
          ></textarea>
          <footer class="editor-footer">
            <span>支持标题、列表、引用、表格、链接和代码块；Ctrl + S 可立即保存</span>
            <span>{{ markdown.length.toLocaleString() }} / 100,000</span>
          </footer>
        </div>

        <div v-else class="preview-shell" role="tabpanel">
          <MarkdownContent v-if="hasContent" :markdown="markdown" />
          <button v-else class="note-empty" type="button" @click="switchMode('edit')">
            <NotebookPen :size="24" />
            <strong>还没有笔记</strong>
            <span>点击这里，用 Markdown 记录这道题的关键理解。</span>
          </button>
        </div>

        <footer class="save-status">
          <span
            :class="['status-pill', `status-${saveState}`]"
            :role="saveState === 'error' ? 'alert' : 'status'"
            aria-live="polite"
          >
            <AlertCircle v-if="saveState === 'error'" :size="13" />
            <LoaderCircle v-else-if="saveState === 'saving'" class="spin" :size="13" />
            <Check v-else-if="saveState === 'saved' || saveState === 'idle'" :size="13" />
            {{ statusText }}
          </span>
          <button v-if="saveState === 'error'" type="button" class="retry-button" @click="saveNow">
            重试
          </button>
          <span v-if="errorMessage" class="error-message">{{ errorMessage }}</span>
        </footer>
      </template>
    </div>
  </section>
</template>

<style scoped>
.note-panel {
  margin-top: 0;
  overflow: hidden;
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  background: var(--bg-card);
}

.note-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  min-height: 66px;
  padding: 12px 14px;
  gap: 20px;
  border-bottom: 1px solid var(--border-secondary);
  background: var(--border-highlight);
}

.note-heading,
.note-title-line,
.note-actions,
.mode-tabs,
.save-button,
.save-status,
.status-pill,
.note-empty,
.note-loading {
  display: flex;
  align-items: center;
}
.note-load-error {
  display: flex;
  align-items: center;
  min-height: 110px;
  padding: 18px;
  gap: 11px;
  color: var(--danger-strong);
  background: var(--bg-input);
}
.note-load-error div { display: grid; min-width: 0; gap: 3px; }
.note-load-error strong { color: var(--danger-strong); font-size: 12px; }
.note-load-error span { color: var(--text-muted); font-size: 10px; }
.note-load-error .retry-button { margin-left: auto; flex: 0 0 auto; }

.note-heading { min-width: 0; gap: 11px; }
.note-icon {
  display: grid;
  flex: 0 0 34px;
  width: 34px;
  height: 34px;
  color: var(--primary);
  place-items: center;
  border: 1px solid rgba(255, 161, 22, 0.2);
  border-radius: 7px;
  background: var(--primary-soft);
}
.note-title-line { gap: 8px; }
h2 { margin: 0; color: var(--text-primary); font-size: 14px; font-weight: 680; }
.note-heading p { margin: 3px 0 0; color: var(--text-muted); font-size: 11px; }
.markdown-badge {
  padding: 2px 6px;
  color: var(--primary-hover);
  font-family: "JetBrains Mono", "Cascadia Code", Consolas, monospace;
  font-size: 9px;
  border: 1px solid rgba(255, 161, 22, 0.23);
  border-radius: 4px;
  background: rgba(255, 161, 22, 0.07);
}

.note-actions { flex: 0 0 auto; gap: 9px; }
.mode-tabs {
  padding: 3px;
  gap: 2px;
  border: 1px solid var(--border-secondary);
  border-radius: 7px;
  background: var(--bg-input);
}
.mode-tabs button,
.save-button,
.retry-button {
  border: 0;
  border-radius: 5px;
}
.mode-tabs button {
  display: flex;
  align-items: center;
  min-height: 30px;
  padding: 0 10px;
  gap: 6px;
  color: var(--text-muted);
  font-size: 11px;
  background: transparent;
}
.mode-tabs button:hover { color: var(--text-primary); }
.mode-tabs button.active { color: var(--text-primary); background: var(--surface-overlay); }
.save-button {
  justify-content: center;
  min-width: 72px;
  min-height: 38px;
  padding: 0 12px;
  gap: 6px;
  color: var(--on-primary);
  font-size: 11px;
  font-weight: 700;
  background: var(--primary);
}
.save-button:hover:not(:disabled) { background: var(--primary-hover); }
.save-button:disabled { color: var(--disabled-text); background: var(--disabled-surface); opacity: 0.78; }

.editor-shell { background: var(--bg-input); }
textarea {
  display: block;
  width: 100%;
  min-height: 290px;
  padding: 18px;
  resize: vertical;
  color: var(--text-primary);
  font-family: "JetBrains Mono", "Cascadia Code", Consolas, monospace;
  font-size: 13px;
  line-height: 1.75;
  border: 0;
  outline: 0;
  background: transparent;
}
textarea::placeholder { color: var(--placeholder); }
textarea:focus { box-shadow: inset 0 0 0 1px var(--primary) !important; }
.editor-footer {
  display: flex;
  justify-content: space-between;
  padding: 8px 13px;
  gap: 18px;
  color: var(--text-muted);
  font-size: 10px;
  border-top: 1px solid var(--border-secondary);
  background: var(--code-surface-raised);
}

.preview-shell {
  min-height: 220px;
  padding: 18px;
  background: var(--bg-input);
}
.note-empty {
  flex-direction: column;
  justify-content: center;
  width: 100%;
  min-height: 184px;
  gap: 7px;
  color: var(--text-muted);
  border: 1px dashed var(--border-primary);
  border-radius: 7px;
  background: var(--border-highlight);
}
.note-empty:hover { color: var(--text-secondary); border-color: rgba(255, 161, 22, 0.42); }
.note-empty svg { color: var(--primary); }
.note-empty strong { color: var(--text-secondary); font-size: 13px; }
.note-empty span { font-size: 11px; }

.note-loading {
  justify-content: center;
  min-height: 160px;
  gap: 8px;
  color: var(--text-muted);
  font-size: 12px;
  background: var(--bg-input);
}
.save-status {
  min-height: 38px;
  padding: 0 13px;
  gap: 9px;
  border-top: 1px solid var(--border-secondary);
  background: var(--code-surface-raised);
}
.status-pill { gap: 5px; color: var(--text-muted); font-size: 10px; }
.status-saved,
.status-idle { color: var(--success-strong); }
.status-dirty { color: var(--warning-strong); }
.status-error,
.status-load-error,
.error-message { color: var(--danger-strong); }
.retry-button {
  min-height: 26px;
  padding: 0 8px;
  color: var(--danger-strong);
  font-size: 10px;
  background: rgba(255, 55, 95, 0.1);
}
.error-message { min-width: 0; overflow: hidden; font-size: 10px; text-overflow: ellipsis; white-space: nowrap; }
.spin { animation: spin 800ms linear infinite; }
@keyframes spin { to { transform: rotate(360deg); } }

@media (max-width: 900px) {
  .note-header { align-items: flex-start; flex-direction: column; }
  .note-actions { width: 100%; justify-content: space-between; }
}
</style>
