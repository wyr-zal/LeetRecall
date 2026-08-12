-- Preserve the legacy progress backfill as the final migration in baseline 1.

INSERT INTO problem_progress (
    problem_id, mastery_level, review_interval_days, review_count,
    last_review_at, next_review_at, created_at, updated_at
)
SELECT id, 'NEW', 0, 0, NULL, NOW(), NOW(), NOW()
FROM problem
WHERE status = 1
ON DUPLICATE KEY UPDATE updated_at = VALUES(updated_at);

