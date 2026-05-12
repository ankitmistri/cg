# Architecture

## Modules
- Auth & RBAC
- User Management
- Master Data (Products, Variants, Features, Categories)
- Interaction Entries
- Reporting & Analytics
- Audit & Activity Logs
- Notification Service

## Entry lifecycle
1. Agent logs in.
2. Agent creates interaction entry with customer + product + category + notes.
3. Team Leader reviews/corrects, adds internal notes.
4. Dashboard aggregates by date/product/category/agent.
5. Reports export to XLSX/PDF.

## Authorization matrix
| Capability | Agent | Team Leader | Manager |
|---|---:|---:|---:|
|Create entry|✅|✅|❌|
|Edit own entry|✅|✅|❌|
|Edit all entries|❌|✅|❌|
|Master data management|❌|✅|❌|
|User management|❌|❌|✅|
|Analytics dashboards|Own|All|All|
|Export reports|Own|All|All|

## Deployment
- Frontend deployed as Next.js app (Vercel or Node runtime)
- Backend API on containerized Node server
- PostgreSQL managed DB
- Redis optional for queues/notifications
