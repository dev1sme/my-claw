# my-claw

Monorepo cấu hình hạ tầng trợ lý, tách rõ:

- `assistant-openclaw/` — cấu hình + workspace OpenClaw
- `provider-cliproxy/` — provider CLI Proxy

## Cấu trúc

```text
my-claw/
├─ assistant-openclaw/
│  ├─ workspace/
│  ├─ config/
│  │  ├─ openclaw.json.example
│  │  └─ cron-jobs.example.json
│  ├─ scripts/
│  └─ .gitignore
├─ provider-cliproxy/
│  ├─ docker-compose.yml
│  ├─ config.yaml.example
│  ├─ scripts/
│  └─ .gitignore
├─ scripts/
└─ .gitignore
```

## Lưu ý bảo mật

- Không commit `.env`, `credentials`, `auths`, `sessions`, `logs`, token/key.
- Dùng file `.example` để chia sẻ cấu hình mẫu.
- File sync thật có hậu tố `.real*` đã bị `.gitignore` chặn mặc định.

## Sync config thật <-> repo

Script: `scripts/sync-real-configs.sh`

```bash
# Live host -> repo snapshots (.real*)
./scripts/sync-real-configs.sh pull

# Repo snapshots -> live host (có confirm)
./scripts/sync-real-configs.sh push

# Bao gồm cả .env (cực kỳ nhạy cảm)
./scripts/sync-real-configs.sh pull --with-env
./scripts/sync-real-configs.sh push --with-env
```

> Sau `push`, chạy thủ công:
> - `openclaw gateway restart`
> - `cd ~/CLIProxyAPI && docker compose up -d`
