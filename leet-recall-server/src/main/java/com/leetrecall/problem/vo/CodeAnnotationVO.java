package com.leetrecall.problem.vo;

import java.time.LocalDateTime;

public record CodeAnnotationVO(
        Long id,
        Long problemId,
        String label,
        String anchorText,
        Integer occurrenceIndex,
        Integer startLine,
        Integer startColumn,
        Integer endLine,
        Integer endColumn,
        String contentMarkdown,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) {
}
