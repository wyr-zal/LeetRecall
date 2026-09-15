package com.leetrecall.review.vo;

import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.common.enums.MasteryLevel;

import java.time.LocalDateTime;
import java.util.List;

public record ReviewQueueItemVO(
        Long problemId,
        Integer leetcodeNumber,
        String title,
        Difficulty difficulty,
        List<String> tags,
        MasteryLevel masteryLevel,
        boolean completed,
        MasteryLevel todayResult,
        LocalDateTime lastReviewedAt,
        LocalDateTime contentUpdatedAt
) {
}

