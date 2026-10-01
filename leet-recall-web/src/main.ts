import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router'
import './assets/main.css'
import { initializeTheme } from '@/composables/useTheme'
import { initializeFontScale } from '@/composables/useFontScale'

initializeTheme()
initializeFontScale()
createApp(App).use(createPinia()).use(router).mount('#app')
