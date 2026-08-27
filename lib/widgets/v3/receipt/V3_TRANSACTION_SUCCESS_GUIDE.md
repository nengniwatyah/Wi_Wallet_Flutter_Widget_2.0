# V3 Transaction Success Guide

## Usage

`V3TransactionSuccess` is a read-only, localized transaction-success summary. Pass every visible string from the caller so the consuming app owns localization, currency formatting, date formatting, and sensitive-data masking.

```dart
V3TransactionSuccess(
  amount: '5,000.00 THB',
  fee: '5.00 THB',
  amountLabel: l10n.amount,
  feeLabel: l10n.fees,
  senderLabel: l10n.from,
  senderName: sender.name,
  senderAccount: sender.maskedAccount,
  merchantLabel: l10n.to,
  merchantName: recipient.name,
  merchantAccount: recipient.maskedAccount,
  dateTimeLabel: l10n.dateTime,
  dateTime: formattedDateTime,
  transactionIdLabel: l10n.transactionId,
  transactionId: transaction.id,
  merchantRefIdLabel: l10n.merchantReference,
  merchantRefId: transaction.merchantReference,
  billerIdLabel: l10n.billerId,
  billerId: transaction.billerId,
  ref1Label: l10n.referenceOne,
  ref1: transaction.referenceOne,
  footerNoteOne: l10n.receiptFooter,
  footerNoteTwo: l10n.receiptSupport,
)
```

## Public API

- `V3TransactionSuccessProperty.receipt` and `.transactionSuccess` select the Figma `Property` axis.
- Required fields mirror `ReceiptComponent`: amount, fee, sender, merchant, date/time, transaction ID, references, and both footer lines.
- `transactionDetailRowCount` controls the visible detail rows from 0 to 7; empty `ref2`/`ref3` fall back to `ref1`, matching the legacy behavior.
- Optional `checkIcon`, `senderLogo`, `merchantLogo`, `qrCode`, and `background` provide visual content without coupling the widget to an asset package.

## Theme and layout

- Uses `V3ThemeScope.colorsOf(context)` for semantic Light/Dark colors.
- Uses `V3Spacing`, `V3Radii`, and `V3PrimitiveShadows`; no legacy theme APIs are imported.
- Displays the recipient account below the recipient name with the same typography and semantic color tokens as the sender account.
- Default Figma geometry is 343px wide with 16px padding, 16px section spacing, and 12px radius. The widget remains width-responsive and text can wrap.

## Accessibility

- The receipt is exposed as a read-only semantic container.
- Decorative backdrop content is ignored by accessibility services.
- Text is supplied by the caller and should be localized.
- Keep transaction IDs and account values readable; mask sensitive values before passing them to the widget.
- Validate at the consuming app's supported text scale and screen-reader language.

## V3 Metadata

```yaml
Theme system: V3
Widget: V3TransactionSuccess
Category: receipt
Source: lib/widgets/v3/receipt/v3_transaction_success.dart
Preview: lib/widgets/v3/receipt/preview_v3_transaction_success.dart
Test: test/widgets/v3/receipt/v3_transaction_success_test.dart
Semantic tokens:
  - background/primary
  - border/primary
  - content/primary
  - content/secondary
  - state/success
```
