# DrawerReviewTransaction Widget

Bottom sheet drawer for reviewing transaction details before confirmation.

## 📋 Overview

`DrawerReviewTransaction` เป็น bottom sheet drawer ที่แสดงรายละเอียดธุรกรรมเพื่อให้ผู้ใช้ตรวจสอบก่อนยืนยัน ประกอบด้วย warning message, transaction details, object label และปุ่มยืนยัน

## 🎨 Design Specs (Based on Figma)

### Layout
- **Height**: 75% ของหน้าจอ (0.75 * screen height)
- **Border Radius**: 16px (top corners only)
- **Background**: `fill/base/100`
- **Padding**: 16px horizontal, 16px top, 40px bottom

### Components Structure
1. **Header** (16px padding)
   - Title: "Review" (center aligned)
   - Close button (right aligned)
   - Font: Noto Sans Thai, 15px, weight 600, line-height 1.51

2. **Content** (Scrollable, 16px horizontal padding)
   - AnnouncementWarning (warning message)
   - Gap: 16px
   - CardReviewTransaction (transaction details)
   - Gap: 8px
   - Object Label (15px, weight 600)
   - Gap: 8px
   - Object Value Container (fill/base/300, 16px padding, 12px radius)

3. **Footer** (16/8/16/40 padding)
   - Confirm Button (Primary button)

## 📦 Import

```dart
import 'package:mcp_test_app/widgets/drawer/drawer_review_transaction.dart';
```

## 🚀 Usage

### Show Drawer

```dart
DrawerReviewTransaction.show(
  context,
  warningTitle: 'Please recheck information before proceeding',
  warningDescription: 'To prevent wrong account transfers or fraudulent activities.',
  totalAmount: '5,000.00',
  feeAmount: '0.00',
  currency: 'THB',
  fromLabel: 'From',
  fromValue: 'Your Wi Wallet',
  mobileLabel: 'Mobile Number',
  mobileValue: '081-141-1234',
  toLabel: 'To',
  toValue: 'Siam Commercial Bank',
  accountNameLabel: 'Account Name',
  accountNameValue: 'Victor Von Doom',
  accountNumberLabel: 'Account Number',
  accountNumberValue: '1234567890',
  objectLabel: 'Object',
  objectValue: 'Personal expenses',
  confirmButtonText: 'Confirm',
  onConfirm: () {
    // Handle confirmation
    Navigator.pop(context);
    print('Transaction confirmed');
  },
);
```

### Direct Widget Usage

```dart
DrawerReviewTransaction(
  warningTitle: 'Please recheck information',
  warningDescription: 'Cannot be changed once confirmed.',
  totalAmount: '5,000.00',
  // ... other required properties
  onConfirm: () => print('Confirmed'),
  onClose: () => Navigator.pop(context),
)
```

## 🌟 Behaviour

- แสดงเป็น modal bottom sheet จากด้านล่างของหน้าจอ
- ความสูงคงที่ 75% ของหน้าจอ
- เนื้อหาภายในสามารถ scroll ได้
- กดปุ่ม X เพื่อปิด (ไม่สามารถ swipe down หรือกดนอก area เพื่อปิดได้)
- กดปุ่ม Confirm เพื่อยืนยันธุรกรรม
- Background มืดโปร่งใสด้านหลัง drawer

## 🎯 Properties

| Property              | Type            | Required | Default   | Description                        |
|-----------------------|-----------------|----------|-----------|------------------------------------|
| `warningTitle`        | `String`        | Yes      | -         | หัวข้อข้อความเตือน                 |
| `warningDescription`  | `String`        | Yes      | -         | รายละเอียดข้อความเตือน             |
| `totalAmount`         | `String`        | Yes      | -         | จำนวนเงินรวม                       |
| `feeAmount`           | `String`        | No       | '0.00'    | ค่าธรรมเนียม                       |
| `currency`            | `String`        | No       | 'THB'     | สกุลเงิน                           |
| `fromLabel`           | `String`        | Yes      | -         | Label "จาก"                        |
| `fromValue`           | `String`        | Yes      | -         | ค่า "จาก"                          |
| `mobileLabel`         | `String`        | Yes      | -         | Label "เบอร์โทร"                   |
| `mobileValue`         | `String`        | Yes      | -         | ค่า "เบอร์โทร"                     |
| `toLabel`             | `String`        | Yes      | -         | Label "ถึง"                        |
| `toValue`             | `String`        | Yes      | -         | ค่า "ถึง"                          |
| `accountNameLabel`    | `String`        | Yes      | -         | Label "ชื่อบัญชี"                  |
| `accountNameValue`    | `String`        | Yes      | -         | ค่า "ชื่อบัญชี"                    |
| `accountNumberLabel`  | `String`        | Yes      | -         | Label "เลขบัญชี"                   |
| `accountNumberValue`  | `String`        | Yes      | -         | ค่า "เลขบัญชี"                     |
| `objectLabel`         | `String`        | Yes      | -         | Label "วัตถุประสงค์"               |
| `objectValue`         | `String`        | Yes      | -         | ค่า "วัตถุประสงค์"                 |
| `confirmButtonText`   | `String`        | No       | 'Confirm' | ข้อความบนปุ่มยืนยัน                |
| `onConfirm`           | `VoidCallback?` | No       | null      | Callback เมื่อกดปุ่มยืนยัน         |
| `onClose`             | `VoidCallback?` | No       | null      | Callback เมื่อกดปุ่มปิด            |

## 🎨 Design Tokens Used

### Colors
- `fill/base/100` - Drawer background
- `fill/base/300` - Object value container background
- `text/base/600` - Text color
- `warning/600` - Warning background (from AnnouncementWarning)
- `success/500` - Total amount color (from CardReviewTransaction)

### Typography
- **Header Title**: 15px, weight 600, line-height 1.51
- **Object Label**: 15px, weight 600, line-height 1.51
- **Object Value**: 13px, weight 600, line-height 1.23

### Spacing
- Header padding: 16px horizontal, 16px vertical
- Content padding: 16px horizontal
- Footer padding: 16/8/16/40
- Component gaps: 16px, 8px

## 🔄 Component Composition

```
DrawerReviewTransaction
├── Header
│   ├── Spacer (24px)
│   ├── Title ("Review")
│   └── Close Button (Icon)
├── Content (Scrollable)
│   ├── AnnouncementWarning
│   ├── CardReviewTransaction
│   ├── Object Label
│   └── Object Value Container
└── Footer
    └── Confirm Button (Primary)
```

## 🧪 Preview

รันตัวอย่างพร้อมสลับธีมได้ที่:

```bash
flutter run lib/widgets/drawer/preview_drawer_review_transaction.dart
```

## 📱 Material Design Compliance

Widget นี้ปฏิบัติตาม Material Design guidelines สำหรับ bottom sheets:
- Modal bottom sheet behavior
- **Swipe to dismiss** (disabled)
- **Tap outside to dismiss** (disabled)
- Backdrop overlay
- Rounded top corners
- Fixed height (75% of screen)
- Scrollable content

## ⚠️ Notes & Recommendations

1. **Height**: ใช้ 75% ของหน้าจอ เหมาะสำหรับเนื้อหาปานกลาง
2. **Scrollable**: เนื้อหาภายใน scroll ได้ รองรับข้อมูลยาว
3. **Theme Support**: รองรับ light/dark mode อัตโนมัติ
4. **Reusable Components**: ใช้ AnnouncementWarning, CardReviewTransaction, Buttons
5. **Dismiss Behavior**: ปิดได้เฉพาะจาก X button เท่านั้น (ไม่สามารถ swipe หรือ tap outside) - เหมาะสำหรับ critical review flow
6. **Localization**: ควร localize ทุก label และข้อความ

## 💡 Usage Tips

### With Localization

```dart
final l10n = AppLocalizations.of(context)!;

DrawerReviewTransaction.show(
  context,
  warningTitle: l10n.transferDrawerWarningTitleRecheckInfo,
  warningDescription: l10n.transferDrawerWarningInfoPreventFraud,
  totalAmount: '5,000.00',
  fromLabel: l10n.transferDrawerDetailFrom,
  // ... other localized properties
);
```

### Custom Confirmation Logic

```dart
DrawerReviewTransaction.show(
  context,
  // ... properties
  onConfirm: () async {
    Navigator.pop(context);
    
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
    
    // Process transaction
    await processTransaction();
    
    // Close loading
    Navigator.pop(context);
    
    // Show success
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Transaction successful!')),
    );
  },
);
```

## 🔧 Customization

### Change Height Ratio

```dart
// In drawer_review_transaction.dart
height: screenHeight * 0.80, // Change from 0.75 to 0.80 (80%)
```

### Add Custom Widgets

```dart
// Add custom widgets in the content section
Column(
  children: [
    AnnouncementWarning(...),
    const SizedBox(height: 16),
    // Add your custom widget here
    CustomWidget(),
    const SizedBox(height: 16),
    CardReviewTransaction(...),
    // ...
  ],
)
```

## 🔗 Related Widgets

- `AnnouncementWarning` - Warning message component
- `CardReviewTransaction` - Transaction details card
- `Buttons` - Primary button component
- `DrawerBalanceDetail` - Similar drawer pattern (but with restricted dismiss behavior)

## 🆚 Comparison with DrawerBalanceDetail

| Feature                  | DrawerReviewTransaction | DrawerBalanceDetail      |
|--------------------------|-------------------------|-------------------------|
| **Purpose**              | Review transaction      | Show balance breakdown   |
| **Warning**              | Title + description     | Simple text (no title)   |
| **Main Content**         | Transaction card        | Balance card             |
| **Button**               | Confirm (action)        | OK (dismiss)             |
| **Image**                | No image                | Fixed asset (144px)      |
| **Dismiss Behavior**     | Button only             | Button only              |
| **Use Case**             | Confirmation flow       | Information display      |

## 📊 Use Cases

1. **Transfer Confirmation** - ยืนยันการโอนเงิน
2. **Payment Review** - ตรวจสอบการชำระเงิน
3. **Transaction Summary** - สรุปรายการธุรกรรม
4. **Bill Payment** - ชำระบิล

---

**Based on Figma Design**: Component ถูกสร้างตาม Figma spec node `state=review_transfer` ใน New Wi Wallet 2.0 design system
