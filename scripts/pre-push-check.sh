#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "[1/5] Secret scan (tracked)"
./scripts/check-secrets.sh

echo "[2/5] Secret scan (staged)"
./scripts/check-secrets.sh --staged || true

echo "[3/5] Git status"
git status --short

echo "[4/5] OpenClaw doctor (non-interactive)"
openclaw doctor --non-interactive || true

echo "[5/5] OpenClaw status deep"
openclaw status --deep | sed -n '1,120p' || true

echo "Done pre-push checks."
