# Hardware Support Interaction Tracker

Internal web platform for Hardware Support teams to record customer interaction entries, monitor trends, and analyze product/agent performance.

## Stack
- Frontend: Next.js 15 + Tailwind + shadcn/ui + Recharts
- Backend: Node.js + Express + Prisma
- Database: PostgreSQL
- Auth: JWT with role-based access control

## Roles
- **Agent**: create/edit own entries, own analytics
- **Team Leader**: master data management, team entries, reporting
- **Manager**: analytics/reporting and user administration only

## Quick start
1. `cp backend/.env.example backend/.env`
2. `cd backend && npm install && npm run prisma:migrate && npm run seed && npm run dev`
3. `cd frontend && npm install && npm run dev`

## Security controls
- bcrypt password hashing
- JWT access and refresh tokens
- RBAC middleware per endpoint
- Zod validation for request payloads
- audit logs for sensitive actions

See `docs/architecture.md`, `docs/schema.sql`, and `docs/api.md`.
