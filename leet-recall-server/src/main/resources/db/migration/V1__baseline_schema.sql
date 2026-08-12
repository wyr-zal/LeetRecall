SET NAMES utf8mb4;

CREATE TABLE problem (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    leetcode_number INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    difficulty VARCHAR(20) NOT NULL,
    core_idea TEXT,
    hint TEXT,
    key_code TEXT,
    full_code LONGTEXT,
    status TINYINT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    UNIQUE KEY uk_leetcode_number (leetcode_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE tag (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL,
    UNIQUE KEY uk_tag_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE problem_tag (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    tag_id BIGINT NOT NULL,
    UNIQUE KEY uk_problem_tag (problem_id, tag_id),
    KEY idx_problem_tag_problem (problem_id),
    CONSTRAINT fk_problem_tag_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE,
    CONSTRAINT fk_problem_tag_tag FOREIGN KEY (tag_id) REFERENCES tag (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE recall_question (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    question_text VARCHAR(500) NOT NULL,
    answer_text TEXT,
    sort_order INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    KEY idx_recall_question_problem (problem_id),
    CONSTRAINT fk_recall_question_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE problem_mistake (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    content VARCHAR(500) NOT NULL,
    sort_order INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    KEY idx_problem_mistake_problem (problem_id),
    CONSTRAINT fk_problem_mistake_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE problem_progress (
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

CREATE TABLE review_record (
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

CREATE TABLE dictation_template (
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

CREATE TABLE dictation_record (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    language VARCHAR(30) NOT NULL,
    submitted_answer_json JSON NOT NULL,
    correct_count INT NOT NULL,
    total_count INT NOT NULL,
    accuracy DECIMAL(5,2) NOT NULL,
    viewed_answer TINYINT NOT NULL DEFAULT 0,
    duration_seconds INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL,
    KEY idx_dictation_record_problem_time (problem_id, created_at),
    CONSTRAINT fk_dictation_record_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE dictation_answer_view (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    problem_id BIGINT NOT NULL,
    session_id VARCHAR(80) NOT NULL,
    viewed_at DATETIME NOT NULL,
    UNIQUE KEY uk_answer_view_session (problem_id, session_id),
    CONSTRAINT fk_answer_view_problem FOREIGN KEY (problem_id) REFERENCES problem (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
