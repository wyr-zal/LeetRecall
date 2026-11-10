import type { CodeAnnotation } from '@/types/annotation'
import type { Difficulty, ProblemSearchItem, RecallQuestion } from '@/types/problem'

/** 服务端离线资料包结构；字段与 OfflineProblemVO 保持一致。 */
export interface OfflineProblem {
  problemId: number
  leetcodeNumber: number
  hot100Order?: number | null
  title: string
  difficulty: Difficulty
  tags: string[]
  descriptionMarkdown: string
  recallQuestions: RecallQuestion[]
  hint: string
  coreIdea: string
  mistakes: string[]
  keyCode: string
  fullCode: string
  templateCode: string
  dictationAnswers: Record<string, string>
  keywords: string[]
  noteMarkdown: string
  noteUpdatedAt?: string | null
  annotations: CodeAnnotation[]
  updatedAt?: string | null
}

export interface OfflinePack {
  schemaVersion: number
  problemCount: number
  problems: OfflineProblem[]
}

export interface OfflineMeta {
  etag: string
  downloadedAt: number
  packBytes: number
  schemaVersion: number
  problemCount: number
  lastCheckedAt: number
  /** 每道题完整缓存最近一次由服务器确认/写入的时间；旧数据缺此项时触发在线刷新。 */
  problemCacheTimes?: Record<string, number>
}

export interface OfflineQueueSnapshot<T> {
  savedAt: number
  data: T
}

export interface OfflineSearchItem extends ProblemSearchItem {
  hot100Order?: number | null
}

export const OFFLINE_SCHEMA_VERSION = 1
