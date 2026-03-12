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
