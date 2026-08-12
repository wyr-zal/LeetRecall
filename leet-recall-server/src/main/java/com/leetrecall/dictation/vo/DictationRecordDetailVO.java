package com.leetrecall.dictation.vo;

import java.util.List;
import java.util.Map;

public record DictationRecordDetailVO(
        Long id,
        String templateCode,
        Map<String, String> submittedAnswers,
        Map<String, String> correctAnswers,
        List<String> incorrectBlankKeys,
        boolean viewedAnswer,
        boolean legacySnapshot
) {
}
