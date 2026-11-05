import type { OfflineMeta, OfflinePack, OfflineProblem } from '@/types/offline'
import { OFFLINE_SCHEMA_VERSION } from '@/types/offline'

export function createProblem(problemId: number, title: string): OfflineProblem {
  return {
    problemId,
    leetcodeNumber: problemId,
    hot100Order: problemId,
    title,
    difficulty: 'MEDIUM',
    tags: ['数组'],
    descriptionMarkdown: `${title}题面`,
    recallQuestions: [],
    hint: '',
    coreIdea: '',
    mistakes: [],
    keyCode: '',
    fullCode: '',
    templateCode: '',
    dictationAnswers: {},
    keywords: [],
    noteMarkdown: '',
    noteUpdatedAt: null,
    annotations: [],
    updatedAt: null,
  }
}

export function createPack(problems: OfflineProblem[]): OfflinePack {
  return { schemaVersion: OFFLINE_SCHEMA_VERSION, problemCount: problems.length, problems }
}

export function createMeta(problemCount: number, etag = '"pack-v1"'): OfflineMeta {
  const now = Date.now()
  return {
    etag,
    downloadedAt: now,
    packBytes: 1024,
    schemaVersion: OFFLINE_SCHEMA_VERSION,
    problemCount,
    lastCheckedAt: now,
  }
}
