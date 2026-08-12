-- 外部 AI JSON 导入：只新增表/列，绝不修改历史 AI 草稿或来源表。
CREATE TABLE external_import_draft (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    leetcode_number INT NOT NULL,
    status VARCHAR(30) NOT NULL COMMENT 'INVALID、READY、IMPORTED',
    request_payload_json JSON NOT NULL COMMENT '题号和格式版本，不含来源或模型信息',
    content_json LONGTEXT NULL COMMENT '已净化的外部 JSON 草稿内容，不保存来源或模型字段',
    draft_payload_json JSON NULL COMMENT '反序列化后的格式化草稿',
    validation_errors_json JSON NOT NULL COMMENT '校验错误列表',
    format_version VARCHAR(50) NOT NULL DEFAULT 'external-json-v1' COMMENT '外部 JSON 格式版本',
    published_problem_id BIGINT NULL COMMENT '确认导入后的题目 ID',
    published_at DATETIME NULL COMMENT '确认导入时间',
    compile_passed TINYINT NULL COMMENT 'Java 21 编译硬门禁结果',
    compile_output TEXT NULL COMMENT '编译器诊断摘要',
    overwrite_existing TINYINT NOT NULL DEFAULT 0 COMMENT '是否覆盖同题号内容',
    confirmed_at DATETIME NULL COMMENT '用户确认导入时间',
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    KEY idx_external_import_draft_status_created (status, created_at),
    KEY idx_external_import_draft_problem (published_problem_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE dictation_record
    ADD COLUMN template_code_snapshot LONGTEXT NULL COMMENT '提交时的默写模板快照',
    ADD COLUMN answer_json_snapshot JSON NULL COMMENT '提交时的默写答案快照';
