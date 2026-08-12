package com.leetrecall.problem.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record ProblemNoteUpdateDTO(
        @NotNull(message = "不能为空")
        @Size(max = 100_000, message = "不能超过 100000 个字符")
        String markdown
) {
}
