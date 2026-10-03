/* eslint-disable vue/one-component-per-file -- 测试内联多个路由视图 stub */
import { describe, expect, it } from 'vitest'
import { defineComponent, h, ref } from 'vue'
import { flushPromises, mount } from '@vue/test-utils'
import { RouterView, createMemoryHistory, createRouter } from 'vue-router'
import AppLayout from '../AppLayout.vue'

const QuickReviewStub = defineComponent({
  name: 'QuickReviewView',
  setup() {
    const count = ref(0)
    return () => h('div', { class: 'quick-stub', onClick: () => { count.value += 1 } }, `QUICK:${count.value}`)
  },
})

const DictationStub = defineComponent({
  name: 'DictationView',
  setup: () => () => h('div', { class: 'dict-stub' }, 'DICT-VIEW'),
})

const ProblemImportStub = defineComponent({
  name: 'ProblemImportView',
  setup() {
    const count = ref(0)
    return () => h('div', { class: 'import-stub', onClick: () => { count.value += 1 } }, `IMPORT:${count.value}`)
  },
})

function buildRouter() {
  return createRouter({
    history: createMemoryHistory(),
    routes: [
      { path: '/', redirect: '/quick-review' },
      {
        path: '/',
        component: AppLayout,
        children: [
          { path: 'quick-review', component: () => Promise.resolve(QuickReviewStub) },
          { path: 'dictation', component: () => Promise.resolve(DictationStub) },
          { path: 'problem-import', component: () => Promise.resolve(ProblemImportStub) },
        ],
      },
    ],
  })
}

const Root = defineComponent({ setup: () => () => h(RouterView) })

async function mountAt(path: string) {
  const router = buildRouter()
  await router.push(path)
  await router.isReady()
  const wrapper = mount(Root, {
    global: {
      plugins: [router],
      stubs: { AppSidebar: true, AppTopbar: true },
    },
  })
  await flushPromises()
  return { wrapper, router }
}

describe('AppLayout 路由切换与页面缓存', () => {
  it('从快速复习切到默写模式渲染默写界面，不残留快速复习', async () => {
    const { wrapper, router } = await mountAt('/quick-review')
    expect(wrapper.find('.quick-stub').exists()).toBe(true)

    await router.push('/dictation')
    await flushPromises()
    expect(wrapper.find('.dict-stub').exists()).toBe(true)
    expect(wrapper.find('.quick-stub').exists()).toBe(false)
    expect(wrapper.find('.app-shell').classes()).toContain('is-dictation-focus')
    expect(wrapper.find('[data-test="global-sidebar"]').exists()).toBe(false)
    expect(wrapper.find('[data-test="global-topbar"]').exists()).toBe(false)
  })

  it('离开默写模式后恢复全局导航与工作台布局', async () => {
    const { wrapper, router } = await mountAt('/dictation')
    expect(wrapper.find('.app-shell').classes()).toContain('is-dictation-focus')

    await router.push('/quick-review')
    await flushPromises()

    expect(wrapper.find('.app-shell').classes()).not.toContain('is-dictation-focus')
    expect(wrapper.find('[data-test="global-sidebar"]').exists()).toBe(true)
    expect(wrapper.find('[data-test="global-topbar"]').exists()).toBe(true)
  })

  it('切回快速复习时保留组件内部状态（keep-alive 生效）', async () => {
    const { wrapper, router } = await mountAt('/quick-review')
    await wrapper.find('.quick-stub').trigger('click')
    expect(wrapper.text()).toContain('QUICK:1')

    await router.push('/dictation')
    await flushPromises()
    await router.push('/quick-review')
    await flushPromises()
    expect(wrapper.text()).toContain('QUICK:1')
  })

  it('经过导入题目页后返回，学习页缓存仍保留且导入页不被缓存', async () => {
    const { wrapper, router } = await mountAt('/quick-review')
    await wrapper.find('.quick-stub').trigger('click')

    await router.push('/problem-import')
    await flushPromises()
    await wrapper.find('.import-stub').trigger('click')
    expect(wrapper.text()).toContain('IMPORT:1')

    await router.push('/quick-review')
    await flushPromises()
    expect(wrapper.text()).toContain('QUICK:1')

    await router.push('/problem-import')
    await flushPromises()
    expect(wrapper.text()).toContain('IMPORT:0')
  })
})
