# HowToSetup — DueBook 1.0.1

## Requirements

- Node.js 22.15.1 or later
- PostgreSQL 14 or later
- npm
- Modern browser; HTTPS for production PWA/service worker

## Run the offline browser app

1. Serve the `Project/` folder through localhost or HTTPS; do not open `index.html` with `file://`.
2. For a quick local preview, run `python -m http.server 8080 --directory Project`.
3. Open `http://localhost:8080`. Customer and transaction data are stored in IndexedDB on this device/browser profile.
4. Use Backup & restore to export JSON before changing devices or clearing browser data.

## Run the Node API locally

1. Install dependencies with `npm install`.
2. Create an empty PostgreSQL database.
3. Copy `.env.example` to `.env`; set `DATABASE_URL` and a random `SESSION_SECRET` of at least 32 characters. Keep `.env` private and out of Git.
5. Start with `npm start`; the server applies the idempotent schema on startup and exposes `GET /api/health`.
6. The first account may be created with `POST /api/auth/register` and JSON `{ "email":"owner@example.com", "password":"use-a-long-unique-password", "businessName":"My Business" }`. Initial registration closes once an account exists.

## Deploy to Render

1. Push the complete GitHub source repository (not the Vibe96 ZIP wrapper) to GitHub.
2. In Render, create a new Blueprint and connect the repository containing `render.yaml`. The service applies `database/schema.sql` automatically on startup.
3. Review the proposed Node web service and PostgreSQL database, then apply the Blueprint.
4. Wait for deployment and confirm `/api/health` returns `{"ok":true,"service":"DueBook API"}`.
5. Create the initial owner account using the API endpoint described above. Do not publish real credentials in the repository.
6. Review Render's current free-plan limits and database expiry/retention terms. Free resources may sleep or have limited persistence/availability.

## Docker (optional local testing)

1. Copy `.env.example` to `.env` and set strong `POSTGRES_PASSWORD` and `SESSION_SECRET` values.
2. Run `docker compose up --build -d`.
3. Open `http://localhost:3000` and check `/api/health`.

## Known limitations — read before selling

- The browser UI stores data only in IndexedDB. It does not call the PostgreSQL API or synchronize records to it.
- The API does not yet include team invitation/role management, password reset, rate limiting, or session revocation.
- The initial API registration route is a one-time first-user setup flow; it is not a complete account-management system.
- No live demo account is bundled. A real Render deployment and manual end-to-end tests are still required.
- GitHub is source hosting; Render runs the Node service and PostgreSQL database. GitHub Pages alone cannot run this API.
