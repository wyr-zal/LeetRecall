/**
 * 只在生产构建注册 Service Worker，避免开发服务器缓存旧模块。
 * sw.js 由构建脚本生成在 dist 根目录，作用域为整个站点。
 */
export function registerServiceWorker(): void {
  if (!import.meta.env.PROD) return
  if (typeof navigator === 'undefined' || !('serviceWorker' in navigator)) return

  const register = () => {
    navigator.serviceWorker.register('/sw.js').catch(() => undefined)
  }
  if (document.readyState === 'complete') {
    register()
  } else {
    window.addEventListener('load', register, { once: true })
  }
}