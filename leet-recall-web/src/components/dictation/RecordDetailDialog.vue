<script setup lang="ts">
import { nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue'
import { X } from 'lucide-vue-next'
import type { DictationRecordDetail } from '@/types/dictation'
const props = defineProps<{ detail: DictationRecordDetail | null }>()
const emit = defineEmits<{ close: [] }>()
const closeButtonRef = ref<HTMLButtonElement | null>(null)

function onKeydown(event: KeyboardEvent): void {
  if (event.key === 'Escape' && props.detail) emit('close')
}

onMounted(() => window.addEventListener('keydown', onKeydown))
onBeforeUnmount(() => window.removeEventListener('keydown', onKeydown))

// 打开时聚焦关闭按钮，键盘用户不必先 Tab 穿过整个页面。
watch(() => props.detail, async (detail) => {
  if (!detail) return
  await nextTick()
  closeButtonRef.value?.focus()
})
</script>

<template>
  <Teleport to="body">
    <div v-if="detail" class="backdrop" @click.self="$emit('close')">
      <section class="dialog" role="dialog" aria-modal="true" aria-labelledby="record-title">
        <header><div><h2 id="record-title">默写记录详情</h2><p>{{ detail.viewedAnswer ? '本次查看过答案' : '本次未查看答案' }}</p></div><button ref="closeButtonRef" type="button" aria-label="关闭" @click="$emit('close')"><X :size="18" /></button></header>
        <p v-if="detail.legacySnapshot" class="legacy-note">这是历史快照以前创建的记录，当前题目已覆盖，因此不再使用当前模板重新判分。</p>
        <details v-else-if="detail.templateCode" class="template-snapshot"><summary>查看本次默写的模板快照</summary><pre>{{ detail.templateCode }}</pre></details>
        <div class="answers">
          <article v-for="(correct, key) in detail.correctAnswers" :key="key" :class="{ incorrect: detail.incorrectBlankKeys.includes(key) }">
            <h3>{{ key }}</h3>
            <dl><div><dt>当时填写</dt><dd>{{ detail.submittedAnswers[key] || '（未填写）' }}</dd></div><div><dt>正确答案</dt><dd>{{ correct }}</dd></div></dl>
          </article>
        </div>
      </section>
    </div>
  </Teleport>
</template>

<style scoped>
.backdrop { position: fixed; z-index: 100; display: grid; inset: 0; padding: 20px; place-items: center; background: rgba(3, 6, 11, 0.72); backdrop-filter: blur(4px); }
.dialog { width: min(680px, 100%); max-height: 84vh; overflow: auto; border: 1px solid var(--border-primary); border-radius: 12px; background: var(--bg-card); }
header { display: flex; align-items: flex-start; justify-content: space-between; padding: 20px; border-bottom: 1px solid var(--border-secondary); }
h2 { margin: 0 0 5px; font-size: 18px; } header p { margin: 0; color: var(--text-muted); font-size: 12px; }
header button { display: grid; width: 34px; height: 34px; color: var(--text-muted); border: 0; border-radius: 6px; place-items: center; background: transparent; }
.answers { display: grid; gap: 10px; padding: 18px; }
.legacy-note { padding: 10px 12px; margin: 16px 18px 0; color: var(--warning); border: 1px solid rgba(245, 158, 11, .3); border-radius: 8px; background: rgba(245, 158, 11, .07); font-size: 12px; line-height: 1.6; }
.template-snapshot { margin: 16px 18px 0; color: var(--text-secondary); font-size: 12px; }.template-snapshot summary { cursor: pointer; }.template-snapshot pre { overflow: auto; padding: 10px; margin: 8px 0 0; color: var(--text-secondary); border: 1px solid var(--border-primary); border-radius: 7px; background: var(--bg-input); font: 11px/1.55 "JetBrains Mono", monospace; white-space: pre-wrap; }
article { padding: 13px; border: 1px solid rgba(34, 197, 94, 0.25); border-radius: 8px; background: rgba(34, 197, 94, 0.04); }
article.incorrect { border-color: rgba(239, 68, 68, 0.35); background: rgba(239, 68, 68, 0.05); }
h3 { margin: 0 0 10px; font: 600 12px/1.4 "JetBrains Mono", monospace; color: var(--text-secondary); }
dl { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin: 0; }
dt { margin-bottom: 4px; color: var(--text-muted); font-size: 11px; } dd { margin: 0; color: var(--text-secondary); font: 12px/1.5 "JetBrains Mono", monospace; overflow-wrap: anywhere; }

@media (max-width: 560px) {
  .backdrop {
    padding: max(12px, env(safe-area-inset-top)) 12px max(12px, env(safe-area-inset-bottom));
  }

  .dialog { max-height: calc(100dvh - 24px - env(safe-area-inset-top) - env(safe-area-inset-bottom)); }
  header { padding: 16px; }
  header button { width: 44px; height: 44px; flex: 0 0 auto; }
  .answers { padding: 14px; }
  dl { grid-template-columns: 1fr; }
}
</style>
