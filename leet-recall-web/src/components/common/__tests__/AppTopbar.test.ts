import { createPinia } from 'pinia'
import { createMemoryHistory, createRouter } from 'vue-router'
import { flushPromises, mount } from '@vue/test-utils'
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest'
import { reviewApi } from '@/api/review'
import AppTopbar from '@/components/common/AppTopbar.vue'
import { useSettingsMenu } from '@/composables/useSettingsMenu'

async function mountTopbar() {
  const pinia = createPinia()
  const router = createRouter({ history: createMemoryHistory(), routes: [
    { path: '/problems/:leetcodeNumber/:section', meta: { workspace: true }, component: { template: '<p>工作台</p>' } },
    { path: '/other', component: { template: '<p>其他</p>' } },
  ] })
  await router.push('/problems/5/notes')
  await router.isReady()
  const wrapper = mount(AppTopbar, { attachTo: document.body, global: { plugins: [pinia, router] } })
  await flushPromises()
  return { wrapper, router }
}

describe('AppTopbar 手机端 ⋯ 面板', () => {
  let wrapper: ReturnType<typeof mount> | undefined

  beforeEach(() => {
    useSettingsMenu().setSettingsMenuOpen(false)
    vi.spyOn(reviewApi, 'getReviewStreak').mockResolvedValue(3)
  })

  afterEach(() => {
    wrapper?.unmount()
    wrapper = undefined
    document.body.innerHTML = ''
    vi.restoreAllMocks()
  })

  it('⋯ 切换 more-open 与 aria-expanded，再次点击关闭', async () => {
    ;({ wrapper } = await mountTopbar())
    const trigger = wrapper.get('.more-trigger')
    expect(trigger.attributes('aria-expanded')).toBe('false')
    expect(wrapper.get('header.topbar').classes()).not.toContain('more-open')

    await trigger.trigger('click')
    expect(trigger.attributes('aria-expanded')).toBe('true')
    expect(wrapper.get('header.topbar').classes()).toContain('more-open')

    await trigger.trigger('click')
    expect(trigger.attributes('aria-expanded')).toBe('false')
    expect(wrapper.get('header.topbar').classes()).not.toContain('more-open')
  })

  it('Esc 关闭并让焦点回到触发器', async () => {
    ;({ wrapper } = await mountTopbar())
    await wrapper.get('.more-trigger').trigger('click')

    document.dispatchEvent(new KeyboardEvent('keydown', { key: 'Escape' }))
    await flushPromises()

    expect(wrapper.get('header.topbar').classes()).not.toContain('more-open')
    expect(document.activeElement).toBe(wrapper.get('.more-trigger').element)
  })

  it('点击面板内部保持展开，点击外部或切换路由时收起', async () => {
    const mounted = await mountTopbar()
    wrapper = mounted.wrapper
    const router = mounted.router
    await wrapper.get('.more-trigger').trigger('click')
    await wrapper.get('.streak').trigger('click')
    expect(wrapper.get('header.topbar').classes()).toContain('more-open')

    const outside = document.createElement('button')
    document.body.appendChild(outside)
    outside.click()
    await flushPromises()
    expect(wrapper.get('header.topbar').classes()).not.toContain('more-open')

    await wrapper.get('.more-trigger').trigger('click')
    await router.push('/problems/5/recall')
    await flushPromises()
    expect(wrapper.get('header.topbar').classes()).not.toContain('more-open')
  })

  it('⋯ 与设置下拉互斥', async () => {
    ;({ wrapper } = await mountTopbar())
    await wrapper.get('.more-trigger').trigger('click')
    await wrapper.get('.menu-trigger').trigger('click')
    await flushPromises()
    expect(useSettingsMenu().settingsMenuOpen.value).toBe(true)
    expect(wrapper.get('header.topbar').classes()).not.toContain('more-open')

    await wrapper.get('.more-trigger').trigger('click')
    await flushPromises()
    expect(useSettingsMenu().settingsMenuOpen.value).toBe(false)
    expect(wrapper.get('header.topbar').classes()).toContain('more-open')
  })
})
