# DrawerDepositChannel Widget

Bottom-sheet drawer presenting a list of supported deposit channels (mobile banking) with theme-aware styling.

## 📋 Overview

`DrawerDepositChannel` แสดงรายการธนาคารด้วยโลโก้ ชื่อ และลูกศรนำทาง เหมาะสำหรับใช้เป็น modal bottom sheet เมื่อผู้ใช้ต้องเลือกช่องทางฝากเงินก่อนดำเนินการต่อ

## 🎨 Layout & Design Tokens

- Height: `MediaQuery.of(context).size.height * 0.5` (ครอบครองครึ่งล่างของจอ)
- Padding: `EdgeInsets.fromLTRB(16, 16, 16, 16)`
- Border radius: 16 px เฉพาะด้านบน `Radius.circular(16)`
- Background: `ThemeColors.get(brightnessKey, 'fill/base/100')`
- Header text: `GoogleFonts.notoSansThai` 15 px, weight 700, สี `text/base/600`
- Label “Mobile Banking”:
  - Background: `fill/base/600`
  - Text: 10 px, weight 600, สี `text/base/600`
- Bank item container:
  - Height 56 px, padding `EdgeInsets.symmetric(horizontal: 16, vertical: 8)`
  - Background: `fill/base/300`, radius 12 px
  - Text: 15 px, weight 400, สี `text/base/600`
- Icons:
  - Close button: `cancel-01.svg` 24 px, สี `text/base/600`
  - Bank logos: SVG assets ต่อธนาคาร (ไม่มีการเติมสีทับ)
  - Trailing arrow: `arrow-right-01.svg` 24 px, ใช้สีจากไฟล์ SVG

## 🚀 Usage Example

```dart
showModalBottomSheet(
  context: context,
  backgroundColor: Colors.transparent,
  isScrollControlled: true,
  builder: (context) => DrawerDepositChannel(
    onClose: () => Navigator.pop(context),
    onBankSelected: (bank) {
      // Handle selected bank type
    },
  ),
);
```

## 🔧 Preview Utilities

รันตัวอย่างพร้อมธีมมืดเป็นค่าเริ่มต้นได้ที่:

```bash
flutter run lib/widgets/drawer/preview_drawer_deposit_channel.dart
```

ไฟล์ preview มี:
- ปุ่ม “Show Drawer” ที่เปิด modal พร้อม blur พื้นหลัง
- Theme toggle (light/dark) ผ่าน `ThemeProvider`
- Locale selector ผ่าน `AppLocalizations` (แม้ widget ใช้อังกฤษล้วนในตอนนี้)

## 🎯 Properties

| Property          | Type                      | Required | Description                                          |
|-------------------|---------------------------|----------|------------------------------------------------------|
| `onClose`         | `VoidCallback?`           | No       | เรียกเมื่อผู้ใช้กดไอคอนปิด                          |
| `onBankSelected`  | `Function(BankType)?`     | No       | คืนค่า enum `BankType` เมื่อเลือกธนาคารแต่ละแถว      |

## 🗂️ BankType Enum

```dart
enum BankType { scb, kbank, bbl, krungsri }
```

การ mapping ถูกจัดการผ่านเมธอด `_getBankName` และ `_getBankLogo` ที่คืนค่าข้อความและพาธ SVG ตาม enum

## ♻️ Behaviour Notes

- รายการธนาคารถูกจัด hard-coded เป็น 4 ธนาคารและทำซ้ำ 2 รอบเพื่อแสดงพฤติกรรม Scroll; ปรับตามข้อมูลจริงได้ผ่านการสร้างลิสต์ก่อนส่งเข้า `_buildBankItem`.
- item แต่ละแถวเป็น `GestureDetector` ที่เรียก `onBankSelected?.call(bank)` เมื่อแตะ
- ตัว drawer ไม่ปิดอัตโนมัติเมื่อเลือก จำเป็นต้องจัดการใน callback (ดูตัวอย่าง preview ที่เรียก `Navigator.pop`)
- ไม่มีสถานะเลือก/hover ให้เพิ่มได้หากต้องการความชัดเจนเพิ่มเติม

## 📝 Implementation Highlights

- ใช้ `ThemeColors` เพื่อให้สอดคล้องกับ design tokens ของโปรเจกต์
- พึ่งพา `GoogleFonts.notoSansThai` เพื่อความคงที่ของ typography
- อาศัย `SvgPicture.asset` ในการแสดงโลโก้และไอคอนทั้งหมด
- ความสูงของ drawer ผูกกับความสูงหน้าจอ (50%) ควรทดสอบบนอุปกรณ์จอเล็ก/ใหญ่

## ✅ Checklist ก่อนใช้งานจริง

1. ตรวจสอบว่า assets (`brands=*.svg`, `cancel-01.svg`, `arrow-right-01.svg`) อยู่ใน `pubspec.yaml`
2. หากธนาคารมีจำนวนเยอะ ควรดึงข้อมูลจากโมเดลหรือ service แทนการซ้ำโค้ดใน widget
3. เพิ่ม localization สำหรับชื่อธนาคารหรือหัวข้อหากต้องรองรับหลายภาษา
4. ทดสอบในธีมมืด/สว่างว่า contrast ของสีอ่านได้ชัดเจน

---

**Design Source**: สร้างตามแนวทาง bottom-sheet และ design tokens ที่กำหนดใน Wi Wallet design system
