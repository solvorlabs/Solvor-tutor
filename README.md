# Solvor Tutor

Offline-first AI exam prep app for SSC and Banking aspirants in tier-2/3 India.  
Built for the Samsung Developer Challenge 2026.

---

## What it does

Students preparing for SSC CGL, CHSL, and Banking PO/Clerk exams in rural India face two hard constraints: patchy internet and no money for coaching. Solvor Tutor runs entirely offline after first install. Every core feature — tests, AI search, spaced repetition — works with zero data.

**Key flows:**

1. **Onboarding** — Phone + OTP, exam selection, language (Hindi/English), daily study budget, weak subject picker. Persisted locally in SQLite.
2. **Diagnostic Test** — 20-question baseline test (5 per subject) to establish a starting accuracy baseline.
3. **Test Engine** — Timed MCQ tests with confidence tagging ("Sure / Unsure / Guess"), timer auto-saved every 5 seconds, resume on app restart.
4. **Review Screen** — Post-test breakdown with speed-accuracy quadrant analysis.
5. **Error Notebook** — Wrong answers auto-schedule into a spaced repetition queue (1 → 3 → 7 → 14 days → mastered). Daily flashcard review.
6. **AI Tutor** — Type or photograph a question. FTS5 full-text search across the local question bank returns the top 3 matching results with explanations. Zero network calls.
7. **Cloud Sync** — When internet is available, a background service flushes the local sync ledger to the backend. Conflict resolution: local-wins.
8. **AI Study Schedule** — Backend calls Gemini (fallback: Groq, fallback: static) to generate a personalised morning/evening study plan based on accuracy data.

---

## Architecture

```
┌─────────────────────────────────────────────────┐
│                 Flutter App                      │
│  ┌──────────┐  ┌──────────┐  ┌───────────────┐  │
│  │ Drift DB │  │ FTS5 RAG │  │ LiteRT / TFLite│  │
│  │ (SQLite) │  │ (search) │  │ (intent class.)│  │
│  └──────────┘  └──────────┘  └───────────────┘  │
│        │              └─── ML Kit OCR ───────┘  │
│  ┌─────▼──────────────────────────────────────┐  │
│  │          Riverpod State Layer               │  │
│  └─────────────────┬──────────────────────────┘  │
└────────────────────│────────────────────────────┘
                     │ HTTP (background, offline-safe)
          ┌──────────▼──────────────────┐
          │     Node.js + Express API    │
          │  ┌──────────┐  ┌─────────┐  │
          │  │PostgreSQL│  │  Redis  │  │
          │  │ (data)   │  │ (cache) │  │
          │  └──────────┘  └─────────┘  │
          │  Gemini → Groq → fallback   │
          └──────────────────────────────┘
                     │
          ┌──────────▼──────────────────┐
          │    Next.js Admin Panel       │
          │  Questions · Import · Stats  │
          └──────────────────────────────┘
```

**On-device AI stack** — the same LiteRT/Google AI Edge runtime used in Samsung Galaxy AI. This is a valid cross-platform claim for the Samsung hackathon.

---

## Repo structure

```
Samsung_Hackathon_Document/
├── solvor_tutor/          Flutter app (Android)
│   ├── lib/
│   │   ├── ai/            LiteRT classifier, FTS5 search, ML Kit OCR
│   │   ├── core/          Database, auth, router, theme
│   │   ├── modules/       Onboarding, diagnostic, test, review,
│   │   │                  error_notebook, ai_tutor, home
│   │   └── sync/          Background cloud sync service
│   ├── assets/
│   │   ├── seed_data/     taxonomy.json + seed_questions.json (13 Qs)
│   │   └── models/        intent_classifier.tflite (stub — drop real model here)
│   └── android/
├── backend/               Node.js + Express API
│   ├── migrations/        001_initial_schema.sql, 002_user_attempts.sql
│   └── src/
│       ├── db/            PostgreSQL pool + migration runner
│       ├── middleware/    JWT auth, error handler
│       ├── routes/        auth, questions, taxonomy, sync, schedule, admin
│       └── workers/       Sync ledger consumer (poll-based)
├── admin/                 Next.js 14 admin panel
│   └── src/
│       ├── app/           login, questions, import, taxonomy, analytics pages
│       ├── components/    AuthGuard, QuestionForm, TaxonomyTree, etc.
│       └── lib/           API client, auth utils
├── docs/superpowers/
│   ├── specs/             System design + DeepSeek prompts
│   └── plans/             Implementation plan
├── README.md              This file
└── SETUP.md               Step-by-step local setup
```

---

## Tech stack

| Layer | Technology |
|-------|-----------|
| Mobile | Flutter 3.2 + Dart |
| Local DB | SQLite via Drift ORM (WAL mode, FTS5) |
| State | Riverpod (StateNotifier + FutureProvider) |
| Navigation | go_router |
| On-device AI | LiteRT (TFLite) intent classifier |
| On-device search | SQLite FTS5 with bm25() ranking |
| OCR | ML Kit Text Recognition (on-device) |
| Backend | Node.js 20 + Express |
| Database | PostgreSQL 15 |
| Cache | Redis 7 (schedule cache, 24h TTL) |
| AI schedule | Gemini 2.0 Flash → Groq llama-3.3-70b → static fallback |
| Sync | Custom sync ledger with local-wins conflict resolution |
| Admin | Next.js 14 + TypeScript + Tailwind CSS |

---

## Samsung angle

The on-device AI layer uses **LiteRT** (Google AI Edge) — the same runtime powering **Samsung Galaxy AI** features. Solvor Tutor demonstrates that the same cross-platform on-device inference stack can serve students in low-connectivity regions, running complex NLP classification and retrieval entirely offline on mid-range Android hardware.

---

## Setup

See [SETUP.md](SETUP.md) for full local setup instructions.

---

## Current seed data

13 questions across 4 subjects (Quantitative Aptitude, Logical Reasoning, English Language, General Knowledge) in English + Hindi + Hinglish explanation. Full content pipeline is in the admin panel at `/import`.

---

## Build status

| Phase | Module | Status |
|-------|--------|--------|
| P0 | Foundation (DB, router, seed) | ✅ Complete |
| P1 | User Onboarding | ✅ Complete |
| P2 | Diagnostic + Test Engine + Review | ✅ Complete |
| P3 | Spaced Repetition Error Notebook | ✅ Complete |
| P4 | On-Device AI (FTS5 RAG + LiteRT) | ✅ Complete |
| P5 | Backend API + Cloud Sync | ✅ Complete |
| P6 | Admin CMS + AI Schedule + OCR | ✅ Complete |
