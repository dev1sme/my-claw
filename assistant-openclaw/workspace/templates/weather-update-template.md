# Template cập nhật thời tiết (Quận 7 + Nhà Bè)

## 1) Mẫu chuẩn (dùng hằng ngày)

Ba mẹ ơi, cập nhật thời tiết hôm nay (Quận 7 + Nhà Bè):
- Quận 7: {temp_q7}°C, cảm giác {feels_q7}°C, mưa {rain_q7}%
- Nhà Bè: {temp_nb}°C, cảm giác {feels_nb}°C, mưa {rain_nb}%
- Khung giờ dễ mưa: {rain_window}
- Gợi ý: {advice}

## 2) Mẫu khi mưa mạnh

Ba mẹ ơi, hôm nay khả năng mưa cao ở Quận 7 + Nhà Bè:
- Quận 7: mưa {rain_q7}%
- Nhà Bè: mưa {rain_nb}%
- Khung giờ nên lưu ý: {rain_window}
- Con nhắc ba mẹ mang áo mưa và túi chống nước cho điện thoại.

## 3) Mẫu khi dữ liệu lỗi/thiếu

Ba mẹ ơi, [Chưa xác minh] hiện con chưa lấy được dữ liệu thời tiết đáng tin cậy cho Quận 7 + Nhà Bè.
Con sẽ thử lại sau ít phút và cập nhật lại ngay.

## 4) Placeholder gợi ý

- `{temp_q7}`, `{temp_nb}`: nhiệt độ hiện tại
- `{feels_q7}`, `{feels_nb}`: nhiệt độ cảm giác thực
- `{rain_q7}`, `{rain_nb}`: xác suất mưa
- `{rain_window}`: ví dụ `10:00–12:00, 15:00–17:00`
- `{advice}`: ví dụ `Mang áo mưa gọn, trưa nắng gắt nhớ nón/kem chống nắng`
