import { mount } from '@vue/test-utils'
import AnnotationCard from '@/components/dictation/AnnotationCard.vue'
import AnnotationPanel from '@/components/dictation/AnnotationPanel.vue'
import type { ResolvedCodeAnnotation } from '@/types/annotation'

function annotation(overrides: Partial<ResolvedCodeAnnotation> = {}): ResolvedCodeAnnotation {
  return {
    id: 1,
    problemId: 7,
    label: '循环边界',
    anchorText: 'for (int i = 0; i < n; i++)',
    occurrenceIndex: 0,
    startLine: 3,
    startColumn: 5,
    endLine: 3,
    endColumn: 32,
    contentMarkdown: '## 为什么从 0 开始',
    createdAt: '2026-08-31T10:00:00',
    updatedAt: '2026-08-31T10:00:00',
    resolved: true,
    relocated: false,
    ...overrides,
  }
}

describe('AnnotationCard', () => {
  it('折叠时只显示标题，展开后显示正文', async () => {
    const wrapper = mount(AnnotationCard, {
      props: { annotation: annotation() },
      global: { stubs: { MarkdownContent: { template: '<div class="markdown-content">正文</div>' } } },
    })

    expect(wrapper.find('.annotation-body').exists()).toBe(false)
    await wrapper.find('.annotation-heading').trigger('click')
    expect(wrapper.find('.annotation-body').exists()).toBe(true)
    expect(wrapper.text()).toContain('正文')
  })

  it('代码片段默认遮罩，点击后才显示', async () => {
    const wrapper = mount(AnnotationCard, { props: { annotation: annotation() } })

    await wrapper.find('.annotation-heading').trigger('click')
    expect(wrapper.find('.anchor-preview code').exists()).toBe(false)
    expect(wrapper.text()).toContain('点击显示代码片段')

    await wrapper.find('.anchor-preview').trigger('click')
    expect(wrapper.find('.anchor-preview code').text()).toBe('for (int i = 0; i < n; i++)')
  })
})

describe('AnnotationPanel', () => {
  it('没有批注时显示空态，答案隐藏时不能从侧栏创建无锚点批注', () => {
    const wrapper = mount(AnnotationPanel, {
      props: { annotations: [], canCreate: false },
    })

    expect(wrapper.find('.panel-empty').exists()).toBe(true)
    expect(wrapper.find('.add-button').exists()).toBe(false)
    expect(wrapper.text()).toContain('显示答案后选中关键代码即可添加')
  })

  it('接收选区锚点后显示新增表单并拦截空内容', async () => {
    const wrapper = mount(AnnotationPanel, {
      props: {
        annotations: [],
        canCreate: true,
        draftAnchor: {
          anchorText: 'return result;',
          occurrenceIndex: 0,
          startLine: 5,
          startColumn: 1,
          endLine: 5,
          endColumn: 15,
        },
      },
    })

    expect(wrapper.find('.new-annotation').exists()).toBe(true)
    await wrapper.find('.new-annotation').trigger('submit')
    expect(wrapper.emitted('saveNew')).toBeUndefined()

    await wrapper.find('textarea').setValue('解释返回值')
    await wrapper.find('.new-annotation').trigger('submit')
    expect(wrapper.emitted('saveNew')?.[0]?.[0]).toMatchObject({
      anchorText: 'return result;',
      contentMarkdown: '解释返回值',
    })
  })
})
