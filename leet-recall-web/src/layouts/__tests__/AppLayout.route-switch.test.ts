import { defineComponent, h, ref } from 'vue'
import { flushPromises, mount } from '@vue/test-utils'
import { RouterView, createMemoryHistory, createRouter } from 'vue-router'
import AppLayout from '../AppLayout.vue'
import appRouter from '@/router'

const Workspace = defineComponent({ name: 'QuickReviewView', setup() {
  const count = ref(0)
  return () => h('button', { class: 'workspace-stub', onClick: () => { count.value += 1 } }, `WORK:${count.value}`)
} })

async function mountAt(path: string) {
  const router = createRouter({ history: createMemoryHistory(), routes: [{ path: '/', component: AppLayout, children: [
    { path: 'quick-review', component: Workspace },
  ] }] })
  await router.push(path)
  const wrapper = mount(RouterView, { global: { plugins: [router], stubs: { AppTopbar: { template: '<header data-test="topbar" />' } } } })
  await flushPromises()
  return { wrapper, router }
}

describe('统一外壳与路由缓存', () => {
  it('页签与导入查询参数变化时不卸载顶栏或工作台', async () => {
    const { wrapper, router } = await mountAt('/quick-review')
    const topbar = wrapper.get('[data-test="global-topbar"]').element
    const workspace = wrapper.get('.workspace-stub').element
    await wrapper.get('.workspace-stub').trigger('click')
    for (const query of ['panel=dictation', 'panel=recall', 'panel=notes&import=1', 'panel=notes']) {
      await router.push(`/quick-review?${query}`)
      await flushPromises()
      expect(wrapper.get('[data-test="global-topbar"]').element).toBe(topbar)
      expect(wrapper.get('.workspace-stub').element).toBe(workspace)
      expect(wrapper.text()).toContain('WORK:1')
    }
    wrapper.unmount()
  })

  it('真实路由把首页、旧模式地址与旧设置页都映射到同一个工作台', async () => {
    await appRouter.push('/')
    expect(appRouter.currentRoute.value.path).toBe('/quick-review')
    await appRouter.push('/dictation')
    expect(appRouter.currentRoute.value.path).toBe('/quick-review')
    expect(appRouter.currentRoute.value.query.panel).toBe('dictation')
    await appRouter.push('/problem-import')
    expect(appRouter.currentRoute.value.path).toBe('/quick-review')
    expect(appRouter.currentRoute.value.query.import).toBe('1')
    await appRouter.push('/settings')
    expect(appRouter.currentRoute.value.path).toBe('/quick-review')
    expect(appRouter.currentRoute.value.query.settings).toBe('1')
    await appRouter.push('/unknown')
    expect(appRouter.currentRoute.value.path).toBe('/quick-review')
  })
})
