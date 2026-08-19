package com.leetrecall.importdata.dto;

import com.leetrecall.common.enums.Difficulty;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import jakarta.validation.constraints.Size;

import java.util.List;
import java.util.Map;

public record ProblemCreateDTO(
        @NotNull @Positive Integer leetcodeNumber,
        @NotBlank @Size(max = 255) String title,
        @NotNull Difficulty difficulty,
        @NotBlank @Size(max = 100_000) String descriptionMarkdown,
        @Size(max = 100_000) String noteMarkdown,
        @NotEmpty @Size(max = 10) List<@NotBlank @Size(max = 50) String> tags,
        @NotBlank String coreIdea,
        @NotBlank @Size(max = 100) String hint,
        @NotEmpty @Size(max = 10) List<@NotBlank @Size(max = 500) String> mistakes,
        @NotBlank String fullCode,
        @NotBlank String keyCode,
        @NotEmpty @Size(min = 1, max = 5) List<@NotBlank @Size(max = 500) String> recallQuestions,
        @NotBlank String dictationTemplate,
        @NotEmpty @Size(max = 30) Map<@NotBlank String, @NotBlank String> dictationAnswers,
        @Size(max = 10) List<@NotBlank @Size(max = 50) String> keywords
) {
    public ProblemCreateDTO {
        tags = tags == null ? List.of() : List.copyOf(tags);
        mistakes = mistakes == null ? List.of() : List.copyOf(mistakes);
        recallQuestions = recallQuestions == null ? List.of() : List.copyOf(recallQuestions);
        dictationAnswers = dictationAnswers == null ? Map.of() : Map.copyOf(dictationAnswers);
        keywords = keywords == null ? List.of() : List.copyOf(keywords);
    }
}
