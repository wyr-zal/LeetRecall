import { http, unwrap } from './http'
import type {
  ProblemSearchItem,
  ReviewProblemDetail,
  ReviewSubmitRequest,
  ReviewSubmitResult,
  TodayReviewQueue,
} from '@/types/problem'
import type { ApiResponse } from '@/types/api'

export const reviewApi = {
  getTodayQueue: () => unwrap(http.get<ApiResponse<TodayReviewQueue>>('/reviews/today')),

  getReviewStreak: () => unwrap(http.get<ApiResponse<number>>('/reviews/streak')),

  getProblemDetail: (problemId: number) => unwrap(
    http.get<ApiResponse<ReviewProblemDetail>>(`/reviews/problems/${problemId}`),
  ),

  submit: (problemId: number, request: ReviewSubmitRequest) => unwrap(
    http.post<ApiResponse<ReviewSubmitResult>>(`/reviews/problems/${problemId}/submit`, request),
  ),

  searchProblems: (keyword: string) => unwrap(
    http.get<ApiResponse<ProblemSearchItem[]>>('/problems/search', { params: { keyword } }),
  ),
}
