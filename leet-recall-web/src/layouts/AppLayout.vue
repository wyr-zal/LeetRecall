<script setup lang="ts">
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import AppTopbar from '@/components/common/AppTopbar.vue'

const route = useRoute()
const overlayOpen = computed(() => route.path === '/quick-review' && (route.query.import === '1' || route.query.picker === '1'))
</script>

<template>
  <div class="app-shell" :inert="overlayOpen">
    <AppTopbar data-test="global-topbar" />
    <div class="app-content">
      <RouterView v-slot="{ Component }">
        <KeepAlive :include="['QuickReviewView']">
          <component :is="Component" />
        </KeepAlive>
      </RouterView>
    </div>
  </div>
</template>

<style scoped>
.app-shell { --topbar-height: 58px; min-height: var(--viewport-height); background: var(--bg-primary); }
@media (max-width: 720px) { .app-shell { --topbar-height: calc(106px + env(safe-area-inset-top)); } }
.app-content { min-width: 0; min-height: calc(var(--viewport-height) - var(--topbar-height)); }
</style>
