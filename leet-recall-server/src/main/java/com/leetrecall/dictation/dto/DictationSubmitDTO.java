package com.leetrecall.dictation.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.util.Map;

public record DictationSubmitDTO(
        @NotNull @Size(max = 30) Map<String, @Size(max = 1000) String> answers,
        boolean viewedAnswer,
        @Min(0) @Max(86400) int durationSeconds
) {
}

