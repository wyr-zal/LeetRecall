package com.leetrecall.review.vo;

import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.common.enums.MasteryLevel;
import lombok.Data;

@Data
public class ReviewQueueRow {
    private Long problemId;
    private Integer leetcodeNumber;
    private String title;
    private Difficulty difficulty;
    private MasteryLevel masteryLevel;
    private Boolean completed;
    private MasteryLevel todayResult;
}

