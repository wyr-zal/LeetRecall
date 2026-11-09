import 'fake-indexeddb/auto'
import { flushPromises, mount } from '@vue/test-utils'
import { createPinia, setActivePinia } from 'pinia'
import { dictationApi } from '@/api/dictation'
import { problemNoteApi } from '@/api/problemNote'
import { reviewApi } from '@/api/review'
import ProblemNotePanel from '@/components/review/ProblemNotePanel.vue'
import { cacheImportedProblem, clearOfflineData, getProblemCacheVersion, invalidateProblem, readProblem, replacePack } from '@/offline/db'
import { markNetworkSuccess } from '@/offline/network'
import { toReviewDetail } from '@/offline/repo'
import { useDictationStore } from '@/stores/dictation'
import { useQuickReviewStore } from '@/stores/quickReview'
import { createMeta, createPack, createProblem } from '@/tests/offlineFixtures'

const old = { ...createProblem(1, '导入题'), coreIdea: '旧思路', fullCode: '旧代码', noteMarkdown: '旧笔记' }
const fresh = { ...old, coreIdea: '新思路', fullCode: '新代码', dictationAnswers: { blank: '新答案' }, noteMarkdown: '新笔记' }

async function replaceImportedCache(): Promise<void> {
  await invalidateProblem(1)
  await cacheImportedProblem(fresh, await getProblemCacheVersion(1))
}

describe('导入前的在途请求', () => {
  beforeEach(async () => {
    localStorage.clear()
    sessionStorage.clear()
    setActivePinia(createPinia())
    markNetworkSuccess()
    await clearOfflineData()
    await replacePack(createPack([old]), createMeta(1))
  })

  afterEach(() => vi.restoreAllMocks())

  it('旧复习详情晚到不会覆盖新缓存，重拉失败仍能读到新思路', async () => {
    let respond!: (detail: ReturnType<typeof toReviewDetail>) => void
    const get = vi.spyOn(reviewApi, 'getProblemDetail').mockReturnValueOnce(new Promise((resolve) => { respond = resolve }))
    const store = useQuickReviewStore()
    const loading = store.loadProblem(1)
    await vi.waitFor(() => expect(get).toHaveBeenCalledTimes(1))
    await replaceImportedCache()
    respond(toReviewDetail(old))

    expect(await loading).toBe(false)
    expect((await readProblem(1))?.coreIdea).toBe('新思路')
    get.mockRejectedValueOnce(new TypeError('断网'))
    expect(await store.loadProblem(1)).toBe(true)
    expect(store.currentProblem?.coreIdea).toBe('新思路')
  })

  it('旧答案晚到不会展开或写回旧代码，断网后查看新缓存答案', async () => {
    vi.spyOn(dictationApi, 'getProblemDetail').mockRejectedValue(new TypeError('断网'))
    vi.spyOn(dictationApi, 'getRecords').mockRejectedValue(new TypeError('断网'))
    let respond!: (answer: { fullCode: string; answers: Record<string, string> }) => void
    const get = vi.spyOn(dictationApi, 'viewAnswer').mockReturnValueOnce(new Promise((resolve) => { respond = resolve }))
    const store = useDictationStore()
    await store.loadProblem(1)
    const revealing = store.setAnswerVisible(true)
    await replaceImportedCache()
    respond({ fullCode: '旧代码', answers: {} })
    await revealing

    expect(store.answerVisible).toBe(false)
    expect((await readProblem(1))?.fullCode).toBe('新代码')
    get.mockRejectedValueOnce(new TypeError('断网'))
    await store.setAnswerVisible(true)
    expect(store.revealedAnswer).toEqual({ fullCode: '新代码', answers: { blank: '新答案' } })
  })

  it('旧笔记请求晚到不会写回旧笔记，面板重新读取后显示新笔记', async () => {
    let respond!: (note: { problemId: number; markdown: string; updatedAt: null }) => void
    const get = vi.spyOn(problemNoteApi, 'get').mockReturnValueOnce(new Promise((resolve) => { respond = resolve }))
    const wrapper = mount(ProblemNotePanel, { props: { problemId: 1 }, global: { stubs: { MarkdownContent: { props: ['content'], template: '<div>{{ content }}</div>' } } } })
    await vi.waitFor(() => expect(get).toHaveBeenCalledTimes(1))
    await replaceImportedCache()
    respond({ problemId: 1, markdown: '旧笔记', updatedAt: null })
    await flushPromises()

    expect((await readProblem(1))?.noteMarkdown).toBe('新笔记')
    get.mockRejectedValueOnce(new TypeError('断网'))
    expect(await wrapper.vm.reload()).toBe(true)
    expect(wrapper.text()).toContain('新笔记')
    wrapper.unmount()
  })
})
