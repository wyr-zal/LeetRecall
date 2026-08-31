import type {
  CodeAnnotation,
  CodeAnnotationAnchor,
  ResolvedCodeAnnotation,
} from '@/types/annotation'

export interface CodePosition {
  line: number
  column: number
}

function toOffset(code: string, position: CodePosition): number | null {
  if (position.line < 1 || position.column < 1) return null
  const lines = code.split('\n')
  if (position.line > lines.length) return null
  const line = lines[position.line - 1] ?? ''
  if (position.column > line.length + 1) return null
  let offset = 0
  for (let index = 0; index < position.line - 1; index += 1) {
    offset += (lines[index] ?? '').length + 1
  }
  return offset + position.column - 1
}

function toPosition(code: string, offset: number): CodePosition {
  const before = code.slice(0, offset)
  const line = before.split('\n').length
  const lastBreak = before.lastIndexOf('\n')
  return { line, column: offset - lastBreak }
}

function rangeText(code: string, anchor: CodeAnnotationAnchor): string | null {
  const start = toOffset(code, { line: anchor.startLine, column: anchor.startColumn })
  const end = toOffset(code, { line: anchor.endLine, column: anchor.endColumn })
  if (start === null || end === null || end < start) return null
  return code.slice(start, end)
}

function findOccurrence(code: string, text: string, occurrenceIndex: number): number {
  if (!text || occurrenceIndex < 0) return -1
  let from = 0
  for (let occurrence = 0; occurrence <= occurrenceIndex; occurrence += 1) {
    const found = code.indexOf(text, from)
    if (found < 0) return -1
    if (occurrence === occurrenceIndex) return found
    from = found + Math.max(text.length, 1)
  }
  return -1
}

export function resolveCodeAnnotation(
  annotation: CodeAnnotation,
  code: string,
): ResolvedCodeAnnotation {
  const anchor: CodeAnnotationAnchor = annotation
  const start = toOffset(code, { line: anchor.startLine, column: anchor.startColumn })
  const end = toOffset(code, { line: anchor.endLine, column: anchor.endColumn })
  if (start !== null && end !== null && end >= start && rangeText(code, anchor) === anchor.anchorText) {
    return { ...annotation, resolved: true, relocated: false }
  }

  const relocatedStart = findOccurrence(code, annotation.anchorText, annotation.occurrenceIndex)
  if (relocatedStart < 0) return { ...annotation, resolved: false, relocated: false }
  const relocatedEnd = relocatedStart + annotation.anchorText.length
  const relocatedStartPosition = toPosition(code, relocatedStart)
  const relocatedEndPosition = toPosition(code, relocatedEnd)
  return {
    ...annotation,
    startLine: relocatedStartPosition.line,
    startColumn: relocatedStartPosition.column,
    endLine: relocatedEndPosition.line,
    endColumn: relocatedEndPosition.column,
    resolved: true,
    relocated: true,
  }
}

export function resolveCodeAnnotations(
  annotations: CodeAnnotation[],
  code: string,
): ResolvedCodeAnnotation[] {
  return annotations.map((annotation) => resolveCodeAnnotation(annotation, code))
}
