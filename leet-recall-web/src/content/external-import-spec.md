# 外部 AI 生成与导入规范

LeetRecall **不会调用 AI**。你负责用任意外部 AI 生成学习资料，系统只负责格式、硬校验和安全覆盖。系统不保存题解作者、网址、题解原文、哈希或 AI 供应商信息。

本规范同时用于「题目导入」页面展示与 `docs/外部AI生成与导入规范.md`，两处内容一致。

## 工作流程

1. 在导入页选择一道 Hot100 题目并加载任务包。
2. 复制任务文档（含中文题面、官方 Java 签名、字段说明、JSON 示例），连同你自己的题解与难点一起交给任意外部 AI。
3. 要求 AI **只返回一个 JSON 对象**，不要 Markdown 代码围栏、解释文字、来源 URL、模型名或提示词。
4. 把返回的 JSON 粘贴回导入页，系统执行严格校验与 Java 21 编译。
5. 全部通过后确认导入；同题号会给出覆盖影响清单再由你确认。

## JSON 字段定义

| 字段 | 类型 | 约束 |
| --- | --- | --- |
| `leetcodeNumber` | number | 必须与所选 Hot100 题号一致 |
| `title` | string | 必须与所选题目标题一致 |
| `difficulty` | string | `EASY` / `MEDIUM` / `HARD`，与所选题目一致 |
| `descriptionMarkdown` | string | 原样使用任务包中的中文题面 |
| `tags` | string[] | 1～10 个 |
| `coreIdea` | string | 本题状态/不变量、关键操作与正确性理由，不能写跨题套话 |
| `hint` | string | 不超过 100 字的行动提示 |
| `mistakes` | string[] | 2～4 条，每条 6～500 字，真实易错点 |
| `fullCode` | string | 完整可编译 Java 代码；保留官方类名与方法签名；不含 `TODO`、`{{`、`package`、`native` |
| `keyCode` | string | 必须是 `fullCode` 中的连续片段 |
| `recallQuestions` | object[] | 3～5 组，每组含 `question`（8～180 字）与 `answer`（≤800 字）；不得重复、不得用通用套话 |
| `dictation.language` | string | 固定为 `JAVA` |
| `dictation.templateCode` | string | 含 3～6 个唯一 `{{blank_n}}` 的完整代码模板 |
| `dictation.answers` | object | 键集合与模板空位完全一致；每个值为非空 Java 片段，≤240 字 |
| `dictation.keywords` | string[] | 1～10 个 |

## 完整 JSON 示例

```json
{
  "leetcodeNumber": 1,
  "title": "两数之和",
  "difficulty": "EASY",
  "descriptionMarkdown": "从任务包原样复制的中文题面",
  "tags": ["数组", "哈希表"],
  "coreIdea": "用哈希表记录已遍历元素到下标的映射；遍历到 x 时查 target-x 是否出现过，出现即得到答案。不变量：表中只存当前元素之前的下标，保证不会用到自身。",
  "hint": "边遍历边把 target-当前值 拿去哈希表里查，命中就返回两个下标。",
  "mistakes": [
    "先把所有元素放进哈希表再查询，会把元素和自己配对导致错误。",
    "返回值写成元素值而不是下标，或下标顺序颠倒。"
  ],
  "fullCode": "class Solution {\n    public int[] twoSum(int[] nums, int target) {\n        java.util.Map<Integer, Integer> seen = new java.util.HashMap<>();\n        for (int i = 0; i < nums.length; i++) {\n            int need = target - nums[i];\n            if (seen.containsKey(need)) return new int[]{seen.get(need), i};\n            seen.put(nums[i], i);\n        }\n        return new int[0];\n    }\n}",
  "keyCode": "if (seen.containsKey(need)) return new int[]{seen.get(need), i};\n            seen.put(nums[i], i);",
  "recallQuestions": [
    { "question": "为什么边遍历边查询，而不是先建完整哈希表再查？", "answer": "边遍历保证表中只有当前元素之前的下标，避免元素与自身配对，同时一次遍历即可完成。" },
    { "question": "哈希表的键和值分别存什么，为什么这样设计？", "answer": "键存元素值、值存下标；因为要按“需要的补数”反查下标，所以以值为键。" },
    { "question": "哪个边界最容易出错，代码如何保证正确？", "answer": "自我配对边界；先查后放（put 在 return 之后）保证 need 命中的一定是更早的下标。" }
  ],
  "dictation": {
    "language": "JAVA",
    "templateCode": "class Solution {\n    public int[] twoSum(int[] nums, int target) {\n        java.util.Map<Integer, Integer> seen = new java.util.HashMap<>();\n        for (int i = 0; i < nums.length; i++) {\n            int need = {{blank_1}};\n            if ({{blank_2}}) return new int[]{seen.get(need), i};\n            {{blank_3}};\n        }\n        return new int[0];\n    }\n}",
    "answers": {
      "blank_1": "target - nums[i]",
      "blank_2": "seen.containsKey(need)",
      "blank_3": "seen.put(nums[i], i)"
    },
    "keywords": ["哈希表", "补数", "一次遍历"]
  }
}
```

## 硬校验条件（任一失败都不能导入，但草稿可继续编辑）

- 只接受一个纯 JSON 对象，不接受 Markdown 代码围栏、说明文字或未知顶层字段。
- 题号、标题、难度、题面必须与所选 Hot100 任务包一致。
- `tags` 1～10 个；`hint` ≤100 字；`mistakes` 2～4 条且每条 6～500 字。
- `recallQuestions` 3～5 组，问题 8～180 字、答案 ≤800 字，组内不重复、不与其他题重复、不用通用套话（如“这题怎么做”“时间复杂度是多少”）。
- `fullCode` 保留官方类名、`public` 方法与构造器签名，不含 `TODO`、`{{`、`package`、`native`，并通过受控 `javac --release 21` 编译。
- `keyCode` 必须是 `fullCode` 的连续片段。
- `dictation` 有 3～6 个唯一 `{{blank_n}}`，`answers` 键集合与空位完全一致，每个答案非空且 ≤240 字，`keywords` 1～10 个。
- 回填 `answers` 后必须逐字符恢复 `fullCode`。
- 已存在同题号时，导入前会列出覆盖影响清单。

## 禁止字段（出现即拒绝）

系统不保存任何来源或模型信息。以下字段一旦出现将直接拒绝：

`sourceRefs`、`sourceTrace`、`sourceAssociations`、`provider`、`model`、`prompt`、`sourceUrl`、`solutionUrl`、`referenceUrls`、`author`、`platform`。

## 覆盖行为

同题号确认导入后：

- **会替换**：题面、核心思路、提示、Java 代码、易错点、回忆问答、当前默写模板、标签关联。
- **会保留**：题目 ID、学习进度、逐题笔记、复习记录、历史默写记录及其逐空答案视图。

新的默写提交会保存当时的模板与答案快照；此功能之前的旧默写记录仍展示原始提交、分数、正确数与时间，但无法精确恢复逐空错项。
