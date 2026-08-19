package com.leetrecall.problem.vo;

import com.leetrecall.common.enums.Difficulty;

import java.util.List;

/**
 * 快速复习页编辑模式的完整内容视图。
 * 与 ReviewProblemDetailVO 的差别：标签不截断，且回忆问答带上 id 以便前端做差分保存。
 */
public record ProblemContentVO(
        Long problemId,
        Integer leetcodeNumber,
        String title,
        Difficulty difficulty,
        String descriptionMarkdown,
        List<String> tags,
        List<RecallQuestionContentVO> recallQuestions,
        String hint,
        String coreIdea,
        List<String> mistakes,
        String keyCode
) {
    public record RecallQuestionContentVO(Long id, String question, String answer) {
    }
}
