<script setup lang="ts">
import { nextTick, onBeforeUnmount, onMounted, ref, watch } from 'vue'

const props = defineProps<{
  open: boolean
  title: string
  description: string
  confirmLabel?: string
}>()
const emit = defineEmits<{ confirm: []; cancel: [] }>()
const cancelButtonRef = ref<HTMLButtonElement | null>(null)

function onKeydown(event: KeyboardEvent): void {
  if (event.key === 'Escape' && props.open) emit('cancel')
}

onMounted(() => window.addEventListener('keydown', onKeydown))
onBeforeUnmount(() => window.removeEventListener('keydown', onKeydown))

// 打开时聚焦「取消」：危险操作不默认聚焦确认键，避免误按 Enter 直接确认。
watch(() => props.open, async (open) => {
  if (!open) return
  await nextTick()
  cancelButtonRef.value?.focus()
})
</script>

<template>
  <Teleport to="body">
    <div v-if="open" class="backdrop" role="presentation" @click.self="$emit('cancel')">
      <section class="dialog" role="alertdialog" aria-modal="true" :aria-labelledby="`${title}-dialog-title`">
        <h2 :id="`${title}-dialog-title`">{{ title }}</h2>
        <p>{{ description }}</p>
        <div class="actions">
          <button ref="cancelButtonRef" type="button" class="secondary" @click="$emit('cancel')">取消</button>
          <button type="button" class="primary" @click="$emit('confirm')">{{ confirmLabel ?? '确定' }}</button>
        </div>
      </section>
    </div>
  </Teleport>
</template>

<style scoped>
.backdrop {
  position: fixed;
  z-index: 100;
  display: grid;
  inset: 0;
  padding: 20px;
  place-items: center;
  background: rgba(3, 6, 11, 0.72);
  backdrop-filter: blur(4px);
}

.dialog {
  width: min(420px, 100%);
  padding: 24px;
  border: 1px solid var(--border-primary);
  border-radius: 12px;
  background: var(--bg-card);
  box-shadow: var(--shadow-high);
}

h2 { margin: 0 0 9px; font-size: calc(18px * var(--ui-font-ratio)); }
p { margin: 0; color: var(--text-secondary); line-height: 1.65; }
.actions { display: flex; justify-content: flex-end; gap: 10px; margin-top: 24px; }
button { min-width: 82px; min-height: 40px; border-radius: 8px; }
.secondary { color: var(--text-secondary); border: 1px solid var(--border-primary); background: transparent; }
.primary { color: var(--on-primary); border: 1px solid var(--primary); background: var(--primary); }

@media (max-width: 480px) {
  .backdrop {
    padding: max(12px, env(safe-area-inset-top)) 12px max(12px, env(safe-area-inset-bottom));
  }

  .dialog { padding: 20px; }
  button { min-height: 44px; }
}
</style>
