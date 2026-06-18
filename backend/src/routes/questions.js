const { Router } = require('express');
const { v4: uuidv4 } = require('uuid');
const { query } = require('../db/connection');
const { authenticate } = require('../middleware/auth');

const router = Router();

// GET /questions?exam=SSC&search=...&difficulty=...&page=1&limit=20
router.get('/', authenticate, async (req, res, next) => {
  try {
    const { exam, search, difficulty, page = '1', limit = '20' } = req.query;
    const pageNum = Math.max(1, parseInt(page, 10) || 1);
    const limitNum = Math.min(100, Math.max(1, parseInt(limit, 10) || 20));
    const offset = (pageNum - 1) * limitNum;

    let baseQuery = `
      SELECT q.id, q.question_en, q.question_hi, q.options_en, q.options_hi,
             q.correct_option, q.difficulty_level, q.explanation_en, q.explanation_hi,
             q.explanation_hinglish, q.shortcut_formula_note, q.common_mistake_note,
             q.created_at
      FROM questions q
    `;
    let countQuery = 'SELECT COUNT(*) AS total FROM questions q';
    const params = [];
    const conditions = [];

    if (exam) {
      conditions.push(`q.taxonomy_id IN (
        SELECT id FROM taxonomy_nodes
        WHERE parent_id IN (SELECT id FROM taxonomy_nodes WHERE name = $1)
      )`);
      params.push(exam);
    }

    if (search) {
      conditions.push(`(q.question_en ILIKE $${params.length + 1} OR q.question_hi ILIKE $${params.length + 1})`);
      params.push(`%${search}%`);
    }

    if (difficulty) {
      conditions.push(`q.difficulty_level = $${params.length + 1}`);
      params.push(difficulty);
    }

    if (conditions.length > 0) {
      const where = ' WHERE ' + conditions.join(' AND ');
      baseQuery += where;
      countQuery += where;
    }

    baseQuery += ' ORDER BY q.created_at DESC LIMIT $' + (params.length + 1) + ' OFFSET $' + (params.length + 2);

    const countParams = [...params];
    params.push(limitNum, offset);

    const [dataResult, countResult] = await Promise.all([
      query(baseQuery, params),
      query(countQuery, countParams),
    ]);

    res.json({
      questions: dataResult.rows,
      pagination: {
        page: pageNum,
        limit: limitNum,
        total: parseInt(countResult.rows[0].total, 10),
      },
    });
  } catch (err) {
    next(err);
  }
});

// GET /questions/:id — single question
router.get('/:id', authenticate, async (req, res, next) => {
  try {
    const { id } = req.params;
    const result = await query(
      `SELECT q.id, q.question_en, q.question_hi, q.options_en, q.options_hi,
              q.correct_option, q.difficulty_level, q.explanation_en, q.explanation_hi,
              q.explanation_hinglish, q.shortcut_formula_note, q.common_mistake_note,
              q.taxonomy_id, q.created_at
       FROM questions q WHERE q.id = $1`,
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Question not found' });
    }

    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

// POST /questions — create new question
router.post('/', authenticate, async (req, res, next) => {
  try {
    const {
      taxonomyId, questionEn, questionHi, optionsEn, optionsHi,
      correctOption, difficultyLevel, explanationEn, explanationHi,
      explanationHinglish, shortcutFormulaNote, commonMistakeNote,
    } = req.body;

    if (!questionEn || !questionHi || !taxonomyId) {
      return res.status(400).json({ error: 'questionEn, questionHi, taxonomyId are required' });
    }

    const id = uuidv4();
    await query(
      `INSERT INTO questions (
        id, taxonomy_id, question_en, question_hi, options_en, options_hi,
        correct_option, difficulty_level, explanation_en, explanation_hi,
        explanation_hinglish, shortcut_formula_note, common_mistake_note
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)`,
      [
        id, taxonomyId, questionEn, questionHi,
        JSON.stringify(optionsEn || []), JSON.stringify(optionsHi || []),
        correctOption || 0, difficultyLevel || 'medium',
        explanationEn || '', explanationHi || '',
        explanationHinglish || '', shortcutFormulaNote || null, commonMistakeNote || null,
      ]
    );

    const result = await query('SELECT * FROM questions WHERE id = $1', [id]);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

// PUT /questions/:id — update existing question
router.put('/:id', authenticate, async (req, res, next) => {
  try {
    const { id } = req.params;
    const {
      taxonomyId, questionEn, questionHi, optionsEn, optionsHi,
      correctOption, difficultyLevel, explanationEn, explanationHi,
      explanationHinglish, shortcutFormulaNote, commonMistakeNote,
    } = req.body;

    const existing = await query('SELECT id FROM questions WHERE id = $1', [id]);
    if (existing.rows.length === 0) {
      return res.status(404).json({ error: 'Question not found' });
    }

    await query(
      `UPDATE questions SET
        taxonomy_id = $1, question_en = $2, question_hi = $3,
        options_en = $4, options_hi = $5, correct_option = $6,
        difficulty_level = $7, explanation_en = $8, explanation_hi = $9,
        explanation_hinglish = $10, shortcut_formula_note = $11,
        common_mistake_note = $12
      WHERE id = $13`,
      [
        taxonomyId, questionEn, questionHi,
        JSON.stringify(optionsEn || []), JSON.stringify(optionsHi || []),
        correctOption, difficultyLevel, explanationEn, explanationHi,
        explanationHinglish, shortcutFormulaNote || null, commonMistakeNote || null,
        id,
      ]
    );

    const result = await query('SELECT * FROM questions WHERE id = $1', [id]);
    res.json(result.rows[0]);
  } catch (err) {
    next(err);
  }
});

module.exports = router;
