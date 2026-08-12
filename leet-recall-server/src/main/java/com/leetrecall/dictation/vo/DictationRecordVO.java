package com.leetrecall.dictation.vo;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record DictationRecordVO(
        Long id,
        LocalDateTime createdAt,
        BigDecimal accuracy,
        int durationSeconds,
        boolean viewedAnswer
) {
}

