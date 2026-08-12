package com.leetrecall.hot100.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

class Hot100ManifestServiceTest {
    @Test
    void loadsOneHundredUniqueChineseProblemUrlsAndOfficialPacks() {
        Hot100ManifestService service = new Hot100ManifestService(new ObjectMapper());
        service.loadManifest();
        assertThat(service.getManifest().problems()).hasSize(100);
        assertThat(service.getManifest().problems()).extracting(problem -> problem.leetcodeNumber()).doesNotHaveDuplicates();
        assertThat(service.getManifest().problems()).allSatisfy(problem -> assertThat(problem.problemUrl()).startsWith("https://leetcode.cn/problems/"));
        assertThat(service.requireOfficialByNumber(1).javaStarterCode()).contains("twoSum");
    }
}
