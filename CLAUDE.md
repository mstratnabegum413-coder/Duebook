# DueBook contributor guide

## Architecture
- `Project/index.html`: semantic page layout and UI controls.
- `Project/styles.css`: responsive visual system; no CSS framework.
- `Project/app.js`: vanilla JS, IndexedDB persistence, rendering, exports and interactions.
- `Project/sw.js`: static shell cache for offline reopening.
- `server.js`: Node built-in HTTP server, PostgreSQL API and signed sessions.
- `database/schema.sql`: PostgreSQL schema.

## Conventions
- Keep browser code framework-free and dependency-free.
- Escape user-controlled strings before inserting HTML (`esc`).
- Use IndexedDB for offline browser records; do not claim cloud sync unless a sync layer is implemented.
- Server queries must remain parameterized and scoped by authenticated `owner_id`.
- Mutating API routes must authenticate and validate ownership before changing data.
- Never commit secrets. Update `.env.example` with placeholder values only.

## Checks
- `npm run check` validates JavaScript syntax.
- Manual browser QC: add/edit customer; record due; record partial/full payment; reload offline; search/filter; WhatsApp link; print statement; JSON export/import; CSV export; PIN set/unlock; Bangla/English; currency selection; mobile viewport.
- Backend QC: test registration/login/logout, cross-owner access denial, invalid input, and CRUD using a disposable PostgreSQL database.
