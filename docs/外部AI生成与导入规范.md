# 外部 AI 生成与导入规范

LeetRecall **不会调用 AI**。你负责用任意外部 AI 生成学习资料，系统只检查内容能否安全导入并在回忆复习、默写模式中正常使用。系统不保存题解作者、网址、题解原文、哈希或 AI 供应商信息。

本规范同时用于「题目导入」页面展示与 `docs/外部AI生成与导入规范.md`，两处内容保持一致。

## 工作流程

1. 在导入页选择一道 Hot100 题目并加载任务包。
2. 任务包中的官方题面、官方 Java 起始签名和题目元数据均为只读参考材料；可以据此生成学习资料，但不要改写或回传官方题目字段。
3. 连同你自己的题解与难点交给任意外部 AI，要求 AI **只返回一个 JSON 对象**，不要在 JSON 外包裹 Markdown 代码围栏或解释文字。
4. 把返回的 JSON 粘贴回导入页，系统执行必要格式校验与 Java 21 编译。
5. 全部通过后确认更新；系统只允许更新已存在官方题目的学习资料，不会新建题目。确认前会显示影响清单。

## JSON 字段定义

| 字段 | 类型 | 约束 |
| --- | --- | --- |
| `leetcodeNumber` | number | 目标题目的唯一标识，必须与所选 Hot100 题号一致 |
| `noteMarkdown` | string | **可选**。个人复习笔记——题解推导、主解法讲解、模板套路、复杂度和延伸变体都放这里；Markdown 格式，最多 100000 字，代码围栏必须成对闭合；缺省或留空则不写入笔记 |
| `coreIdea` | string | 本题状态/不变量、关键操作与正确性理由，不能写跨题套话 |
| `hint` | string | 行动提示；建议简洁，不按文字长度阻断 |
| `mistakes` | string[] | 建议 2～4 条真实易错点；每条最多 500 字 |
| `fullCode` | string | 完整可编译 Java 代码；必须保留官方类名与方法签名，不含 `package`、`native` |
| `keyCode` | string | 非空关键代码；不要求与 `fullCode` 逐字符匹配 |
| `recallQuestions` | object[] | 1～5 组（超过 5 组会阻止导入），每组含非空 `question` 和 `answer`；建议生成 3～5 组专属问答，问题最多 500 字 |
| `dictation.language` | string | 固定为 `JAVA` |
| `dictation.templateCode` | string | 至少含 1 个唯一 `{{blank_n}}` 的完整代码模板 |
| `dictation.answers` | object | 键集合与模板空位完全一致；每个值为非空 Java 片段 |
| `dictation.keywords` | string[] | 可为空；单个关键词最多 50 字 |

`title`、`difficulty`、`descriptionMarkdown`、`tags`、`officialTags` 等官方题目字段**不能出现在导入 JSON 中**。官方题面可阅读参考，但不能通过导入修改。

## 完整 JSON 示例

```json
{
  "leetcodeNumber": 1,
  "noteMarkdown": "## 思路推导\n枚举右边界，用哈希表回看左边界。\n\n## 复杂度\n时间 O(n)，空间 O(n)。",
  "coreIdea": "用哈希表记录已遍历元素到下标的映射；遍历到 x 时查 target-x 是否出现过，出现即得到答案。不变量：表中只存当前元素之前的下标，保证不会用到自身。",
  "hint": "先判断补数再写入当前值。",
  "mistakes": [
    "先把所有元素放进哈希表再查询，会把元素和自己配对导致错误。",
    "返回值写成元素值而不是下标，或下标顺序颠倒。"
  ],
  "fullCode": "class Solution {\n    public int[] twoSum(int[] nums, int target) {\n        java.util.Map<Integer, Integer> seen = new java.util.HashMap<>();\n        for (int i = 0; i < nums.length; i++) {\n            int need = target - nums[i];\n            if (seen.containsKey(need)) return new int[]{seen.get(need), i};\n            seen.put(nums[i], i);\n        }\n        return new int[0];\n    }\n}",
  "keyCode": "if (seen.containsKey(need)) return new int[]{seen.get(need), i};\n            seen.put(nums[i], i);",
  "recallQuestions": [
    { "question": "为什么边遍历边查询，而不是先建完整哈希表再查？", "answer": "边遍历保证表中只有当前元素之前的下标，避免元素与自身配对，同时一次遍历即可完成。" },
    { "question": "哈希表的键和值分别存什么，为什么这样设计？", "answer": "键存元素值、值存下标；因为要按需要的补数反查下标，所以以值为键。" },
    { "question": "哪个边界最容易出错，代码如何保证正确？", "answer": "自我配对边界；先查后放保证 need 命中的一定是更早的下标。" }
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

- 只接受一个 JSON 对象；JSON 外的 Markdown 代码围栏、说明文字或多余 JSON 值会明确报出位置。普通未定义字段不会参与导入，保存草稿时会自动丢弃。
- `leetcodeNumber` 必须与所选 Hot100 题号一致。旧 JSON 中的 `title`、`difficulty`、`descriptionMarkdown`、`tags` 或 `officialTags` 会返回明确校验错误，不会被静默接受。
- 确认时目标题目必须已存在于官方题库；不存在时拒绝导入且不会创建 `problem` 记录。
- 会写入定长数据库列的内容不得超限：单个关键词 50 字、单条易错点或回忆问题 500 字。
- `noteMarkdown` 缺省或留空不会阻断导入；写了内容则按 100000 字上限和代码围栏闭合校验，未闭合会提示起始行号。
- `recallQuestions` 为 1～5 组，每组必须有非空问题和答案，超过 5 组会阻止导入；重复、套话、答案长短等内容质量不阻断。
- `fullCode` 保留官方类名、`public` 方法与构造器签名，不含 `package`、`native`，并通过 Java 21 编译。
- `keyCode` 只要求非空；是否为最佳关键片段由用户和外部 AI 决定。
- `dictation` 至少有 1 个唯一 `{{blank_n}}`，`answers` 键集合与空位完全一致且答案非空；回填后必须逐字符恢复 `fullCode`。

## 额外字段

系统不保存未定义字段。以下来源或模型字段即使出现在外部 AI 返回内容中，也会在草稿保存时自动丢弃，不会参与最终导入：

`sourceRefs`、`sourceTrace`、`sourceAssociations`、`provider`、`model`、`prompt`、`sourceUrl`、`solutionUrl`、`referenceUrls`、`author`、`platform`，以及其他未定义字段。

## 更新影响

确认更新已有题目后：

- **会替换**：核心思路、提示、易错点、回忆问答、完整/关键代码、当前默写模板。
- **仅首次填入**：`noteMarkdown` 只在这道题没有笔记记录或笔记内容为空时写入；已有非空手写笔记不覆盖。
- **会保留**：题目 ID、官方题号、标题、难度、题面、官方标签、学习进度、复习记录、历史默写记录及逐空答案视图。
- 不会创建题目，不会修改官方题目字段或标签关联。

新的默写提交会保存当时的模板与答案快照；此功能之前的旧默写记录仍展示原始提交、分数、正确数与时间，但无法精确恢复逐空错项。
