export type Difficulty = 'EASY' | 'MEDIUM' | 'HARD'
export type MasteryLevel = 'NEW' | 'FORGOT' | 'FUZZY' | 'KNOWN'

export interface ProblemSearchItem {
  problemId: number
  leetcodeNumber: number
  title: string
}

export interface ProblemNote {
  problemId: number
  markdown: string
  updatedAt?: string | null
}

export interface ReviewQueueItem extends ProblemSearchItem {
  difficulty: Difficulty
  tags: string[]
  masteryLevel: MasteryLevel
  completed: boolean
  todayResult?: MasteryLevel
}

export interface TodayReviewQueue {
  total: number
  completed: number
  items: ReviewQueueItem[]
}

export interface RecallQuestion {
  id: number
  question: string
  answer?: string | null
}

export interface ReviewProblemDetail extends ProblemSearchItem {
  difficulty: Difficulty
  descriptionMarkdown: string
  tags: string[]
  recallQuestions: RecallQuestion[]
  hint: string
  coreIdea: string
  mistakes: string[]
  keyCode: string
}

export interface RecallAnswerInput {
  questionId: number
  answer: string
}

export interface ReviewSubmitRequest {
  result: Exclude<MasteryLevel, 'NEW'>
  recallAnswers: RecallAnswerInput[]
  usedHint: boolean
  viewedAnswer: boolean
  durationSeconds: number
}

export interface ReviewSubmitResult {
  nextReviewAt: string
  nextIntervalDays: number
}
