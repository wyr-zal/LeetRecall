package com.leetrecall.externalimport.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record ExternalImportDraftRequest(
        @NotNull Integer hot100Number,
        @NotBlank @Size(max = 200_000) String content
) { }
