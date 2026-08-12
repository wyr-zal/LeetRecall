package com.leetrecall.dictation.vo;

import com.leetrecall.common.enums.Language;

import java.util.List;

public record DictationProblemDetailVO(
        Long problemId,
        Integer leetcodeNumber,
        String title,
        List<String> tags,
        Language language,
        String templateCode,
        List<String> keywords,
        List<String> mistakes
) {
}

