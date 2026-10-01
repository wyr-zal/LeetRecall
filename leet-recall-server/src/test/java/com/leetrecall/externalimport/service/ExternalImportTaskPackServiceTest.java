package com.leetrecall.externalimport.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.hot100.model.Hot100Manifest;
import com.leetrecall.hot100.model.Hot100OfficialSource;
import com.leetrecall.hot100.service.Hot100ManifestService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.ArrayList;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ExternalImportTaskPackServiceTest {
    @Mock private Hot100ManifestService hot100ManifestService;

    @Test
    void marksOfficialStatementReadOnlyAndOnlyEmitsLearningFieldsInExample() throws Exception {
        var manifest = new Hot100Manifest.Hot100Problem(
                1, "哈希", 1, "两数之和", Difficulty.EASY, "https://leetcode.cn/problems/two-sum/");
        var official = new Hot100OfficialSource.OfficialProblem(
                "哈希", 1, "两数之和", Difficulty.EASY, "https://leetcode.cn/problems/two-sum/", 1,
                "官方题面", List.of("数组"), "class Solution { public int[] twoSum(int[] nums, int target) { } }");
        when(hot100ManifestService.requireByNumber(1)).thenReturn(manifest);
        when(hot100ManifestService.requireOfficialByNumber(1)).thenReturn(official);
        ExternalImportTaskPackService service = new ExternalImportTaskPackService(hot100ManifestService, new ObjectMapper());

        var task = service.create(1);
        var example = new ObjectMapper().readTree(task.exampleJson());
        List<String> fields = new ArrayList<>();
        example.fieldNames().forEachRemaining(fields::add);

        assertThat(task.instructionMarkdown()).contains("只读参考材料", "不要改写或回传");
        assertThat(task.descriptionMarkdown()).isEqualTo("官方题面");
        assertThat(fields).containsExactlyInAnyOrder("leetcodeNumber", "noteMarkdown", "coreIdea", "hint", "mistakes",
                "fullCode", "keyCode", "recallQuestions", "dictation");
        assertThat(example.has("title")).isFalse();
        assertThat(example.has("difficulty")).isFalse();
        assertThat(example.has("descriptionMarkdown")).isFalse();
        assertThat(example.has("tags")).isFalse();
    }
}
