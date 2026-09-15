import { createPinia } from 'pinia'
import { flushPromises, mount } from '@vue/test-utils'
import { reviewApi } from '@/api/review'
import QuickReviewView from '@/views/quick-review/QuickReviewView.vue'

describe('QuickReviewView', () => {
  beforeEach(() => {
    vi.spyOn(reviewApi, 'getTodayQueue').mockResolvedValue({
      total: 1,
      completed: 0,
      items: [{
        problemId: 1,
        leetcodeNumber: 1,
        title: '两数之和',
        difficulty: 'EASY',
        tags: ['哈希表'],
        masteryLevel: 'NEW',
        completed: false,
      }],
    })
    vi.spyOn(reviewApi, 'getProblemDetail').mockResolvedValue({
      problemId: 1,
      leetcodeNumber: 1,
      title: '两数之和',
      difficulty: 'EASY',
      descriptionMarkdown: '**给定**一个整数数组和目标值。',
      tags: ['哈希表'],
      recallQuestions: [{ id: 1, question: '哈希表保存什么？', answer: '数字到下标的映射。' }],
      hint: '先查后存。',
      coreIdea: '查询补数。',
      mistakes: ['重复使用同一元素'],
      keyCode: 'seen.get(target - nums[i]);',
    })
  })

  afterEach(() => vi.restoreAllMocks())

  it('defaults to the statement and switches recall and notes in place', async () => {
    const wrapper = mount(QuickReviewView, {
      global: {
        plugins: [createPinia()],
        stubs: {
          RecallQuestionList: { template: '<div data-test="recall-content">回忆内容</div>' },
          HintPanel: true,
          AnswerPanel: true,
          ProblemNotePanel: { template: '<div data-test="note-content">笔记内容</div>' },
          ReviewResultButtons: true,
          ReviewQueue: true,
          KeyboardShortcutPanel: true,
          LoadingState: true,
          ErrorState: true,
          EmptyState: true,
        },
      },
    })
    await flushPromises()

    expect(wrapper.get('#tab-description').attributes('aria-selected')).toBe('true')
    expect(wrapper.get('#panel-description').isVisible()).toBe(true)
    expect(wrapper.get('#panel-description strong').text()).toBe('给定')
    expect(wrapper.get('#panel-recall').isVisible()).toBe(false)

    await wrapper.get('#tab-recall').trigger('click')
    await flushPromises()
    expect(wrapper.get('#tab-recall').attributes('aria-selected')).toBe('true')
    expect(wrapper.get('#panel-recall').attributes('style') ?? '').not.toContain('display: none')
    expect(wrapper.get('[data-test="recall-content"]').text()).toBe('回忆内容')

    await wrapper.get('#tab-notes').trigger('click')
    await flushPromises()
    expect(wrapper.get('#tab-notes').attributes('aria-selected')).toBe('true')
    expect(wrapper.get('#panel-notes').attributes('style') ?? '').not.toContain('display: none')
    expect(wrapper.get('[data-test="note-content"]').text()).toBe('笔记内容')
  })
})
