package com.leetrecall.dictation.vo;

import java.math.BigDecimal;
import java.util.List;

public record DictationSubmitVO(
        int correctCount,
        int totalCount,
        BigDecimal accuracy,
        boolean viewedAnswer,
        List<DictationResultItemVO> resultItems
) {
}

