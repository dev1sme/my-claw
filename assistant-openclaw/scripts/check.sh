#!/usr/bin/env bash
set -euo pipefail

openclaw doctor --non-interactive || true
openclaw status --deep || true
openclaw channels status --probe --json || true
openclaw cron list || true
