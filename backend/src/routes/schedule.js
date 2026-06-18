const { Router } = require('express');
const IORedis = require('ioredis');
const { query } = require('../db/connection');
const { authenticate } = require('../middleware/auth');

const router = Router();

const redis = new IORedis(process.env.REDIS_URL, {
  maxRetriesPerRequest: 3,
  retryStrategy(times) { if (times > 3) return null; return Math.min(times * 200, 2000); },
});

const GEMINI_API = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';
const GROQ_API = 'https://api.groq.com/openai/v1/chat/completions';
const GROQ_MODEL = 'llama-3.3-70b-versatile';

function getTodayKey(userId) {
  const date = new Date().toISOString().slice(0, 10);
  return `schedule:${userId}:${date}`;
}

async function getCachedSchedule(userId) {
  try {
    const cached = await redis.get(getTodayKey(userId));
    return cached ? JSON.parse(cached) : null;
  } catch {
    return null;
  }
}

async function setCachedSchedule(userId, data) {
  try {
    await redis.set(getTodayKey(userId), JSON.stringify(data), 'EX', 86400);
  } catch {
    // cache write failure is non-fatal
  }
}

async function fetchUserPerformance(userId) {
  const accuracyBySubject = await query(
    `SELECT tn.name AS subject,
            COUNT(ua.id) AS attempts,
            SUM(CASE WHEN ua.is_correct THEN 1 ELSE 0 END) AS correct
     FROM user_attempts ua
     JOIN questions q ON q.id = ua.question_id
     JOIN taxonomy_nodes tn ON tn.id = q.taxonomy_id
     WHERE ua.user_id = $1 AND tn.level = 0
     GROUP BY tn.name`,
    [userId]
  );

  const streakResult = await query(
    `SELECT COUNT(DISTINCT DATE(created_at)) AS study_days
     FROM user_attempts
     WHERE user_id = $1 AND created_at >= NOW() - INTERVAL '7 days'`,
    [userId]
  );

  const userResult = await query(
    `SELECT selected_exam, daily_capacity_minutes, weak_domains,
            (SELECT COUNT(*) FROM tests WHERE user_id = $1 AND completed_at IS NOT NULL) AS tests_taken
     FROM users WHERE id = $1`,
    [userId]
  );

  const user = userResult.rows[0];
  const weakDomains = user?.weak_domains || [];

  const subjects = accuracyBySubject.rows.map((r) => ({
    name: r.subject,
    attempts: parseInt(r.attempts, 10),
    correct: parseInt(r.correct, 10),
    accuracy: parseInt(r.attempts, 10) > 0
      ? Math.round((parseInt(r.correct, 10) / parseInt(r.attempts, 10)) * 100)
      : 0,
  }));

  return {
    subjects,
    studyStreakDays: parseInt(streakResult.rows[0]?.study_days || '0', 10),
    testsTaken: parseInt(user?.tests_taken || '0', 10),
    dailyCapacityMinutes: user?.daily_capacity_minutes || 30,
    weakDomains,
  };
}

function buildPrompt(performance) {
  const weakSubjects = performance.subjects
    .filter((s) => s.accuracy < 60)
    .map((s) => `${s.name} (${s.accuracy}% accuracy)`);

  const strongSubjects = performance.subjects
    .filter((s) => s.accuracy >= 60)
    .map((s) => `${s.name} (${s.accuracy}% accuracy)`);

  const content = `You are an AI study scheduler. Generate a JSON daily study plan.

User Profile:
- Daily capacity: ${performance.dailyCapacityMinutes} minutes
- Study streak: ${performance.studyStreakDays} days in the last 7
- Tests taken: ${performance.testsTaken}
- Weak subjects (accuracy < 60%): ${weakSubjects.length > 0 ? weakSubjects.join(', ') : 'none'}
- Strong subjects: ${strongSubjects.length > 0 ? strongSubjects.join(', ') : 'none'}
- Weak domains to focus on: ${performance.weakDomains.join(', ') || 'none specified'}

Output valid JSON only, no markdown wrapping:
{
  "morning": ["topic 1", "topic 2"],
  "evening": ["topic 3", "topic 4"],
  "focus_subject": "name of weakest subject"
}`;

  return content;
}

function parseJSON(text) {
  const cleaned = text.replace(/```json|```/g, '').trim();
  return JSON.parse(cleaned);
}

async function callGemini(prompt) {
  const apiKey = process.env.GEMINI_API_KEY;
  if (!apiKey) throw new Error('GEMINI_API_KEY not configured');

  const response = await fetch(`${GEMINI_API}?key=${apiKey}`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({
      contents: [{
        parts: [{ text: prompt }],
      }],
      generationConfig: {
        temperature: 0.7,
        maxOutputTokens: 1024,
      },
    }),
  });

  if (!response.ok) {
    const body = await response.text();
    throw new Error(`Gemini API responded ${response.status}: ${body.slice(0, 200)}`);
  }

  const data = await response.json();
  const text = data.candidates?.[0]?.content?.parts?.[0]?.text;
  if (!text) throw new Error('Gemini returned empty response');
  return parseJSON(text);
}

async function callGroq(prompt) {
  const apiKey = process.env.GROQ_API_KEY;
  if (!apiKey) throw new Error('GROQ_API_KEY not configured');

  const response = await fetch(GROQ_API, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${apiKey}`,
    },
    body: JSON.stringify({
      model: GROQ_MODEL,
      messages: [{ role: 'user', content: prompt }],
      temperature: 0.7,
      max_tokens: 1024,
    }),
  });

  if (!response.ok) {
    const body = await response.text();
    throw new Error(`Groq API responded ${response.status}: ${body.slice(0, 200)}`);
  }

  const data = await response.json();
  const text = data.choices?.[0]?.message?.content;
  if (!text) throw new Error('Groq returned empty response');
  return parseJSON(text);
}

function generateFallbackPlan(performance) {
  const weak = performance.weakDomains.length > 0
    ? performance.weakDomains
    : performance.subjects
        .filter((s) => s.accuracy < 60)
        .map((s) => s.name);

  const strong = performance.subjects
    .filter((s) => s.accuracy >= 60)
    .map((s) => s.name);

  const focus = weak.length > 0 ? weak[0] : (strong[0] || 'General Review');

  const morning = weak.slice(0, 2);
  const evening = [...strong.slice(0, 2), ...weak.slice(2, 4)];

  if (morning.length === 0) morning.push('General Review');
  if (evening.length === 0) evening.push('Practice Test');

  return { morning, evening, focus_subject: focus };
}

// GET /schedule/:userId — return AI-generated daily study plan
router.get('/:userId', authenticate, async (req, res, next) => {
  try {
    const { userId } = req.params;

    if (userId !== req.userId) {
      return res.status(403).json({ error: 'Forbidden' });
    }

    const cached = await getCachedSchedule(userId);
    if (cached) {
      return res.json({ ...cached, cached: true });
    }

    const performance = await fetchUserPerformance(userId);
    const prompt = buildPrompt(performance);

    let plan;
    let aiProvider = 'none';

    try {
      plan = await callGemini(prompt);
      aiProvider = 'gemini';
    } catch (geminiErr) {
      console.warn('Gemini failed, trying Groq:', geminiErr.message);
      try {
        plan = await callGroq(prompt);
        aiProvider = 'groq';
      } catch (groqErr) {
        console.warn('Groq also failed, using static fallback:', groqErr.message);
        plan = generateFallbackPlan(performance);
      }
    }

    const result = {
      userId,
      date: new Date().toISOString().slice(0, 10),
      dailyCapacityMinutes: performance.dailyCapacityMinutes,
      weakDomains: performance.weakDomains,
      aiProvider,
      ...plan,
      cached: false,
    };

    await setCachedSchedule(userId, result);

    res.json(result);
  } catch (err) {
    next(err);
  }
});

module.exports = router;
