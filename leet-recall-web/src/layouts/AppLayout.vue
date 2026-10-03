<script setup lang="ts">
import { computed, ref } from 'vue'
import { useRoute } from 'vue-router'
import AppSidebar from '@/components/common/AppSidebar.vue'
import AppTopbar from '@/components/common/AppTopbar.vue'
import { readStorage, writeStorage } from '@/utils/storage'

const collapsed = ref(readStorage('leet-recall:sidebar-collapsed', false))
const route = useRoute()
const dictationFocus = computed(() => route.path === '/dictation')

function toggleSidebar(): void {
  collapsed.value = !collapsed.value
  writeStorage('leet-recall:sidebar-collapsed', collapsed.value)
}
</script>

<template>
  <div class="app-shell" :class="{ 'is-collapsed': collapsed, 'is-dictation-focus': dictationFocus }">
    <AppSidebar v-if="!dictationFocus" data-test="global-sidebar" :collapsed="collapsed" @toggle="toggleSidebar" />
    <div class="app-stage">
      <AppTopbar v-if="!dictationFocus" data-test="global-topbar" />
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
  min-height: var(--viewport-height);
  transition: grid-template-columns 180ms ease;
}

.app-shell.is-collapsed {
  --current-sidebar-width: 72px;
}

.app-shell.is-dictation-focus {
  display: block;
  height: var(--viewport-height);
  min-height: 0;
}

.app-stage {
  min-width: 0;
  background: var(--bg-primary);
  box-shadow: var(--shadow-medium);
}

.is-dictation-focus .app-stage,
.is-dictation-focus .app-content {
  height: var(--viewport-height);
  min-height: 0;
}

.is-dictation-focus .app-stage {
  box-shadow: none;
}

.app-content {
  min-height: calc(var(--viewport-height) - var(--topbar-height));
  border-left: 1px solid var(--border-highlight);
}

.is-dictation-focus .app-content {
  border-left: 0;
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

  .app-content {
    border-left: 0;
  }
}
</style>
