<script setup lang="ts">
import { ref } from 'vue'
import { Code2, Database, Minus, Plus, Trash2, Type } from 'lucide-vue-next'
import ConfirmDialog from '@/components/common/ConfirmDialog.vue'
import { useFontScale } from '@/composables/useFontScale'

const {
  uiFontSize,
  codeFontSize,
  minFontSize,
  maxFontSize,
  stepUiFontSize,
  stepCodeFontSize,
} = useFontScale()
const confirmOpen = ref(false)
const cleared = ref(false)

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
  <main class="settings-page">
    <header><p>偏好设置</p><h1>设置</h1><span>只保留与个人复习直接相关的本地控制。</span></header>
    <section class="setting-row app-card"><div class="setting-icon"><Database :size="19" /></div><div><h2>数据保存方式</h2><p>复习进度与默写记录保存在 MySQL；当前未提交输入仅保存在本浏览器。</p></div><span class="status">已启用</span></section>
    <section class="setting-row app-card">
      <div class="setting-icon"><Type :size="19" /></div>
      <div><h2>界面文字大小</h2><p>导航、题目描述、按钮与各面板正文的字号，{{ minFontSize }}–{{ maxFontSize }}px。只保存在当前浏览器。</p></div>
      <div class="size-control" role="group" aria-label="界面文字大小">
        <button type="button" aria-label="减小界面文字" :disabled="uiFontSize <= minFontSize" @click="stepUiFontSize(-1)"><Minus :size="16" /></button>
        <output class="size-value">{{ uiFontSize }} px</output>
        <button type="button" aria-label="增大界面文字" :disabled="uiFontSize >= maxFontSize" @click="stepUiFontSize(1)"><Plus :size="16" /></button>
      </div>
    </section>
    <section class="setting-row app-card">
      <div class="setting-icon"><Code2 :size="19" /></div>
      <div><h2>代码字号</h2><p>默写编辑器的代码、代码空位输入框与代码预览的字号，{{ minFontSize }}–{{ maxFontSize }}px。</p></div>
      <div class="size-control" role="group" aria-label="代码字号">
        <button type="button" aria-label="减小代码字号" :disabled="codeFontSize <= minFontSize" @click="stepCodeFontSize(-1)"><Minus :size="16" /></button>
        <output class="size-value">{{ codeFontSize }} px</output>
        <button type="button" aria-label="增大代码字号" :disabled="codeFontSize >= maxFontSize" @click="stepCodeFontSize(1)"><Plus :size="16" /></button>
      </div>
    </section>
    <section class="setting-row app-card"><div class="setting-icon danger"><Trash2 :size="19" /></div><div><h2>清除本地草稿</h2><p>只清除当前题目和未提交输入，不会删除服务器中的复习与默写记录。</p></div><button type="button" @click="confirmOpen = true">清除草稿</button></section>
    <p v-if="cleared" class="cleared" role="status">本地草稿已清除，刷新页面后生效。</p>
    <ConfirmDialog :open="confirmOpen" title="清除本地草稿" description="确定清除当前浏览器中所有未提交的回忆与默写内容吗？" confirm-label="确认清除" @confirm="clearDrafts" @cancel="confirmOpen = false" />
  </main>
</template>

<style scoped>
.settings-page {
  width: min(900px, calc(100% - 56px));
  padding: 34px 0 56px;
  margin: 0 auto;
}

header {
  padding: 0 2px 20px;
  margin-bottom: 20px;
  border-bottom: 1px solid var(--border-secondary);
}

header p {
  margin: 0 0 6px;
  color: var(--primary);
  font-size: calc(11px * var(--ui-font-ratio));
  font-weight: 700;
}

h1 {
  margin: 0 0 7px;
  font-size: calc(27px * var(--ui-font-ratio));
}

header span {
  color: var(--text-muted);
  font-size: calc(13px * var(--ui-font-ratio));
}

.setting-row {
  display: grid;
  grid-template-columns: 42px minmax(0, 1fr) auto;
  gap: 14px;
  align-items: center;
  padding: 18px 20px;
  margin-bottom: 12px;
  background: var(--bg-card);
}

.setting-icon {
  display: grid;
  width: 38px;
  height: 38px;
  color: var(--primary);
  border: 1px solid rgba(255, 161, 22, 0.25);
  border-radius: 8px;
  place-items: center;
  background: var(--primary-soft);
  box-shadow: none;
}

.setting-icon.danger {
  color: var(--danger);
  border-color: rgba(255, 55, 95, 0.24);
  background: var(--danger-soft);
}

h2 {
  margin: 0 0 5px;
  font-size: calc(15px * var(--ui-font-ratio));
}

section p {
  margin: 0;
  color: var(--text-muted);
  font-size: calc(12px * var(--ui-font-ratio));
  line-height: 1.55;
}

.status {
  color: var(--success);
  font-size: calc(12px * var(--ui-font-ratio));
}

.setting-row button {
  min-height: 38px;
  padding: 0 13px;
  color: var(--danger);
  border: 1px solid rgba(255, 55, 95, 0.4);
  border-radius: 8px;
  background: var(--danger-soft);
}

.cleared {
  color: var(--success);
  font-size: calc(12px * var(--ui-font-ratio));
}

.size-control {
  display: flex;
  align-items: center;
  gap: 6px;
}

.setting-row .size-control button {
  display: grid;
  width: 38px;
  min-height: 38px;
  padding: 0;
  color: var(--text-secondary);
  border: 1px solid var(--border-primary);
  border-radius: 8px;
  place-items: center;
  background: var(--bg-input);
}

.setting-row .size-control button:hover:not(:disabled) {
  color: var(--text-primary);
  border-color: var(--border-hover);
}

.setting-row .size-control button:disabled {
  color: var(--disabled-text);
  border-color: var(--border-secondary);
  background: var(--disabled-surface);
}

.size-value {
  min-width: 58px;
  color: var(--text-primary);
  font-size: calc(13px * var(--ui-font-ratio));
  font-variant-numeric: tabular-nums;
  text-align: center;
}

@media (max-width: 620px) {
  .settings-page {
    width: calc(100% - 24px);
    padding-bottom: calc(88px + env(safe-area-inset-bottom));
  }

  .setting-row { grid-template-columns: 42px 1fr; }

  .setting-row > :last-child {
    grid-column: 2;
    justify-self: start;
  }

  .setting-row button { min-height: 44px; }

  .setting-row .size-control button {
    width: 44px;
    min-height: 44px;
  }
}
</style>
