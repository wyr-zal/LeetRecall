package com.leetrecall.externalimport.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.leetrecall.externalimport.vo.ExternalImportTaskPackVO;
import com.leetrecall.hot100.model.Hot100OfficialSource;
import com.leetrecall.hot100.service.Hot100ManifestService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ExternalImportTaskPackService {
    private final Hot100ManifestService hot100ManifestService;
    private final ObjectMapper objectMapper;

    public ExternalImportTaskPackVO create(Integer number) {
        var manifest = hot100ManifestService.requireByNumber(number);
        Hot100OfficialSource.OfficialProblem official = hot100ManifestService.requireOfficialByNumber(number);
        return new ExternalImportTaskPackVO(
                number, manifest.title(), manifest.difficulty(), manifest.problemUrl(), official.descriptionMarkdown(),
                official.javaStarterCode(), instruction(number, manifest.title(), manifest.difficulty(), official.javaStarterCode()),
                example(number, manifest.title(), manifest.difficulty(), official.descriptionMarkdown(), official.officialTags(), official.javaStarterCode())
        );
    }

    private String instruction(int number, String title, Object difficulty, String starter) {
        return "# LeetRecall 外部 AI 学习资料任务包\n\n"
                + "题号：" + number + "\n题目：" + title + "\n难度：" + difficulty + "\n\n"
                + "把本任务包和你自己的题解、难点一起交给任意外部 AI。要求 AI 只返回 JSON，不要 Markdown 代码围栏。\n"
                + "系统不会调用 AI，也不会保存来源、模型、提示词或 URL；粘贴 JSON 后只校验能否安全导入和正常使用。\n\n"
                + "## 生成要求\n"
                + "- `coreIdea` 必须写清状态/不变量、关键操作和正确性原因，不能写跨题套话。\n"
                + "- `recallQuestions` 必须是本题专属的 3～5 组问答，覆盖状态或不变量、关键转移/操作、边界/易错点；每个答案必须可从题解推导。\n"
                + "- `mistakes` 写 2～4 条真实易错点；`hint` 不超过 100 字。\n"
                + "- `fullCode` 是可提交的完整 Java 代码，必须实现下方官方类名和方法签名；`keyCode` 必须是完整代码中的连续关键片段。\n"
                + "- `descriptionMarkdown` 必须是非空、可正常渲染的 Markdown 题面。允许改写正文和调整标题、段落、列表、引用、示例、分隔线及来源链接；代码围栏必须成对闭合。\n"
                + "- `noteMarkdown` 是这道题的个人复习笔记，用 Markdown 写推导过程、模板套路、复杂度和延伸变体，代码围栏必须成对闭合；可以省略，省略时系统不会写入笔记。\n"
                + "- `dictation` 至少使用 1 个唯一 `{{blank_n}}`，答案键必须完全一致，回填后必须逐字符恢复 `fullCode`。\n"
                + "- 请只输出规定字段。额外字段不会参与导入，系统保存草稿时会自动丢弃。\n\n"
                + "## 官方 Java 方法签名\n```java\n" + starter + "\n```\n\n"
                + "## JSON 字段\n"
                + "`leetcodeNumber`, `title`, `difficulty`, `descriptionMarkdown`, `noteMarkdown`, `tags`, `coreIdea`, `hint`, `mistakes`, `fullCode`, `keyCode`, `recallQuestions[{question,answer}]`, `dictation{language,templateCode,answers,keywords}`。\n";
    }

    private String example(int number, String title, Object difficulty, String description, java.util.List<String> tags, String starter) {
        try {
            var example = new java.util.LinkedHashMap<String, Object>();
            example.put("leetcodeNumber", number);
            example.put("title", title);
            example.put("difficulty", difficulty.toString());
            example.put("descriptionMarkdown", description);
            example.put("noteMarkdown", "## 思路推导\n填写你的推导过程\n\n## 代码模板\n填写可复用的写法\n\n## 复杂度\n时间 O(?)，空间 O(?)");
            example.put("tags", tags);
            example.put("coreIdea", "填写本题专属的状态、不变量和正确性理由");
            example.put("hint", "填写一个不泄露答案的行动提示");
            example.put("mistakes", java.util.List.of("填写真实边界错误", "填写更新顺序或数据结构错误"));
            example.put("fullCode", starter.replace("        \n", "        // 填写完整实现\n"));
            example.put("keyCode", "填写完整代码中的连续关键片段");
            example.put("recallQuestions", java.util.List.of(
                    java.util.Map.of("question", "本题的状态或不变量具体是什么？", "answer", "填写本题答案"),
                    java.util.Map.of("question", "关键转移或数据结构操作为什么这样安排？", "answer", "填写本题答案"),
                    java.util.Map.of("question", "哪个边界最容易出错，代码如何保证？", "answer", "填写本题答案")
            ));
            example.put("dictation", java.util.Map.of("language", "JAVA", "templateCode", "class Solution { {{blank_1}} {{blank_2}} {{blank_3}} }", "answers", java.util.Map.of("blank_1", "填写", "blank_2", "填写", "blank_3", "填写"), "keywords", tags));
            return objectMapper.writerWithDefaultPrettyPrinter().writeValueAsString(example);
        } catch (JsonProcessingException exception) {
            throw new IllegalStateException("无法创建任务包 JSON 示例", exception);
        }
    }
}
