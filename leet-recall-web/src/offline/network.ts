import { ref } from 'vue'

/** 与 API 层共用的在线状态；由 axios 拦截器和 online/offline 事件共同维护。 */
export const online = ref(typeof navigator === 'undefined' ? true : navigator.onLine !== false)

if (typeof window !== 'undefined') {
  window.addEventListener('offline', () => { online.value = false })
  window.addEventListener('online', () => { online.value = true })
}

export function markNetworkFailure(): void {
  online.value = false
}

export function markNetworkSuccess(): void {
  online.value = true
}