# Workflow ระบบ Localization (i10n) ของโปรเจกต์

เอกสารนี้อธิบายขั้นตอนการทำงานของระบบ Localization ที่ใช้ในโปรเจกต์นี้ ซึ่งมีการปรับแต่งให้ทำงานร่วมกับไฟล์ `localization.json` (ที่ได้จากการ Export Google Sheets) เพื่อความสะดวกในการจัดการภาษา

## ภาพรวมของ Workflow

1.  **Source of Truth:** `localization.json` (ไฟล์ข้อมูลดิบ)
2.  **Generation Script:** `tool/generate_arb.dart` (แปลง JSON -> ARB)
3.  **Intermediate Files:** `lib/l10n/*.arb` (ไฟล์มาตรฐาน Flutter)
4.  **Flutter Generator:** `flutter gen-l10n` (แปลง ARB -> Dart Code)
5.  **Usage:** `AppLocalizations` (นำไปใช้ใน Widget)

---

## ขั้นตอนการทำงาน (Step-by-Step)

### 1. อัปเดตข้อมูลภาษา (Source of Truth)
ข้อมูลภาษาทั้งหมดจะถูกเก็บไว้ในไฟล์ `localization.json` ที่ Root ของโปรเจกต์
*   **รูปแบบ:** JSON Array ของ Object
*   **คอลัมน์สำคัญ:**
    *   `Name`: ชื่อ Key (เช่น `headerDeposit`)
    *   `EN`: ข้อความภาษาอังกฤษ (ใช้เป็น Fallback และต้นแบบ)
    *   `TH`, `ZH`, `RU`, `MM`: ข้อความภาษาอื่นๆ
    *   `description`: คำอธิบายสำหรับ Metadata (Optional)

**ตัวอย่าง `localization.json`:**
```json
[
  {
    "Name": "welcomeMessage",
    "EN": "Welcome {name}",
    "TH": "ยินดีต้อนรับ {name}",
    "description": "Greeting message on home screen"
  }
]
```

### 2. สร้างไฟล์ ARB (Generate ARB)
เมื่อมีการแก้ไข `localization.json` ให้รันคำสั่งเพื่อแปลงข้อมูลเป็นไฟล์ `.arb` สำหรับแต่ละภาษา

**คำสั่ง:**
```bash
dart run tool/generate_arb.dart
```

**สิ่งที่สคริปต์ทำ:**
*   อ่าน `localization.json`
*   แปลง Key เป็น `lowerCamelCase`
*   ตรวจสอบ Placeholders (เช่น `{name}`) ในภาษาอังกฤษและสร้าง Metadata
*   สร้างไฟล์ `lib/l10n/app_en.arb`, `app_th.arb`, ฯลฯ
*   หากภาษาอื่นไม่มีค่า จะใช้ภาษาอังกฤษเป็นค่าเริ่มต้น (Fallback)

### 3. สร้างโค้ด Dart (Generate Dart Code)
หลังจากได้ไฟล์ `.arb` ใหม่แล้ว ให้รันคำสั่งของ Flutter เพื่อสร้างคลาส `AppLocalizations`

**คำสั่ง:**
```bash
flutter gen-l10n
```
*   *Note: ปกติ IDE หรือการรัน `flutter run` จะทำขั้นตอนนี้ให้อัตโนมัติ แต่ถ้ารันเองจะมั่นใจกว่า*

### 4. ตรวจสอบความถูกต้อง (Verify)
แนะนำให้รัน `flutter analyze` เพื่อตรวจสอบว่าไม่มีข้อผิดพลาดในไฟล์ที่สร้างขึ้น

**คำสั่ง:**
```bash
flutter analyze
```

---

## การนำไปใช้งานใน Widget (Usage)

เมื่อผ่านขั้นตอนข้างต้นแล้ว สามารถเรียกใช้ข้อความในโค้ดได้ทันทีผ่าน `AppLocalizations`

### การเรียกใช้ทั่วไป
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ใน build method
Text(AppLocalizations.of(context)!.welcomeMessage('Tony'))
```

### การตั้งค่าใน `MaterialApp` (ทำครั้งเดียว)
ในไฟล์ `lib/main.dart`:
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

MaterialApp(
  title: 'Wi Wallet',
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  // ...
);
```

---

## สรุปคำสั่งที่ต้องใช้ (Cheatsheet)

เมื่อมีการแก้ `localization.json`:

1.  `dart run tool/generate_arb.dart` (สร้าง ARB)
2.  `flutter gen-l10n` (สร้าง Dart)
3.  `flutter analyze` (ตรวจสอบ)
