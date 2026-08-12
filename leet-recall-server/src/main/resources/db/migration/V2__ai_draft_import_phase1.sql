CREATE TABLE problem_source (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    draft_id BIGINT NULL,
    problem_id BIGINT NULL,
    source_type VARCHAR(30) NOT NULL,
    source_role VARCHAR(30) NOT NULL,
    source_url VARCHAR(1000),
    canonical_url VARCHAR(1000),
    content_sha256 CHAR(64),
    content_excerpt TEXT,
    created_at DATETIME NOT NULL,
    KEY idx_problem_source_draft (draft_id),
    KEY idx_problem_source_problem (problem_id),
    KEY idx_problem_source_canonical (canonical_url(255))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE ai_import_draft (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    leetcode_number INT NULL,
    canonical_url VARCHAR(1000),
    status VARCHAR(30) NOT NULL,
    request_payload_json JSON,
    raw_model_response LONGTEXT,
    draft_payload_json JSON,
    validation_errors_json JSON,
    model_name VARCHAR(100),
    prompt_version VARCHAR(50) NOT NULL,
    published_problem_id BIGINT NULL,
    published_at DATETIME NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    KEY idx_ai_import_draft_status_created (status, created_at),
    KEY idx_ai_import_draft_problem (published_problem_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
