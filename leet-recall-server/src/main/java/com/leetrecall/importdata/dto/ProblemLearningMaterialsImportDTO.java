package com.leetrecall.importdata.dto;

import java.util.List;
import java.util.Map;

/** External learning materials that may be updated without changing official problem data. */
public record ProblemLearningMaterialsImportDTO(
        Integer leetcodeNumber,
        String noteMarkdown,
        String coreIdea,
        String hint,
        List<String> mistakes,
        String fullCode,
        String keyCode,
        List<RecallQuestion> recallQuestions,
        String dictationTemplate,
        Map<String, String> dictationAnswers,
        List<String> keywords
) {
    public record RecallQuestion(String question, String answer) { }
}
