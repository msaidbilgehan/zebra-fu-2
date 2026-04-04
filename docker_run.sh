#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="docker-compose.yml"
ENV_FILE=".env"

# ── Helpers ──────────────────────────────────────────────────────────
info()  { printf "\033[1;34m[INFO]\033[0m  %s\n" "$1"; }
ok()    { printf "\033[1;32m[OK]\033[0m    %s\n" "$1"; }
err()   { printf "\033[1;31m[ERROR]\033[0m %s\n" "$1" >&2; }

# ── Pre-flight checks ───────────────────────────────────────────────
clear
echo "========"
echo " Docker "
echo "========"
echo "Date: $(date)"
echo ""

# Docker daemon
if ! docker info > /dev/null 2>&1; then
    err "Docker daemon is not running. Start Docker and try again."
    exit 1
fi
ok "Docker daemon is running."

# Compose file
if [ ! -f "$COMPOSE_FILE" ]; then
    err "$COMPOSE_FILE not found in $(pwd)."
    exit 1
fi
ok "Found $COMPOSE_FILE."

# .env file
if [ ! -f "$ENV_FILE" ]; then
    err "$ENV_FILE not found. Copy .env.example to .env and fill in your secrets."
    exit 1
fi
ok "Found $ENV_FILE."

# ── Tear down ────────────────────────────────────────────────────────
echo ""
info "Stopping existing containers..."
docker compose down --remove-orphans

# ── Cleanup ──────────────────────────────────────────────────────────
info "Pruning dangling images..."
docker image prune -f

# ── Build & Run ──────────────────────────────────────────────────────
info "Building and starting services (detached)..."
docker compose up --build -d

# ── Health wait ──────────────────────────────────────────────────────
info "Waiting for services to become healthy..."

MAX_WAIT=120
ELAPSED=0
INTERVAL=5

while [ "$ELAPSED" -lt "$MAX_WAIT" ]; do
    # Check if backend container is healthy
    HEALTH=$(docker inspect --format='{{.State.Health.Status}}' app_backend 2>/dev/null || echo "starting")
    if [ "$HEALTH" = "healthy" ]; then
        break
    fi
    printf "  Backend status: %s (%ds / %ds)\r" "$HEALTH" "$ELAPSED" "$MAX_WAIT"
    sleep "$INTERVAL"
    ELAPSED=$((ELAPSED + INTERVAL))
done

echo ""

if [ "$HEALTH" = "healthy" ]; then
    ok "Backend is healthy."
else
    err "Backend did not become healthy within ${MAX_WAIT}s (status: $HEALTH)."
    info "Check logs: docker compose logs backend"
fi

# ── Summary ──────────────────────────────────────────────────────────
echo ""
echo "====================================="
echo "  Services"
echo "====================================="
echo "  Frontend : http://localhost:3000"
echo "  Backend  : http://localhost:8000"
echo "  Postgres : localhost:5432"
echo "====================================="
echo ""
info "Logs: docker compose logs -f"
