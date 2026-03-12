#!/usr/bin/env bash
set -euo pipefail

# Sync real runtime config <-> repo snapshots
# Modes:
#   pull: live host -> repo
#   push: repo -> live host

MODE="${1:-}"
shift || true

REPO_ROOT="${REPO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
LIVE_OPENCLAW_DIR="${LIVE_OPENCLAW_DIR:-$HOME/.openclaw}"
LIVE_CLIPROXY_DIR="${LIVE_CLIPROXY_DIR:-$HOME/CLIProxyAPI}"

INCLUDE_ENV=0
DRY_RUN=0
FORCE=0

usage() {
  cat <<'EOF'
Usage:
  sync-real-configs.sh pull [--with-env] [--dry-run]
  sync-real-configs.sh push [--with-env] [--dry-run] [--force]

Options:
  --with-env   include .env files (.env.real snapshots)
  --dry-run    print actions only
  --force      skip confirmation for push mode

Snapshot files used in repo:
  assistant-openclaw/config/openclaw.json.real
  assistant-openclaw/config/cron-jobs.real.json
  provider-cliproxy/docker-compose.real.yml
  provider-cliproxy/config.yaml.real
  assistant-openclaw/.env.real                (optional)
  provider-cliproxy/.env.real                 (optional)
EOF
}

if [[ -z "$MODE" || "$MODE" == "-h" || "$MODE" == "--help" ]]; then
  usage
  exit 0
fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --with-env) INCLUDE_ENV=1 ;;
    --dry-run) DRY_RUN=1 ;;
    --force) FORCE=1 ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
  shift
done

backup_if_exists() {
  local path="$1"
  local ts
  ts="$(date +%Y%m%d-%H%M%S)"
  if [[ -f "$path" ]]; then
    cp -a "$path" "$path.bak.$ts"
    echo "backup: $path.bak.$ts"
  fi
}

copy_one() {
  local src="$1"
  local dst="$2"

  if [[ ! -f "$src" ]]; then
    echo "skip (missing source): $src"
    return 0
  fi

  echo "copy: $src -> $dst"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    return 0
  fi

  mkdir -p "$(dirname "$dst")"
  backup_if_exists "$dst"
  cp -a "$src" "$dst"

  # tighten file perms for .env snapshots
  if [[ "$dst" == *.env.real || "$dst" == *.env ]]; then
    chmod 600 "$dst" || true
  fi
}

confirm_push() {
  if [[ "$FORCE" -eq 1 ]]; then
    return 0
  fi
  echo "[WARN] push mode will overwrite LIVE configs on this machine."
  read -r -p "Type 'YES' to continue: " ans
  [[ "$ans" == "YES" ]]
}

# Map pairs depending on direction
pull_pairs() {
  copy_one "$LIVE_OPENCLAW_DIR/openclaw.json" "$REPO_ROOT/assistant-openclaw/config/openclaw.json.real"
  copy_one "$LIVE_OPENCLAW_DIR/cron/jobs.json" "$REPO_ROOT/assistant-openclaw/config/cron-jobs.real.json"
  copy_one "$LIVE_CLIPROXY_DIR/docker-compose.yml" "$REPO_ROOT/provider-cliproxy/docker-compose.real.yml"
  copy_one "$LIVE_CLIPROXY_DIR/config.yaml" "$REPO_ROOT/provider-cliproxy/config.yaml.real"

  if [[ "$INCLUDE_ENV" -eq 1 ]]; then
    copy_one "$LIVE_OPENCLAW_DIR/.env" "$REPO_ROOT/assistant-openclaw/.env.real"
    copy_one "$LIVE_CLIPROXY_DIR/.env" "$REPO_ROOT/provider-cliproxy/.env.real"
  fi
}

push_pairs() {
  copy_one "$REPO_ROOT/assistant-openclaw/config/openclaw.json.real" "$LIVE_OPENCLAW_DIR/openclaw.json"
  copy_one "$REPO_ROOT/assistant-openclaw/config/cron-jobs.real.json" "$LIVE_OPENCLAW_DIR/cron/jobs.json"
  copy_one "$REPO_ROOT/provider-cliproxy/docker-compose.real.yml" "$LIVE_CLIPROXY_DIR/docker-compose.yml"
  copy_one "$REPO_ROOT/provider-cliproxy/config.yaml.real" "$LIVE_CLIPROXY_DIR/config.yaml"

  if [[ "$INCLUDE_ENV" -eq 1 ]]; then
    copy_one "$REPO_ROOT/assistant-openclaw/.env.real" "$LIVE_OPENCLAW_DIR/.env"
    copy_one "$REPO_ROOT/provider-cliproxy/.env.real" "$LIVE_CLIPROXY_DIR/.env"
  fi
}

case "$MODE" in
  pull)
    pull_pairs
    echo "done: pull"
    ;;
  push)
    if ! confirm_push; then
      echo "cancelled"
      exit 1
    fi
    push_pairs
    echo "done: push"
    echo "Next (manual):"
    echo "  openclaw gateway restart"
    echo "  (cd $LIVE_CLIPROXY_DIR && docker compose up -d)"
    ;;
  *)
    echo "Unknown mode: $MODE" >&2
    usage
    exit 1
    ;;
esac
