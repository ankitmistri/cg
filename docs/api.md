# API Design (v1)

## Auth
- `POST /api/v1/auth/login`
- `POST /api/v1/auth/refresh`
- `POST /api/v1/auth/logout`
- `POST /api/v1/auth/change-password`

## Users (Manager)
- `GET /api/v1/users`
- `POST /api/v1/users`
- `PATCH /api/v1/users/:id`
- `POST /api/v1/users/:id/reset-password`

## Master data (Team Leader)
- `GET/POST /api/v1/product-types`
- `GET/POST /api/v1/product-variants`
- `GET/POST /api/v1/product-features`
- `GET/POST /api/v1/categories`

## Entries
- `GET /api/v1/entries` (scoped by role)
- `POST /api/v1/entries`
- `GET /api/v1/entries/:id`
- `PATCH /api/v1/entries/:id`

## Dashboard
- `GET /api/v1/dashboard/summary`
- `GET /api/v1/dashboard/trends`
- `GET /api/v1/dashboard/agents`

## Reports
- `GET /api/v1/reports/export?format=xlsx|pdf`

## Filters
- `from,to,productTypeId,variantId,featureId,categoryId,agentId,teamLeaderId`
