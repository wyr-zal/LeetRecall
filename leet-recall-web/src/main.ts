import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router'
import './assets/main.css'
import { initializeTheme } from '@/composables/useTheme'
import { initializeFontScale } from '@/composables/useFontScale'
import { useOfflineStore } from '@/stores/offline'
import { registerServiceWorker } from '@/offline/register'

initializeTheme()
initializeFontScale()
const pinia = createPinia()
createApp(App).use(pinia).use(router).mount('#app')
useOfflineStore(pinia).initialize()
registerServiceWorker()
