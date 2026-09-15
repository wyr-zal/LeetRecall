import { mount } from '@vue/test-utils'
import { nextTick } from 'vue'
import ReviewQueue from '@/components/review/ReviewQueue.vue'
import type { ReviewQueueItem } from '@/types/problem'

function queueItem(
  problemId: number,
  lastReviewedAt: string | null,
  contentUpdatedAt: string | null = null,
): ReviewQueueItem {
  return {
    problemId,
    leetcodeNumber: problemId,
    title: `题目${problemId}`,
    difficulty: 'MEDIUM',
    tags: [],
    masteryLevel: 'NEW',
    completed: false,
    lastReviewedAt,
    contentUpdatedAt,
  }
}

/** tsconfig 开了 noUncheckedIndexedAccess，下标取值需要显式收窄。 */
function at<T>(items: T[], index: number): T {
  const item = items[index]
  if (item === undefined) throw new Error(`下标 ${index} 不存在`)
  return item
}

function labelsOf(items: ReviewQueueItem[]): string[] {
  const wrapper = mount(ReviewQueue, { props: { items, currentProblemId: items[0]?.problemId ?? null } })
  return wrapper.findAll('.queue-time').map((node) => node.text())
}

describe('ReviewQueue', () => {
  beforeEach(() => {
    // jsdom 不实现 scrollIntoView，组件挂载时的当前项定位会直接抛错。
    Element.prototype.scrollIntoView = vi.fn()
    vi.useFakeTimers()
    vi.setSystemTime(new Date(2026, 8, 1, 22, 0, 0))
  })

  afterEach(() => vi.useRealTimers())

  it('renders the last review time as relative days within a week and a date beyond it', () => {
    expect(
      labelsOf([
        queueItem(1, null),
        queueItem(2, '2026-09-01T08:30:00'),
        queueItem(3, '2026-08-31T20:00:00'),
        queueItem(4, '2026-08-28T20:00:00'),
        queueItem(5, '2026-08-10T20:00:00'),
        queueItem(6, '2025-12-30T20:00:00'),
      ]),
    ).toEqual(['未复习', '复习 今天', '复习 昨天', '复习 4天前', '复习 08-10', '复习 2025-12-30'])
  })

  it('labels a problem with only a content update as updated', () => {
    expect(labelsOf([queueItem(1, null, '2026-09-01T11:01:27')])).toEqual(['已更新 今天'])
  })

  it('shows whichever of the two timestamps is later', () => {
    expect(
      labelsOf([
        // 更新晚于复习 -> 已更新
        queueItem(1, '2026-08-19T07:39:45', '2026-08-19T15:06:42'),
        // 复习晚于更新 -> 复习
        queueItem(2, '2026-08-30T20:00:00', '2026-08-14T10:55:58'),
      ]),
    ).toEqual(['已更新 08-19', '复习 2天前'])
  })

  // 导入会在无笔记时自动写笔记，笔记时间与导入时间同秒，此时不能算复习过。
  it('treats identical timestamps as an update rather than a review', () => {
    expect(labelsOf([queueItem(1, '2026-08-21T11:22:12', '2026-08-21T11:22:12')])).toEqual([
      '已更新 08-21',
    ])
  })

  it('keeps the datetime attribute pointing at the timestamp being shown', () => {
    const wrapper = mount(ReviewQueue, {
      props: {
        items: [queueItem(1, '2026-08-19T07:39:45', '2026-08-19T15:06:42'), queueItem(2, null)],
        currentProblemId: 1,
      },
    })

    const stamps = wrapper.findAll('.queue-time')
    expect(at(stamps, 0).attributes('datetime')).toBe('2026-08-19T15:06:42')
    expect(at(stamps, 0).classes()).toContain('updated')
    expect(at(stamps, 1).attributes('datetime')).toBeUndefined()
    expect(at(stamps, 1).classes()).toContain('never')
  })

  // 打开页面时队列不再停在第一题：数据到达后把当前题滚到列表中部。
  it('scrolls the current problem to the middle when the queue data arrives', async () => {
    mount(ReviewQueue, {
      props: {
        items: [queueItem(1, null), queueItem(2, null), queueItem(3, null)],
        currentProblemId: 2,
      },
    })

    await nextTick()

    expect(Element.prototype.scrollIntoView).toHaveBeenCalledWith({ block: 'center' })
  })

  it('relocates the current problem after the queue is refreshed', async () => {
    const wrapper = mount(ReviewQueue, {
      props: { items: [queueItem(1, null), queueItem(2, null)], currentProblemId: 1 },
    })
    await nextTick()
    vi.mocked(Element.prototype.scrollIntoView).mockClear()

    await wrapper.setProps({
      items: [queueItem(1, null), queueItem(2, null), queueItem(3, null)],
      currentProblemId: 1,
    })
    await nextTick()
    await nextTick()

    expect(Element.prototype.scrollIntoView).toHaveBeenCalledWith({ block: 'center' })
  })

  // 点击切题：目标题已在视口内，最小滚动，避免列表跳动。
  it('uses the minimal scroll when the current problem changes', async () => {
    const wrapper = mount(ReviewQueue, {
      props: { items: [queueItem(1, null), queueItem(2, null)], currentProblemId: 1 },
    })
    await nextTick()
    vi.mocked(Element.prototype.scrollIntoView).mockClear()

    await wrapper.setProps({ currentProblemId: 2 })
    await nextTick()
    await nextTick()

    expect(Element.prototype.scrollIntoView).toHaveBeenCalledWith({ block: 'nearest' })
  })
})
