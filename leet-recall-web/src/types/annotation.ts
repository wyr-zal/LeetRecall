export interface CodeAnnotation {
  id: number
  problemId: number
  label?: string | null
  anchorText: string
  occurrenceIndex: number
  startLine: number
  startColumn: number
  endLine: number
  endColumn: number
  contentMarkdown: string
  createdAt: string
  updatedAt: string
}

export interface CodeAnnotationAnchor {
  anchorText: string
  occurrenceIndex: number
  startLine: number
  startColumn: number
  endLine: number
  endColumn: number
}

export interface CodeAnnotationInput extends CodeAnnotationAnchor {
  label?: string | null
  contentMarkdown: string
}

export interface ResolvedCodeAnnotation extends CodeAnnotation {
  resolved: boolean
  relocated: boolean
}
