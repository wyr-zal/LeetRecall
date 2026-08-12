import { http, unwrap } from './http'
import type { ApiResponse } from '@/types/api'
import type { ExternalImportDraft, ExternalImportDraftRequest, ExternalImportTaskPack, Hot100Manifest } from '@/types/import'

export const problemImportApi = {
  getHot100Manifest: () => unwrap(
    http.get<ApiResponse<Hot100Manifest>>('/hot100'),
  ),
  getExternalImportTask: (number: number) => unwrap(
    http.get<ApiResponse<ExternalImportTaskPack>>(`/hot100/${number}/external-import-task`),
  ),
  createExternalDraft: (request: ExternalImportDraftRequest) => unwrap(
    http.post<ApiResponse<ExternalImportDraft>>('/external-import-drafts', request),
  ),
  updateExternalDraft: (draftId: number, request: ExternalImportDraftRequest) => unwrap(
    http.put<ApiResponse<ExternalImportDraft>>(`/external-import-drafts/${draftId}`, request),
  ),
  confirmExternalDraft: (draftId: number, confirmOverwrite: boolean) => unwrap(
    http.post<ApiResponse<ExternalImportDraft>>(`/external-import-drafts/${draftId}/confirm`, { confirmOverwrite }),
  ),
}
