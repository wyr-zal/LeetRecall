SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS problem (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    leetcode_number INT NOT NULL,
    hot100_order INT,
    title VARCHAR(255) NOT NULL,
    difficulty VARCHAR(20) NOT NULL,
    description_markdown MEDIUMTEXT,
    core_idea TEXT,
    hint TEXT,
    key_code TEXT,
    full_code LONGTEXT,
    status TINYINT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    UNIQUE KEY uk_leetcode_number (leetcode_number),
    UNIQUE KEY uk_problem_hot100_order (hot100_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS tag (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL,
    UNIQUE KEY uk_tag_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS problem_tag (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    tag_id BIGINT NOT NULL,
    UNIQUE KEY uk_problem_tag (problem_id, tag_id),
    KEY idx_problem_tag_problem (problem_id),
    CONSTRAINT fk_problem_tag_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE,
    CONSTRAINT fk_problem_tag_tag FOREIGN KEY (tag_id) REFERENCES tag (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS recall_question (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    question_text VARCHAR(500) NOT NULL,
    answer_text TEXT,
    sort_order INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    UNIQUE KEY uk_recall_question_problem_order (problem_id, sort_order),
    CONSTRAINT fk_recall_question_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS problem_mistake (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    content VARCHAR(500) NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    UNIQUE KEY uk_problem_mistake_problem_order (problem_id, sort_order),
    CONSTRAINT fk_problem_mistake_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS problem_progress (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    mastery_level VARCHAR(20) NOT NULL DEFAULT 'NEW',
    review_interval_days INT NOT NULL DEFAULT 0,
    review_count INT NOT NULL DEFAULT 0,
    last_review_at DATETIME,
    next_review_at DATETIME,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    UNIQUE KEY uk_progress_problem (problem_id),
    KEY idx_problem_progress_next (next_review_at),
    CONSTRAINT fk_problem_progress_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS review_record (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    review_result VARCHAR(20) NOT NULL,
    user_recall_json JSON,
    used_hint TINYINT NOT NULL DEFAULT 0,
    viewed_answer TINYINT NOT NULL DEFAULT 0,
    duration_seconds INT NOT NULL DEFAULT 0,
    previous_interval_days INT NOT NULL DEFAULT 0,
    next_interval_days INT NOT NULL DEFAULT 0,
    reviewed_at DATETIME NOT NULL,
    created_at DATETIME NOT NULL,
    KEY idx_review_record_problem_time (problem_id, reviewed_at),
    CONSTRAINT fk_review_record_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS dictation_template (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    language VARCHAR(30) NOT NULL DEFAULT 'JAVA',
    template_code LONGTEXT NOT NULL,
    answer_json JSON NOT NULL,
    keyword_json JSON,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    UNIQUE KEY uk_problem_language (problem_id, language),
    CONSTRAINT fk_dictation_template_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS dictation_record (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    language VARCHAR(30) NOT NULL,
    submitted_answer_json JSON NOT NULL,
    template_code_snapshot LONGTEXT,
    answer_json_snapshot JSON,
    correct_count INT NOT NULL,
    total_count INT NOT NULL,
    accuracy DECIMAL(5,2) NOT NULL,
    viewed_answer TINYINT NOT NULL DEFAULT 0,
    duration_seconds INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL,
    KEY idx_dictation_record_problem_time (problem_id, created_at),
    CONSTRAINT fk_dictation_record_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS dictation_answer_view (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    session_id VARCHAR(80) NOT NULL,
    viewed_at DATETIME NOT NULL,
    UNIQUE KEY uk_answer_view_session (problem_id, session_id),
    CONSTRAINT fk_dictation_answer_view_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS problem_note (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    content_markdown MEDIUMTEXT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    UNIQUE KEY uk_problem_note_problem (problem_id),
    CONSTRAINT fk_problem_note_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS problem_code_annotation (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    anchor_text VARCHAR(1000) NOT NULL,
    occurrence_index INT NOT NULL DEFAULT 0,
    start_line INT NOT NULL,
    start_column INT NOT NULL,
    end_line INT NOT NULL,
    end_column INT NOT NULL,
    label VARCHAR(60),
    content_markdown MEDIUMTEXT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    KEY idx_problem_code_annotation_problem (problem_id, start_line, start_column),
    CONSTRAINT fk_problem_code_annotation_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS external_import_draft (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    leetcode_number INT NULL,
    status VARCHAR(30) NOT NULL,
    request_payload_json JSON,
    content_json LONGTEXT,
    draft_payload_json JSON,
    validation_errors_json JSON,
    format_version VARCHAR(50) NOT NULL DEFAULT 'external-json-v1',
    published_problem_id BIGINT NULL,
    published_at DATETIME NULL,
    compile_passed TINYINT NULL,
    compile_output TEXT,
    overwrite_existing TINYINT NOT NULL DEFAULT 0,
    confirmed_at DATETIME NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    KEY idx_external_import_draft_status_created (status, created_at),
    KEY idx_external_import_draft_problem (published_problem_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
