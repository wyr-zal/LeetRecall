import { computed, ref } from 'vue'
import { defineStore } from 'pinia'
import { codeAnnotationApi } from '@/api/codeAnnotation'
import type {
  CodeAnnotation,
  CodeAnnotationInput,
  ResolvedCodeAnnotation,
} from '@/types/annotation'
import { resolveCodeAnnotations } from '@/utils/codeAnchor'

export const useCodeAnnotationStore = defineStore('codeAnnotation', () => {
  const problemId = ref<number | null>(null)
  const code = ref('')
  const annotations = ref<CodeAnnotation[]>([])
  const loading = ref(false)
  const saving = ref(false)
  const error = ref('')
  let loadSequence = 0

  const resolvedAnnotations = computed<ResolvedCodeAnnotation[]>(() =>
    resolveCodeAnnotations(annotations.value, code.value))

  async function load(nextProblemId: number, fullCode = ''): Promise<void> {
    const sequence = ++loadSequence
    problemId.value = nextProblemId
    code.value = fullCode
    annotations.value = []
    error.value = ''
    loading.value = true
    try {
      const loaded = await codeAnnotationApi.list(nextProblemId)
      if (sequence === loadSequence && problemId.value === nextProblemId) annotations.value = loaded
    } catch (cause) {
      if (sequence === loadSequence && problemId.value === nextProblemId) {
        error.value = cause instanceof Error ? cause.message : '代码批注读取失败，请重试'
      }
    } finally {
      if (sequence === loadSequence) loading.value = false
    }
  }

  function setCode(fullCode: string): void {
    code.value = fullCode
  }

  async function create(input: CodeAnnotationInput): Promise<CodeAnnotation | null> {
    if (problemId.value === null) return null
    saving.value = true
    error.value = ''
    try {
      const annotation = await codeAnnotationApi.create(problemId.value, input)
      annotations.value = [...annotations.value, annotation]
      return annotation
    } catch (cause) {
      error.value = cause instanceof Error ? cause.message : '代码批注保存失败，请重试'
      return null
    } finally {
      saving.value = false
    }
  }

  async function update(id: number, input: CodeAnnotationInput): Promise<CodeAnnotation | null> {
    if (problemId.value === null) return null
    saving.value = true
    error.value = ''
    try {
      const annotation = await codeAnnotationApi.update(problemId.value, id, input)
      annotations.value = annotations.value.map((item) => item.id === id ? annotation : item)
      return annotation
    } catch (cause) {
      error.value = cause instanceof Error ? cause.message : '代码批注保存失败，请重试'
      return null
    } finally {
      saving.value = false
    }
  }

  async function remove(id: number): Promise<boolean> {
    if (problemId.value === null) return false
    saving.value = true
    error.value = ''
    try {
      await codeAnnotationApi.delete(problemId.value, id)
      annotations.value = annotations.value.filter((item) => item.id !== id)
      return true
    } catch (cause) {
      error.value = cause instanceof Error ? cause.message : '代码批注删除失败，请重试'
      return false
    } finally {
      saving.value = false
    }
  }

  return {
    problemId,
    annotations,
    resolvedAnnotations,
    loading,
    saving,
    error,
    load,
    setCode,
    create,
    update,
    remove,
  }
})
