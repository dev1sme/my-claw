#!/usr/bin/env bash
set -euo pipefail

# Lightweight secret scan before commit/push.
# Usage:
#   ./scripts/check-secrets.sh            # scan tracked files
#   ./scripts/check-secrets.sh --staged   # scan staged diff only

MODE="tracked"
if [[ "${1:-}" == "--staged" ]]; then
  MODE="staged"
fi

# Patterns: tuned to reduce false negatives for common leaked credentials.
PATTERN='(AKIA[0-9A-Z]{16}|ASIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}|AIza[0-9A-Za-z\-_]{35}|sk-[A-Za-z0-9]{20,}|-----BEGIN (RSA|EC|OPENSSH|DSA) PRIVATE KEY-----|OPENCLAW_GATEWAY_PASSWORD\s*=\s*[^<"[:space:]]+|MY_PROVIDER_API_KEY\s*=\s*[^<"[:space:]]+|TAVILY_API_KEY\s*=\s*[^<"[:space:]]+)'

TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT

if [[ "$MODE" == "staged" ]]; then
  git diff --cached -- . ':(exclude)*.png' ':(exclude)*.jpg' ':(exclude)*.jpeg' ':(exclude)*.gif' > "$TMP" || true
  if grep -nE "$PATTERN" "$TMP"; then
    echo "\n[FAIL] Possible secret found in staged diff."
    exit 1
  fi
else
  # Scan tracked files only; respect .gitignore by design.
  if git grep -nIE "$PATTERN" -- . ':(exclude)*.example' ':(exclude)*.md' ':(exclude)*.txt'; then
    echo "\n[FAIL] Possible secret found in tracked files."
    exit 1
  fi
fi

echo "[OK] No obvious secrets detected ($MODE scan)."
