import type { PageResult } from './api'
import type { Difficulty, RecallQuestion } from './problem'

export interface DictationQueueItem {
  problemId: number
  leetcodeNumber: number
  title: string
  completed: boolean
  accuracy?: number
}

export interface TodayDictationQueue {
  total: number
  completed: number
  items: DictationQueueItem[]
}

export interface DictationProblemDetail {
  problemId: number
  leetcodeNumber: number
  title: string
  difficulty: Difficulty
  tags: string[]
  descriptionMarkdown: string
  recallQuestions: RecallQuestion[]
  coreIdea: string
  language: 'JAVA'
  templateCode: string
  keywords: string[]
  mistakes: string[]
}

export interface DictationAnswer {
  answers: Record<string, string>
  fullCode: string
}

export interface DictationResultItem {
  blankKey: string
  submittedAnswer: string
  correctAnswer: string
  correct: boolean
}

export interface DictationSubmitResult {
  correctCount: number
  totalCount: number
  accuracy: number
  viewedAnswer: boolean
  resultItems: DictationResultItem[]
}

export interface DictationRecord {
  id: number
  createdAt: string
  accuracy: number
  durationSeconds: number
  viewedAnswer: boolean
}

export interface DictationRecordDetail {
  id: number
  templateCode?: string | null
  submittedAnswers: Record<string, string>
  correctAnswers: Record<string, string>
  incorrectBlankKeys: string[]
  viewedAnswer: boolean
  legacySnapshot: boolean
}

export type DictationRecordPage = PageResult<DictationRecord>
