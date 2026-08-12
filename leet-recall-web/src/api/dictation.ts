import { http, unwrap } from './http'
import type { ApiResponse } from '@/types/api'
import type {
  DictationAnswer,
  DictationProblemDetail,
  DictationRecordDetail,
  DictationRecordPage,
  DictationSubmitResult,
  TodayDictationQueue,
} from '@/types/dictation'

function sessionHeaders(sessionId: string) {
  return { 'X-Dictation-Session': sessionId }
}

export const dictationApi = {
  getTodayQueue: () => unwrap(http.get<ApiResponse<TodayDictationQueue>>('/dictations/today')),

  getProblemDetail: (problemId: number) => unwrap(
    http.get<ApiResponse<DictationProblemDetail>>(`/dictations/problems/${problemId}`),
  ),

  viewAnswer: (problemId: number, sessionId: string) => unwrap(
    http.get<ApiResponse<DictationAnswer>>(`/dictations/problems/${problemId}/answer`, {
      headers: sessionHeaders(sessionId),
    }),
  ),

  submit: (
    problemId: number,
    sessionId: string,
    answers: Record<string, string>,
    viewedAnswer: boolean,
    durationSeconds: number,
  ) => unwrap(http.post<ApiResponse<DictationSubmitResult>>(
    `/dictations/problems/${problemId}/submit`,
    { answers, viewedAnswer, durationSeconds },
    { headers: sessionHeaders(sessionId) },
  )),

  getRecords: (problemId: number, page = 1, pageSize = 10) => unwrap(
    http.get<ApiResponse<DictationRecordPage>>(`/dictations/problems/${problemId}/records`, {
      params: { page, pageSize },
    }),
  ),

  getRecordDetail: (problemId: number, recordId: number) => unwrap(
    http.get<ApiResponse<DictationRecordDetail>>(
      `/dictations/problems/${problemId}/records/${recordId}`,
    ),
  ),
}

