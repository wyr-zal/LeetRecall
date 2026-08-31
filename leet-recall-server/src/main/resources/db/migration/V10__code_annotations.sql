USE `leet_recall`;

-- 代码批注：默写模式在标准答案代码（problem.full_code）上做的选区批注。
-- 目标库由 Flyway 连接配置决定（leetrecall），与 V1~V9 一致，脚本内不切库。
-- 锚点采用「位置 + 文本」双锚：代码被编辑或重新导入后，位置失配时按 anchor_text 的第
-- occurrence_index 次出现重新定位，仍找不到则由前端标记为失效批注，正文不丢。
CREATE TABLE problem_code_annotation (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    anchor_text VARCHAR(1000) NOT NULL COMMENT '选中的代码原文片段',
    occurrence_index INT NOT NULL DEFAULT 0 COMMENT '该片段在全码中的第几次出现，从 0 开始',
    start_line INT NOT NULL COMMENT '起始行，从 1 开始',
    start_column INT NOT NULL COMMENT '起始列，从 1 开始',
    end_line INT NOT NULL COMMENT '结束行，从 1 开始',
    end_column INT NOT NULL COMMENT '结束列，从 1 开始',
    label VARCHAR(60) NULL COMMENT '可选短标题，默写时只露标题不泄露正文',
    content_markdown MEDIUMTEXT NOT NULL COMMENT '批注正文 Markdown',
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    KEY idx_problem_code_annotation_problem (problem_id, start_line, start_column),
    CONSTRAINT fk_problem_code_annotation_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
