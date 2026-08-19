# 外部 AI 生成与导入规范

LeetRecall **不会调用 AI**。你负责用任意外部 AI 生成学习资料，系统只检查内容能否安全导入并在回忆复习、默写模式中正常使用。系统不保存题解作者、网址、题解原文、哈希或 AI 供应商信息。

本规范同时用于「题目导入」页面展示与 `docs/外部AI生成与导入规范.md`，两处内容一致。

## 工作流程

1. 在导入页选择一道 Hot100 题目并加载任务包。
2. 复制任务文档（含中文题面、官方 Java 签名、字段说明、JSON 示例），连同你自己的题解与难点一起交给任意外部 AI。
3. 要求 AI **只返回一个 JSON 对象**，不要在 JSON 外包裹 Markdown 代码围栏或解释文字。
4. 把返回的 JSON 粘贴回导入页，系统执行必要格式校验与 Java 21 编译。
5. 全部通过后确认导入；同题号会给出覆盖影响清单再由你确认。

## JSON 字段定义

| 字段 | 类型 | 约束 |
| --- | --- | --- |
| `leetcodeNumber` | number | 必须与所选 Hot100 题号一致 |
| `title` | string | 必须与所选题目标题一致 |
| `difficulty` | string | `EASY` / `MEDIUM` / `HARD`，与所选题目一致 |
| `descriptionMarkdown` | string | 非空、可正常渲染的 Markdown 题面；正文及标题/段落/列表/引用/示例/分隔线/来源链接均可调整，代码围栏必须成对闭合 |
| `noteMarkdown` | string | **可选**。这道题的个人复习笔记，Markdown 格式，最多 100000 字，代码围栏必须成对闭合；缺省或留空则不写入笔记 |
| `tags` | string[] | 建议 1～10 个；单个标签最多 50 字 |
| `coreIdea` | string | 本题状态/不变量、关键操作与正确性理由，不能写跨题套话 |
| `hint` | string | 行动提示；建议简洁，不按文字长度阻断 |
| `mistakes` | string[] | 建议 2～4 条真实易错点；每条最多 500 字 |
| `fullCode` | string | 完整可编译 Java 代码；必须保留官方类名与方法签名，不含 `package`、`native` |
| `keyCode` | string | 非空关键代码；不要求与 `fullCode` 逐字符匹配 |
| `recallQuestions` | object[] | 至少 1 组，每组含非空 `question` 和 `answer`；建议生成 3～5 组专属问答，问题最多 500 字 |
| `dictation.language` | string | 固定为 `JAVA` |
| `dictation.templateCode` | string | 至少含 1 个唯一 `{{blank_n}}` 的完整代码模板 |
| `dictation.answers` | object | 键集合与模板空位完全一致；每个值为非空 Java 片段 |
| `dictation.keywords` | string[] | 可为空；单个关键词最多 50 字 |

## 完整 JSON 示例

```json
{
  "leetcodeNumber": 1,
  "title": "两数之和",
  "difficulty": "EASY",
  "descriptionMarkdown": "使用可正常渲染的中文 Markdown 题面；允许按需要精简或调整结构，但代码围栏必须成对闭合",
  "noteMarkdown": "## 思路推导\n枚举右边界，用哈希表回看左边界。\n\n## 复杂度\n时间 O(n)，空间 O(n)。",
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

## 必要校验（失败时不能导入，但草稿可继续编辑）

- 只接受一个 JSON 对象；JSON 外的 Markdown 代码围栏、说明文字或多余 JSON 值会明确报出位置。额外字段不会阻断，保存草稿时自动丢弃。
- 题号、标题、难度必须与所选 Hot100 任务包一致。题面只要求非空且能正常渲染；允许精简正文、调整段落和列表、删除分隔线或来源链接。代码围栏未闭合会阻止导入，并明确提示起始行号。
- 会写入定长数据库列的内容不得超限：单个标签/关键词 50 字、单条易错点或回忆问题 500 字。
- `noteMarkdown` 缺省或留空不会阻断导入；写了内容则按 100000 字上限和代码围栏闭合校验，未闭合会提示起始行号。
- `recallQuestions` 至少 1 组，每组必须有非空问题和答案；重复、套话、答案长短等内容质量不阻断。
- `fullCode` 保留官方类名、`public` 方法与构造器签名，不含 `package`、`native`，并通过 Java 21 编译。
- `keyCode` 只要求非空；是否为最佳关键片段由用户和外部 AI 决定。
- `dictation` 至少有 1 个唯一 `{{blank_n}}`，`answers` 键集合与空位完全一致且答案非空。
- 回填 `answers` 后必须逐字符恢复 `fullCode`。
- 已存在同题号时，导入前会列出覆盖影响清单。

## 额外字段

系统不保存额外字段。以下来源或模型字段即使出现在外部 AI 返回内容中，也会在草稿保存时自动丢弃，不会参与最终导入：

`sourceRefs`、`sourceTrace`、`sourceAssociations`、`provider`、`model`、`prompt`、`sourceUrl`、`solutionUrl`、`referenceUrls`、`author`、`platform`，以及其他未定义字段。

## 覆盖行为

同题号确认导入后：

- **会替换**：题面、核心思路、提示、Java 代码、易错点、回忆问答、当前默写模板、标签关联。
- **会保留**：题目 ID、学习进度、逐题笔记、复习记录、历史默写记录及其逐空答案视图。

`noteMarkdown` 只在这道题**还没有笔记**（没有笔记记录或笔记内容为空）时写入，你在快速复习页手写的笔记永远不会被导入覆盖。想让 JSON 里的笔记生效，先在页面上清空这道题的笔记再导入。

新的默写提交会保存当时的模板与答案快照；此功能之前的旧默写记录仍展示原始提交、分数、正确数与时间，但无法精确恢复逐空错项。
