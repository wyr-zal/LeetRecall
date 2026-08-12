# LeetRecall

LeetRecall 是面向个人的 LeetCode Hot100 复习工具。它只保留两个核心功能：先回忆解题思路的“快速复习”，以及补全关键代码的“默写模式”。

## 当前进度

- [x] 阶段一：工程骨架、数据库结构、初始化数据、统一响应与全局异常处理
- [x] 阶段二：快速复习接口、事务保存与复习调度算法
- [x] 阶段三：深色公共布局、快速复习、快捷键与草稿恢复
- [x] 阶段四：默写接口、答案留痕、评分、历史与 Monaco 填空编辑器
- [x] 阶段五：外部 AI JSON 导入、Docker Compose、测试与文档

## 功能

### 快速复习

- 今日复习队列、进度与题目切换
- 内容区顶部横向切换“题目描述 / 回忆复习 / 我的笔记”，切题时默认展示完整题面
- 1～5 个回忆问题，输入自动保存
- 提示、核心思路、易错点与关键代码
- 每道题独立的 Markdown 笔记，支持编辑/预览、自动保存、`Ctrl+S` 和失败重试
- 不会 / 模糊 / 会三档结果与间隔调度
- `1`、`2`、`3`、`H`、`A`、方向键和 `Esc` 快捷键
- 输入框聚焦时不会误触数字快捷键

### 默写模式

- Monaco Editor Java 高亮、行号、缩进、撤销、复制、全屏和字号调整
- `{{blank_x}}` 可输入空位、重置、查看答案和提交评分
- 空格、换行、尾部分号等差异标准化
- 查看答案后服务端将本次最高分限制为 60
- 最近默写记录及填写答案、正确答案和错误空位详情

### 辅助功能

- 生成外部 AI 任务包，支持预览、复制和下载 Markdown
- 粘贴 JSON 后预览校验结果，明确覆盖影响并确认导入
- 全局题目搜索
- 清除当前浏览器中的未提交草稿

## 技术栈

- Web：Vue 3、TypeScript、Vite、Vue Router、Pinia、Axios、Tailwind CSS、Monaco Editor、Markdown-It、Lucide
- Server：Java 21、Spring Boot 3.2、MyBatis-Plus、MySQL 8、Hibernate Validator、Springdoc OpenAPI
- Deploy：Docker、Docker Compose、Nginx

## Docker Compose 启动（推荐）

### WSL 一键启动

在项目根目录执行：

```bash
./scripts/start-local.sh
```

脚本会检查 Docker、首次自动创建 `.env`、构建并在后台启动完整服务；默认端口被占用时仅对本次启动自动选择空闲端口，并输出实际应用地址。再次执行时会通过源码指纹判断前后端是否变化：未变化时直接复用容器，变化时只重建对应服务并保留当前端口。在 WSL 中会优先使用 Windows Docker Desktop CLI，避免 WSL Integration 代理或 WSL 内 `docker compose` 插件状态影响启动；Windows 引擎不可用时再回退 WSL Docker。

### Windows 双击启动

在 Windows 资源管理器中直接双击项目根目录的 `start-local.cmd`。它会自动切换到默认 WSL 发行版并调用 `scripts/start-local.sh`，窗口会保留启动结果与访问地址。

前提是已安装 WSL，且 Docker Desktop 已启动并启用该 WSL 发行版的 Integration。

### 1. 创建环境配置

```bash
cp .env.example .env
```

请至少修改 `.env` 中的三个密码项。`.env` 已被 Git 忽略。

### 2. 构建并启动

新版 Docker：

```bash
docker compose --env-file .env -f deploy/docker-compose.yml up -d --build
```

独立版 Compose：

```bash
docker-compose --env-file .env -f deploy/docker-compose.yml up -d --build
```

### 3. 访问

- 应用入口：<http://localhost:8088>
- 后端直连：<http://localhost:8080>
- OpenAPI：<http://localhost:8080/swagger-ui.html>
- Web 容器直连：<http://localhost:5173>

首次启动会按 Hot100 清单加载中文题面和 Java 起始签名。学习资料由用户自行使用外部 AI 生成后导入；MySQL 使用 `mysql_data` 命名卷，容器重启后记录不会丢失。

查看状态和日志：

```bash
docker compose --env-file .env -f deploy/docker-compose.yml ps
docker compose --env-file .env -f deploy/docker-compose.yml logs -f server
```

停止服务（保留数据）：

```bash
docker compose --env-file .env -f deploy/docker-compose.yml down
```

## 本地开发

### 前置条件

- Java 21
- Maven 3.9+
- Node.js 22+
- MySQL 8

### 数据库

先创建 `leet_recall` 数据库和用户，然后按顺序执行：

```text
leet-recall-server/src/main/resources/schema.sql
leet-recall-server/src/main/resources/init.sql
```

也可以只启动 Compose 中的 MySQL：

```bash
docker compose --env-file .env -f deploy/docker-compose.yml up -d mysql
```

### 后端

```bash
cd leet-recall-server
DB_URL='jdbc:mysql://localhost:3306/leet_recall?useUnicode=true&characterEncoding=utf8&serverTimezone=Asia/Shanghai' \
DB_USERNAME=leet_recall \
DB_PASSWORD='你的密码' \
mvn spring-boot:run
```

后端默认监听 <http://localhost:8080>。

### 前端

```bash
cd leet-recall-web
npm install
npm run dev
```

开发服务器默认监听 <http://localhost:5173>，并将 `/api` 代理到 `127.0.0.1:8080`。

## 测试与构建

后端：

```bash
cd leet-recall-server
mvn test
mvn -DskipTests package
```

前端：

```bash
cd leet-recall-web
npm run lint
npm run typecheck
npm test
npm run build
npm audit
```

## API

| 方法 | 路径 | 说明 |
| --- | --- | --- |
| GET | `/api/reviews/today` | 获取今日快速复习队列 |
| GET | `/api/reviews/problems/{problemId}` | 获取快速复习详情 |
| POST | `/api/reviews/problems/{problemId}/submit` | 提交掌握状态 |
| GET | `/api/problems/{problemId}/note` | 获取题目的 Markdown 笔记 |
| PUT | `/api/problems/{problemId}/note` | 保存题目的 Markdown 笔记 |
| GET | `/api/dictations/today` | 获取今日默写队列 |
| GET | `/api/dictations/problems/{problemId}` | 获取不含答案的默写详情 |
| GET | `/api/dictations/problems/{problemId}/answer` | 查看并记录答案访问 |
| POST | `/api/dictations/problems/{problemId}/submit` | 提交默写并评分 |
| GET | `/api/dictations/problems/{problemId}/records` | 获取默写历史 |
| GET | `/api/hot100/{number}/external-import-task` | 获取外部 AI 任务包 |
| POST | `/api/external-import-drafts` | 保存并校验外部 JSON |
| PUT | `/api/external-import-drafts/{id}` | 修改并重新校验 JSON |
| POST | `/api/external-import-drafts/{id}/confirm` | 确认导入/覆盖 |

统一返回结构：

```json
{
  "code": 0,
  "message": "success",
  "data": {}
}
```

## 项目结构

```text
LeetRecall
├── leet-recall-web       # Vue 3 前端
├── leet-recall-server    # Spring Boot 后端与 SQL
├── deploy                # Compose 与网关 Nginx
├── scripts               # 本地启动与数据库预检脚本
├── docs                  # 架构说明
├── .env.example          # 无真实密码的环境变量模板
└── README.md
```

更多技术决策见 `docs/architecture.md`。
## 外部 AI JSON 导入

- LeetRecall 不调用任何 AI，也不保存来源、模型、提示词或 URL 元数据。
- 导入页按 Hot100 题号生成任务包，用户可补充自己的题解/难点，预览后复制或下载 Markdown 文档，交给任意外部 AI。
- 外部 AI 返回纯 JSON 后粘贴回导入页。服务端严格检查字段白名单、题目身份、专属问答、默写回填、官方方法签名和 Java 21 编译。
- 同题号导入覆盖题目内容但保留题目 ID、学习进度、笔记、复习记录和历史默写记录；新默写记录保存模板/答案快照。

## 既有数据库迁移到 Flyway

首次升级已有数据库前，先运行 `scripts/preflight-existing-db-migration.sh`。它会检查旧表结构并把 MySQL 备份到 `backups/`，默认不改数据库；确认备份后才运行 `scripts/preflight-existing-db-migration.sh --apply`。新数据库由 Flyway 自动执行版本化迁移；不要再手动灌入旧初始化 SQL。
