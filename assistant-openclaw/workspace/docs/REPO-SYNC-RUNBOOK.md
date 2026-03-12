# REPO SYNC RUNBOOK (my-claw)

Mục tiêu: giảm thao tác lặp, tránh sync/push nhầm, luôn có kiểm tra trước khi đẩy.

## Rule bắt buộc

- Trước mọi sync/push repo, luôn hỏi ba:
  - "Ba có đồng ý sync/push các thay đổi này không?"
- Chỉ thực thi sau khi ba xác nhận rõ.

## Quy trình chuẩn (SOP)

### Bước 1 — Kiểm tra thay đổi

```bash
cd /home/dev1sme/my-claw
git status --short
```

### Bước 2 — Xin xác nhận

- Liệt kê file thay đổi + mục đích.
- Hỏi ba có đồng ý sync/push không.

### Bước 3 — Sync config thật về repo snapshot (khi cần)

```bash
cd /home/dev1sme/my-claw
./scripts/sync-real-configs.sh pull
```

### Bước 4 — Kiểm tra restore (dry-run)

```bash
./scripts/sync-real-configs.sh push --dry-run --force
```

### Bước 5 — Commit + Push

```bash
git add .
git commit -m "<clear message>"
git push
```

## Lưu ý bảo mật

- Không commit: `.env`, credentials, auths, sessions, logs.
- File `.real*` bị `.gitignore` chặn mặc định.
- Nếu cần sync `.env`, phải dùng `--with-env` và xác nhận riêng.

## Rollback nhanh

```bash
# quay về commit trước
git reset --hard HEAD~1

# nếu đã push, dùng revert để an toàn lịch sử
git revert <commit>
git push
```
