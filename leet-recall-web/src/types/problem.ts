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

/** 编辑模式专用：标签不截断，回忆问答带 id 以便后端差分保存。 */
export interface ProblemContentRecallQuestion {
  id: number
  question: string
  answer: string
}

export interface ProblemContent {
  problemId: number
  leetcodeNumber: number
  title: string
  difficulty: Difficulty
  descriptionMarkdown: string
  tags: string[]
  recallQuestions: ProblemContentRecallQuestion[]
  hint: string
  coreIdea: string
  mistakes: string[]
  keyCode: string
}

/** 新增的问答 id 传 null，后端据此插入新行。 */
export interface ProblemContentRecallQuestionInput {
  id: number | null
  question: string
  answer: string
}

export interface ProblemContentUpdate {
  title: string
  difficulty: Difficulty
  descriptionMarkdown: string
  tags: string[]
  recallQuestions: ProblemContentRecallQuestionInput[]
  hint: string
  coreIdea: string
  mistakes: string[]
  keyCode: string
}

/** 回忆问答上限由后端 ReviewSubmitDTO 的 @Size(max = 5) 决定，超出会让复习提交失败。 */
export const MAX_RECALL_QUESTIONS = 5

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
