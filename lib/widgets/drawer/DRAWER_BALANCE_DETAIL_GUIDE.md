# DrawerBalanceDetail Widget

Bottom sheet drawer for displaying balance details with breakdown.

## 📋 Overview

`DrawerBalanceDetail` เป็น bottom sheet drawer ที่แสดงรายละเอียดยอดเงินคงเหลือ ประกอบด้วย total balance, hold amount, ledger balance และข้อความเตือนเกี่ยวกับ hold amount

## 🎨 Design Specs (Based on Figma)

https://www.figma.com/design/D7WVaC8n3foVLo6S3HuPn8/New-Wi-Wallet-2.0?node-id=7089-198920&t=sYCnD6dsF9QpTyn1-4

### Layout
- **Height**: 80% ของหน้าจอ (0.80 * screen height)
- **Border Radius**: 16px (top corners only)
- **Background**: `fill/base/100`
- **Padding**: 16px horizontal, 16px top, 40px bottom

### Components Structure
1. **Header** (16px padding)
   - Title: "Balance Detail" (center aligned)
   - Font: Noto Sans Thai, 15px, weight 600, line-height 1.51

2. **Content** (Scrollable, 16px horizontal padding)
   - Image (144px height ตาม Figma, full-wallet.png from assets, no border radius)
   - Gap: 16px
   - Balance Card (fill/base/300, 16px padding, 12px radius)
     - Total Balance Label + Amount (green, 22px, bold)
     - Divider
     - Hold Amount (with red asterisk *)
     - Ledger Balance
   - Gap: 8px
   - AnnouncementWarning (reused widget component)

3. **Footer** (16/8/16/40 padding)
   - OK Button (Primary button)

## 📦 Import

```dart
import 'package:mcp_test_app/widgets/drawer/drawer_balance_detail.dart';
```

## 🚀 Usage

### Show Drawer

```dart
DrawerBalanceDetail.show(
  context,
  totalBalanceAmount: '100,000,000,000.00',
  currency: 'THB',
  holdAmountLabel: 'Hold Amount',
  holdAmountValue: '5,030.20',
  ledgerBalanceLabel: 'Ledger Balance',
  ledgerBalanceValue: '15,030.20',
  warningText: '*Hold Amount means they aren\'t immediately available for use.',
  buttonText: 'OK',
);
```



## 🌟 Behaviour

- แสดงเป็น modal bottom sheet จากด้านล่างของหน้าจอ
- ความสูงคงที่ 80% ของหน้าจอ
- เนื้อหาภายในสามารถ scroll ได้
- **ปิดได้เฉพาะจากปุ่ม OK เท่านั้น** (isDismissible: false, enableDrag: false)
- กดนอก area หรือ swipe down จะไม่มีผลอะไร
- Background มืดโปร่งใสด้านหลัง drawer

## 🎯 Properties

| Property              | Type            | Required | Default | Description                           |
|-----------------------|-----------------|----------|---------|------------------------------------- -|
| `totalBalanceAmount`  | `String`        | Yes      | -       | จำนวนเงินรวม                          |
| `currency`            | `String`        | No       | 'THB'   | สกุลเงิน                              |
| `holdAmountLabel`     | `String`        | Yes      | -       | Label "Hold Amount"                   |
| `holdAmountValue`     | `String`        | Yes      | -       | จำนวน Hold Amount                     |
| `ledgerBalanceLabel`  | `String`        | Yes      | -       | Label "Ledger Balance"                |
| `ledgerBalanceValue`  | `String`        | Yes      | -       | จำนวน Ledger Balance                  |
| `warningText`         | `String`        | Yes      | -       | ข้อความเตือนเกี่ยวกับ Hold Amount     |
| `buttonText`          | `String`        | No       | 'OK'    | ข้อความบนปุ่ม                         |
| `onClose`             | `VoidCallback?` | No       | null    | Callback เมื่อกดปุ่มปิด               |

## 🎨 Design Tokens Used

### Colors
- `fill/base/100` - Drawer background
- `fill/base/300` - Balance card background
- `text/base/600` - Primary text color
- `text/base/400` - Label text color (Hold Amount, Ledger Balance labels)
- `success/500` - Total balance amount color (green)
- `stroke/base/200` - Divider color
- `#FF2729` - Red asterisk color
- `#FDE4B5` - Warning background
- `#AA8129` - Warning text/icon color

### Typography
- **Header Title**: 15px, weight 600, line-height 1.51
- **Total Balance Label**: 15px, weight 600, line-height 1.51
- **Total Balance Amount**: 22px, weight 700, line-height 1.27
- **Detail Labels/Values**: 13px, weight 600, line-height 1.23
- **Warning Text**: 11px, weight 500, line-height 1.45

### Spacing
- Header padding: 16px horizontal, 16px vertical
- Content padding: 16px horizontal
- Card padding: 16px all sides
- Footer padding: 16/8/16/40
- Component gaps: 16px, 8px, 4px

## 🔄 Component Composition

```
DrawerBalanceDetail
├── Header
│   └── Title ("Balance Detail")
├── Content (Scrollable)
│   ├── Image (144px height)
│   ├── Balance Card
│   │   ├── Total Balance (Label + Amount)
│   │   ├── Divider
│   │   ├── Hold Amount (with red *)
│   │   └── Ledger Balance
│   └── AnnouncementWarning
└── Footer
    └── OK Button (Primary)
```

## 🧪 Preview

รันตัวอย่างพร้อมสลับธีมได้ที่:

```bash
flutter run lib/widgets/drawer/preview_drawer_balance_detail.dart
```

## 📱 Material Design Compliance

Widget นี้ปฏิบัติตาม Material Design guidelines สำหรับ bottom sheets:
- Modal bottom sheet behavior
- **No swipe to dismiss** (requires explicit button action)
- **No tap outside to dismiss** (requires explicit button action)
- Backdrop overlay
- Rounded top corners
- Fixed height (80% of screen)
- Scrollable content

## 📱 Edge-to-Edge & Gesture Navigation Support

Widget นี้รองรับการแสดงผลแบบ **Edge-to-Edge** บนอุปกรณ์ทั้ง Android และ iOS:

1.  **Gesture Navigation Bar (Android) / Home Indicator (iOS)**:
    - มีการคำนวณ `bottomPadding` จาก `MediaQuery.of(context).viewPadding.bottom`
    - เพิ่มพื้นที่ด้านล่างสุดของ Drawer เพื่อไม่ให้ปุ่มกดทับซ้อนกับ System Navigation Bar
    - พื้นที่นี้ใช้สี `fill/base/100` (สีเดียวกับ Background) พร้อม `BackdropFilter` (Blur 10px) เพื่อความสวยงามและ Seamless

2.  **Safe Area**:
    - เนื้อหาและปุ่มกดจะถูกดันขึ้นมาจากขอบล่างโดยอัตโนมัติเมื่ออยู่บนอุปกรณ์ที่มี Notch หรือ Gesture Bar
    - ปุ่ม OK จะมี Padding ด้านล่าง 16px (จากเดิม 40px) เมื่อมี Gesture Bar เพื่อความสมดุล

```dart
// ตัวอย่างการคำนวณในโค้ด
final bottomPadding = mediaQuery.viewPadding.bottom > 0
    ? mediaQuery.viewPadding.bottom
    : mediaQuery.padding.bottom;

// ...

if (bottomPadding > 0)
  ClipRRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: bottomPadding,
        color: theme.ThemeColors.get(brightnessKey, 'fill/base/100').withValues(alpha: 0.9),
      ),
    ),
  ),
```

## ⚠️ Notes & Recommendations

1. **Height**: ใช้ 80% ของหน้าจอ เหมาะสำหรับเนื้อหาปานกลาง
2. **Scrollable**: เนื้อหาภายใน scroll ได้ รองรับข้อมูลยาว
3. **Theme Support**: รองรับ light/dark mode อัตโนมัติ
4. **Fixed Image**: ใช้รูป full-wallet.png จาก assets (144px height ตาม Figma, ไม่มี border radius)
5. **Red Asterisk**: ใช้สีแดง (#FF2729) เพื่อเน้นข้อมูลสำคัญ
6. **Reused Component**: ใช้ AnnouncementWarning widget สำหรับ warning message
   - ใช้ `descriptionSpans` parameter เพื่อทำ "*Hold Amount" เป็น bold (font weight 700)
   - ส่วนที่เหลือของข้อความใช้ font weight 500 (ปกติ)
7. **Dismiss Behavior**: ปิดได้เฉพาะจากปุ่ม OK เท่านั้น (isDismissible: false, enableDrag: false)
8. **Localization**: ควร localize ทุก label และข้อความ

## 💡 Usage Tips

### With Localization

```dart
final l10n = AppLocalizations.of(context)!;

DrawerBalanceDetail.show(
  context,
  totalBalanceAmount: '100,000.00',
  holdAmountLabel: l10n.homeDrawerDetailHoldAmount,
  holdAmountValue: '5,030.20',
  ledgerBalanceLabel: l10n.homeDrawerDetailLedgerBalance,
  ledgerBalanceValue: '15,030.20',
  warningText: l10n.homeDrawerWarningHoldAmount,
  buttonText: l10n.homeDrawerTextButtonBalanceDetailOk,
);
```

### Format Large Numbers

```dart
import 'package:intl/intl.dart';

final formatter = NumberFormat('#,##0.00');
final balance = 100000000000.00;

DrawerBalanceDetail.show(
  context,
  totalBalanceAmount: formatter.format(balance),
  // ... other properties
);
```

## 🔧 Customization

### Change Height Ratio

```dart
// In drawer_balance_detail.dart
height: screenHeight * 0.80, // Change from 0.75 to 0.80 (80%)
```

### Custom Image Height

```dart
// Modify image height in drawer_balance_detail.dart
// ⚠️ ขนาดปัจจุบัน 144px ตาม Figma spec
Image.asset(
  'lib/assets/images/full-wallet.png',
  height: 200, // Change from 144 to 200 if needed
  // ...
)
```

### Custom Warning Text Style

```dart
// ใช้ descriptionSpans เพื่อ customize text style
AnnouncementWarning(
  title: '',
  description: '',
  descriptionSpans: [
    TextSpan(
      text: '*Hold Amount',
      style: TextStyle(fontWeight: FontWeight.w700), // Bold
    ),
    TextSpan(
      text: ' means they aren\'t immediately available.',
      style: TextStyle(fontWeight: FontWeight.w500), // Normal
    ),
  ],
)
```

## 🔗 Related Widgets

- `DrawerReviewTransaction` - Transaction review drawer
- `AnnouncementWarning` - Warning message component (reused)
- `Buttons` - Primary button component

## 📊 Use Cases

1. **Balance Overview** - แสดงภาพรวมยอดเงิน
2. **Hold Amount Explanation** - อธิบายยอดเงินที่ถูกระงับ
3. **Account Summary** - สรุปข้อมูลบัญชี
4. **Financial Details** - รายละเอียดทางการเงิน

## 🆚 Comparison with DrawerReviewTransaction

| Feature                  | DrawerBalanceDetail      | DrawerReviewTransaction |
|--------------------------|--------------------------|-------------------------|
| **Purpose**              | Show balance breakdown   | Review transaction      |
| **Warning**              | Simple text (no title)   | Title + description     |
| **Main Content**         | Balance card             | Transaction card        |
| **Button**               | OK (dismiss)             | Confirm (action)        |
| **Image**                | Fixed asset (144px)      | No image                |
| **Dismiss Behavior**     | Button only              | Button + swipe/tap      |
| **Use Case**             | Information display      | Confirmation flow       |

---

**Based on Figma Design**: Component ถูกสร้างตาม Figma spec node `state=balance_detail` ใน New Wi Wallet 2.0 design system
