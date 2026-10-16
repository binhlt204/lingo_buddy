# 📱 HƯỚNG DẪN CÀI ĐẶT VÀ CHẠY ỨNG DỤNG LINGOBUDDY
> Áp dụng cho cả 3 nền tảng: **Web**, **Android** và **iOS** từ một mã nguồn duy nhất (Flutter).

---

## 📋 MỤC LỤC
1. [Chuẩn bị môi trường chung (Đã cấu hình sẵn)](#1-chuẩn-bị-môi-trường-chung)
2. [Nền tảng 1: Hướng dẫn chạy trên WEB](#2-nền-tảng-1-hướng-dẫn-chạy-trên-web)
3. [Nền tảng 2: Hướng dẫn chạy và build file cho ANDROID](#3-nền-tảng-2-hướng-dẫn-chạy-và-build-file-cho-android)
4. [Nền tảng 3: Hướng dẫn chạy và build file cho iOS (iPhone/iPad)](#4-nền-tảng-3-hướng-dẫn-chạy-và-build-file-cho-ios-iphoneipad)
5. [Bảng tóm tắt lệnh thao tác nhanh (Cheatsheet)](#5-bảng-tóm-tắt-lệnh-thao-tác-nhanh)
6. [Xử lý các lỗi thường gặp (Troubleshooting)](#6-xử-lý-các-lỗi-thường-gặp)

---

## 1. Chuẩn Bị Môi Trường Chung

Trên máy tính của bạn, hệ thống đã được cài đặt:
- **Flutter SDK:** Phiên bản `3.47.7 (Stable)` đặt tại `C:\flutter\bin`.
- **Biến môi trường PATH:** Đã được thiết lập tự động.

Mở **PowerShell** hoặc **Terminal trong VS Code** tại thư mục dự án `D:\WEB_APP_ENG` và chạy lệnh kiểm tra:
```powershell
flutter doctor
```

Cập nhật các gói thư viện phụ thuộc trước khi chạy:
```powershell
flutter pub get
```

---

## 2. Nền Tảng 1: Hướng Dẫn Chạy Trên WEB

Web là nền tảng nhanh nhất để test giao diện, font chữ, màu pastel và chức năng flashcard/bài đọc mà không cần cắm điện thoại hay bật máy ảo nặng.

### 2.1. Chạy thử nghiệm trực tiếp (Debug Mode)
Mở terminal tại thư mục `D:\WEB_APP_ENG`:
```powershell
# Chạy trên Google Chrome
flutter run -d chrome

# Hoặc chạy cố định ở một cổng cụ thể (ví dụ port 3000)
flutter run -d chrome --web-port 3000

# Hoặc chạy trên Microsoft Edge
flutter run -d edge
```

**Các phím tắt khi app đang chạy trong terminal:**
- `r`: Hot Reload (cập nhật thay đổi code ngay lập tức không mất dữ liệu).
- `R`: Hot Restart (khởi động lại app).
- `q`: Dừng chạy server.

---

### 2.2. Đóng gói bản Web hoàn chỉnh (Production Build)
Khi bạn muốn đưa website lên mạng Internet (đưa lên GitHub Pages, Vercel, Netlify hoặc Firebase Hosting hoàn toàn miễn phí):
```powershell
flutter build web --release
```
- Kết quả sau khi build sẽ nằm trọn vẹn trong thư mục:
  👉 `D:\WEB_APP_ENG\build\web\`
- Bạn chỉ cần kéo toàn bộ thư mục `build/web` này thả lên Vercel/Netlify là mọi người có thể vào học tiếng Anh trực tiếp qua link web.

---

## 3. Nền Tảng 2: Hướng Dẫn Chạy Và Build Cho ANDROID

### 3.1. Hoàn tất cài đặt Android Toolchain (Thao tác 1 lần duy nhất)
Hiện tại máy bạn đã có sẵn Android SDK `35.0.1`. Để hoàn thiện:
1. Mở **Android Studio** trên máy tính.
2. Vào **Settings** (hoặc icon bánh răng ở màn hình Welcome) ➔ **Languages & Frameworks** ➔ **Android SDK** ➔ chuyển qua tab **SDK Tools**.
3. Tích chọn:
   - ✅ **Android SDK Command-line Tools (latest)**
   - ✅ **Android SDK Build-Tools**
   - ✅ **Android SDK Platform-Tools**
4. Nhấn **Apply** ➔ **OK** để tải về.
5. Mở terminal và chấp nhận bản quyền Android bằng lệnh:
   ```powershell
   flutter doctor --android-licenses
   ```
   *(Nhấn phím `y` liên tục cho đến khi hoàn thành)*.

---

### 3.2. Cách 1: Chạy trực tiếp trên điện thoại Android thật (Khuyên dùng - Nhẹ máy nhất)
1. **Bật chế độ nhà phát triển trên điện thoại:**
   - Vào **Cài đặt** ➔ **Thông tin điện thoại** ➔ Nhấn liên tục 7 lần vào dòng **Số hiệu bản dựng (Build Number)** đến khi hiện thông báo *"Bạn đã là nhà phát triển"*.
   - Quay lại Cài đặt ➔ vào mục **Tùy chọn nhà phát triển (Developer Options)** ➔ Bật công tắc **Gỡ lỗi USB (USB Debugging)**.
2. **Cắm cáp USB** nối điện thoại với máy tính. Trên màn hình điện thoại, chọn *"Luôn cho phép gỡ lỗi từ máy tính này"* ➔ Nhấn **OK**.
3. **Kiểm tra kết nối trên máy tính:**
   ```powershell
   flutter devices
   ```
   *(Bạn sẽ thấy tên điện thoại của mình xuất hiện trong danh sách)*.
4. **Chạy app lên điện thoại:**
   ```powershell
   flutter run
   ```
   *(Flutter sẽ tự động build và cài đặt app lên màn hình điện thoại của bạn)*.

---

### 3.3. Cách 2: Chạy trên máy ảo Android (Android Emulator)
1. Trong Android Studio, mở menu **Tools** ➔ **Device Manager**.
2. Nhấn **Create Device** ➔ Chọn máy (ví dụ: *Pixel 7* hoặc *Pixel 8*) ➔ Nhấn Next ➔ Tải một bản Android OS (ví dụ: Android 13/14 - Tiramisu/UpsideDownCake) ➔ Nhấn **Finish**.
3. Bấm nút **Play (▶)** để khởi động máy ảo.
4. Sau khi máy ảo bật lên, tại terminal gõ:
   ```powershell
   flutter run
   ```

---

### 3.4. Xuất file cài đặt `.apk` để gửi cho bạn bè
Khi muốn chia sẻ app cho người khác cài đặt mà không cần máy tính:
```powershell
flutter build apk --split-per-abi --release
# hoặc xuất 1 file APK dùng chung cho mọi dòng máy:
flutter build apk --release
```
- Đường dẫn file cài đặt sau khi build:
  👉 `D:\WEB_APP_ENG\build\app\outputs\flutter-apk\app-release.apk`
- Bạn có thể gửi file `.apk` này qua Zalo, Drive để cài trực tiếp vào điện thoại Android.

---

## 4. Nền Tảng 3: Hướng Dẫn Chạy Và Build Cho iOS (iPhone/iPad)

> [!IMPORTANT]
> **Quy định của Apple:** Mã nguồn iOS bắt buộc phải được biên dịch thông qua công cụ **Xcode** (công cụ độc quyền của Apple và chỉ hoạt động trên hệ điều hành **macOS**). Dưới đây là 2 trường hợp cụ thể:

---

### 4.1. Trường hợp A: Nếu bạn có máy tính Mac (MacBook / Mac Mini / iMac)
1. Tải **Xcode** từ App Store trên macOS.
2. Mở Terminal trên Mac và cấu hình Xcode command-line tools:
   ```bash
   sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
   sudo xcodebuild -runFirstLaunch
   ```
3. Cài đặt quản lý thư viện CocoaPods:
   ```bash
   sudo gem install cocoapods
   ```
4. Copy thư mục dự án `WEB_APP_ENG` sang máy Mac:
   ```bash
   cd WEB_APP_ENG
   flutter pub get
   ```
5. **Chạy trên máy ảo iPhone (iOS Simulator):**
   ```bash
   open -a Simulator
   flutter run -d ios
   ```
6. **Chạy trên iPhone thật:**
   - Cắm iPhone vào máy Mac qua cáp Lightning/Type-C.
   - Mở file `ios/Runner.xcworkspace` bằng Xcode.
   - Tại mục **Signing & Capabilities**, đăng nhập Apple ID miễn phí của bạn và chọn Team.
   - Nhấn nút **Run ▶** trên Xcode hoặc gõ `flutter run` ở terminal.

---

### 4.2. Trường hợp B: Đang dùng máy tính Windows (Không có máy Mac)
Khi dùng Windows, bạn vẫn có thể viết code Dart/Flutter bình thường. Để tạo ra file cài cho iPhone, bạn dùng **Build Cloud Tự Động (CI/CD)**:

#### Giải pháp tốt nhất: Dùng GitHub Actions hoặc Codemagic (Miễn phí)
1. Đẩy mã nguồn dự án lên GitHub (như hướng dẫn ở mục trước).
2. Tạo file cấu hình `.github/workflows/build_ios.yml` trong project.
3. Mỗi khi bạn đẩy code lên, GitHub sẽ tự động mượn một máy chủ Mac ảo trên đám mây của họ để:
   - Tải code của bạn về.
   - Biên dịch bằng Xcode.
   - Xuất ra file `.ipa` (file cài đặt iOS) gửi về trang GitHub Releases cho bạn tải về cài vào iPhone (thông qua AltStore, Sideloadly hoặc TestFlight).

---

## 5. Bảng Tóm Tắt Lệnh Thao Tác Nhanh

| Mục đích | Lệnh PowerShell / Terminal |
| :--- | :--- |
| **Kiểm tra công cụ & thiết bị** | `flutter doctor` |
| **Xem danh sách thiết bị đang nối** | `flutter devices` |
| **Cập nhật thư viện** | `flutter pub get` |
| **Chạy trên Web (Chrome)** | `flutter run -d chrome` |
| **Chạy trên Windows Desktop** | `flutter run -d windows` |
| **Chạy trên Android (Máy thật/ảo)** | `flutter run` |
| **Build ra file Web hoàn chỉnh** | `flutter build web --release` |
| **Build file APK Android gửi bạn bè** | `flutter build apk --release` |
| **Xóa cache build khi gặp lỗi lạ** | `flutter clean` sau đó chạy `flutter pub get` |

---

## 6. Xử Lý Các Lỗi Thường Gặp (Troubleshooting)

1. **Lỗi `flutter : The term 'flutter' is not recognized...`**:
   - Do terminal chưa nhận biến môi trường mới. Bạn chỉ cần tắt cửa sổ VS Code / PowerShell đi và mở lại, hoặc gõ `$env:Path = "$env:Path;C:\flutter\bin"`.

2. **Cắm điện thoại Android vào nhưng `flutter devices` không nhận**:
   - Kiểm tra xem cáp sạc có hỗ trợ truyền dữ liệu không.
   - Kiểm tra xem đã bật **Gỡ lỗi USB (USB Debugging)** trong Cài đặt của điện thoại chưa.
   - Chuyển chế độ kết nối USB trên điện thoại từ *"Chỉ sạc"* sang *"Truyền tệp / MTP"*.

3. **Lỗi hiển thị màn hình trắng trên Web**:
   - Do trình duyệt đang lưu cache cũ. Nhấn tổ hợp phím `Ctrl + Shift + R` (hoặc `F5`) trên Chrome để tải lại trang.
