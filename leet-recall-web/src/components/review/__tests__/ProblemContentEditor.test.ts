import { mount } from '@vue/test-utils'
import ProblemContentEditor from '@/components/review/ProblemContentEditor.vue'
import type { ProblemContent } from '@/types/problem'

function content(overrides: Partial<ProblemContent> = {}): ProblemContent {
  return {
    problemId: 1,
    leetcodeNumber: 347,
    title: '前 K 个高频元素',
    difficulty: 'MEDIUM',
    descriptionMarkdown: '题面内容',
    tags: ['数组', '哈希表'],
    recallQuestions: [{ id: 11, question: 'cnt 表示什么？', answer: '出现次数' }],
    hint: '先统计再分桶',
    coreIdea: '哈希计数后按次数分桶',
    mistakes: ['桶长度要用 maxCnt + 1'],
    keyCode: 'return result;',
    ...overrides,
  }
}

function mountEditor(overrides: Partial<ProblemContent> = {}) {
  return mount(ProblemContentEditor, {
    props: { content: content(overrides), saving: false, errorMessage: '' },
    global: { stubs: { MarkdownContent: true } },
  })
}

/** tsconfig 开了 noUncheckedIndexedAccess，下标取值需要显式收窄。 */
function at<T>(items: T[], index: number): T {
  const item = items[index]
  if (item === undefined) throw new Error(`下标 ${index} 不存在`)
  return item
}

describe('ProblemContentEditor', () => {
  it('用传入的内容初始化表单，标签不截断', () => {
    const wrapper = mountEditor({ tags: ['数组', '哈希表', '桶排序', '堆', '计数', '排序'] })

    expect((wrapper.find('input[type="text"]').element as HTMLInputElement).value)
      .toBe('前 K 个高频元素')
    expect(wrapper.findAll('.tag-chip')).toHaveLength(6)
  })

  it('保存时带上原有 questionId，新增的问答 id 为 null', async () => {
    const wrapper = mountEditor()

    await wrapper.find('.block-heading .ghost-button').trigger('click')
    const questionAreas = wrapper.findAll('.question-editor textarea')
    await at(questionAreas, 2).setValue('新问题')
    await at(questionAreas, 3).setValue('新答案')
    await wrapper.find('form').trigger('submit')

    const payload = wrapper.emitted('save')?.[0]?.[0] as { recallQuestions: { id: number | null }[] }
    expect(payload.recallQuestions.map((question) => question.id)).toEqual([11, null])
  })

  it('回忆问答达到 5 组后禁用添加按钮', async () => {
    const wrapper = mountEditor({
      recallQuestions: [1, 2, 3, 4, 5].map((index) => ({
        id: index,
        question: `问题 ${index}`,
        answer: `答案 ${index}`,
      })),
    })

    const addButton = at(wrapper.findAll('.block-heading .ghost-button'), 0)
    expect(addButton.attributes('disabled')).toBeDefined()
    await addButton.trigger('click')
    expect(wrapper.findAll('.question-editor')).toHaveLength(5)
  })

  it('内容不完整时本地拦截，不向上抛保存事件', async () => {
    const wrapper = mountEditor()

    await wrapper.find('input[type="text"]').setValue('   ')
    await wrapper.find('form').trigger('submit')

    expect(wrapper.emitted('save')).toBeUndefined()
    expect(wrapper.find('.editor-error').text()).toContain('标题不能为空')
  })

  it('删除标签后不会再出现在保存内容里', async () => {
    const wrapper = mountEditor()

    await at(wrapper.findAll('.tag-chip button'), 0).trigger('click')
    await wrapper.find('form').trigger('submit')

    const payload = wrapper.emitted('save')?.[0]?.[0] as { tags: string[] }
    expect(payload.tags).toEqual(['哈希表'])
  })

  it('点击取消只发出 cancel 事件', async () => {
    const wrapper = mountEditor()

    await wrapper.find('.editor-actions .ghost-button').trigger('click')

    expect(wrapper.emitted('cancel')).toHaveLength(1)
    expect(wrapper.emitted('save')).toBeUndefined()
  })
})
