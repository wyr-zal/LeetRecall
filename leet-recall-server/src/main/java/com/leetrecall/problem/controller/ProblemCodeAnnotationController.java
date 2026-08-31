package com.leetrecall.problem.controller;

import com.leetrecall.common.response.ApiResponse;
import com.leetrecall.problem.dto.CodeAnnotationSaveDTO;
import com.leetrecall.problem.service.ProblemCodeAnnotationService;
import com.leetrecall.problem.vo.CodeAnnotationVO;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/problems/{problemId}/code-annotations")
@RequiredArgsConstructor
public class ProblemCodeAnnotationController {
    private final ProblemCodeAnnotationService annotationService;

    @GetMapping
    public ApiResponse<List<CodeAnnotationVO>> list(@PathVariable Long problemId) {
        return ApiResponse.success(annotationService.list(problemId));
    }

    @PostMapping
    public ApiResponse<CodeAnnotationVO> create(
            @PathVariable Long problemId,
            @Valid @RequestBody CodeAnnotationSaveDTO request
    ) {
        return ApiResponse.success(annotationService.create(problemId, request));
    }

    @PutMapping("/{annotationId}")
    public ApiResponse<CodeAnnotationVO> update(
            @PathVariable Long problemId,
            @PathVariable Long annotationId,
            @Valid @RequestBody CodeAnnotationSaveDTO request
    ) {
        return ApiResponse.success(annotationService.update(problemId, annotationId, request));
    }

    @DeleteMapping("/{annotationId}")
    public ApiResponse<Void> delete(@PathVariable Long problemId, @PathVariable Long annotationId) {
        annotationService.delete(problemId, annotationId);
        return ApiResponse.success();
    }
}
