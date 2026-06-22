# Solvor Tutor — Setup Guide

## Prerequisites

| Tool | Version | Install |
|------|---------|---------|
| Flutter (FVM) | 3.44.2 | `/home/codemaster29/fvm/versions/stable/bin/flutter` |
| Dart | 3.12.2 | Bundled with Flutter |
| Node.js | ≥ 20.x | https://nodejs.org |
| PostgreSQL | ≥ 15 | https://www.postgresql.org/download |
| Redis | ≥ 7 | https://redis.io/docs/getting-started |
| Java | 17 | For Android builds |

---

## 1. Clone & root structure

```
Samsung_Hackathon_Document/
├── solvor_tutor/     # Flutter app
├── backend/          # Node.js API (optional)
└── admin/            # Next.js admin panel (optional)
```

---

## 2. Quick Demo (No Backend Needed)

The app runs **90% offline** — Firebase Auth and local SQLite handle everything. Backend is only needed for question bank sync.

```bash
# 1. Set Flutter path
export PATH="/home/codemaster29/fvm/versions/stable/bin:$PATH"

# 2. Install deps
cd solvor_tutor
flutter pub get

# 3. Run on device (replace IP with your laptop's LAN IP)
JAVA_HOME=/usr/lib/jvm/java-17-openjdk \
  flutter run --dart-define=API_BASE=http://192.168.x.x:3000

# 4. Or build release APK
JAVA_HOME=/usr/lib/jvm/java-17-openjdk \
  flutter build apk --release --dart-define=API_BASE=http://192.168.x.x:3000
```

> The `API_BASE` is only used for an optional backend call during sign-in (wrapped in try/catch — skipped silently if server is down).

---

## 3. Firebase Setup

### 3a. Project & Auth Providers
- Firebase project: **virtual-guardian-3d3f6**
- **Google Sign-In** enabled in Authentication → Sign-in method
- **Phone Auth** enabled (requires Blaze plan for real SMS; test numbers work on Spark)

### 3b. SHA Fingerprints (for Phone Auth + Google Sign-In)
```bash
# Debug keystore
keytool -list -v -alias androiddebugkey \
  -keystore ~/.android/debug.keystore \
  -storepass android -keypass android
```

Copy **SHA-1** and **SHA-256** to:
Firebase Console → Project Settings → General → Your apps → Android → SHA certificate fingerprints

### 3c. Test Phone Numbers (No SMS Required)
Firebase Console → Authentication → Sign-in method → Phone → **Phone numbers for testing**
Add `+91 8800603512` with code `123456`

### 3d. Firebase Config
`lib/firebase_options.dart` is already generated and checked in. No changes needed.

---

## 4. Run on Phone via USB

```bash
export PATH="/home/codemaster29/fvm/versions/stable/bin:$PATH"
JAVA_HOME=/usr/lib/jvm/java-17-openjdk \
  flutter run --dart-define=API_BASE=http://192.168.x.x:3000
```

The app auto-detects USB connection. Use `r` for hot reload, `R` for hot restart.

---

## 5. Backend (Optional — For Question Bank API)

### 5a. Database
```bash
psql -U postgres
CREATE USER solvor WITH PASSWORD 'solvor_pass';
CREATE DATABASE solvor_tutor OWNER solvor;
\q
```

### 5b. Configure
```bash
cd backend
cp .env.example .env
# Edit .env with your keys
npm install
npm run migrate
npm start
```

### 5c. Service Account
Place your Firebase Admin SDK JSON at `backend/serviceAccountKey.json`.

---

## 6. Generating APK for Friends

```bash
export PATH="/home/codemaster29/fvm/versions/stable/bin:$PATH"
JAVA_HOME=/usr/lib/jvm/java-17-openjdk \
  flutter build apk --release --dart-define=API_BASE=http://192.168.x.x:3000
```

APK at: `solvor_tutor/build/app/outputs/flutter-apk/app-release.apk`

Share via Google Drive / WhatsApp / USB.

> Friends only need **internet for first Google Sign-In**. Everything else (tests, review, flashcards, AI search) works fully offline.

---

## 7. Architecture Overview

```
solvor_tutor/
├── lib/
│   ├── ai/                    # On-device AI modules
│   │   ├── edge/              # TFLite intent classifier
│   │   ├── search/            # FTS5 offline search
│   │   ├── ocr/               # ML Kit OCR pipeline
│   │   └── paraphrase/        # Explanation shortener
│   ├── core/
│   │   ├── auth/              # Auth state (Riverpod)
│   │   ├── database/          # Drift/SQLite schema + DAOs
│   │   ├── router/            # go_router config
│   │   └── theme/             # Design tokens + neon theme
│   └── modules/
│       ├── onboarding/        # Auth method → phone/Google → exam → language → budget → weak subjects
│       ├── home/              # Dashboard with 4 cards
│       ├── diagnostic/        # 20-min baseline test builder
│       ├── test_engine/       # Timer, answer capture, confidence, submit
│       ├── review/            # Score, accuracy, speed quadrants, explanations
│       ├── error_notebook/    # Spaced repetition flashcards (1-3-7-14 day intervals)
│       ├── ai_tutor/          # Search + OCR + explanation paraphrasing
│       └── settings/          # Profile, theme, language, goals, logout
└── assets/
    ├── seed_data/             # 20 bilingual seed questions
    └── models/                # TFLite intent classifier model
```

## 8. TFLite Model (Stub)

`assets/models/intent_classifier.tflite` is a placeholder. The classifier gracefully falls back to keyword-based detection (concept doubt / formula lookup / translation request). To upgrade, drop a trained `.tflite` model at that path and rebuild.

## 9. Common Issues

| Symptom | Fix |
|---------|-----|
| `BILLING_NOT_ENABLED` on phone auth | Use test phone numbers in Firebase Console (no billing needed) |
| `SMS unable to be sent until this region enabled` | Add India (+91) to SMS region policy in Firebase Console → Authentication → Settings |
| Flutter build fails with SDK errors | Use FVM Flutter: `export PATH="/home/codemaster29/fvm/versions/stable/bin:$PATH"` |
| `There is nothing to pop` | Back buttons use `context.go('/home')` — fixed |
| No questions in DB | Seed data loads on first launch; uninstall and reinstall to re-trigger |
| Camera OCR crashes | Check camera permission in Android Settings |
| Google Sign-In fails | Ensure SHA-1 fingerprint is added to Firebase Console |
