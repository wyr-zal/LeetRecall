import type { Difficulty } from './problem'

export interface ProblemCreated {
  problemId: number
  leetcodeNumber: number
  title: string
}

export interface Hot100Problem {
  order: number
  group: string
  leetcodeNumber: number
  slug: string
  title: string
  englishTitle: string
  difficulty: Difficulty
  problemUrl: string
}

export interface Hot100Manifest {
  sourceStudyPlanUrl: string
  sourceVersion: string
  generatedAt: string
  problems: Hot100Problem[]
}

export interface ExternalImportTaskPack {
  leetcodeNumber: number
  title: string
  difficulty: Difficulty
  problemUrl: string
  descriptionMarkdown: string
  javaStarterCode: string
  instructionMarkdown: string
  exampleJson: string
}

export interface ExternalImportDraftRequest {
  hot100Number: number
  content: string
}

export interface ExternalImportImpact {
  overwriteExisting: boolean
  existingProblemId?: number | null
  preserved: string[]
  replaced: string[]
  requiresConfirmation: boolean
}

export interface ExternalImportDraft {
  id: number
  status: 'INVALID' | 'READY' | 'IMPORTED'
  leetcodeNumber: number
  content?: string | null
  payload?: Record<string, unknown>
  validationErrors: string[]
  compilePassed?: boolean
  compileOutput?: string
  publishedProblemId?: number
  impact: ExternalImportImpact
  confirmedAt?: string | null
  createdAt: string
  updatedAt: string
}
