package com.leetrecall.externalimport.vo;

import com.fasterxml.jackson.databind.JsonNode;

import java.time.LocalDateTime;
import java.util.List;

public record ExternalImportDraftResponse(
        Long id,
        String status,
        Integer leetcodeNumber,
        String content,
        JsonNode payload,
        List<String> validationErrors,
        Boolean compilePassed,
        String compileOutput,
        Long publishedProblemId,
        ExternalImportImpactVO impact,
        LocalDateTime confirmedAt,
        LocalDateTime createdAt,
        LocalDateTime updatedAt
) { }
