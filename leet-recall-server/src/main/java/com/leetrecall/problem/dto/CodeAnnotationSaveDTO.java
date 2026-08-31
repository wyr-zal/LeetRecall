package com.leetrecall.problem.dto;

import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record CodeAnnotationSaveDTO(
        @Size(max = 60, message = "标题不能超过 60 个字符")
        String label,

        @NotBlank(message = "批注的代码片段不能为空")
        @Size(max = 500, message = "批注的代码片段不能超过 500 个字符")
        String anchorText,

        @NotNull(message = "不能为空")
        @Min(value = 0, message = "不能小于 0")
        Integer occurrenceIndex,

        @NotNull(message = "不能为空")
        @Min(value = 1, message = "不能小于 1")
        Integer startLine,

        @NotNull(message = "不能为空")
        @Min(value = 1, message = "不能小于 1")
        Integer startColumn,

        @NotNull(message = "不能为空")
        @Min(value = 1, message = "不能小于 1")
        Integer endLine,

        @NotNull(message = "不能为空")
        @Min(value = 1, message = "不能小于 1")
        Integer endColumn,

        @NotBlank(message = "批注内容不能为空")
        @Size(max = 100_000, message = "批注内容不能超过 100000 个字符")
        String contentMarkdown
) {
}
