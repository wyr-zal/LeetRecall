package com.leetrecall.hot100.controller;

import com.leetrecall.common.response.ApiResponse;
import com.leetrecall.externalimport.service.ExternalImportTaskPackService;
import com.leetrecall.externalimport.vo.ExternalImportTaskPackVO;
import com.leetrecall.hot100.model.Hot100Manifest;
import com.leetrecall.hot100.service.Hot100ManifestService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/hot100")
@RequiredArgsConstructor
public class Hot100Controller {
    private final Hot100ManifestService hot100ManifestService;
    private final ExternalImportTaskPackService taskPackService;

    @GetMapping
    public ApiResponse<Hot100Manifest> getManifest() {
        return ApiResponse.success(hot100ManifestService.getManifest());
    }

    @GetMapping("/{leetcodeNumber}/external-import-task")
    public ApiResponse<ExternalImportTaskPackVO> getExternalImportTask(@PathVariable Integer leetcodeNumber) {
        return ApiResponse.success(taskPackService.create(leetcodeNumber));
    }
}
