import type { CodeAnnotation } from '@/types/annotation'
import type {
  DictationAnswer,
  DictationProblemDetail,
  DictationRecord,
} from '@/types/dictation'
import type { OfflineProblem } from '@/types/offline'
import type { ProblemNote, ReviewProblemDetail } from '@/types/problem'
import {
  PENDING_ANSWER_VIEW_KEY,
  readProblem,
  readQueueSnapshot,
  updateProblem,
  writeQueueSnapshot,
} from '@/offline/db'

const REVIEW_QUEUE_KEY = 'review-queue'
const DICTATION_QUEUE_KEY = 'dictation-queue'

function historyKey(problemId: number): string {
  return `dictation-history:${problemId}`
}

export function toReviewDetail(problem: OfflineProblem): ReviewProblemDetail {
  return {
    problemId: problem.problemId,
    leetcodeNumber: problem.leetcodeNumber,
    title: problem.title,
    difficulty: problem.difficulty,
    descriptionMarkdown: problem.descriptionMarkdown,
    tags: problem.tags,
    recallQuestions: problem.recallQuestions,
    hint: problem.hint,
    coreIdea: problem.coreIdea,
    mistakes: problem.mistakes,
    keyCode: problem.keyCode,
    updatedAt: problem.updatedAt ?? null,
  }
}

export function toDictationDetail(problem: OfflineProblem): DictationProblemDetail {
  return {
    problemId: problem.problemId,
    leetcodeNumber: problem.leetcodeNumber,
    title: problem.title,
    difficulty: problem.difficulty,
    tags: problem.tags.slice(0, 2),
    descriptionMarkdown: problem.descriptionMarkdown,
    recallQuestions: problem.recallQuestions,
    coreIdea: problem.coreIdea,
    language: 'JAVA',
    templateCode: problem.templateCode,
    keywords: problem.keywords,
    mistakes: problem.mistakes.slice(0, 4),
  }
}

export function toDictationAnswer(problem: OfflineProblem): DictationAnswer {
  return {
    answers: problem.dictationAnswers,
    fullCode: problem.fullCode,
  }
}

export function toNote(problem: OfflineProblem): ProblemNote {
  return {
    problemId: problem.problemId,
    markdown: problem.noteMarkdown,
    updatedAt: problem.noteUpdatedAt ?? null,
  }
}

export function toAnnotations(problem: OfflineProblem): CodeAnnotation[] {
  return problem.annotations
}

export async function readReviewDetail(problemId: number): Promise<ReviewProblemDetail | null> {
  const problem = await readProblem(problemId)
  return problem ? toReviewDetail(problem) : null
}

export async function readDictationDetail(problemId: number): Promise<DictationProblemDetail | null> {
  const problem = await readProblem(problemId)
  return problem ? toDictationDetail(problem) : null
}

export async function readDictationAnswer(problemId: number): Promise<DictationAnswer | null> {
  const problem = await readProblem(problemId)
  return problem ? toDictationAnswer(problem) : null
}

export async function readNote(problemId: number): Promise<ProblemNote | null> {
  const problem = await readProblem(problemId)
  return problem ? toNote(problem) : null
}

export async function readAnnotations(problemId: number): Promise<CodeAnnotation[] | null> {
  const problem = await readProblem(problemId)
  return problem ? toAnnotations(problem) : null
}

export async function cacheReviewDetail(detail: ReviewProblemDetail): Promise<void> {
  await updateProblem(detail.problemId, () => ({
    title: detail.title,
    difficulty: detail.difficulty,
    descriptionMarkdown: detail.descriptionMarkdown,
    tags: detail.tags,
    recallQuestions: detail.recallQuestions,
    hint: detail.hint,
    coreIdea: detail.coreIdea,
    mistakes: detail.mistakes,
    keyCode: detail.keyCode,
    updatedAt: detail.updatedAt ?? null,
  }))
}

export async function cacheDictationDetail(detail: DictationProblemDetail): Promise<void> {
  await updateProblem(detail.problemId, () => ({
    title: detail.title,
    difficulty: detail.difficulty,
    tags: detail.tags,
    descriptionMarkdown: detail.descriptionMarkdown,
    recallQuestions: detail.recallQuestions,
    coreIdea: detail.coreIdea,
    templateCode: detail.templateCode,
    keywords: detail.keywords,
    mistakes: detail.mistakes,
  }))
}

export async function cacheDictationAnswer(problemId: number, answer: DictationAnswer): Promise<void> {
  await updateProblem(problemId, () => ({
    fullCode: answer.fullCode,
    dictationAnswers: answer.answers,
  }))
}

export async function cacheNote(problemId: number, note: ProblemNote): Promise<void> {
  await updateProblem(problemId, () => ({
    noteMarkdown: note.markdown,
    noteUpdatedAt: note.updatedAt ?? null,
  }))
}

export async function cacheAnnotations(problemId: number, annotations: CodeAnnotation[]): Promise<void> {
  await updateProblem(problemId, () => ({ annotations }))
}

export async function cacheReviewQueue<T>(data: T): Promise<void> {
  await writeQueueSnapshot(REVIEW_QUEUE_KEY, data)
}

export async function readReviewQueue<T>(): Promise<{ data: T; savedAt: number } | null> {
  return readQueueSnapshot<T>(REVIEW_QUEUE_KEY)
}

export async function cacheDictationQueue<T>(data: T): Promise<void> {
  await writeQueueSnapshot(DICTATION_QUEUE_KEY, data)
}

export async function readDictationQueue<T>(): Promise<{ data: T; savedAt: number } | null> {
  return readQueueSnapshot<T>(DICTATION_QUEUE_KEY)
}

export async function cacheDictationHistory(problemId: number, records: DictationRecord[]): Promise<void> {
  await writeQueueSnapshot(historyKey(problemId), records)
}

export async function readDictationHistory(problemId: number): Promise<DictationRecord[]> {
  const snapshot = await readQueueSnapshot<DictationRecord[]>(historyKey(problemId))
  return snapshot?.data ?? []
}

export async function addPendingAnswerView(problemId: number): Promise<void> {
  const snapshot = await readQueueSnapshot<number[]>(PENDING_ANSWER_VIEW_KEY)
  const ids = new Set(snapshot?.data ?? [])
  ids.add(problemId)
  await writeQueueSnapshot(PENDING_ANSWER_VIEW_KEY, [...ids])
}

export async function readPendingAnswerViews(): Promise<number[]> {
  const snapshot = await readQueueSnapshot<number[]>(PENDING_ANSWER_VIEW_KEY)
  return snapshot?.data ?? []
}

export async function clearPendingAnswerViews(): Promise<void> {
  await writeQueueSnapshot<number[]>(PENDING_ANSWER_VIEW_KEY, [])
}