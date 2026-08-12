package com.leetrecall.externalimport.controller;

import com.leetrecall.common.response.ApiResponse;
import com.leetrecall.externalimport.dto.ExternalImportConfirmRequest;
import com.leetrecall.externalimport.dto.ExternalImportDraftRequest;
import com.leetrecall.externalimport.service.ExternalImportDraftService;
import com.leetrecall.externalimport.vo.ExternalImportDraftResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/external-import-drafts")
@RequiredArgsConstructor
public class ExternalImportController {
    private final ExternalImportDraftService draftService;

    @PostMapping
    public ApiResponse<ExternalImportDraftResponse> create(@Valid @RequestBody ExternalImportDraftRequest request) {
        return ApiResponse.success(draftService.create(request));
    }

    @GetMapping("/{draftId}")
    public ApiResponse<ExternalImportDraftResponse> get(@PathVariable Long draftId) {
        return ApiResponse.success(draftService.get(draftId));
    }

    @PutMapping("/{draftId}")
    public ApiResponse<ExternalImportDraftResponse> update(@PathVariable Long draftId, @Valid @RequestBody ExternalImportDraftRequest request) {
        return ApiResponse.success(draftService.update(draftId, request));
    }

    @PostMapping("/{draftId}/confirm")
    public ApiResponse<ExternalImportDraftResponse> confirm(@PathVariable Long draftId, @RequestBody(required = false) ExternalImportConfirmRequest request) {
        return ApiResponse.success(draftService.confirm(draftId, request != null && request.confirmOverwrite()));
    }
}
