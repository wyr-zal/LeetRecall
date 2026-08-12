import { readStorage, writeStorage } from '@/utils/storage'

export const ACTIVE_PROBLEM_KEY = 'leet-recall:active-problem'

export function readActiveProblemId(): number | null {
  const value = readStorage<unknown>(ACTIVE_PROBLEM_KEY, null)
  return typeof value === 'number' && Number.isInteger(value) && value > 0 ? value : null
}

export function writeActiveProblemId(problemId: number): void {
  writeStorage(ACTIVE_PROBLEM_KEY, problemId)
}
