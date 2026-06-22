const { Router } = require('express');
const jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');
const { initializeApp, cert } = require('firebase-admin/app');
const { getAuth } = require('firebase-admin/auth');
const { query } = require('../db/connection');

const router = Router();

const serviceAccount = require('../serviceAccountKey.json');
initializeApp({ credential: cert(serviceAccount) });

// POST /auth/firebase-login — verify Firebase ID token, upsert user
router.post('/firebase-login', async (req, res, next) => {
  try {
    const { idToken } = req.body;
    if (!idToken) return res.status(400).json({ error: 'idToken required' });

    const decoded = await getAuth().verifyIdToken(idToken);
    const uid = decoded.uid;
    const phone = decoded.phone_number ?? null;
    const email = decoded.email ?? null;

    const existing = await query(
      'SELECT id FROM users WHERE phone_number = $1 OR email = $2',
      [phone, email]
    );

    let userId;
    if (existing.rows.length === 0) {
      const result = await query(
        `INSERT INTO users (id, phone_number, email, firebase_uid)
         VALUES ($1, $2, $3, $4) RETURNING id`,
        [uuidv4(), phone, email, uid]
      );
      userId = result.rows[0].id;
    } else {
      userId = existing.rows[0].id;
    }

    const token = jwt.sign(
      { userId, phone, email },
      process.env.JWT_SECRET,
      { expiresIn: '30d' }
    );

    res.json({ success: true, userId, token });
  } catch (err) {
    next(err);
  }
});

// POST /auth/register — legacy user creation (kept for admin panel compat)
router.post('/register', async (req, res, next) => {
  try {
    const { phoneNumber, selectedExam, uiLanguage } = req.body;

    if (!phoneNumber) {
      return res.status(400).json({ error: 'phoneNumber is required' });
    }

    const existing = await query('SELECT id FROM users WHERE phone_number = $1', [phoneNumber]);
    let userId;

    if (existing.rows.length === 0) {
      const result = await query(
        `INSERT INTO users (id, phone_number, selected_exam, ui_language)
         VALUES ($1, $2, $3, $4)
         RETURNING id`,
        [uuidv4(), phoneNumber, selectedExam || null, uiLanguage || 'en']
      );
      userId = result.rows[0].id;
    } else {
      userId = existing.rows[0].id;
    }

    res.json({ message: 'User registered', userId });
  } catch (err) {
    next(err);
  }
});

// POST /auth/verify-otp — verify OTP, return JWT (legacy admin panel compat)
router.post('/verify-otp', async (req, res, next) => {
  try {
    const { phoneNumber, otp } = req.body;

    if (!phoneNumber || !otp) {
      return res.status(400).json({ error: 'phoneNumber and otp are required' });
    }

    const result = await query('SELECT id FROM users WHERE phone_number = $1', [phoneNumber]);
    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    const user = result.rows[0];
    const token = jwt.sign(
      { userId: user.id, phone: phoneNumber },
      process.env.JWT_SECRET,
      { expiresIn: '30d' }
    );

    res.json({ token, userId: user.id });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
