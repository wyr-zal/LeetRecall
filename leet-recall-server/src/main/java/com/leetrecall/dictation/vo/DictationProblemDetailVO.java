package com.leetrecall.dictation.vo;

import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.common.enums.Language;
import com.leetrecall.review.vo.RecallQuestionVO;

import java.util.List;

public record DictationProblemDetailVO(
        Long problemId,
        Integer leetcodeNumber,
        String title,
        Difficulty difficulty,
        List<String> tags,
        String descriptionMarkdown,
        List<RecallQuestionVO> recallQuestions,
        String coreIdea,
        Language language,
        String templateCode,
        List<String> keywords,
        List<String> mistakes
) {
}

