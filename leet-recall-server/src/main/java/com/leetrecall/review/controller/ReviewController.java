package com.leetrecall.review.controller;

import com.leetrecall.common.response.ApiResponse;
import com.leetrecall.review.dto.ReviewSubmitDTO;
import com.leetrecall.review.service.ReviewService;
import com.leetrecall.review.vo.ReviewProblemDetailVO;
import com.leetrecall.review.vo.ReviewSubmitVO;
import com.leetrecall.review.vo.TodayReviewQueueVO;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/reviews")
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    @GetMapping("/today")
    public ApiResponse<TodayReviewQueueVO> getTodayQueue() {
        return ApiResponse.success(reviewService.getTodayQueue());
    }

    @GetMapping("/streak")
    public ApiResponse<Integer> getReviewStreak() {
        return ApiResponse.success(reviewService.getReviewStreak());
    }

    @GetMapping("/problems/{problemId}")
    public ApiResponse<ReviewProblemDetailVO> getProblemDetail(@PathVariable Long problemId) {
        return ApiResponse.success(reviewService.getProblemDetail(problemId));
    }

    @PostMapping("/problems/{problemId}/submit")
    public ApiResponse<ReviewSubmitVO> submit(
            @PathVariable Long problemId,
            @Valid @RequestBody ReviewSubmitDTO request
    ) {
        return ApiResponse.success(reviewService.submit(problemId, request));
    }
}
