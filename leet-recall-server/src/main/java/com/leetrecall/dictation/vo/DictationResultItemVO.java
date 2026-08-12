package com.leetrecall.dictation.vo;

public record DictationResultItemVO(
        String blankKey,
        String submittedAnswer,
        String correctAnswer,
        boolean correct
) {
}

