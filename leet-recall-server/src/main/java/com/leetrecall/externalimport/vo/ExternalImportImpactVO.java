package com.leetrecall.externalimport.vo;

import java.util.List;

public record ExternalImportImpactVO(
        boolean overwriteExisting,
        Long existingProblemId,
        List<String> preserved,
        List<String> replaced,
        boolean requiresConfirmation
) { }
