# OpenClaw Quick Commands (Linux)

> Mục tiêu: thao tác nhanh, ngắn gọn, có verify + rollback.

## 1) Kiểm tra trạng thái nhanh

```bash
openclaw status --deep
openclaw channels status --probe --json
openclaw security audit
```

## 2) Gateway service (systemd user)

```bash
systemctl --user status openclaw-gateway --no-pager
systemctl --user restart openclaw-gateway
```

## 3) Zalo Personal

### 3.1 Login lại Zalo
```bash
openclaw channels logout --channel zalouser
openclaw channels login --channel zalouser
openclaw channels status --probe --json
```

### 3.2 Gửi test vào group (không DM)
```bash
openclaw message send --channel zalouser --target group:5393880010575793033 --message "[TEST] routing group"
```

### 3.3 Lấy QR PNG về máy Linux local (qua cloudflared)
```bash
scp -o ProxyCommand='cloudflared access ssh --hostname debian13.dev1sme.cloud' \
  dev1sme@debian13.dev1sme.cloud:/tmp/openclaw/openclaw-zalouser-qr-default.png \
  ~/Downloads/qr-zalo-default.png
```

## 4) Cron thời tiết (Quận 7 + Nhà Bè)

### 4.1 Job hiện tại
- Job ID: `210c2149-4ac6-4f1f-88e2-a68e41f49d64`
- Lịch: `30 6 * * *` (Asia/Saigon)
- Delivery: `zalouser` -> `group:5393880010575793033`

### 4.2 Kiểm tra cron
```bash
openclaw cron list
openclaw cron status
```

### 4.3 Chạy test ngay
```bash
openclaw cron run 210c2149-4ac6-4f1f-88e2-a68e41f49d64 --force
```

## 5) Backup + rollback

### 5.1 Backup config + cron
```bash
cp ~/.openclaw/openclaw.json ~/.openclaw/openclaw.json.bak.$(date +%Y%m%d-%H%M%S)
cp ~/.openclaw/cron/jobs.json ~/.openclaw/cron/jobs.json.bak.$(date +%Y%m%d-%H%M%S)
```

### 5.2 Rollback nhanh
```bash
cp ~/.openclaw/openclaw.json.bak.<timestamp> ~/.openclaw/openclaw.json
cp ~/.openclaw/cron/jobs.json.bak.<timestamp> ~/.openclaw/cron/jobs.json
openclaw gateway restart
```

## 6) Logs (lưu ý giới hạn)

```bash
openclaw logs --follow
openclaw logs --limit 300 --plain
```

> Lưu ý: `--max-bytes` phải `<= 1000000`.

## 7) Verify 3 bước sau khi sửa cron routing

1. `openclaw cron list` -> đúng `channel=zalouser`, `to=group:5393880010575793033`, `bestEffort=false`.
2. Gửi test group bằng `openclaw message send ...`.
3. Nếu lỗi, kiểm tra lại `openclaw channels status --probe --json` + `openclaw status --deep`.

## 8) Post-update checklist (luôn chạy sau khi update OpenClaw)

### 8.1 Health check nhanh
```bash
openclaw doctor --non-interactive
openclaw status --deep
```

### 8.2 Nếu plugin/channel lỗi `Cannot find module ...`
```bash
# ví dụ với plugin Zalo Personal
cd /home/dev1sme/.nvm/versions/node/v25.8.0/lib/node_modules/openclaw/extensions/zalouser
npm install
openclaw gateway restart
```

### 8.3 Verify end-to-end sau khi fix
```bash
openclaw channels status --probe --json
openclaw message send --channel zalouser --target group:5393880010575793033 --message "[TEST] post-update check"
```

### 8.4 Nếu vẫn lỗi
```bash
openclaw logs --follow
```
