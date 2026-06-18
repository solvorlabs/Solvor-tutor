-- user_attempts table — mirrors Flutter SQLite schema for cloud sync

CREATE TABLE IF NOT EXISTS user_attempts (
    id UUID PRIMARY KEY,
    test_id UUID NOT NULL REFERENCES tests(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id),
    question_id UUID NOT NULL REFERENCES questions(id),
    selected_option INTEGER NOT NULL,
    is_correct BOOLEAN NOT NULL DEFAULT FALSE,
    time_taken_seconds INTEGER NOT NULL DEFAULT 0,
    confidence_level VARCHAR(20),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_attempts_user ON user_attempts(user_id);
CREATE INDEX idx_attempts_question ON user_attempts(question_id);
CREATE INDEX idx_attempts_test ON user_attempts(test_id);
CREATE INDEX idx_attempts_created ON user_attempts(created_at);
