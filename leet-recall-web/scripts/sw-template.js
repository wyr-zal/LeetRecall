/* global BUILD_ID, PRECACHE_URLS */
// 由 vite.config.ts 在构建后拼接到 dist/sw.js 顶部：BUILD_ID 与 PRECACHE_URLS 取自本次产物。
// 应用外壳全部预缓存（全有或全无）；导航离线回退到本版本 index.html；
// /api/ 与跨域请求不经过 SW，离线数据由页面侧 IndexedDB 负责。

const CACHE_PREFIX = 'leetrecall-shell-'
const CACHE_NAME = CACHE_PREFIX + BUILD_ID
// 保留当前与上一版：已打开的页面仍可能请求上一版的分块文件。
const KEEP_VERSIONS = 2
// 弱网下请求可能长时间挂起，超时后直接使用本地外壳。
const NAVIGATION_TIMEOUT_MS = 3000

function withTimeout(promise, ms) {
  return new Promise((resolve, reject) => {
    const timer = setTimeout(() => reject(new Error('navigation timeout')), ms)
    promise.then(
      (value) => {
        clearTimeout(timer)
        resolve(value)
      },
      (error) => {
        clearTimeout(timer)
        reject(error)
      },
    )
  })
}

/** 优先本版本缓存，其次任意旧版本（旧页面的分块文件仍需可用）。 */
async function matchShell(request) {
  const current = await caches.open(CACHE_NAME)
  return (await current.match(request)) ?? (await caches.match(request))
}

async function respondNavigation(request) {
  try {
    const response = await withTimeout(fetch(request), NAVIGATION_TIMEOUT_MS)
    if (response.ok) return response
  } catch {
    // 离线或超时：回退到本地外壳。
  }
  return (await matchShell('/index.html')) ?? fetch(request)
}

async function respondAsset(request) {
  return (await matchShell(request)) ?? fetch(request)
}

self.addEventListener('install', (event) => {
  event.waitUntil((async () => {
    const cache = await caches.open(CACHE_NAME)
    // 全有或全无：任一文件失败则本版本不激活，旧版本继续服务，避免 index.html 与分块不一致。
    await Promise.all(PRECACHE_URLS.map((url) => cache.add(new Request(url, { cache: 'reload' }))))
    await self.skipWaiting()
  })())
})

self.addEventListener('activate', (event) => {
  event.waitUntil((async () => {
    const versions = (await caches.keys()).filter((name) => name.startsWith(CACHE_PREFIX)).sort()
    await Promise.all(versions.slice(0, -KEEP_VERSIONS).map((name) => caches.delete(name)))
    await self.clients.claim()
  })())
})

self.addEventListener('fetch', (event) => {
  const { request } = event
  if (request.method !== 'GET') return
  const url = new URL(request.url)
  if (url.origin !== self.location.origin || url.pathname.startsWith('/api/')) return
  event.respondWith(request.mode === 'navigate' ? respondNavigation(request) : respondAsset(request))
})
