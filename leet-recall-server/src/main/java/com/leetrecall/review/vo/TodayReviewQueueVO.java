package com.leetrecall.review.vo;

import java.util.List;

public record TodayReviewQueueVO(int total, int completed, List<ReviewQueueItemVO> items) {
}

