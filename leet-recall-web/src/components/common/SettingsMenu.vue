<script setup lang="ts">
import { nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { Code2, Minus, Plus, Settings, Trash2, Type } from 'lucide-vue-next'
import ConfirmDialog from '@/components/common/ConfirmDialog.vue'
import { useFontScale } from '@/composables/useFontScale'

const props = defineProps<{ open: boolean }>()
const emit = defineEmits<{ toggle: []; close: [] }>()

const { uiFontSize, codeFontSize, minFontSize, maxFontSize, stepUiFontSize, stepCodeFontSize } = useFontScale()
const menuRef = ref<HTMLElement | null>(null)
const triggerRef = ref<HTMLButtonElement | null>(null)
const panelRef = ref<HTMLElement | null>(null)
const confirmOpen = ref(false)
const cleared = ref(false)

function insideDialog(target: EventTarget | null): boolean {
  return target instanceof Element && target.closest('[role="dialog"], [role="alertdialog"]') !== null
}

/** 嵌套的清除确认框自己消费 Esc，面板不能抢先关闭。 */
function onDocumentKeydown(event: KeyboardEvent): void {
  if (event.key !== 'Escape' || !props.open || confirmOpen.value || insideDialog(event.target)) return
  event.preventDefault()
  emit('close')
  triggerRef.value?.focus({ preventScroll: true })
}

function onClickOutside(event: MouseEvent): void {
  if (!props.open || confirmOpen.value) return
  if (menuRef.value?.contains(event.target as Node)) return
  emit('close')
}

watch(() => props.open, async (open) => {
  if (!open) {
    confirmOpen.value = false
    return
  }
  cleared.value = false
  await nextTick()
  panelRef.value?.querySelector<HTMLElement>('button:not(:disabled)')?.focus({ preventScroll: true })
})

onMounted(() => {
  document.addEventListener('keydown', onDocumentKeydown)
  document.addEventListener('click', onClickOutside)
})

onBeforeUnmount(() => {
  document.removeEventListener('keydown', onDocumentKeydown)
  document.removeEventListener('click', onClickOutside)
})

function clearDrafts(): void {
  for (const key of Object.keys(localStorage)) {
    if (key.startsWith('leet-recall:review-') || key.startsWith('leet-recall:dictation-')) {
      localStorage.removeItem(key)
    }
  }
  confirmOpen.value = false
  cleared.value = true
}
</script>

<template>
  <div ref="menuRef" class="settings-menu">
    <button
      ref="triggerRef"
      class="menu-trigger"
      type="button"
      aria-label="设置"
      title="设置"
      aria-haspopup="true"
      aria-controls="settings-panel"
      :aria-expanded="open"
      @click="emit('toggle')"
    >
      <Settings :size="18" /><span>设置</span>
    </button>
    <div v-if="open" id="settings-panel" ref="panelRef" class="settings-panel" role="group" aria-label="偏好设置">
      <p class="panel-hint">复习进度与默写记录保存在服务器；未提交的输入只保存在本浏览器。</p>
      <div class="setting-row">
        <span class="setting-label"><Type :size="16" />界面文字大小</span>
        <div class="size-control" role="group" aria-label="界面文字大小">
          <button type="button" aria-label="减小界面文字" :disabled="uiFontSize <= minFontSize" @click="stepUiFontSize(-1)"><Minus :size="15" /></button>
          <output class="size-value">{{ uiFontSize }} px</output>
          <button type="button" aria-label="增大界面文字" :disabled="uiFontSize >= maxFontSize" @click="stepUiFontSize(1)"><Plus :size="15" /></button>
        </div>
      </div>
      <div class="setting-row">
        <span class="setting-label"><Code2 :size="16" />代码字号</span>
        <div class="size-control" role="group" aria-label="代码字号">
          <button type="button" aria-label="减小代码字号" :disabled="codeFontSize <= minFontSize" @click="stepCodeFontSize(-1)"><Minus :size="15" /></button>
          <output class="size-value">{{ codeFontSize }} px</output>
          <button type="button" aria-label="增大代码字号" :disabled="codeFontSize >= maxFontSize" @click="stepCodeFontSize(1)"><Plus :size="15" /></button>
        </div>
      </div>
      <p class="panel-hint">{{ minFontSize }}–{{ maxFontSize }}px，只保存在当前浏览器。</p>
      <div class="panel-divider" role="separator" />
      <div class="setting-row">
        <span class="setting-label"><Trash2 :size="16" />清除本地草稿</span>
        <button class="danger" type="button" @click="confirmOpen = true">清除草稿</button>
      </div>
      <p class="panel-hint">只清除本浏览器中未提交的回忆与默写内容，服务器记录不受影响，刷新页面后生效。</p>
      <p v-if="cleared" class="cleared" role="status">本地草稿已清除，刷新页面后生效。</p>
    </div>
    <ConfirmDialog
      :open="open && confirmOpen"
      title="清除本地草稿"
      description="确定清除当前浏览器中所有未提交的回忆与默写内容吗？"
      confirm-label="确认清除"
      @confirm="clearDrafts"
      @cancel="confirmOpen = false"
    />
  </div>
</template>

<style scoped>
.settings-menu {
  position: relative;
  flex: 0 0 auto;
}

/* 外观与顶栏 .tool-button 对齐 */
.menu-trigger {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 34px;
  height: 34px;
  padding: 0 8px;
  gap: 6px;
  color: var(--text-secondary);
  border: 1px solid var(--border-primary);
  border-radius: 7px;
  background: var(--bg-card);
  white-space: nowrap;
}

.menu-trigger:hover {
  color: var(--text-primary);
  background: var(--bg-card-hover);
}

.settings-panel {
  position: absolute;
  top: calc(100% + 8px);
  right: 0;
  z-index: 30;
  display: flex;
  width: 300px;
  max-height: calc(var(--viewport-height) - var(--topbar-height) - 24px);
  flex-direction: column;
  gap: 10px;
  padding: 14px;
  overflow: auto;
  border: 1px solid var(--border-primary);
  border-radius: 10px;
  background: var(--bg-card);
  box-shadow: var(--shadow-high);
  overscroll-behavior: contain;
}

.setting-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 10px;
}

.setting-label {
  display: inline-flex;
  align-items: center;
  gap: 7px;
  color: var(--text-primary);
  font-size: calc(13px * var(--ui-font-ratio));
}

.setting-label svg {
  color: var(--primary);
}

.panel-hint {
  margin: 0;
  color: var(--text-muted);
  font-size: calc(11px * var(--ui-font-ratio));
  line-height: 1.55;
}

.panel-divider {
  height: 1px;
  background: var(--border-secondary);
}

.size-control {
  display: flex;
  align-items: center;
  gap: 5px;
}

.size-control button {
  display: grid;
  width: 30px;
  min-height: 30px;
  padding: 0;
  color: var(--text-secondary);
  border: 1px solid var(--border-primary);
  border-radius: 7px;
  place-items: center;
  background: var(--bg-input);
}

.size-control button:hover:not(:disabled) {
  color: var(--text-primary);
  border-color: var(--border-hover);
}

.size-control button:disabled {
  color: var(--disabled-text);
  border-color: var(--border-secondary);
  background: var(--disabled-surface);
}

.size-value {
  min-width: 52px;
  color: var(--text-primary);
  font-size: calc(13px * var(--ui-font-ratio));
  font-variant-numeric: tabular-nums;
  text-align: center;
}

.danger {
  min-height: 30px;
  padding: 0 10px;
  color: var(--danger);
  border: 1px solid rgba(255, 55, 95, 0.4);
  border-radius: 7px;
  background: var(--danger-soft);
  font-size: calc(12px * var(--ui-font-ratio));
}

.cleared {
  margin: 0;
  color: var(--success);
  font-size: calc(11px * var(--ui-font-ratio));
}

@media (max-width: 1100px) {
  .menu-trigger span { display: none; }
}

@media (max-width: 720px) {
  .menu-trigger { min-width: 44px; height: 44px; }

  .settings-panel {
    position: fixed;
    top: var(--topbar-height);
    right: 10px;
    left: 10px;
    width: auto;
  }

  .size-control button { width: 40px; min-height: 40px; }
  .danger { min-height: 40px; }
}
</style>
