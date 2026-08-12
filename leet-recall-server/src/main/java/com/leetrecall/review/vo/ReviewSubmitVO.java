package com.leetrecall.review.vo;

import java.time.LocalDateTime;

public record ReviewSubmitVO(LocalDateTime nextReviewAt, int nextIntervalDays) {
}

