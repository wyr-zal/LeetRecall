package com.leetrecall.externalimport.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.common.enums.Difficulty;
import com.leetrecall.hot100.model.Hot100Manifest;
import com.leetrecall.hot100.model.Hot100OfficialSource;
import org.junit.jupiter.api.Test;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import static org.assertj.core.api.Assertions.assertThat;

class ExternalImportValidatorTest {
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final ExternalImportValidator validator = new ExternalImportValidator(objectMapper, new JavaCompileService());
    private final Hot100Manifest.Hot100Problem expected = new Hot100Manifest.Hot100Problem(1, "哈希", 1, "两数之和", Difficulty.EASY, "https://leetcode.cn/problems/two-sum/");
    private final String code = "class Solution {\n    public int[] twoSum(int[] nums, int target) {\n        int[] result = new int[0];\n        return result;\n    }\n}";
    private final Hot100OfficialSource.OfficialProblem official = new Hot100OfficialSource.OfficialProblem("哈希", 1, "两数之和", Difficulty.EASY, "https://leetcode.cn/problems/two-sum/", 1, "题面原文", List.of("数组"), "class Solution { public int[] twoSum(int[] nums, int target) { } }");

    @Test
    void acceptsOnlyWhenJavaAndDictationRestorePass() {
        Map<String, Object> payload = validPayload();
        payload.put("fullCode", code);
        payload.put("keyCode", "int[] result = new int[0];");
        payload.put("dictation", Map.of(
                "language", "JAVA",
                "templateCode", "class Solution {\n{{blank_1}}\n{{blank_2}}\n{{blank_3}}\n}",
                "answers", Map.of(
                        "blank_1", "    public int[] twoSum(int[] nums, int target) {",
                        "blank_2", "        int[] result = new int[0];",
                        "blank_3", "        return result;\n    }"
                ),
                "keywords", List.of("补数", "遍历")
        ));

        var result = validator.validateRaw(write(payload), expected, official);

        assertThat(result.ready()).describedAs(result.errors().toString()).isTrue();
        assertThat(result.errors()).isEmpty();
    }

    @Test
    void ignoresExtraFieldsAndAllowsContentStyleVariations() {
        Map<String, Object> payload = validPayload();
        payload.put("sourceRefs", List.of("S1"));
        payload.put("recallQuestions", List.of(
                Map.of("question", "这题怎么做", "answer", "填写答案"),
                Map.of("question", "这题的核心思路是什么", "answer", "填写答案"),
                Map.of("question", "时间复杂度是多少", "answer", "填写答案")
        ));

        var result = validator.validateRaw(write(payload), expected, official);

        assertThat(result.ready()).describedAs(result.errors().toString()).isTrue();
        assertThat(result.errors()).isEmpty();
    }

    @Test
    void stripsForbiddenFieldsBeforeSavingDraftContent() throws Exception {
        Map<String, Object> payload = validPayload();
        payload.put("sourceUrl", "https://example.com/private-source");
        payload.put("provider", "external-model");

        String sanitized = validator.sanitizeForStorage(write(payload));

        assertThat(sanitized).doesNotContain("private-source").doesNotContain("external-model");
        assertThat(objectMapper.readTree(sanitized).fieldNames())
                .toIterable().doesNotContain("sourceUrl", "provider");
    }

    @Test
    void rejectsChangedOfficialMethodSignature() {
        Map<String, Object> payload = validPayload();
        payload.put("fullCode", "class Solution { public int[] twoSum(int[] nums, long target) { return new int[0]; } }");

        var result = validator.validateRaw(write(payload), expected, official);

        assertThat(result.ready()).isFalse();
        assertThat(result.errors()).anyMatch(error -> error.contains("官方 public 方法签名"));
    }

    @Test
    void recognizesOfficialSignatureWhenCodeContainsUrlAndBraceLiterals() {
        Map<String, Object> payload = validPayload();
        payload.put("fullCode", "class Solution { public int[] twoSum(int[] nums, int target) { String url = \"https://example.com/}\"; char brace = '}'; return new int[0]; } }");

        var result = validator.validateRaw(write(payload), expected, official);

        assertThat(result.compilePassed()).isTrue();
        assertThat(result.errors()).noneMatch(error -> error.contains("官方 public 方法签名"));
    }

    @Test
    void rejectsARequiredMethodHiddenInsideANestedClass() {
        Map<String, Object> payload = validPayload();
        payload.put("fullCode", "class Solution { class Helper { public int[] twoSum(int[] nums, int target) { return new int[0]; } } }");

        var result = validator.validateRaw(write(payload), expected, official);

        assertThat(result.ready()).isFalse();
        assertThat(result.errors()).anyMatch(error -> error.contains("官方 public 方法签名"));
    }

    @Test
    void compilesHot100NodeUsageWithGraphFields() {
        JavaCompileService.CompileResult result = new JavaCompileService().compile("class Solution { public Node cloneGraph(Node node) { if (node == null) return null; Node copy = new Node(node.val); copy.neighbors = new ArrayList<>(); for (Node neighbor : node.neighbors) copy.neighbors.add(neighbor); return copy; } }");

        assertThat(result.passed()).describedAs(result.output()).isTrue();
    }

    @Test
    void compilesWithEmbeddedCompilerWhenJavacIsUnavailable() {
        JavaCompileService.CompileResult result = new JavaCompileService("javac-not-installed")
                .compile("class Solution { public int answer() { return 42; } }");

        assertThat(result.passed()).describedAs(result.output()).isTrue();
    }

    @Test
    void acceptsRewordedDescriptionWhenMarkdownStructureMatches() {
        Hot100OfficialSource.OfficialProblem structuredOfficial = officialWithDescription("""
                # 题目说明

                给定一个数组，请求出答案。[原题](https://leetcode.cn/problems/two-sum/)

                - 第一个条件
                - 第二个条件 [参考](https://example.com/rule)

                ```text
                示例输入
                ```

                ---
                """);
        Map<String, Object> payload = validPayload();
        payload.put("descriptionMarkdown", """
                # 另一种表述

                给你一组数，找出符合要求的结果。[题目链接](https://anywhere.invalid/problem)

                - 改写后的条件
                - 仍保留一个链接 [说明](https://anywhere.invalid/rule)

                ```text
                任意示例文本
                ```

                ---
                """);

        var result = validator.validateRaw(write(payload), expected, structuredOfficial);

        assertThat(result.errors()).noneMatch(error -> error.contains("Markdown 排版结构"));
    }

    @Test
    void acceptsDescriptionWhenNonEssentialMarkdownStructureChanges() {
        Hot100OfficialSource.OfficialProblem structuredOfficial = officialWithDescription("""
                这是说明，[原题](https://leetcode.cn/problems/two-sum/)。

                ---

                - 第一项
                - 第二项
                """);
        Map<String, Object> payload = validPayload();
        payload.put("descriptionMarkdown", """
                这是改写后的说明，不保留链接，文字可自由改写。

                - 只保留了一项
                """);

        var result = validator.validateRaw(write(payload), expected, structuredOfficial);

        assertThat(result.ready()).describedAs(result.errors().toString()).isTrue();
        assertThat(result.errors()).noneMatch(error -> error.contains("descriptionMarkdown"));
    }

    @Test
    void rejectsUnclosedDescriptionFenceWithExactLineNumber() {
        Map<String, Object> payload = validPayload();
        payload.put("descriptionMarkdown", """
                题目说明

                ```text
                输入：nums = [2, 7]
                输出：[0, 1]
                """);

        var result = validator.validateRaw(write(payload), expected, official);

        assertThat(result.ready()).isFalse();
        assertThat(result.errors()).contains("descriptionMarkdown 第 3 行：代码围栏 ``` 未闭合，请在代码块末尾补上同类型围栏");
    }

    @Test
    void reportsExpectedAndActualValuesForLockedFields() {
        Map<String, Object> payload = validPayload();
        payload.put("leetcodeNumber", 2);
        payload.put("title", "错误标题");
        payload.put("difficulty", "HARD");

        var result = validator.validateRaw(write(payload), expected, official);

        assertThat(result.errors()).contains(
                "leetcodeNumber：必须为 1，实际为 “2”",
                "title：必须为“两数之和”，实际为 “错误标题”",
                "difficulty：必须为 EASY，实际为 “HARD”"
        );
    }

    @Test
    void allowsLongDictationAnswerWhenItRestoresTheCode() {
        Map<String, Object> payload = validPayload();
        String blankOne = "    public int[] twoSum(int[] nums, int target) {";
        String longAnswer = "        /*" + "x".repeat(1_200) + "*/";
        String blankThree = "        return new int[0];\n    }";
        String template = "class Solution {\n{{blank_1}}\n{{blank_2}}\n{{blank_3}}\n}";
        payload.put("fullCode", "class Solution {\n" + blankOne + "\n" + longAnswer + "\n" + blankThree + "\n}");
        payload.put("keyCode", "return new int[0];");
        payload.put("dictation", Map.of(
                "language", "JAVA",
                "templateCode", template,
                "answers", Map.of("blank_1", blankOne, "blank_2", longAnswer, "blank_3", blankThree),
                "keywords", List.of("补数")
        ));

        var result = validator.validateRaw(write(payload), expected, official);

        assertThat(longAnswer.length()).isGreaterThan(1_000);
        assertThat(result.ready()).describedAs(result.errors().toString()).isTrue();
    }

    @Test
    void acceptsOneQuestionAndOneDictationBlank() {
        Map<String, Object> payload = validPayload();
        payload.put("recallQuestions", List.of(
                Map.of("question", "核心状态是什么？", "answer", "保存已遍历数字与下标。")
        ));
        payload.put("dictation", Map.of(
                "language", "JAVA",
                "templateCode", "class Solution {\n{{blank_1}}\n}",
                "answers", Map.of("blank_1", "    public int[] twoSum(int[] nums, int target) {\n        int[] result = new int[0];\n        return result;\n    }"),
                "keywords", List.of()
        ));

        var result = validator.validateRaw(write(payload), expected, official);

        assertThat(result.ready()).describedAs(result.errors().toString()).isTrue();
    }

    @Test
    void reportsMalformedJsonLocation() {
        var result = validator.validateRaw("{\n  \"leetcodeNumber\": 1,\n  \"title\": \"两数之和\",\n}", expected, official);

        assertThat(result.ready()).isFalse();
        assertThat(result.errors()).singleElement().asString().contains("JSON 第 4 行");
    }

    @Test
    void reportsWrongFieldTypeWithFieldPath() {
        Map<String, Object> payload = validPayload();
        payload.put("recallQuestions", "不是数组");

        var result = validator.validateRaw(write(payload), expected, official);

        assertThat(result.ready()).isFalse();
        assertThat(result.errors()).singleElement().asString().contains("JSON 字段 recallQuestions 类型不正确");
    }

    private Hot100OfficialSource.OfficialProblem officialWithDescription(String description) {
        return new Hot100OfficialSource.OfficialProblem("哈希", 1, "两数之和", Difficulty.EASY,
                "https://leetcode.cn/problems/two-sum/", 1, description, List.of("数组"),
                "class Solution { public int[] twoSum(int[] nums, int target) { } }");
    }

    private Map<String, Object> validPayload() {
        Map<String, Object> payload = new LinkedHashMap<>();
        payload.put("leetcodeNumber", 1);
        payload.put("title", "两数之和");
        payload.put("difficulty", "EASY");
        payload.put("descriptionMarkdown", "题面原文");
        payload.put("tags", List.of("数组"));
        payload.put("coreIdea", "遍历时维护补数映射，并说明首次命中即正确的原因。");
        payload.put("hint", "先判断补数再写入当前值。");
        payload.put("mistakes", List.of("不能在查询前写入当前下标，否则会复用同一元素", "结果为空时要保持题目要求的返回类型"));
        payload.put("fullCode", code);
        payload.put("keyCode", "int[] result = new int[0];");
        payload.put("recallQuestions", List.of(
                Map.of("question", "遍历到当前元素时，映射表保存的对象是什么？", "answer", "保存已经遍历过的数字及其下标。"),
                Map.of("question", "为什么必须先查补数再写当前数字？", "answer", "这样不会把当前元素当成两个不同元素使用。"),
                Map.of("question", "没有命中补数时循环结束后返回什么？", "answer", "返回题目约定的空数组兜底值。")
        ));
        payload.put("dictation", Map.of(
                "language", "JAVA",
                "templateCode", "class Solution {\n{{blank_1}}\n{{blank_2}}\n{{blank_3}}\n}",
                "answers", Map.of("blank_1", "    public int[] twoSum(int[] nums, int target) {", "blank_2", "        int[] result = new int[0];", "blank_3", "        return result;\n    }"),
                "keywords", List.of("补数", "遍历")
        ));
        return payload;
    }

    private String write(Map<String, Object> payload) {
        try {
            return objectMapper.writeValueAsString(payload);
        } catch (JsonProcessingException exception) {
            throw new AssertionError(exception);
        }
    }
}
