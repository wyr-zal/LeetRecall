<script setup lang="ts">
import { ref, useId } from 'vue'
import { X } from 'lucide-vue-next'
import { useDialogFocus } from '@/composables/useDialogFocus'

const props = defineProps<{ open: boolean; title: string; compact?: boolean; busy?: boolean }>()
const emit = defineEmits<{ close: [] }>()
const dialog = ref<HTMLElement | null>(null)
const titleId = useId()
function close(): void { if (!props.busy) emit('close') }
useDialogFocus(() => props.open, dialog, close)
</script>

<template>
  <Teleport to="body">
    <div v-show="open" class="workspace-backdrop" @click.self="close">
      <section ref="dialog" class="workspace-drawer" :class="{ compact }" role="dialog" aria-modal="true" :aria-labelledby="titleId" tabindex="-1">
        <header class="drawer-heading">
          <h2 :id="titleId">{{ title }}</h2>
          <button type="button" :aria-label="`关闭${title}`" :disabled="busy" @click="close"><X :size="19" /></button>
        </header>
        <div class="drawer-content"><slot /></div>
      </section>
    </div>
  </Teleport>
</template>

<style scoped>
.workspace-backdrop { position: fixed; z-index: 80; inset: 0; display: flex; justify-content: flex-end; background: rgba(3, 6, 11, .45); }
.workspace-drawer { display: flex; width: min(960px, 94vw); height: 100%; min-width: 0; flex-direction: column; background: var(--bg-primary); border-left: 1px solid var(--border-primary); box-shadow: var(--shadow-high); }
.workspace-drawer.compact { width: min(460px, 94vw); }
.drawer-heading { display: flex; flex: 0 0 auto; align-items: center; justify-content: space-between; padding: max(10px, env(safe-area-inset-top)) 18px 10px; gap: 12px; border-bottom: 1px solid var(--border-secondary); background: var(--bg-card); }
h2 { margin: 0; font-size: calc(16px * var(--ui-font-ratio)); }
button { display: grid; width: 44px; height: 44px; flex: 0 0 auto; place-items: center; color: var(--text-secondary); border: 1px solid var(--border-primary); border-radius: 7px; background: transparent; }
button:hover { color: var(--text-primary); background: var(--bg-card-hover); }
.drawer-content { min-height: 0; flex: 1; overflow: auto; overscroll-behavior: contain; padding-bottom: env(safe-area-inset-bottom); }
.compact .drawer-content { display: flex; flex-direction: column; padding: 12px; overflow: hidden; }
@media (max-width: 720px) { .workspace-drawer, .workspace-drawer.compact { width: 100%; } }
</style>
