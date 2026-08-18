<script setup lang="ts">
import {
  Braces,
  ChevronRight,
  FileInput,
  PanelLeftClose,
  Settings,
  SquarePen,
  Zap,
} from 'lucide-vue-next'

defineProps<{ collapsed: boolean }>()
defineEmits<{ toggle: [] }>()

const navItems = [
  { to: '/quick-review', label: '快速复习', icon: Zap },
  { to: '/dictation', label: '默写模式', icon: SquarePen },
  { to: '/problem-import', label: '导入题目', icon: FileInput },
]
</script>

<template>
  <aside class="sidebar" :class="{ collapsed }">
    <RouterLink class="brand" to="/quick-review" aria-label="LeetRecall 快速复习">
      <span class="brand-icon"><Braces :size="28" /></span>
      <span class="brand-copy">
        <span class="brand-name">LeetRecall</span>
        <span class="brand-meta">REVIEW WORKSPACE</span>
      </span>
    </RouterLink>

    <nav class="navigation" aria-label="主导航">
      <RouterLink
        v-for="item in navItems"
        :key="item.to"
        :to="item.to"
        class="nav-link"
        :aria-label="item.label"
      >
        <component :is="item.icon" :size="21" :stroke-width="1.8" />
        <span>{{ item.label }}</span>
      </RouterLink>
    </nav>

    <div class="sidebar-bottom">
      <RouterLink class="bottom-action" to="/settings" aria-label="设置">
        <Settings :size="21" :stroke-width="1.8" />
        <span>设置</span>
      </RouterLink>
      <button class="bottom-action desktop-only" type="button" aria-label="折叠侧栏" @click="$emit('toggle')">
        <PanelLeftClose v-if="!collapsed" :size="21" />
        <ChevronRight v-else :size="21" />
        <span>{{ collapsed ? '展开' : '折叠' }}</span>
      </button>
    </div>
  </aside>
</template>

<style scoped>
.sidebar {
  position: sticky;
  top: 0;
  z-index: 30;
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100dvh;
  overflow: hidden;
  border-right: 1px solid var(--border-primary);
  background: var(--bg-sidebar);
  box-shadow: none;
}

.brand {
  display: flex;
  align-items: center;
  height: var(--topbar-height);
  padding: 0 18px;
  color: var(--text-primary);
  text-decoration: none;
  white-space: nowrap;
}

.brand-icon {
  display: grid;
  flex: 0 0 36px;
  width: 36px;
  height: 36px;
  color: var(--primary);
  border: 1px solid rgba(255, 161, 22, 0.22);
  border-radius: 8px;
  place-items: center;
  background: var(--primary-soft);
  box-shadow: none;
}

.brand-copy {
  display: grid;
  gap: 3px;
  margin-left: 12px;
  overflow: hidden;
}

.brand-name {
  overflow: hidden;
  font-size: 17px;
  font-weight: 680;
  letter-spacing: 0;
  line-height: 1;
}

.brand-meta {
  color: var(--text-muted);
  font-size: 9px;
  font-weight: 650;
  letter-spacing: 0.08em;
}

.navigation {
  display: grid;
  gap: 5px;
  padding: 20px 12px;
}

.nav-link,
.bottom-action {
  position: relative;
  display: flex;
  align-items: center;
  min-height: 46px;
  padding: 0 14px;
  overflow: hidden;
  color: var(--text-secondary);
  text-decoration: none;
  white-space: nowrap;
  border: 1px solid transparent;
  border-radius: 7px;
  background: transparent;
  transition: color 150ms ease, background-color 150ms ease, border-color 150ms ease;
}

.nav-link span,
.bottom-action span {
  margin-left: 13px;
}

.nav-link:hover,
.bottom-action:hover {
  color: var(--text-primary);
  background: var(--bg-card-hover);
}

.nav-link.router-link-active {
  color: var(--text-primary);
  border-color: var(--border-primary);
  background: var(--bg-card-hover);
  box-shadow: none;
}

.nav-link.router-link-active::before {
  position: absolute;
  top: 12px;
  bottom: 12px;
  left: -1px;
  width: 3px;
  content: '';
  border-radius: 0 3px 3px 0;
  background: var(--primary);
}

.sidebar-bottom {
  display: grid;
  gap: 4px;
  padding: 12px;
  margin-top: auto;
  border-top: 1px solid var(--border-secondary);
}

.bottom-action {
  width: 100%;
  font-size: 15px;
  text-align: left;
}

.collapsed .brand,
.collapsed .nav-link,
.collapsed .bottom-action {
  justify-content: center;
  padding-inline: 0;
}

.collapsed .brand-name,
.collapsed .brand-meta,
.collapsed .brand-copy,
.collapsed .nav-link span,
.collapsed .bottom-action span {
  display: none;
}

@media (max-width: 1279px) {
  .brand,
  .nav-link,
  .bottom-action {
    justify-content: center;
    padding-inline: 0;
  }

  .brand-name,
  .brand-meta,
  .brand-copy,
  .nav-link span,
  .bottom-action span,
  .desktop-only {
    display: none;
  }
}

@media (max-width: 720px) {
  .sidebar {
    position: fixed;
    top: auto;
    bottom: 0;
    flex-direction: row;
    width: 100%;
    height: 64px;
    border-top: 1px solid var(--border-primary);
    border-right: 0;
    box-shadow: 0 -12px 32px var(--shadow-medium);
  }

  .brand,
  .sidebar-bottom {
    display: none;
  }

  .navigation {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    width: 100%;
    padding: 8px;
  }

  .nav-link {
    min-height: 48px;
  }

  .nav-link.router-link-active::before {
    top: auto;
    right: 28%;
    bottom: 0;
    left: 28%;
    width: auto;
    height: 3px;
    border-radius: 3px 3px 0 0;
  }
}
</style>
