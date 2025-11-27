# คู่มือการใช้งาน PreLoading Widget

`PreLoading` เป็น Widget สำหรับแสดงสถานะกำลังโหลดแบบเต็มหน้าจอ (Full Screen Overlay) พร้อมเอฟเฟกต์เบลอฉากหลัง (Blur Effect) และ Lottie Animation

## 1. PreLoading Widget

Widget นี้ถูกออกแบบมาให้ใช้งานง่าย โดยจะแสดงผลทับหน้าจอทั้งหมด (Overlay)

### Source Code
ไฟล์อยู่ที่: `lib/widgets/loading/pre_loading.dart`

```dart
class PreLoading extends StatelessWidget {
  const PreLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Blur Background
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: const Color.fromRGBO(0, 0, 0, 0.5)),
          ),
        ),
        // 2. Lottie Animation
        Center(
          child: Lottie.asset(
            'lib/assets/lottie/wi_loader.json',
            width: 280,
            height: 280,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
```

---

## 2. วิธีการใช้งาน (How to Apply)

การใช้งาน `PreLoading` มักจะใช้ร่วมกับ `Stack` เพื่อให้แสดงผลทับเนื้อหาหลักของหน้าจอ

### ตัวอย่างการใช้งานพื้นฐาน

```dart
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Page')),
      body: Stack(
        children: [
          // 1. เนื้อหาหลักของหน้า (Main Content)
          SingleChildScrollView(
            child: Column(
              children: [
                // ... widgets ...
              ],
            ),
          ),

          // 2. PreLoading Overlay (แสดงเมื่อ _isLoading เป็น true)
          if (_isLoading) const PreLoading(),
        ],
      ),
    );
  }
}
```

### ข้อควรระวัง
*   ควรวาง `PreLoading` ไว้เป็นลูกตัวสุดท้ายของ `Stack` เสมอ เพื่อให้แน่ใจว่าจะแสดงผลทับ Widget อื่นๆ ทั้งหมด
*   `PreLoading` จะบล็อกการสัมผัส (Touch Events) ของ Widget ที่อยู่ด้านหลังโดยอัตโนมัติ เนื่องจากมี Container เต็มหน้าจอกั้นอยู่

---

## 3. การทดสอบด้วย PreviewPreLoadingPage

เรามีหน้า `PreviewPreLoadingPage` สำหรับทดสอบการแสดงผลของ `PreLoading` โดยเฉพาะ
ไฟล์อยู่ที่: `lib/widgets/loading/preview_pre_loading.dart`

### ฟีเจอร์ของหน้า Preview
1.  **Independent Run**: สามารถกด Run ไฟล์นี้แยกได้เลย (มี `main()` ในตัว)
2.  **Theme Toggle**: มีปุ่มเปลี่ยน Theme (Dark/Light) ที่มุมขวาบน เพื่อดูผลลัพธ์ทั้งสองโหมด
3.  **Background Simulation**: มีรายการ List จำลองอยู่ด้านหลัง เพื่อให้เห็นผลลัพธ์ของ Blur Effect ได้ชัดเจน
4.  **Always Loading**: ในหน้า Preview นี้ สถานะ `_isLoading` จะถูกตั้งเป็น `true` ตลอดเวลา เพื่อให้เห็น Animation และ Overlay ได้ทันทีที่เปิด

### วิธีการ Run
คลิกขวาที่ไฟล์ `lib/widgets/loading/preview_pre_loading.dart` แล้วเลือก **Run** หรือกดปุ่ม Run ที่อยู่เหนือ `void main()`

---

## 4. การปรับแต่ง (Customization)

หากต้องการปรับขนาดของ Animation หรือความเบลอ สามารถแก้ไขได้โดยตรงที่ไฟล์ `lib/widgets/loading/pre_loading.dart`

*   **Animation Size**: แก้ไข `width` และ `height` ใน `Lottie.asset` (ปัจจุบันตั้งค่าไว้ที่ 280)
*   **Blur Intensity**: แก้ไขค่า `sigmaX` และ `sigmaY` ใน `BackdropFilter` (ปัจจุบันตั้งค่าไว้ที่ 10)
*   **Overlay Color**: แก้ไขสีและความโปร่งใสใน `Container` (ปัจจุบันใช้สีดำโปร่งแสง 50%)
