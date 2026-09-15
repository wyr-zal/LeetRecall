package com.leetrecall.review.vo;

import com.leetrecall.common.enums.Difficulty;

import java.time.LocalDateTime;
import java.util.List;

public record ReviewProblemDetailVO(
        Long problemId,
        Integer leetcodeNumber,
        String title,
        Difficulty difficulty,
        String descriptionMarkdown,
        List<String> tags,
        List<RecallQuestionVO> recallQuestions,
        String hint,
        String coreIdea,
        List<String> mistakes,
        String keyCode,
        LocalDateTime updatedAt,
        boolean externalImported
) {
}
