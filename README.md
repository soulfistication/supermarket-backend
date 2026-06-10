# Supermarket backend

Elixir / Phoenix mini backend to feed apps with data.

## Prerequisites

- Elixir 1.15+ and Erlang/OTP 26+

## Run

```bash
mix deps.get
mix phx.server
```

The API listens on port **3000** by default (override with `PORT`).

## API

All routes require HTTP Basic Auth (`veka` / `nenitohotovy`).

| Method | Path | Description |
|--------|------|-------------|
| POST | `/api/v1/users` | Register a user |
| POST | `/api/v1/login/access_token` | Login (or register when name/phone/fb present) |
| GET | `/api/v1/products` | List products |
| GET | `/api/v1/categories` | List categories |

Seed data lives in `priv/data/`. The legacy Node.js backend is kept in `legacy_node/` for reference.

## iOS app

Point the app at your machine's LAN IP, e.g. `http://192.168.0.9:3000`.
