# Card Review Transaction Widget

Transaction review card component for displaying transfer details.

## 📋 Overview

A card component that displays transaction review information including total amount, fee, and transfer details (from/to accounts).

## 🎨 Design Specs

**From Figma:**
- Component: `state=reviewTransaction`
- Layout width: expands to available width (`double.infinity`). Figma mock uses 343px for reference.
- Padding: 16px
- Gap: 16px
- Border Radius: 12px
- Background: `fill/base/300`

## 📦 Import

```dart
import 'package:mcp_test_app/widgets/card/card_review_transaction.dart';
```

## 🚀 Usage

### Basic Example

```dart
CardReviewTransaction(
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
)
```

### With Localization

```dart
final l10n = AppLocalizations.of(context)!;

CardReviewTransaction(
  totalAmount: l10n.cardReviewTotalAmountMock,
  feeAmount: l10n.cardReviewFeeAmountMock,
  currency: l10n.cardReviewCurrencyMock,
  fromLabel: l10n.cardReviewFromLabel,
  fromValue: l10n.cardReviewFromValueMock,
  mobileLabel: l10n.cardReviewMobileLabel,
  mobileValue: l10n.cardReviewMobileValueMock,
  toLabel: l10n.cardReviewToLabel,
  toValue: l10n.cardReviewToValueMock,
  accountNameLabel: l10n.cardReviewAccountNameLabel,
  accountNameValue: l10n.cardReviewAccountNameValueMock,
  accountNumberLabel: l10n.cardReviewAccountNumberLabel,
  accountNumberValue: l10n.cardReviewAccountNumberValueMock,
);
```

## 🎯 Properties

| Property | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| totalAmount | String | Yes | - | Total transaction amount |
| feeAmount | String | No | '0.00' | Transaction fee amount |
| currency | String | No | 'THB' | Currency code |
| fromLabel | String | Yes | - | "From" label text |
| fromValue | String | Yes | - | Source account/wallet name |
| mobileLabel | String | Yes | - | "Mobile Number" label text |
| mobileValue | String | Yes | - | Mobile phone number |
| toLabel | String | Yes | - | "To" label text |
| toValue | String | Yes | - | Destination bank name |
| accountNameLabel | String | Yes | - | "Account Name" label text |
| accountNameValue | String | Yes | - | Recipient account name |
| accountNumberLabel | String | Yes | - | "Account Number" label text |
| accountNumberValue | String | Yes | - | Recipient account number |

## 🎨 Design Tokens Used

### Colors
- `fill/base/300` - Card background
- `text/base/600` - Primary text color
- `success/500` - Total amount color (green)
- `stroke/base/200` - Divider color

### Typography
- **Total Label:** 15px, SemiBold, line-height 1.51
- **Total Amount:** 22px, Bold, line-height 1.27
- **Fee & Details:** 13px, SemiBold, line-height 1.23

### Spacing
- Card padding: 16px
- Section gap: 16px
- Detail row gap: 16px
- Border radius: 12px

## 🌍 Localization Keys

Add these keys to your ARB files:

```json
{
  "cardReviewPreviewTitle": "Card Review Transaction Preview",
  "cardReviewTotalLabel": "Total",
  "cardReviewTotalAmountMock": "5,000.00",
  "cardReviewCurrencyMock": "THB",
  "cardReviewFeeLabel": "Fee",
  "cardReviewFeeAmountMock": "0.00",
  "cardReviewFromLabel": "From",
  "cardReviewFromValueMock": "Your Wi Wallet",
  "cardReviewMobileLabel": "Mobile Number",
  "cardReviewMobileValueMock": "081-141-1234",
  "cardReviewToLabel": "To",
  "cardReviewToValueMock": "Siam Commercial Bank",
  "cardReviewAccountNameLabel": "Account Name",
  "cardReviewAccountNameValueMock": "Victor Von Doom",
  "cardReviewAccountNumberLabel": "Account Number",
  "cardReviewAccountNumberValueMock": "1234567890"
}
```

ไฟล์ preview (`lib/widgets/card/preview_card_review_transaction.dart`) ดึงค่า mock ชุดนี้ผ่าน `AppLocalizations` เพื่อให้สลับภาษาได้ทันที

## ✨ Features

- ✅ Theme-aware (Light/Dark mode)
- ✅ Responsive design
- ✅ Consistent with design tokens
- ✅ Noto Sans Thai font support
- ✅ Flexible text wrapping
- ✅ Clean dividers between sections

## 📱 Layout Structure

```
CardReviewTransaction
├── Total Section
│   ├── "Total" label
│   ├── Amount (green, bold)
│   └── Fee row (Fee + amount + currency)
├── Divider
└── Details Section
    ├── From row
    ├── Mobile Number row
    ├── Divider
    ├── To row
    ├── Account Name row
    └── Account Number row
```

## 🎯 Use Cases

1. **Transfer Confirmation** - Show transaction details before confirmation
2. **Transaction Review** - Display completed transaction summary
3. **Payment Summary** - Show payment breakdown

## 💡 Tips

1. **Amount Formatting:** Use NumberFormat for proper currency formatting
2. **Long Text:** Widget handles text wrapping automatically
3. **Localization:** All labels should be localized
4. **Theme:** Automatically adapts to light/dark mode

## 🔧 Customization

### Change Amount Color

Modify the `success/500` token in `theme_color.dart`:

```dart
'success/500': _hex('#YOUR_COLOR'),
```

### Adjust Spacing

Modify the `SizedBox` heights in the widget:

```dart
const SizedBox(height: 16), // Change to your preferred spacing
```

### Custom Font

Replace `GoogleFonts.notoSansThai` with your preferred font:

```dart
style: GoogleFonts.yourFont(
  fontSize: 13,
  fontWeight: FontWeight.w600,
)
```

## 🧪 Testing

Run the preview:

```bash
flutter run lib/widgets/card/preview_card_review_transaction.dart
```

## 📝 Example with Number Formatting

```dart
import 'package:intl/intl.dart';

final formatter = NumberFormat('#,##0.00');
final amount = 5000.00;

CardReviewTransaction(
  totalAmount: formatter.format(amount),
  // ... other properties
)
```

## 🎨 Theme Integration

The widget automatically uses:
- Current theme brightness (light/dark)
- Design tokens from `ThemeColors`
- Noto Sans Thai font for Thai language support

## ⚠️ Important Notes

1. **Width:** Expands to fit its parent (`double.infinity`). Apply `SizedBox`/`ConstrainedBox` if you need a fixed 343px layout like the mock.
2. **Font:** Uses Noto Sans Thai for proper Thai character rendering
3. **Colors:** All colors use design tokens for consistency
4. **Responsive:** Text wraps automatically for long content
5. **Labels:** "Total" and "Fee" remain hard-coded in English; localize by cloning the widget or submitting an enhancement if required.
6. **Reusable Component:** Used in `DrawerReviewTransaction` for transaction confirmation flow

## 🔗 Related Widgets

- `DrawerReviewTransaction` - Uses this card for transaction review
- `AnnouncementWarning` - Warning message component
- `FullAmountInput` - For amount input
- `MobileCodeInput` - For mobile number input

## 🆚 Usage Context

### In DrawerReviewTransaction

```dart
// CardReviewTransaction is embedded in the drawer
DrawerReviewTransaction.show(
  context,
  // ... warning properties
  totalAmount: '5,000.00',
  feeAmount: '0.00',
  currency: 'THB',
  fromLabel: 'From',
  fromValue: 'Your Wi Wallet',
  // ... other transaction details
);
```

The card is displayed within a scrollable drawer at 75% screen height, combined with:
- AnnouncementWarning (top)
- CardReviewTransaction (middle)
- Object label/value (bottom)
- Confirm button (footer)

---

**Made with ❤️ following Wi Wallet design system**
