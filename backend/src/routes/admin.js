const { Router } = require('express');
const { v4: uuidv4 } = require('uuid');
const { query } = require('../db/connection');
const { authenticate } = require('../middleware/auth');

const router = Router();

const REQUIRED_FIELDS = [
  'question_en', 'question_hi', 'options_en', 'options_hi',
  'correct_option', 'explanation_en', 'explanation_hi',
  'taxonomy_id', 'difficulty_level',
];

// POST /admin/import — bulk import questions
router.post('/import', authenticate, async (req, res, next) => {
  try {
    const { questions } = req.body;

    if (!Array.isArray(questions) || questions.length === 0) {
      return res.status(400).json({ error: 'questions array is required' });
    }

    let inserted = 0;
    let failed = 0;
    const errors = [];

    for (let i = 0; i < questions.length; i++) {
      const q = questions[i];

      const missing = REQUIRED_FIELDS.filter((f) => {
        const val = q[f];
        return val === undefined || val === null || val === '';
      });

      if (missing.length > 0) {
        failed++;
        errors.push({ row: i + 1, message: `Missing fields: ${missing.join(', ')}` });
        continue;
      }

      try {
        const optsEn = Array.isArray(q.options_en) ? q.options_en : JSON.parse(q.options_en);
        const optsHi = Array.isArray(q.options_hi) ? q.options_hi : JSON.parse(q.options_hi);

        await query(
          `INSERT INTO questions (
            id, taxonomy_id, question_en, question_hi, options_en, options_hi,
            correct_option, difficulty_level, explanation_en, explanation_hi,
            explanation_hinglish, shortcut_formula_note, common_mistake_note
          ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)`,
          [
            q.id || uuidv4(),
            q.taxonomy_id,
            q.question_en,
            q.question_hi,
            JSON.stringify(optsEn),
            JSON.stringify(optsHi),
            parseInt(q.correct_option, 10),
            q.difficulty_level,
            q.explanation_en,
            q.explanation_hi,
            q.explanation_hinglish || '',
            q.shortcut_formula_note || null,
            q.common_mistake_note || null,
          ]
        );
        inserted++;
      } catch (err) {
        failed++;
        errors.push({ row: i + 1, message: err.message });
      }
    }

    res.json({ inserted, failed, errors });
  } catch (err) {
    next(err);
  }
});

// GET /admin/analytics — aggregated attempt data
router.get('/analytics', authenticate, async (req, res, next) => {
  try {
    const result = await query(
      `SELECT
        q.id AS question_id,
        q.question_en AS question_text,
        COUNT(ua.id) AS total_attempts,
        SUM(CASE WHEN ua.is_correct = TRUE THEN 1 ELSE 0 END) AS correct_attempts,
        CASE
          WHEN COUNT(ua.id) = 0 THEN 0
          ELSE ROUND(SUM(CASE WHEN ua.is_correct THEN 1 ELSE 0 END)::numeric / COUNT(ua.id), 4)
        END AS accuracy_rate,
        COALESCE(ROUND(AVG(ua.time_taken_seconds), 1), 0) AS avg_time_seconds,
        q.difficulty_level,
        tn.name AS topic_name
      FROM questions q
      LEFT JOIN user_attempts ua ON ua.question_id = q.id
      LEFT JOIN taxonomy_nodes tn ON tn.id = q.taxonomy_id
      GROUP BY q.id, q.question_en, q.difficulty_level, tn.name
      ORDER BY total_attempts DESC`
    );

    res.json({ rows: result.rows });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
