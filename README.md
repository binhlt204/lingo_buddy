# 🐱 LingoBuddy — Ứng Dụng Học Tiếng Anh Trình Độ B1
> Ứng dụng học tiếng Anh đa nền tảng (**Android**, **iOS**, **Web**, **Desktop**) xây dựng bằng **Flutter**, phong cách thiết kế **Soft Cozy Minimalism** cùng linh vật đồng hành Mochi.

---

## ✨ Điểm Nổi Bật
- **Giao diện Soft Cozy Pastel:** Tông màu kem ấm, xanh matcha dịu mắt, font bo tròn hiện đại, mang lại cảm giác học tập thoải mái, không áp lực.
- **Linh vật Mochi:** Chú mèo chibi đeo kính tròn cử động mượt mà, đồng hành nhắc bài và chúc mừng khi bạn hoàn thành mục tiêu.
- **Thẻ Note & Lặp lại ngắt quãng (SRS):** Thẻ lật 3D hai mặt (Từ vựng, IPA, âm thanh phát âm, nghĩa tiếng Việt, ví dụ ngữ cảnh B1) cùng 3 nút chấm điểm *Khó / Vừa / Dễ* theo thuật toán SM-2.
- **Đọc bài (Reading) chạm tra từ:** Chạm trực tiếp vào từ vựng B1 trong bài đọc để hiện nghĩa tiếng Việt và thêm vào Thẻ Note chỉ với 1 chạm, kèm tính năng bật/tắt song ngữ.
- **Luyện Nghe (Listening):** Chỉnh tốc độ audio (0.8x, 1.0x, 1.2x) và bài tập chép chính tả điền từ (Dictation).
- **Luyện Nói & Viết:** Phản xạ Shadowing theo mẫu câu B1 và luyện viết email ngắn theo cấu trúc gợi ý.
- **Lưu trữ Offline:** Lưu tiến độ, streak và lịch ôn bài ngay trên thiết bị.

---

## 🚀 Hướng Dẫn Cài Đặt & Chạy Ứng Dụng

Chi tiết từng bước thiết lập và chạy trên cả 3 nền tảng đã được viết đầy đủ tại:  
👉 **[Xem chi tiết tại HUONG_DAN_CAI_DAT_VA_CHAY.md](HUONG_DAN_CAI_DAT_VA_CHAY.md)**

### Tóm tắt lệnh chạy nhanh:
```powershell
# Chạy trên Web (Google Chrome)
flutter run -d chrome

# Chạy trên Android (cắm cáp điện thoại hoặc bật máy ảo)
flutter run

# Build file APK Android gửi bạn bè cài đặt
flutter build apk --release

# Build bản Web sẵn sàng đưa lên hosting
flutter build web --release
```

---

## 📂 Cấu Trúc Dự Án
```
lib/
├── core/
│   ├── theme/app_theme.dart        # Bảng màu pastel & typography
│   ├── utils/tts_helper.dart       # Bộ phát âm Text-to-Speech
│   └── widgets/mascot_widget.dart  # Linh vật Mochi vẽ bằng CustomPainter
├── data/
│   ├── models/                     # Data models (WordModel, ReadingModel)
│   ├── repositories/b1_data.dart   # Dữ liệu từ vựng & bài đọc chuẩn B1
│   └── services/srs_service.dart   # Thuật toán Spaced Repetition SM-2
├── features/
│   ├── home/home_screen.dart       # Dashboard, streak & điều hướng
│   ├── flashcards/flashcard_screen.dart # Thẻ lật 3D & chấm điểm SRS
│   ├── reading/reading_screen.dart # Đọc bài kèm chạm tra từ & song ngữ
│   ├── listening/listening_screen.dart  # Nghe & bài tập chép chính tả
│   └── practice/practice_screen.dart    # Luyện Nói (Shadowing) & Viết
└── main.dart                       # Khởi động ứng dụng
```
