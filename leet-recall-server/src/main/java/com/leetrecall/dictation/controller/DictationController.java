package com.leetrecall.dictation.controller;

import com.leetrecall.common.response.ApiResponse;
import com.leetrecall.common.response.PageResponse;
import com.leetrecall.dictation.dto.DictationSubmitDTO;
import com.leetrecall.dictation.service.DictationService;
import com.leetrecall.dictation.vo.DictationAnswerVO;
import com.leetrecall.dictation.vo.DictationProblemDetailVO;
import com.leetrecall.dictation.vo.DictationRecordDetailVO;
import com.leetrecall.dictation.vo.DictationRecordVO;
import com.leetrecall.dictation.vo.DictationSubmitVO;
import com.leetrecall.dictation.vo.TodayDictationQueueVO;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import lombok.RequiredArgsConstructor;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Validated
@RestController
@RequestMapping("/api/dictations")
@RequiredArgsConstructor
public class DictationController {

    private final DictationService dictationService;

    @GetMapping("/today")
    public ApiResponse<TodayDictationQueueVO> getTodayQueue() {
        return ApiResponse.success(dictationService.getTodayQueue());
    }

    @GetMapping("/problems/{problemId}")
    public ApiResponse<DictationProblemDetailVO> getProblemDetail(@PathVariable Long problemId) {
        return ApiResponse.success(dictationService.getProblemDetail(problemId));
    }

    @GetMapping("/problems/{problemId}/answer")
    public ApiResponse<DictationAnswerVO> viewAnswer(
            @PathVariable Long problemId,
            @RequestHeader("X-Dictation-Session") @NotBlank String sessionId
    ) {
        return ApiResponse.success(dictationService.viewAnswer(problemId, sessionId));
    }

    @PostMapping("/problems/{problemId}/submit")
    public ApiResponse<DictationSubmitVO> submit(
            @PathVariable Long problemId,
            @RequestHeader("X-Dictation-Session") @NotBlank String sessionId,
            @Valid @RequestBody DictationSubmitDTO request
    ) {
        return ApiResponse.success(dictationService.submit(problemId, sessionId, request));
    }

    @GetMapping("/problems/{problemId}/records")
    public ApiResponse<PageResponse<DictationRecordVO>> getRecords(
            @PathVariable Long problemId,
            @RequestParam(defaultValue = "1") @Min(1) int page,
            @RequestParam(defaultValue = "10") @Min(1) @Max(50) int pageSize
    ) {
        return ApiResponse.success(dictationService.getRecords(problemId, page, pageSize));
    }

    @GetMapping("/problems/{problemId}/records/{recordId}")
    public ApiResponse<DictationRecordDetailVO> getRecordDetail(
            @PathVariable Long problemId,
            @PathVariable Long recordId
    ) {
        return ApiResponse.success(dictationService.getRecordDetail(problemId, recordId));
    }
}

