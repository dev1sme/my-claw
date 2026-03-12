#!/usr/bin/env bash
set -euo pipefail

SRC="${1:?Usage: restore.sh <backup_dir>}"

cp -a "$SRC/openclaw.json" "$HOME/.openclaw/openclaw.json"
cp -a "$SRC/cron-jobs.json" "$HOME/.openclaw/cron/jobs.json"

# workspace restore is optional (uncomment if needed)
# rm -rf "$HOME/.openclaw/workspace-dev"
# cp -a "$SRC/workspace-dev" "$HOME/.openclaw/workspace-dev"

openclaw gateway restart

echo "Restore complete from: $SRC"
