<script setup lang="ts">
import { ref } from 'vue'
import { Database, Trash2 } from 'lucide-vue-next'
import ConfirmDialog from '@/components/common/ConfirmDialog.vue'

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
    <section class="setting-row app-card"><div class="setting-icon danger"><Trash2 :size="19" /></div><div><h2>清除本地草稿</h2><p>只清除当前题目和未提交输入，不会删除服务器中的复习与默写记录。</p></div><button type="button" @click="confirmOpen = true">清除草稿</button></section>
    <p v-if="cleared" class="cleared" role="status">本地草稿已清除，刷新页面后生效。</p>
    <ConfirmDialog :open="confirmOpen" title="清除本地草稿" description="确定清除当前浏览器中所有未提交的回忆与默写内容吗？" confirm-label="确认清除" @confirm="clearDrafts" @cancel="confirmOpen = false" />
  </main>
</template>

<style scoped>
.settings-page { width: min(900px, calc(100% - 56px)); padding: 34px 0 56px; margin: 0 auto; }header { padding: 0 2px 20px; margin-bottom: 20px; border-bottom: 1px solid var(--border-secondary); }header p { margin: 0 0 6px; color: var(--primary); font-size: 11px; font-weight: 700; }h1 { margin: 0 0 7px; font-size: 27px; }header span { color: var(--text-muted); font-size: 13px; }
.setting-row { display: grid; grid-template-columns: 42px minmax(0,1fr) auto; gap: 14px; align-items: center; padding: 18px 20px; margin-bottom: 12px; background: #222222; }.setting-icon { display: grid; width: 38px; height: 38px; color: var(--primary); border: 1px solid rgba(255,161,22,.25); border-radius: 8px; place-items: center; background: var(--primary-soft); box-shadow: none; }.setting-icon.danger { color: var(--danger); border-color: rgba(255,55,95,.24); background: rgba(255,55,95,.08); }h2 { margin: 0 0 5px; font-size: 15px; }section p { margin: 0; color: var(--text-muted); font-size: 12px; line-height: 1.55; }.status { color: var(--success); font-size: 12px; }.setting-row button { min-height: 38px; padding: 0 13px; color: var(--danger); border: 1px solid rgba(255,55,95,.4); border-radius: 8px; background: rgba(255,55,95,.06); }.cleared { color: var(--success); font-size: 12px; }
@media (max-width: 620px) { .settings-page { width: calc(100% - 24px); padding-bottom: 88px; }.setting-row { grid-template-columns: 42px 1fr; }.setting-row > :last-child { grid-column: 2; justify-self: start; } }
</style>
