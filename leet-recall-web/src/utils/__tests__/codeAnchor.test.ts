import { describe, expect, it } from 'vitest'
import type { CodeAnnotation } from '@/types/annotation'
import { resolveCodeAnnotation, resolveCodeAnnotations } from '@/utils/codeAnchor'

function annotation(overrides: Partial<CodeAnnotation> = {}): CodeAnnotation {
  return {
    id: 1,
    problemId: 7,
    label: '循环边界',
    anchorText: 'int count = 0;',
    occurrenceIndex: 0,
    startLine: 2,
    startColumn: 1,
    endLine: 2,
    endColumn: 15,
    contentMarkdown: '说明',
    createdAt: '2026-08-31T10:00:00',
    updatedAt: '2026-08-31T10:00:00',
    ...overrides,
  }
}

describe('codeAnchor', () => {
  it('keeps a matching position anchor', () => {
    const result = resolveCodeAnnotation(annotation(), 'class A {\nint count = 0;\n}')

    expect(result).toMatchObject({ resolved: true, relocated: false, startLine: 2, startColumn: 1 })
  })

  it('relocates by the requested text occurrence after code changes', () => {
    const result = resolveCodeAnnotation(
      annotation({ startLine: 2, endLine: 2 }),
      'class A {\n  int other = 0;\n}\nint count = 0;',
    )

    expect(result).toMatchObject({
      resolved: true,
      relocated: true,
      startLine: 4,
      startColumn: 1,
      endLine: 4,
      endColumn: 15,
    })
  })

  it('uses the occurrence index for repeated snippets', () => {
    const result = resolveCodeAnnotation(
      annotation({ occurrenceIndex: 1, startLine: 2, endLine: 2 }),
      'int count = 0;\nint count = 0;',
    )

    expect(result.startLine).toBe(2)
    expect(result.resolved).toBe(true)
  })

  it('marks an annotation stale when the snippet no longer exists', () => {
    const result = resolveCodeAnnotation(annotation(), 'class A {}')

    expect(result).toMatchObject({ resolved: false, relocated: false })
  })

  it('resolves every annotation without dropping stale entries', () => {
    const result = resolveCodeAnnotations([annotation(), annotation({ id: 2, anchorText: 'missing' })], 'int count = 0;')

    expect(result).toHaveLength(2)
    expect(result[0]?.resolved).toBe(true)
    expect(result[1]?.resolved).toBe(false)
  })
})
