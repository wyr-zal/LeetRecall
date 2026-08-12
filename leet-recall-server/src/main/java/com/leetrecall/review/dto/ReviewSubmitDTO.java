package com.leetrecall.review.dto;

import com.leetrecall.common.enums.MasteryLevel;
import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.util.List;

public record ReviewSubmitDTO(
        @NotNull MasteryLevel result,
        @Valid @Size(max = 5) List<RecallAnswerDTO> recallAnswers,
        boolean usedHint,
        boolean viewedAnswer,
        @Min(0) @Max(86400) int durationSeconds
) {
    public ReviewSubmitDTO {
        recallAnswers = recallAnswers == null ? List.of() : List.copyOf(recallAnswers);
    }
}

