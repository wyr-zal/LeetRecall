package com.leetrecall.offline.vo;

import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.problem.vo.CodeAnnotationVO;
import com.leetrecall.review.vo.RecallQuestionVO;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

/**
 * 一道题的完整离线快照。字段覆盖复习页与默写页的只读内容，
 * 前端按页面需要映射成现有 VO，不直接暴露给业务组件。
 */
public record OfflineProblemVO(
        Long problemId,
        Integer leetcodeNumber,
        Integer hot100Order,
        String title,
        Difficulty difficulty,
        List<String> tags,
        String descriptionMarkdown,
        List<RecallQuestionVO> recallQuestions,
        String hint,
        String coreIdea,
        List<String> mistakes,
        String keyCode,
        String fullCode,
        String templateCode,
        Map<String, String> dictationAnswers,
        List<String> keywords,
        String noteMarkdown,
        LocalDateTime noteUpdatedAt,
        List<CodeAnnotationVO> annotations,
        LocalDateTime updatedAt
) {
}