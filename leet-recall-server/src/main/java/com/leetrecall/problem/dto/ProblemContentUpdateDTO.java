package com.leetrecall.problem.dto;

import com.leetrecall.common.enums.Difficulty;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 约束按 schema.sql 的实际列定义推导，不沿用 ProblemCreateDTO：
 * 后者的注解在导入链路中从未经过 @Valid 绑定，其 hint max=100 等取值与数据库不符。
 * hint / coreIdea / keyCode / answer 对应 TEXT 列，10000 字符（utf8mb4 最多 40KB）留足余量。
 */
public record ProblemContentUpdateDTO(
        @NotBlank(message = "不能为空")
        @Size(max = 255, message = "不能超过 255 个字符")
        String title,

        @NotNull(message = "不能为空")
        Difficulty difficulty,

        @NotBlank(message = "不能为空")
        @Size(max = 100_000, message = "不能超过 100000 个字符")
        String descriptionMarkdown,

        @Size(max = 10, message = "最多 10 个")
        List<@NotBlank(message = "不能为空") @Size(max = 50, message = "不能超过 50 个字符") String> tags,

        // 上限 5 由 ReviewSubmitDTO 的 @Size(max = 5) 决定：超出会让该题提交复习结果失败。
        @Valid
        @NotEmpty(message = "至少需要 1 组")
        @Size(max = 5, message = "最多 5 组")
        List<RecallQuestionInput> recallQuestions,

        @NotBlank(message = "不能为空")
        @Size(max = 10_000, message = "不能超过 10000 个字符")
        String hint,

        @NotBlank(message = "不能为空")
        @Size(max = 10_000, message = "不能超过 10000 个字符")
        String coreIdea,

        @Size(max = 10, message = "最多 10 条")
        List<@NotBlank(message = "不能为空") @Size(max = 500, message = "不能超过 500 个字符") String> mistakes,

        @NotBlank(message = "不能为空")
        @Size(max = 10_000, message = "不能超过 10000 个字符")
        String keyCode
) {
    public ProblemContentUpdateDTO {
        tags = copyTolerantOfNulls(tags);
        mistakes = copyTolerantOfNulls(mistakes);
        recallQuestions = copyTolerantOfNulls(recallQuestions);
    }

    /** List.copyOf 遇到 null 元素会抛 NPE 变成 500；这里保留 null 让 @NotBlank 正常报 400。 */
    private static <T> List<T> copyTolerantOfNulls(List<T> values) {
        return values == null ? List.of() : Collections.unmodifiableList(new ArrayList<>(values));
    }

    /** id 为空表示新增；非空表示更新该行，从而保住 review_record 与本地草稿的 questionId 关联。 */
    public record RecallQuestionInput(
            Long id,

            @NotBlank(message = "不能为空")
            @Size(max = 500, message = "不能超过 500 个字符")
            String question,

            @NotBlank(message = "不能为空")
            @Size(max = 10_000, message = "不能超过 10000 个字符")
            String answer
    ) {
    }
}
