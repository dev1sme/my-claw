# TOOLS.md - Local Notes

Skills define _how_ tools work. This file is for _your_ specifics — the stuff that's unique to your setup.

## Human Preferences (Operational)

- Keep responses concise, avoid vòng vo.
- Prefer automation-first workflows.
- Prefer checklist + step-by-step instructions.
- Include concrete examples/templates when useful.
- Include clear commit messages.
- When possible: include logs, rollback, troubleshooting, and post-patch verification.

## Installed Skills (local workspace)

- `skills/openclaw-tavily-search`

## Notes about cheat-sheets

- Preferred storage folder: `cheat-sheet/` (workspace root).
- Must ask ba/mẹ before saving new cheat-sheets.
- If approved, ask desired filename first (suggest one when helpful).

## Repo Sync Policy (my-claw)

- Any change that may affect repo content must ask ba before sync/push.
- Default flow:
  1. Show changed files (`git status --short`).
  2. Ask: "Ba có đồng ý sync/push không?"
  3. If approved: run sync script + commit + push.
- Sync script path: `/home/dev1sme/my-claw/scripts/sync-real-configs.sh`.
- Recommended commands:
  - Pull real configs into repo snapshots: `./scripts/sync-real-configs.sh pull`
  - Dry-run restore check: `./scripts/sync-real-configs.sh push --dry-run --force`
  - Real restore (with confirm): `./scripts/sync-real-configs.sh push`

## Why Separate?

Skills are shared. Your setup is yours. Keeping them apart means you can update skills without losing your notes, and share skills without leaking your infrastructure.

---

Add whatever helps you do your job. This is your cheat sheet.
