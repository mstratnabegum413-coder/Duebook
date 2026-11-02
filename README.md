# DueBook — Customer Ledger & Payment Tracker

DueBook is an offline-first customer ledger for small businesses. The browser app uses vanilla HTML, CSS and JavaScript, with IndexedDB for local customer and transaction records. It includes a responsive dashboard, customer records, due/payment entries, WhatsApp reminders, printable statements, a device PIN, Bangla/English UI, currency selection and JSON/CSV backup.

## Architecture and an important limitation

- `Project/`: installable offline-first browser application (PWA shell cache + IndexedDB).
- `server.js`: Node.js HTTP service with PostgreSQL-backed accounts and owner-scoped customer/transaction API routes.
- `database/`: PostgreSQL schema and optional seed template.
- `render.yaml`: Render Blueprint for a Node web service and PostgreSQL database.

**The browser UI and PostgreSQL API are not synchronized in this release.** The browser app reads and writes IndexedDB locally; the authenticated API is a separate backend starter. This version therefore does not provide cloud sync, shared team data, or cross-device synchronization. Do not advertise those features until a sync layer and conflict handling are implemented and tested. The device PIN is a convenience lock, not server account authentication.

## Local offline app

Serve `Project/` over localhost or HTTPS (not `file://`). For example: `python -m http.server 8080 --directory Project`, then open `http://localhost:8080`.

## Node API / Render

Use Node.js 22.15.1+ and PostgreSQL 14+. Run `npm install`, configure `DATABASE_URL` and a random `SESSION_SECRET` of at least 32 characters, then run `npm start`; the server initializes the idempotent schema automatically. The initial registration endpoint is available only while the database has no users; the first account receives the owner role. Additional account invitation/role-management UI is not included.

For Render, connect this repository and use the included `render.yaml` Blueprint. Render provisions the web service and PostgreSQL database and generates a session secret. Check the current Render plan limits and database retention before relying on a free database for business-critical records.

## Checks

- `npm run check` runs JavaScript syntax checks and a static packaging preflight.
- `docs/TEST-PLAN.md` describes manual browser/API checks that still need to be run against a deployed environment.
- A passing static preflight is not a live deployment, penetration test, browser E2E test, or Vibe96 audit score.

## Data and security

Browser records remain in that browser profile on that device. Export JSON backups regularly before clearing browser storage or changing devices. Never commit `.env`, real credentials, database dumps containing customer data, or private keys. `.env.example` contains placeholders only.
