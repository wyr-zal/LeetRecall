package com.leetrecall.problem.vo;

import java.time.LocalDateTime;

public record ProblemNoteVO(Long problemId, String markdown, LocalDateTime updatedAt) {
}
