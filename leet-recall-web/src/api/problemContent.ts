import { http, unwrap } from './http'
import type { ApiResponse } from '@/types/api'
import type { ProblemContent, ProblemContentUpdate } from '@/types/problem'

export const problemContentApi = {
  get: (problemId: number) => unwrap(
    http.get<ApiResponse<ProblemContent>>(`/problems/${problemId}/content`),
  ),

  save: (problemId: number, request: ProblemContentUpdate) => unwrap(
    http.put<ApiResponse<ProblemContent>>(`/problems/${problemId}/content`, request),
  ),
}
