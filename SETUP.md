# Solvor Tutor — Setup Guide

## Prerequisites

| Tool | Version | Install |
|------|---------|---------|
| Flutter | ≥ 3.2.0 | https://docs.flutter.dev/get-started/install |
| Dart | ≥ 3.2.0 | Bundled with Flutter |
| Node.js | ≥ 20.x | https://nodejs.org |
| PostgreSQL | ≥ 15 | https://www.postgresql.org/download |
| Redis | ≥ 7 | https://redis.io/docs/getting-started |
| Android Studio | Latest | For emulator / device flashing |

---

## 1. Clone & root structure

```
Samsung_Hackathon_Document/
├── solvor_tutor/     # Flutter app
├── backend/          # Node.js API
└── admin/            # Next.js admin panel
```

---

## 2. Backend

### 2a. Create PostgreSQL database

```bash
psql -U postgres
CREATE USER solvor WITH PASSWORD 'solvor_pass';
CREATE DATABASE solvor_tutor OWNER solvor;
\q
```

### 2b. Configure environment

```bash
cd backend
cp .env.example .env
```

Edit `.env`:
```
DATABASE_URL=postgresql://solvor:solvor_pass@localhost:5432/solvor_tutor
JWT_SECRET=<generate a random 64-char string>
REDIS_URL=redis://localhost:6379
PORT=3000
GEMINI_API_KEY=<your Google AI Studio key>
GROQ_API_KEY=<your Groq API key>
```

> Get Gemini key: https://aistudio.google.com/app/apikey  
> Get Groq key: https://console.groq.com/keys

### 2c. Install and migrate

```bash
npm install
npm run migrate
```

Expected output:
```
✓ 001_initial_schema.sql applied successfully
✓ 002_user_attempts.sql applied successfully
All migrations applied.
```

### 2d. Start the API

```bash
npm start
# or for development with auto-reload:
npm run dev
```

API is live at `http://localhost:3000`. Health check: `GET /health`

### 2e. Start the sync worker (optional for offline testing)

```bash
node src/workers/sync_consumer.js
```

---

## 3. Flutter App

### 3a. Install dependencies

```bash
cd solvor_tutor
flutter pub get
```

### 3b. Generate Drift code (if .g.dart files are missing or stale)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 3c. Configure backend URL

Open `lib/sync/sync_service.dart` and check `_baseUrl`. For a physical device on the same network, replace `localhost` with your machine's local IP:

```dart
// In main.dart where SyncService is instantiated:
baseUrl: 'http://192.168.x.x:3000'  // your machine's LAN IP
```

For emulator, `http://10.0.2.2:3000` maps to host localhost.

### 3d. Run on device / emulator

```bash
flutter run
# Release build (recommended for performance demo):
flutter build apk --release
```

The debug APK is ~125MB. The release APK will be significantly smaller.

### 3e. TFLite model (stub)

`assets/models/intent_classifier.tflite` is currently an empty stub. The intent classifier gracefully falls back to `IntentType.unknown` — all AI Tutor searches still work via FTS5. To upgrade, drop a trained `.tflite` model at that path and re-run `flutter build apk`.

---

## 4. Admin Panel

### 4a. Install dependencies

```bash
cd admin
npm install
```

### 4b. Configure API URL

```bash
# .env.local is already set to localhost:
NEXT_PUBLIC_API_URL=http://localhost:3000
```

### 4c. Run

```bash
npm run dev
# Open http://localhost:4000  (or whatever port Next.js picks)
```

Login with any phone number — the OTP is printed to the backend console (no SMS provider in dev mode).

---

## 5. Full stack in one terminal session

```bash
# Terminal 1 — Backend
cd backend && npm start

# Terminal 2 — Admin panel
cd admin && npm run dev

# Terminal 3 — Flutter
cd solvor_tutor && flutter run
```

---

## 6. Common issues

| Symptom | Fix |
|---------|-----|
| `relation "user_attempts" does not exist` | Run `npm run migrate` again — ensure migration 002 ran |
| Flutter: `No such module 'sqlite3'` | Run `flutter pub get` then rebuild |
| FTS5 search returns no results | First-launch seed required; uninstall app and reinstall to re-trigger seed load |
| Camera OCR crashes | Check device has camera permission granted in Android Settings |
| Sync never fires | Backend must be reachable; check `_baseUrl` in sync_service.dart matches your server IP |
| Admin login loop | Backend must be running; check browser console for `CORS` or `401` errors |
