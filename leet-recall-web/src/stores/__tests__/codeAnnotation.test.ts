import { createPinia, setActivePinia } from 'pinia'
import { codeAnnotationApi } from '@/api/codeAnnotation'
import { useCodeAnnotationStore } from '@/stores/codeAnnotation'
import type { CodeAnnotation } from '@/types/annotation'

function annotation(id: number, problemId = 1): CodeAnnotation {
  return {
    id,
    problemId,
    label: `批注 ${id}`,
    anchorText: 'return result;',
    occurrenceIndex: 0,
    startLine: id,
    startColumn: 1,
    endLine: id,
    endColumn: 15,
    contentMarkdown: `说明 ${id}`,
    createdAt: '2026-08-31T10:00:00',
    updatedAt: '2026-08-31T10:00:00',
  }
}

describe('codeAnnotationStore', () => {
  beforeEach(() => setActivePinia(createPinia()))
  afterEach(() => vi.restoreAllMocks())

  it('loads annotations and resolves them against the current answer code', async () => {
    vi.spyOn(codeAnnotationApi, 'list').mockResolvedValue([annotation(1)])
    const store = useCodeAnnotationStore()

    await store.load(1, 'class A {\nreturn result;\n}')

    expect(codeAnnotationApi.list).toHaveBeenCalledWith(1)
    expect(store.resolvedAnnotations[0]).toMatchObject({ resolved: true, startLine: 2 })
    expect(store.loading).toBe(false)
  })

  it('updates local state only after create and update succeed', async () => {
    vi.spyOn(codeAnnotationApi, 'list').mockResolvedValue([])
    vi.spyOn(codeAnnotationApi, 'create').mockResolvedValue(annotation(2))
    vi.spyOn(codeAnnotationApi, 'update').mockResolvedValue(annotation(1, 1))
    const store = useCodeAnnotationStore()
    await store.load(1, 'return result;')

    await store.create({
      anchorText: 'return result;', occurrenceIndex: 0, startLine: 1, startColumn: 1,
      endLine: 1, endColumn: 15, label: '新增', contentMarkdown: '内容',
    })
    expect(store.annotations.map((item) => item.id)).toEqual([2])

    await store.update(2, {
      anchorText: 'return result;', occurrenceIndex: 0, startLine: 1, startColumn: 1,
      endLine: 1, endColumn: 15, label: '更新', contentMarkdown: '新内容',
    })
    expect(store.annotations[0]?.label).toBe('批注 1')
  })

  it('keeps local state and exposes an error when deletion fails', async () => {
    vi.spyOn(codeAnnotationApi, 'list').mockResolvedValue([annotation(1)])
    vi.spyOn(codeAnnotationApi, 'delete').mockRejectedValue(new Error('网络不可用'))
    const store = useCodeAnnotationStore()
    await store.load(1, 'return result;')

    expect(await store.remove(1)).toBe(false)
    expect(store.annotations).toHaveLength(1)
    expect(store.error).toBe('网络不可用')
  })
})
