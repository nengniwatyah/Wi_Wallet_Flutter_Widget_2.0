# ระบบ Localization (i10n) ในโปรเจกต์ Flutter

ระบบ Internationalization (i10n) ในโปรเจกต์ Flutter นี้ทำงานอย่างเป็นระบบ โดยอาศัยเครื่องมือที่มากับ Flutter เอง ทำให้การจัดการข้อความหลายภาษาง่ายและมีประสิทธิภาพสูง

นี่คือขั้นตอนและส่วนประกอบหลักๆ ของระบบ i10n ที่เห็นในโปรเจกต์ของคุณ:

### 1. ไฟล์ตั้งค่าหลัก: `l10n.yaml`

ไฟล์นี้เปรียบเสมือน "พิมพ์เขียว" ของระบบแปลภาษาในแอปของคุณ มันจะบอก Flutter ว่า:

-   **ไฟล์ภาษาต้นแบบอยู่ที่ไหน:** (`template-arb-file`) โดยปกติจะชี้ไปที่ไฟล์ภาษาอังกฤษ เช่น `app_en.arb`
-   **ไฟล์ภาษาทั้งหมดเก็บไว้ที่ไหน:** (`arb-dir`) ในโปรเจกต์ของคุณคือไดเรกทอรี `lib/l10n`
-   **ไฟล์ Dart ที่จะสร้างขึ้นควรไปอยู่ที่ไหน:** (`output-localization-file`) ซึ่งก็คือ `app_localizations.dart`
-   **คลาส Dart ที่จะถูกสร้างขึ้นควรชื่ออะไร:** (`output-class`) โดยทั่วไปจะชื่อ `AppLocalizations`

### 2. ไฟล์ข้อมูลภาษา: `lib/l10n/*.arb`

ไฟล์ `.arb` (Application Resource Bundle) คือหัวใจของการแปลภาษา เป็นไฟล์ที่เก็บข้อความทั้งหมดในรูปแบบ "key-value"

-   `app_en.arb`: เป็นไฟล์ **"ต้นแบบ" (Template)** ภาษาอังกฤษ ทุกข้อความใหม่ที่คุณต้องการเพิ่มในแอป **ต้องเริ่มที่ไฟล์นี้ก่อนเสมอ**
-   `app_th.arb`, `app_my.arb`, `app_ru.arb`, `app_zh.arb`: เป็นไฟล์แปลของภาษาอื่นๆ (ไทย, มาเลย์, รัสเซีย, จีน) โดยจะมี "key" เหมือนกับในไฟล์ `app_en.arb` ทุกประการ แต่ "value" จะเป็นข้อความที่แปลแล้ว

**ตัวอย่างในไฟล์ `app_en.arb`:**
```json
{
  "helloWorld": "Hello World!",
  "welcomeMessage": "Welcome {userName}"
}
```

**ตัวอย่างในไฟล์ `app_th.arb`:**
```json
{
  "helloWorld": "สวัสดีชาวโลก!",
  "welcomeMessage": "ยินดีต้อนรับ {userName}"
}
```
> สังเกตว่า `{userName}` คือตัวแปร (placeholder) ที่สามารถส่งค่าเข้าไปแทรกในข้อความได้จากโค้ด

### 3. การสร้างโค้ดอัตโนมัติ: `flutter gen-l10n`

นี่คือคำสั่งที่ใช้ในการสร้างไฟล์ภาษา:
```bash
flutter gen-l10n
```
คำสั่งนี้จะ:
1.  อ่านไฟล์ `l10n.yaml` เพื่อดูการตั้งค่า
2.  เข้าไปอ่านไฟล์ `.arb` ทั้งหมดใน `lib/l10n`
3.  **สร้างไฟล์ Dart อัตโนมัติ** ไปไว้ที่ `lib/generated/intl/`
4.  ไฟล์ที่สำคัญที่สุดที่ถูกสร้างขึ้นคือ `app_localizations.dart` ซึ่งภายในจะมีคลาสชื่อ `AppLocalizations`

### 4. การนำไปใช้งานในโค้ด: คลาส `AppLocalizations`

แทนที่จะเขียนข้อความลงไปในโค้ดตรงๆ (Hardcode) เช่น `Text("Hello World!")` เราจะเรียกใช้ผ่านคลาสที่ถูกสร้างขึ้นมาแทน:

```dart
// ก่อนใช้ i10n
Text("Hello World!");

// หลังใช้ i10n
Text(AppLocalizations.of(context)!.helloWorld);
```

**ข้อดีคือ:**
-   **Type-Safe:** ถ้าคุณพิมพ์ชื่อ key ผิด (เช่น `helloWorrld`) โค้ดจะ error ทันทีตอน compile ไม่ต้องรอไปเจอตอนแอปทำงาน
-   **โค้ดสะอาด:** แยกข้อความออกจาก Logic ของโค้ดอย่างชัดเจน
-   **เปลี่ยนภาษาง่าย:** Flutter จะจัดการเลือกข้อความจากภาษาที่ถูกต้องให้เองตามภาษาของเครื่องผู้ใช้

### 5. การตั้งค่าใน `MaterialApp`

เพื่อให้ Flutter รู้จักกับระบบ i10n ของเรา เราต้องไปตั้งค่าในไฟล์ `lib/main.dart` ตรง `MaterialApp` (หรือ `CupertinoApp`) ดังนี้:

```dart
MaterialApp(
  // ...
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  // ...
)
```
-   `localizationsDelegates`: บอก Flutter ว่าจะโหลดภาษาจากที่ไหน (ซึ่งก็คือจากคลาส `AppLocalizations` ของเรา)
-   `supportedLocales`: บอก Flutter ว่าแอปของเรารองรับภาษาอะไรบ้าง ซึ่งรายการนี้จะถูกสร้างขึ้นอัตโนมัติตามจำนวนไฟล์ `.arb` ที่เรามี

### สรุปขั้นตอนการทำงานทั้งหมด

1.  **กำหนดข้อความ:** เพิ่ม Key-Value ในไฟล์ `app_en.arb` ก่อนเสมอ
2.  **แปลภาษา:** นำ Key เดียวกันไปใส่ในไฟล์ `.arb` ของภาษาอื่นๆ พร้อมใส่คำแปล
3.  **สร้างโค้ด:** รันคำสั่ง `flutter gen-l10n`
4.  **เรียกใช้:** ใช้ `AppLocalizations.of(context)!.yourKey` ในโค้ด Widget
5.  **ตั้งค่า:** กำหนด `localizationsDelegates` และ `supportedLocales` ใน `MaterialApp`

ระบบนี้ทำให้การเพิ่ม/แก้ไข/ลบข้อความในแอปทำได้จากที่เดียวคือไฟล์ `.arb` และมั่นใจได้ว่าทุกภาษาจะมีข้อความครบถ้วนเหมือนกัน

---

