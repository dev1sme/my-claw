#!/usr/bin/env bash
set -euo pipefail

TS="$(date +%Y%m%d-%H%M%S)"
OUT="${1:-$HOME/backup-openclaw-$TS}"
mkdir -p "$OUT"

cp -a "$HOME/.openclaw/openclaw.json" "$OUT/openclaw.json"
cp -a "$HOME/.openclaw/cron/jobs.json" "$OUT/cron-jobs.json"
cp -a "$HOME/.openclaw/workspace-dev" "$OUT/workspace-dev"

echo "Backup saved to: $OUT"
