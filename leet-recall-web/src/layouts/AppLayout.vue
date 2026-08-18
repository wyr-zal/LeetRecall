<script setup lang="ts">
import { ref } from 'vue'
import AppSidebar from '@/components/common/AppSidebar.vue'
import AppTopbar from '@/components/common/AppTopbar.vue'
import { readStorage, writeStorage } from '@/utils/storage'

const collapsed = ref(readStorage('leet-recall:sidebar-collapsed', false))

function toggleSidebar(): void {
  collapsed.value = !collapsed.value
  writeStorage('leet-recall:sidebar-collapsed', collapsed.value)
}
</script>

<template>
  <div class="app-shell" :class="{ 'is-collapsed': collapsed }">
    <AppSidebar :collapsed="collapsed" @toggle="toggleSidebar" />
    <div class="app-stage">
      <AppTopbar />
      <div class="app-content">
        <RouterView v-slot="{ Component }">
          <KeepAlive :include="['QuickReviewView', 'DictationView']">
            <component :is="Component" />
          </KeepAlive>
        </RouterView>
      </div>
    </div>
  </div>
</template>

<style scoped>
.app-shell {
  --current-sidebar-width: var(--sidebar-width);
  display: grid;
  grid-template-columns: var(--current-sidebar-width) minmax(0, 1fr);
  min-height: 100dvh;
  transition: grid-template-columns 180ms ease;
}

.app-shell.is-collapsed {
  --current-sidebar-width: 72px;
}

.app-stage {
  min-width: 0;
  background: var(--bg-primary);
  box-shadow: var(--shadow-medium);
}

.app-content {
  min-height: calc(100dvh - var(--topbar-height));
  border-left: 1px solid var(--border-highlight);
}

@media (max-width: 1279px) {
  .app-shell {
    --current-sidebar-width: 72px;
  }
}

@media (max-width: 720px) {
  .app-shell {
    display: block;
  }
}
</style>
