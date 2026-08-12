package com.leetrecall.hot100.model;

import com.leetrecall.common.enums.Difficulty;

import java.util.List;

public record Hot100OfficialSource(
        List<OfficialProblem> problems
) {
    public record OfficialProblem(
            String group,
            int leetcodeNumber,
            String title,
            Difficulty difficulty,
            String problemUrl,
            int order,
            String descriptionMarkdown,
            List<String> officialTags,
            String javaStarterCode
    ) { }
}
