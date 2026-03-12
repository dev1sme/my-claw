# WORKSPACE CONVENTIONS

## 1) Ưu tiên cấu trúc

1. Root chỉ giữ file lõi (`AGENTS.md`, `SOUL.md`, `USER.md`, `IDENTITY.md`, `TOOLS.md`, `HEARTBEAT.md`, `README.md`).
2. Tài liệu thao tác để trong `cheat-sheet/`.
3. Tri thức theo ngày để trong `memory/`.
4. Script để trong `scripts/`.
5. Mẫu dùng lại để trong `templates/`.

## 2) Checklist trước khi kết thúc task

- [ ] Đã báo rõ thay đổi gì
- [ ] Có hướng dẫn verify
- [ ] Có rollback nếu task rủi ro
- [ ] Đã commit

## 3) Lệnh kiểm tra nhanh

```bash
git status --short
find . -maxdepth 2 -type f | sort
```
