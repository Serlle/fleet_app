# fleet_app 🚗🛠️

This is a Ruby on Rails 7 application that implements a backend for a fleet
management challenge. It exposes simple HTML views and a JSON API under
`/api/v1`. The API uses JWT (Bearer) tokens for authentication and supports
filtering, searching, pagination and sorting on key endpoints.

---

## Quick facts
- Ruby: 3.4.3 (declared in `Gemfile`)
- Rails: ~> 7.1.3
- Database: PostgreSQL
- Test framework: RSpec + FactoryBot
- Pagination: Kaminari
- Serialization: ActiveModelSerializers
- Auth: JWT (manual via `jwt` gem)

## Setup (local development)

1. Install system dependencies: Ruby, PostgreSQL, etc.

2. Install gems:

```bash
bundle install
```

3. Create and migrate the database, then seed:

```bash
rails db:create db:migrate db:seed
```

4. Provide required environment variables. You can create a `.env` file
   (the project includes `dotenv-rails` in development/test groups):

```
AUTH_USERNAME=admin
AUTH_PASSWORD=secret
JWT_SECRET=a-long-random-secret
```

5. Start the server:

```bash
bin/rails server
```

Open `http://localhost:3000` for the HTML views or call the API under
`http://localhost:3000/api/v1`.

## Important environment variables
- `AUTH_USERNAME` and `AUTH_PASSWORD` — credentials used by the login endpoint to return a JWT.
- `JWT_SECRET` — secret used to encode/decode JWT tokens. Keep this secret in CI/production.

## Routes and API overview

Key API endpoints (JSON):

- Auth
  - POST `/api/v1/auth/login`
    - body: `{ "username": "...", "password": "..." }`
    - response: `{ "token": "<jwt>" }`

- Vehicles
  - GET `/api/v1/vehicles` (filters, search, pagination, sorting)
    - query params: `page`, `per_page`
    - example: `/api/v1/vehicles?page=2&per_page=2`
  - GET `/api/v1/vehicles/:id`
  - POST `/api/v1/vehicles`
  - PUT/PATCH `/api/v1/vehicles/:id`
  - DELETE `/api/v1/vehicles/:id`

- MaintenanceServices
  - GET `/api/v1/vehicles/:vehicle_id/maintenance_services`
    - query params: `page` and `per_page`
    - response format: `{ maintenance_services: [...], meta: { page, per_page, total } }`
  - POST `/api/v1/vehicles/:vehicle_id/maintenance_services`
  - PUT/PATCH `/api/v1/maintenance_services/:id`

- Reports
  - GET `/api/v1/reports/maintenance_summary?from=YYYY-MM-DD&to=YYYY-MM-DD`

Notes:
- All API endpoints require an `Authorization: Bearer <token>` header, except the login endpoint.
- The API controllers set `request.format = :json` by default (CSV is allowed for reports).

## Pagination, filtering & sorting details

- Pagination uses Kaminari. Provide `page` and `per_page` (defaults to 5).

Example: get the second page of maintenance services for vehicle 5 with 20 per page:

```http
GET /api/v1/vehicles/5/maintenance_services?page=2&per_page=20 HTTP/1.1
Host: localhost:3000
Authorization: Bearer <token>
```

Response shape:

```json
{
  "maintenance_services": [ /* array of maintenance service objects (serialized) */ ],
  "meta": { "page": 2, "per_page": 20, "total": 123 }
}
```

## Models & Business Rules (high-level)

- Vehicle
  - `vin` and `plate` are stored uppercase and unique (case-insensitive validation).
  - `year` must be between 1990 and 2050.
  - `status` enum: `active`, `inactive`, `in_maintenance`.
  - Vehicle status is updated automatically when its maintenance services change.

- MaintenanceService
  - belongs_to Vehicle
  - enums: `status` (pending, in_progress, completed) and `priority` (low, medium, high)
  - `completed_at` must be present if `status` is `completed`
  - provides scopes and helper methods for reporting (sum by status, by plate, top vehicles by cost)

## Serialization

ActiveModelSerializers is used for JSON serialization. Serializer files live in `app/serializers/` and configure what attributes/associations are included in API responses.

## Authentication details

- Login endpoint compares incoming credentials to `ENV['AUTH_USERNAME']` and `ENV['AUTH_PASSWORD']`. On success it returns a JWT produced by `Auth::JwtEncoder`.
- Protected API controllers include the `Authenticable` concern which reads the `Authorization` header, decodes the token with `Auth::JwtDecoder`, and sets `current_claims`.

## Running tests

Run the full test-suite:

```bash
bundle exec rspec
```

During tests, specs typically set `ENV` variables for `AUTH_USERNAME`, `AUTH_PASSWORD`, and `JWT_SECRET` and obtain a token by POSTing to the login endpoint.

## Development helpers & recommended improvements

- Add DB-level unique indexes for `LOWER(vin)` and `LOWER(plate)` to enforce case-insensitive uniqueness at the database level.
- Use `includes` / `preload` in controllers or serializers to avoid N+1 queries (the `bullet` gem is present in development to warn about issues).
- Extract repeated paginated JSON response formatting into a shared helper to DRY controller code.

## Example cURL flows

1) Login and use token:

```bash
# login -> get token
curl -X POST -H "Content-Type: application/json" -d '{"username":"admin","password":"secret"}' http://localhost:3000/api/v1/auth/login

# use token
curl -H "Authorization: Bearer <token>" http://localhost:3000/api/v1/vehicles
```

## Where to go next (suggested tasks)
- Add pagination/filters for `GET /api/v1/vehicles` if you want parity with maintenance services (I can add it now).
- Add request specs for `GET /api/v1/vehicles` covering pagination/search/sort.
- Add DB migrations to ensure case-insensitive uniqueness on `vin` and `plate`.
