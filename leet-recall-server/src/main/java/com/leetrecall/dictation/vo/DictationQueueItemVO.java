package com.leetrecall.dictation.vo;

import java.math.BigDecimal;

public record DictationQueueItemVO(
        Long problemId,
        Integer leetcodeNumber,
        String title,
        boolean completed,
        BigDecimal accuracy
) {
}

