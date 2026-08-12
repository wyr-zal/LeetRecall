import { http, unwrap } from './http'
import type { ApiResponse } from '@/types/api'
import type { ProblemNote } from '@/types/problem'

export const problemNoteApi = {
  get: (problemId: number) => unwrap(
    http.get<ApiResponse<ProblemNote>>(`/problems/${problemId}/note`),
  ),

  save: (problemId: number, markdown: string) => unwrap(
    http.put<ApiResponse<ProblemNote>>(`/problems/${problemId}/note`, { markdown }),
  ),
}
