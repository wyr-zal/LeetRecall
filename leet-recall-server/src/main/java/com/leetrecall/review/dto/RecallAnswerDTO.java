package com.leetrecall.review.dto;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record RecallAnswerDTO(
        @NotNull Long questionId,
        @Size(max = 2000) String answer
) {
}

