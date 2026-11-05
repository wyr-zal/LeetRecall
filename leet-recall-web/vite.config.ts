import { fileURLToPath, URL } from 'node:url'
import { readdir, readFile, writeFile } from 'node:fs/promises'
import { join, relative, sep } from 'node:path'
import { defineConfig, type Plugin } from 'vite'
import vue from '@vitejs/plugin-vue'

const DIST_DIR = fileURLToPath(new URL('./dist', import.meta.url))
const SW_TEMPLATE = fileURLToPath(new URL('./scripts/sw-template.js', import.meta.url))

async function listFiles(dir: string): Promise<string[]> {
  const entries = await readdir(dir, { withFileTypes: true })
  const nested = await Promise.all(entries.map((entry) => {
    const path = join(dir, entry.name)
    return entry.isDirectory() ? listFiles(path) : [path]
  }))
  return nested.flat()
}

/**
 * 构建后生成 dist/sw.js：顶部注入本次构建号与预缓存清单（dist 全部产物），
 * 其余逻辑见 scripts/sw-template.js。开发模式不生成，前端也只在生产环境注册。
 */
function serviceWorkerShell(): Plugin {
  return {
    name: 'leetrecall-service-worker',
    apply: 'build',
    async closeBundle() {
      const buildId = new Date().toISOString().replace(/\D/g, '').slice(0, 14)
      const precache = (await listFiles(DIST_DIR))
        .map((path) => relative(DIST_DIR, path).split(sep).join('/'))
        .filter((file) => file !== 'sw.js')
        .map((file) => `/${file}`)
        .sort()
      const header = `const BUILD_ID = ${JSON.stringify(buildId)}\nconst PRECACHE_URLS = ${JSON.stringify(precache)}\n`
      const template = await readFile(SW_TEMPLATE, 'utf8')
      await writeFile(join(DIST_DIR, 'sw.js'), header + template, 'utf8')
    },
  }
}

export default defineConfig({
  plugins: [vue(), serviceWorkerShell()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  server: {
    host: '0.0.0.0',
    port: 5173,
    proxy: {
      '/api': {
        target: process.env.VITE_API_TARGET || 'http://127.0.0.1:8080',
        changeOrigin: true,
      },
    },
  },
  build: {
    // Monaco is route-level lazy-loaded and intentionally ships its editor runtime separately.
    chunkSizeWarningLimit: 2500,
  },
})
