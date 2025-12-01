# คู่มือการทำ Skeleton Loading ด้วย Lottie

คู่มือนี้รวบรวมวิธีการใช้งาน Skeleton Loading ในโปรเจกต์ โดยเน้นการใช้ `LottieSkeleton` Widget และการทดสอบผ่าน `SkeletonPreviewPage`

## 1. LottieSkeleton Widget (Recommended)

`LottieSkeleton` เป็น Widget หลักที่เราใช้สำหรับทำ Skeleton Loading โดยมีคุณสมบัติเด่นคือ:
- **Automatic Sizing**: ขนาดของ Skeleton จะเท่ากับ Widget ลูก (`child`) โดยอัตโนมัติ ไม่ต้องกำหนด width/height เอง
- **Rounded Corners**: รองรับการกำหนด `borderRadius` เพื่อให้ Skeleton มีรูปร่างตรงกับ UI จริง (เช่น ปุ่มมน, รูปวงกลม)
- **Theme Aware**: รองรับ Dark/Light mode (ขึ้นอยู่กับไฟล์ Lottie ที่ใช้)

### Source Code
ไฟล์อยู่ที่: `lib/widgets/skeleton/lottie_skeleton.dart`

```dart
class LottieSkeleton extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? lottieAsset;
  final double? width;   // Optional: ถ้าต้องการ fix ขนาด
  final double? height;  // Optional: ถ้าต้องการ fix ขนาด
  final BorderRadiusGeometry? borderRadius; // กำหนดความมนของขอบ

  const LottieSkeleton({
    super.key,
    required this.isLoading,
    required this.child,
    this.lottieAsset,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Stack(
      children: [
        // 1. Widget จริงถูกซ่อนไว้ (Opacity 0) เพื่อดัน Layout ให้ได้ขนาดเท่าจริง
        Opacity(opacity: 0, child: child),
        
        // 2. แสดง Lottie Animation ทับลงไปในพื้นที่นั้น
        Positioned.fill(
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: Lottie.asset(
              lottieAsset ?? 'lib/assets/lottie/wi_skeleton.json',
              width: width,
              height: height,
              fit: BoxFit.fill,
              repeat: true,
            ),
          ),
        ),
      ],
    );
  }
}
```

---

## 2. วิธีการใช้งาน (How to Apply)

การใส่ Skeleton ให้กับ Widget ใดๆ ทำได้ง่ายๆ เพียงแค่ Wrap Widget นั้นด้วย `LottieSkeleton`

### ตัวอย่างที่ 1: ปุ่มกด (Button)
ต้องการให้ Skeleton มีขอบมนเท่ากับปุ่ม (เช่น 24px)

```dart
LottieSkeleton(
  isLoading: isLoading,
  borderRadius: BorderRadius.circular(24), // ใส่ความมนให้เท่ากับปุ่มจริง
  child: ElevatedButton(
    onPressed: () {},
    child: Text('Submit'),
  ),
)
```

### ตัวอย่างที่ 2: รูปภาพวงกลม (Circle Avatar)
ต้องการให้ Skeleton เป็นวงกลม

```dart
LottieSkeleton(
  isLoading: isLoading,
  borderRadius: BorderRadius.circular(50), // รัศมีวงกลม
  child: CircleAvatar(
    radius: 50,
    backgroundImage: NetworkImage(url),
  ),
)
```

### ตัวอย่างที่ 3: ข้อความ (Text)
สำหรับข้อความ อาจจะใส่ `borderRadius` เล็กน้อย (เช่น 4px หรือ 8px) เพื่อความสวยงาม

```dart
LottieSkeleton(
  isLoading: isLoading,
  borderRadius: BorderRadius.circular(4),
  child: Text('Total Balance'),
)
```

---

## 3. การทดสอบด้วย SkeletonPreviewPage

เรามีหน้า `SkeletonPreviewPage` สำหรับทดสอบ Skeleton Loading โดยเฉพาะ แยกจากหน้าหลักของแอป
ไฟล์อยู่ที่: `lib/widgets/skeleton/skeleton_preview_page.dart`

### ฟีเจอร์ของหน้า Preview
1.  **Independent Run**: สามารถกด Run ไฟล์นี้แยกได้เลย (มี `main()` ในตัว)
2.  **Theme Toggle**: มีปุ่มเปลี่ยน Theme (Dark/Light) ที่มุมขวาบน เพื่อดูผลลัพธ์ทั้งสองโหมด
3.  **Pull-to-Refresh**: จำลองการโหลดข้อมูลด้วยการดึงหน้าจอลงมา (Pull down)
    - Refresh Indicator จะเด้งกลับทันที
    - Skeleton จะแสดงค้างไว้ 2 วินาที แล้วกลับมาเป็นเนื้อหาจริง

### วิธีเพิ่ม Widget ใหม่เข้าไปทดสอบ
1.  เปิดไฟล์ `lib/widgets/skeleton/skeleton_preview_page.dart`
2.  ไปที่ส่วน `body` ภายใน `CustomScrollView` -> `SliverFillRemaining` -> `Column`
3.  เพิ่ม Widget ที่ต้องการทดสอบเข้าไปใน `children` ของ `Column`
4.  ส่งตัวแปร `_isLoading` เข้าไปใน property `isLoading` ของ Widget นั้น

```dart
// ตัวอย่างใน skeleton_preview_page.dart
DrawerBalanceDetail(
  // ... parameters ...
  isLoading: _isLoading, // เชื่อมต่อกับ state ของหน้า Preview
  showButton: false,
),
```

---

## 4. รูปแบบอื่นๆ (Legacy / Alternative)

### FutureBuilder + Lottie
เหมาะสำหรับกรณีโหลดข้อมูลครั้งเดียวและต้องการแสดง Skeleton เต็มพื้นที่ หรือตรงกลาง

```dart
FutureBuilder<String>(
  future: fetchData(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(
        child: Lottie.asset('assets/lottie/your_skeleton.json'),
      );
    }
    return Text(snapshot.data ?? '');
  },
)
```

### List Skeleton
สำหรับ `ListView` ให้ใช้การเช็ค `isLoading` แล้วสลับ Widget ทั้งก้อน

```dart
isLoading
    ? ListView.builder(
        itemCount: 5,
        itemBuilder: (_, __) => LottieSkeleton(
          isLoading: true,
          child: ListTile(title: Text('Loading...')), // Dummy child for sizing
        ),
      )
    : ListView.builder(
        itemCount: realItems.length,
        itemBuilder: (_, index) => RealItemWidget(item: realItems[index]),
      );
```
