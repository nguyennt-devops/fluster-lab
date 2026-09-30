# 📱 Bài tập Flutter: 9 Labs — Nguyễn Thái Nguyên (23IT.B142)

Dự án gồm các bài thực hành Lab 1 đến Lab 9 trong chương trình phát triển ứng dụng di động với Flutter.

## 👤 Thông tin sinh viên
* **Họ tên:** Nguyễn Thái Nguyên
* **Mã sinh viên:** 23IT.B142

---

## 🛠 Công Nghệ Sử Dụng
* **Framework:** Flutter & Dart
* **Công cụ:** Android Studio / VS Code
* **Kiểm thử:** Widget Testing & Unit Testing
* **API:** WeatherAPI (Lab 9)
* **Thư viện:** `http`, `geolocator`, `audioplayers`.

---

## 📚 Danh Sách 9 Bài Lab

### 💎 Lab 1: I Am Rich
* **Mục tiêu:** Làm quen với cấu trúc cơ bản của Flutter, hiển thị hình ảnh và văn bản.
* **Kỹ năng:** Center widget, Image widget, Scaffold.

### 💳 Lab 2: Mi Card
* **Mục tiêu:** Xây dựng giao diện danh thiếp cá nhân.
* **Kỹ năng:** Row, Column, CircleAvatar, Card, ListTile, Custom Fonts.

### 🎲 Lab 3: Dicee
* **Mục tiêu:** Tạo ứng dụng tung xúc xắc ngẫu nhiên.
* **Kỹ năng:** StatefulWidget, `dart:math` (Random), Expanded.

### 🔮 Lab 4: Magic 8 Ball
* **Mục tiêu:** Xây dựng trò chơi dự đoán tương lai bằng cách nhấn vào quả cầu.
* **Kỹ năng:** TextButton, State Management cơ bản.

### 🎹 Lab 5: Xylophone
* **Mục tiêu:** Ứng dụng phát âm thanh nốt nhạc khi nhấn phím đàn.
* **Kỹ năng:** Sử dụng package ngoài (audioplayers), viết hàm rút gọn (refactoring).

### ❓ Lab 6: Quizzler
* **Mục tiêu:** Ứng dụng trả lời câu hỏi Đúng/Sai.
* **Kỹ năng:** Lập trình hướng đối tượng (OOP), quản lý List, logic kiểm tra kết quả.

### 📖 Lab 7: Destini
* **Mục tiêu:** Ứng dụng kể chuyện tương tác dựa trên lựa chọn của người dùng.
* **Kỹ năng:** Cấu trúc rẽ nhánh phức tạp, Logic Brain.

### ⚖️ Lab 8: BMI Calculator
* **Mục tiêu:** Công cụ tính chỉ số khối cơ thể (BMI).
* **Kỹ năng:** Custom Widgets, Theme tùy chỉnh, Điều hướng màn hình (Navigation), Logic toán học.

### ☁️ Lab 9: Clima
* **Mục tiêu:** Ứng dụng thời tiết theo vị trí thời gian thực và tìm kiếm thành phố.
* **Kỹ năng:** Networking (API calls), JSON Parsing, GPS (Geolocator), Async/Await.

---

## 🧪 Kiểm Thử (Testing)
Tất cả các bài Lab đều được viết file test tương ứng trong thư mục `test/` (từ `lap1_test.dart` đến `lap9_test.dart`).

**Cách chạy test:**
```bash
flutter test
```

## ▶️ Chạy ứng dụng

Mỗi bài Lab có file riêng trong `lib/`. Ví dụ, để chạy Lab 9:

```bash
flutter run -t lib/lap9.dart
```

Thay `lap9.dart` bằng file Lab cần chạy.
