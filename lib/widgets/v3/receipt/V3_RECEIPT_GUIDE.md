# V3 Receipt Guide

`V3Receipt` is the V3 tokenized implementation of the legacy
`ReceiptImageComponent`. It preserves the Payment header, sender/recipient
rows, amount and QR section, transaction details, footer notes, responsive QR
layout, and caller-controlled asset overrides.

## Usage

```dart
V3Receipt(
  amount: '5,000.00 THB',
  fee: 'Fees 5.00 THB',
  senderName: sender.name,
  senderAccount: sender.maskedAccount,
  merchantName: recipient.name,
  merchantAccount: recipient.maskedAccount,
  dateTime: formattedDateTime,
  transactionId: transaction.id,
  merchantRefId: transaction.merchantReference,
  billerId: transaction.billerId,
  ref1: transaction.referenceOne,
  footerNoteOne: l10n.receiptFooter,
  footerNoteTwo: l10n.receiptSupport,
)
```

## Public API

- `transactionDetailRowCount` shows 0–7 detail rows; empty `ref2` and `ref3` fall back to `ref1`.
- `senderLogoAssetPath`, `merchantLogoAssetPath`, `qrAssetPath`, `backgroundSvgAssetPath`, `backgroundImageUrl`, and `headerLogoAssetPath` preserve the legacy asset customization points.
- Default assets use the existing SCB, QR, receipt background, and Wi Wallet files.

## Theme and accessibility

- All widget colors come from `V3ThemeScope.colorsOf(context)` semantic tokens.
- Spacing, typography, radius, and elevation use V3 APIs.
- The receipt is a read-only semantic container. Caller text should be localized and account/transaction values masked.
- The widget supports Light/Dark themes and text scaling without a fixed outer width.

## V3 Metadata

```yaml
Theme system: V3
Widget: V3Receipt
Category: receipt
Source: lib/widgets/v3/receipt/v3_receipt.dart
Preview: lib/widgets/v3/receipt/preview_v3_receipt.dart
Test: test/widgets/v3/receipt/v3_receipt_test.dart
Semantic tokens:
  - background/primary
  - background/white
  - border/primary
  - border/secondary
  - content/primary
  - content/secondary
  - content/extension/navy
```
