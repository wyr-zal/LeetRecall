package com.leetrecall.hot100.model;

import com.leetrecall.common.enums.Difficulty;

import java.util.List;

public record Hot100Manifest(
        List<Hot100Problem> problems
) {
    public record Hot100Problem(
            int order,
            String group,
            int leetcodeNumber,
            String title,
            Difficulty difficulty,
            String problemUrl
    ) { }
}
