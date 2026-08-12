package com.leetrecall.externalimport.vo;

import com.leetrecall.common.enums.Difficulty;

public record ExternalImportTaskPackVO(
        Integer leetcodeNumber,
        String title,
        Difficulty difficulty,
        String problemUrl,
        String descriptionMarkdown,
        String javaStarterCode,
        String instructionMarkdown,
        String exampleJson
) { }
