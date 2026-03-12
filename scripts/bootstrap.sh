#!/usr/bin/env bash
set -euo pipefail

echo "[1] assistant-openclaw check"
bash ./assistant-openclaw/scripts/check.sh || true

echo "[2] provider-cliproxy compose validate"
( cd ./provider-cliproxy && docker compose config >/dev/null )

echo "Done."
