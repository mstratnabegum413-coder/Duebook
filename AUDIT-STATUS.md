# DueBook — Vibe96 readiness status

This document records package-level checks only. It does not claim a Vibe96 score, live deployment, or full production QC.

| Requirement | Status | Evidence / limitation |
|---|---|---|
| Complete editable source | Partial | Vanilla browser source and Node API source are included. |
| No real credentials | Pass by package inspection | `.env.example` contains placeholders; `.env` is excluded. |
| Clean setup guide | Partial | Local, Docker and Render steps documented; dependency lockfile is not present because npm registry access timed out during packaging. |
| Database schema | Pass by inspection | PostgreSQL schema, keys, constraints and indexes included; server initializes it idempotently at startup. |
| Signed-in API mutations and owner scoping | Partial | Mutating data routes authenticate and scope by owner; full role administration and account-management workflows are absent. |
| Working frontend-to-backend integration | Not complete | Browser UI uses IndexedDB only; it does not synchronize to PostgreSQL API. |
| Live demo and demo credentials | Not complete | Requires a real Render deployment and account setup. |
| Dependency audit | Not complete | Direct `pg` dependency is pinned; no lockfile or successful `npm audit` is available. |
| Static preflight | Pass if `npm run check` succeeds | Syntax and required-file checks only; not browser E2E or security audit. |

## Release blockers before claiming production-ready / 95+

1. Implement and test frontend authentication plus IndexedDB/API synchronization, offline queue, conflict handling and multi-device behavior; alternatively, position this as a single-device local-only product and remove the separate unused API.
2. Add owner-controlled invitations and roles, login throttling, CSRF strategy, password reset, session revocation and security review.
3. Generate and commit `package-lock.json` on a network-enabled machine; run `npm audit` and remediate findings.
4. Deploy to Render with a persistent PostgreSQL plan appropriate for business data; verify the real URL, health endpoint and demo workflow.
5. Run the manual browser and API test plan on Android and desktop browsers.
