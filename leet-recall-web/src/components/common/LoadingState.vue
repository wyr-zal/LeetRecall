<template>
  <div class="skeleton-wrap" aria-label="正在加载" aria-busy="true">
    <span class="skeleton short" />
    <span class="skeleton title" />
    <span class="skeleton block" />
    <span class="skeleton block second" />
  </div>
</template>

<style scoped>
.skeleton-wrap {
  display: grid;
  gap: 14px;
  padding: 28px;
  border: 1px solid var(--border-secondary);
  border-radius: 8px;
  background: var(--bg-card);
  box-shadow: inset 0 1px 0 var(--border-highlight);
}

.skeleton {
  display: block;
  height: 16px;
  border-radius: 6px;
  background: linear-gradient(90deg, var(--code-surface-raised) 25%, var(--bg-card-hover) 50%, var(--code-surface-raised) 75%);
  background-size: 200% 100%;
  animation: shimmer 1.35s linear infinite;
}

.short { width: 28%; }
.title { width: 62%; height: 28px; }
.block { width: 100%; height: 92px; }
.second { height: 72px; }

@keyframes shimmer {
  to { background-position: -200% 0; }
}
</style>
