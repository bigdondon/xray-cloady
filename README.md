# xray-cloady

VLESS + WS deployment for Cloady (free tier, usw1).

Build: multi-stage Dockerfile — the official xray image has no shell, so the
binary is copied from `ghcr.io/xtls/xray-core:latest` into Alpine.

Runtime config is generated at container start from environment variables
(no secrets are stored in this repo):
- `UUID` — VLESS client UUID
- `WS_PATH` — WebSocket path, e.g. `/f9ffcdfae3e50e38`
- `PORT` — defaults to 3000; Cloady terminates TLS on 443 at the ingress.
