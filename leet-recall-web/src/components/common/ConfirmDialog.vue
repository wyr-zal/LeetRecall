<script setup lang="ts">
defineProps<{
  open: boolean
  title: string
  description: string
  confirmLabel?: string
}>()
defineEmits<{ confirm: []; cancel: [] }>()
</script>

<template>
  <Teleport to="body">
    <div v-if="open" class="backdrop" role="presentation" @click.self="$emit('cancel')">
      <section class="dialog" role="alertdialog" aria-modal="true" :aria-labelledby="`${title}-dialog-title`">
        <h2 :id="`${title}-dialog-title`">{{ title }}</h2>
        <p>{{ description }}</p>
        <div class="actions">
          <button type="button" class="secondary" @click="$emit('cancel')">取消</button>
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
  box-shadow: 0 24px 64px rgba(0, 0, 0, 0.46);
}

h2 { margin: 0 0 9px; font-size: 18px; }
p { margin: 0; color: var(--text-secondary); line-height: 1.65; }
.actions { display: flex; justify-content: flex-end; gap: 10px; margin-top: 24px; }
button { min-width: 82px; min-height: 40px; border-radius: 8px; }
.secondary { color: var(--text-secondary); border: 1px solid var(--border-primary); background: transparent; }
.primary { color: white; border: 1px solid var(--primary); background: var(--primary); }
</style>
