-- Legacy sample data is made versioned for new databases only. Existing
-- installations baseline at 1.2 and never replay this migration.

INSERT INTO problem (id, leetcode_number, title, difficulty, core_idea, hint, key_code, full_code, status, created_at, updated_at) VALUES
(1, 1, '两数之和', 'EASY', '用哈希表记录已经遍历过的数字及其下标。遍历到当前数字时，查找 target - nums[i] 是否已经出现；若出现即可返回两个下标。', '一边遍历一边记录；先查补数，再写入当前值，避免同一元素被使用两次。', 'Integer index = seen.get(target - nums[i]);\nif (index != null) return new int[]{index, i};', 'class Solution {\n    public int[] twoSum(int[] nums, int target) {\n        Map<Integer, Integer> seen = new HashMap<>();\n        for (int i = 0; i < nums.length; i++) {\n            Integer index = seen.get(target - nums[i]);\n            if (index != null) return new int[]{index, i};\n            seen.put(nums[i], i);\n        }\n        return new int[0];\n    }\n}', 1, NOW(), NOW()),
(2, 42, '接雨水', 'HARD', '双指针从两端向中间移动，并维护 leftMax 与 rightMax。较低一侧的最高值决定该侧当前位置能接多少水。', '左右最高柱中较小的一侧可以先结算；移动该侧指针并累加高度差。', 'if (leftMax <= rightMax) {\n    water += leftMax - height[left++];\n} else {\n    water += rightMax - height[right--];\n}', 'class Solution {\n    public int trap(int[] height) {\n        int left = 0, right = height.length - 1;\n        int leftMax = 0, rightMax = 0, water = 0;\n        while (left <= right) {\n            leftMax = Math.max(leftMax, height[left]);\n            rightMax = Math.max(rightMax, height[right]);\n            if (leftMax <= rightMax) water += leftMax - height[left++];\n            else water += rightMax - height[right--];\n        }\n        return water;\n    }\n}', 1, NOW(), NOW()),
(3, 53, '最大子数组和', 'MEDIUM', '动态规划记录以当前位置结尾的最大子数组和。当前值要么独立开始新子数组，要么接在前一段后面。', '维护 current 与 best；current 只代表必须以当前位置结尾的答案。', 'current = Math.max(nums[i], current + nums[i]);\nbest = Math.max(best, current);', 'class Solution {\n    public int maxSubArray(int[] nums) {\n        int current = nums[0], best = nums[0];\n        for (int i = 1; i < nums.length; i++) {\n            current = Math.max(nums[i], current + nums[i]);\n            best = Math.max(best, current);\n        }\n        return best;\n    }\n}', 1, NOW(), NOW()),
(4, 70, '爬楼梯', 'EASY', '到第 i 阶的方法数等于到第 i-1 阶与第 i-2 阶的方法数之和，可用两个变量滚动计算。', '这是斐波那契型转移；只保存前两项即可。', 'int next = previous + current;\nprevious = current;\ncurrent = next;', 'class Solution {\n    public int climbStairs(int n) {\n        if (n <= 2) return n;\n        int previous = 1, current = 2;\n        for (int i = 3; i <= n; i++) {\n            int next = previous + current;\n            previous = current;\n            current = next;\n        }\n        return current;\n    }\n}', 1, NOW(), NOW()),
(5, 98, '验证二叉搜索树', 'MEDIUM', '递归为每个节点维护严格的上下界。左子树上界变为当前值，右子树下界变为当前值。', '不能只比较父子节点；把祖先给出的有效值域继续向下传递。', 'if (node.val <= lower || node.val >= upper) return false;\nreturn validate(node.left, lower, node.val) && validate(node.right, node.val, upper);', 'class Solution {\n    public boolean isValidBST(TreeNode root) {\n        return validate(root, Long.MIN_VALUE, Long.MAX_VALUE);\n    }\n    private boolean validate(TreeNode node, long lower, long upper) {\n        if (node == null) return true;\n        if (node.val <= lower || node.val >= upper) return false;\n        return validate(node.left, lower, node.val)\n                && validate(node.right, node.val, upper);\n    }\n}', 1, NOW(), NOW()),
(6, 146, 'LRU 缓存', 'MEDIUM', '哈希表提供 O(1) 定位，双向链表维护最近使用顺序。访问或更新后把节点移动到头部，超容量时删除尾部节点。', '哈希表负责找节点，双向链表负责调整顺序；准备虚拟头尾节点简化边界。', 'remove(node);\naddFirst(node);\nif (cache.size() > capacity) cache.remove(removeLast().key);', 'class LRUCache {\n    private final int capacity;\n    private final Map<Integer, Node> cache = new HashMap<>();\n    private final Node head = new Node(0, 0);\n    private final Node tail = new Node(0, 0);\n    LRUCache(int capacity) { this.capacity = capacity; head.next = tail; tail.prev = head; }\n    public int get(int key) { Node node = cache.get(key); if (node == null) return -1; moveFirst(node); return node.value; }\n    public void put(int key, int value) { Node node = cache.get(key); if (node != null) { node.value = value; moveFirst(node); return; } node = new Node(key, value); cache.put(key, node); addFirst(node); if (cache.size() > capacity) cache.remove(removeLast().key); }\n    private void moveFirst(Node node) { remove(node); addFirst(node); }\n    private void addFirst(Node node) { node.next = head.next; node.prev = head; head.next.prev = node; head.next = node; }\n    private void remove(Node node) { node.prev.next = node.next; node.next.prev = node.prev; }\n    private Node removeLast() { Node node = tail.prev; remove(node); return node; }\n    private static class Node { int key, value; Node prev, next; Node(int key, int value) { this.key = key; this.value = value; } }\n}', 1, NOW(), NOW()),
(7, 200, '岛屿数量', 'MEDIUM', '遍历网格，遇到陆地就把岛屿数加一，并用 DFS 将与它相连的陆地全部标记为已访问。', '每次发现未访问陆地才计数；DFS 负责淹没整个连通块。', 'if (grid[row][col] == ''1'') {\n    count++;\n    flood(grid, row, col);\n}', 'class Solution {\n    public int numIslands(char[][] grid) {\n        int count = 0;\n        for (int row = 0; row < grid.length; row++) {\n            for (int col = 0; col < grid[0].length; col++) {\n                if (grid[row][col] == ''1'') { count++; flood(grid, row, col); }\n            }\n        }\n        return count;\n    }\n    private void flood(char[][] grid, int row, int col) {\n        if (row < 0 || row >= grid.length || col < 0 || col >= grid[0].length || grid[row][col] != ''1'') return;\n        grid[row][col] = ''0'';\n        flood(grid, row + 1, col); flood(grid, row - 1, col);\n        flood(grid, row, col + 1); flood(grid, row, col - 1);\n    }\n}', 1, NOW(), NOW()),
(8, 236, '二叉树的最近公共祖先', 'MEDIUM', '使用后序遍历。递归分别在左右子树查找 p 和 q；左右都有结果时当前节点就是最近公共祖先，只有一侧找到时继续向上返回该侧结果。', '后序遍历；递归返回找到的节点或空；左右子树都找到目标时返回当前节点。', 'if (root == null || root == p || root == q) return root;\nTreeNode left = lowestCommonAncestor(root.left, p, q);\nTreeNode right = lowestCommonAncestor(root.right, p, q);\nif (left != null && right != null) return root;\nreturn left != null ? left : right;', 'class Solution {\n    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {\n        if (root == null || root == p || root == q) return root;\n        TreeNode left = lowestCommonAncestor(root.left, p, q);\n        TreeNode right = lowestCommonAncestor(root.right, p, q);\n        if (left != null && right != null) return root;\n        return left != null ? left : right;\n    }\n}', 1, NOW(), NOW())
ON DUPLICATE KEY UPDATE title = VALUES(title), difficulty = VALUES(difficulty), core_idea = VALUES(core_idea), hint = VALUES(hint), key_code = VALUES(key_code), full_code = VALUES(full_code), status = VALUES(status), updated_at = NOW();

INSERT INTO tag (id, name, created_at) VALUES
(1, '哈希表', NOW()), (2, '数组', NOW()), (3, '双指针', NOW()), (4, '动态规划', NOW()),
(5, '递归', NOW()), (6, '二叉树', NOW()), (7, '二叉搜索树', NOW()), (8, '链表', NOW()),
(9, '设计', NOW()), (10, '深度优先搜索', NOW()), (11, '矩阵', NOW()), (12, '后序遍历', NOW())
ON DUPLICATE KEY UPDATE name = VALUES(name);

INSERT IGNORE INTO problem_tag (problem_id, tag_id) VALUES
(1, 1), (1, 2), (2, 2), (2, 3), (3, 2), (3, 4), (4, 4),
(5, 5), (5, 6), (5, 7), (6, 1), (6, 8), (6, 9),
(7, 10), (7, 11), (8, 5), (8, 6), (8, 12);

INSERT INTO recall_question (id, problem_id, question_text, answer_text, sort_order, created_at, updated_at) VALUES
(1, 1, '为什么要先查补数再写入当前值？', '避免同一个元素被使用两次。', 1, NOW(), NOW()),
(2, 1, '哈希表中保存什么？', '数字到下标的映射。', 2, NOW(), NOW()),
(3, 1, '时间复杂度和空间复杂度是多少？', '时间 O(n)，空间 O(n)。', 3, NOW(), NOW()),
(4, 2, '双指针每次移动哪一侧？', '移动当前左右最高值较小的一侧。', 1, NOW(), NOW()),
(5, 2, '当前位置能接的水如何计算？', '该侧最高值减去当前位置高度。', 2, NOW(), NOW()),
(6, 2, '为什么较低一侧可以立即结算？', '另一侧存在不低于它的边界，结果由较低边界决定。', 3, NOW(), NOW()),
(7, 3, 'current 表示什么？', '必须以当前位置结尾的最大子数组和。', 1, NOW(), NOW()),
(8, 3, '状态转移如何写？', 'max(nums[i], current + nums[i])。', 2, NOW(), NOW()),
(9, 3, '为什么 best 不能初始化为 0？', '数组可能全部为负数。', 3, NOW(), NOW()),
(10, 4, '第 i 阶的方法数来自哪里？', '第 i-1 阶和第 i-2 阶。', 1, NOW(), NOW()),
(11, 4, '为什么可以只用两个变量？', '当前状态只依赖前两个状态。', 2, NOW(), NOW()),
(12, 4, 'n 小于等于 2 时返回什么？', '直接返回 n。', 3, NOW(), NOW()),
(13, 5, '递归参数需要携带什么？', '当前节点允许的严格上下界。', 1, NOW(), NOW()),
(14, 5, '左子树和右子树如何更新边界？', '左子树更新上界，右子树更新下界。', 2, NOW(), NOW()),
(15, 5, '为什么边界使用 long？', '避免节点值为 int 极值时溢出或无法表达开区间。', 3, NOW(), NOW()),
(16, 6, '哈希表和双向链表各负责什么？', '哈希表 O(1) 定位，链表维护使用顺序。', 1, NOW(), NOW()),
(17, 6, '访问节点后要做什么？', '移动到链表头部。', 2, NOW(), NOW()),
(18, 6, '超出容量时删除哪个节点？', '删除尾部的最久未使用节点。', 3, NOW(), NOW()),
(19, 7, '什么时候岛屿数量加一？', '遍历到一个尚未访问的陆地时。', 1, NOW(), NOW()),
(20, 7, 'DFS 的职责是什么？', '标记当前连通块中的所有陆地。', 2, NOW(), NOW()),
(21, 7, '递归终止条件有哪些？', '越界或当前位置不是未访问陆地。', 3, NOW(), NOW()),
(22, 8, '这题使用什么遍历？', '后序遍历。', 1, NOW(), NOW()),
(23, 8, '递归函数返回什么？', '当前子树找到的 p、q、公共祖先或空。', 2, NOW(), NOW()),
(24, 8, '左右子树都找到目标时返回什么？', '返回当前节点。', 3, NOW(), NOW())
ON DUPLICATE KEY UPDATE question_text = VALUES(question_text), answer_text = VALUES(answer_text), sort_order = VALUES(sort_order), updated_at = NOW();

INSERT INTO problem_mistake (id, problem_id, content, sort_order, created_at, updated_at) VALUES
(1, 1, '先写入当前值会错误复用同一元素', 1, NOW(), NOW()), (2, 1, '返回数字而不是下标', 2, NOW(), NOW()),
(3, 2, '直接使用当前两侧高度而不是历史最高值', 1, NOW(), NOW()), (4, 2, '指针移动和水量累加顺序写反', 2, NOW(), NOW()),
(5, 3, 'best 初始化为 0 导致全负数组错误', 1, NOW(), NOW()), (6, 3, '把 current 当作全局最优', 2, NOW(), NOW()),
(7, 4, '循环起点或终点造成少算一阶', 1, NOW(), NOW()), (8, 4, '更新两个滚动变量的顺序错误', 2, NOW(), NOW()),
(9, 5, '只比较父子节点，忽略祖先边界', 1, NOW(), NOW()), (10, 5, '使用 int 边界处理极值失败', 2, NOW(), NOW()),
(11, 6, '更新已有 key 时忘记移动节点', 1, NOW(), NOW()), (12, 6, '删除尾节点后忘记同步删除哈希表', 2, NOW(), NOW()),
(13, 7, '发现陆地后没有立刻标记，导致重复访问', 1, NOW(), NOW()), (14, 7, '行列边界判断写反', 2, NOW(), NOW()),
(15, 8, '递归终止条件遗漏 root == p 或 root == q', 1, NOW(), NOW()), (16, 8, '左右子树都有结果时没有返回当前节点', 2, NOW(), NOW())
ON DUPLICATE KEY UPDATE content = VALUES(content), sort_order = VALUES(sort_order), updated_at = NOW();

INSERT INTO dictation_template (id, problem_id, language, template_code, answer_json, keyword_json, created_at, updated_at) VALUES
(1, 1, 'JAVA', 'class Solution {\n    public int[] twoSum(int[] nums, int target) {\n        Map<Integer, Integer> seen = new HashMap<>();\n        for (int i = 0; i < nums.length; i++) {\n            Integer index = seen.get({{blank_1}});\n            if (index != null) return new int[]{index, {{blank_2}}};\n            seen.put({{blank_3}}, i);\n        }\n        return new int[0];\n    }\n}', JSON_OBJECT('blank_1', 'target - nums[i]', 'blank_2', 'i', 'blank_3', 'nums[i]'), JSON_ARRAY('补数查找', '下标映射', '先查后存'), NOW(), NOW()),
(2, 2, 'JAVA', 'class Solution {\n    public int trap(int[] height) {\n        int left = 0, right = height.length - 1, leftMax = 0, rightMax = 0, water = 0;\n        while (left <= right) {\n            leftMax = Math.max({{blank_1}}, height[left]);\n            rightMax = Math.max(rightMax, {{blank_2}});\n            if (leftMax <= rightMax) water += leftMax - height[{{blank_3}}];\n            else water += rightMax - height[right--];\n        }\n        return water;\n    }\n}', JSON_OBJECT('blank_1', 'leftMax', 'blank_2', 'height[right]', 'blank_3', 'left++'), JSON_ARRAY('双指针', '左右最高值', '较低侧结算'), NOW(), NOW()),
(3, 3, 'JAVA', 'class Solution {\n    public int maxSubArray(int[] nums) {\n        int current = nums[0], best = {{blank_1}};\n        for (int i = 1; i < nums.length; i++) {\n            current = Math.max(nums[i], {{blank_2}});\n            best = Math.max({{blank_3}}, current);\n        }\n        return best;\n    }\n}', JSON_OBJECT('blank_1', 'nums[0]', 'blank_2', 'current + nums[i]', 'blank_3', 'best'), JSON_ARRAY('以当前位置结尾', '状态转移', '全局最优'), NOW(), NOW()),
(4, 4, 'JAVA', 'class Solution {\n    public int climbStairs(int n) {\n        if (n <= 2) return {{blank_1}};\n        int previous = 1, current = 2;\n        for (int i = 3; i <= n; i++) {\n            int next = {{blank_2}} + current;\n            previous = {{blank_3}};\n            current = next;\n        }\n        return current;\n    }\n}', JSON_OBJECT('blank_1', 'n', 'blank_2', 'previous', 'blank_3', 'current'), JSON_ARRAY('斐波那契转移', '滚动变量', '初始条件'), NOW(), NOW()),
(5, 5, 'JAVA', 'class Solution {\n    private boolean validate(TreeNode node, long lower, long upper) {\n        if (node == null) return true;\n        if (node.val <= {{blank_1}} || node.val >= {{blank_2}}) return false;\n        return validate(node.left, lower, {{blank_3}})\n            && validate(node.right, node.val, upper);\n    }\n}', JSON_OBJECT('blank_1', 'lower', 'blank_2', 'upper', 'blank_3', 'node.val'), JSON_ARRAY('严格上下界', '祖先约束', '左右递归'), NOW(), NOW()),
(6, 6, 'JAVA', 'class LRUCache {\n    public int get(int key) {\n        Node node = cache.get(key);\n        if (node == null) return {{blank_1}};\n        {{blank_2}}(node);\n        return node.value;\n    }\n    private void moveFirst(Node node) {\n        remove(node);\n        {{blank_3}}(node);\n    }\n}', JSON_OBJECT('blank_1', '-1', 'blank_2', 'moveFirst', 'blank_3', 'addFirst'), JSON_ARRAY('哈希定位', '移动到头部', '淘汰尾节点'), NOW(), NOW()),
(7, 7, 'JAVA', 'class Solution {\n    private void flood(char[][] grid, int row, int col) {\n        if (row < 0 || row >= grid.length || col < 0 || col >= grid[0].length || grid[row][col] != {{blank_1}}) return;\n        grid[row][col] = {{blank_2}};\n        flood(grid, row + 1, col);\n        flood(grid, row - 1, col);\n        flood(grid, row, col + 1);\n        flood(grid, row, {{blank_3}});\n    }\n}', JSON_OBJECT('blank_1', '''1''', 'blank_2', '''0''', 'blank_3', 'col - 1'), JSON_ARRAY('连通块', '访问标记', '四方向递归'), NOW(), NOW()),
(8, 8, 'JAVA', 'class Solution {\n    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {\n        if (root == null || root == p || {{blank_1}}) {\n            return {{blank_2}};\n        }\n        TreeNode {{blank_3}} = lowestCommonAncestor(root.left, p, q);\n        TreeNode {{blank_4}} = lowestCommonAncestor(root.right, p, q);\n        if (left != null && {{blank_5}}) {\n            return {{blank_6}};\n        }\n        return {{blank_7}} != null ? left : right;\n    }\n}', JSON_OBJECT('blank_1', 'root == q', 'blank_2', 'root', 'blank_3', 'left', 'blank_4', 'right', 'blank_5', 'right != null', 'blank_6', 'root', 'blank_7', 'left'), JSON_ARRAY('递归终止', '左右递归', '返回节点', '结果组合'), NOW(), NOW())
ON DUPLICATE KEY UPDATE template_code = VALUES(template_code), answer_json = VALUES(answer_json), keyword_json = VALUES(keyword_json), updated_at = NOW();

