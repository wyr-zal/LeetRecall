package com.leetrecall.externalimport.model;

import com.leetrecall.common.enums.Difficulty;

import java.util.List;
import java.util.Map;

public record ExternalImportPayload(
        Integer leetcodeNumber,
        String title,
        Difficulty difficulty,
        String descriptionMarkdown,
        List<String> tags,
        String coreIdea,
        String hint,
        List<String> mistakes,
        String fullCode,
        String keyCode,
        List<RecallQuestion> recallQuestions,
        Dictation dictation
) {
    public record RecallQuestion(String question, String answer) { }
    public record Dictation(String language, String templateCode, Map<String, String> answers, List<String> keywords) { }
}
