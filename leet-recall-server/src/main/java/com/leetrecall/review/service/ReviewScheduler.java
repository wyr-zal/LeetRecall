package com.leetrecall.review.service;

import com.leetrecall.common.enums.MasteryLevel;
import org.springframework.stereotype.Component;

@Component
public class ReviewScheduler {

    private static final int MAX_INTERVAL_DAYS = 30;

    public int nextInterval(MasteryLevel result, int currentIntervalDays) {
        return switch (result) {
            case FORGOT -> 1;
            case FUZZY -> 3;
            case KNOWN -> currentIntervalDays < 3
                    ? 3
                    : Math.min(MAX_INTERVAL_DAYS, currentIntervalDays * 2);
            case NEW -> throw new IllegalArgumentException("NEW 不能作为复习结果");
        };
    }
}

