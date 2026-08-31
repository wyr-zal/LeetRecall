import { http, unwrap } from './http'
import type { ApiResponse } from '@/types/api'
import type { CodeAnnotation, CodeAnnotationInput } from '@/types/annotation'

export const codeAnnotationApi = {
  list: (problemId: number) => unwrap(
    http.get<ApiResponse<CodeAnnotation[]>>(`/problems/${problemId}/code-annotations`),
  ),

  create: (problemId: number, input: CodeAnnotationInput) => unwrap(
    http.post<ApiResponse<CodeAnnotation>>(`/problems/${problemId}/code-annotations`, input),
  ),

  update: (problemId: number, annotationId: number, input: CodeAnnotationInput) => unwrap(
    http.put<ApiResponse<CodeAnnotation>>(
      `/problems/${problemId}/code-annotations/${annotationId}`,
      input,
    ),
  ),

  delete: (problemId: number, annotationId: number) => unwrap(
    http.delete<ApiResponse<void>>(`/problems/${problemId}/code-annotations/${annotationId}`),
  ),
}
