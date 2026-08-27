# Receipt

## Metadata

- Component slug: `receipt`
- Figma component set: `Receipt`
- Figma file key: `mhUvPg9tOjlvQvEW6glQhJ`
- Figma node: `961:2772`
- Source: uSpec Extract plugin `2.5.0`
- Supported modes: `Light`, `Dark`
- Input: `transaction-succes_base.json`

## Overview

`Receipt` is a vertical transaction summary component with receipt and transaction-success variants. The extracted default variant is `Property=Transaction Success`. The component presents confirmation, transaction type, amount and fee information, sender/recipient details, date/time, transaction references, and footer guidance.

## Variant axes

| Property | Values | Default |
| --- | --- | --- |
| `Property` | `Receipt`, `Transaction Success` | `Transaction Success` |

## API

The extraction exposes one variant property and no boolean, instance-swap, or consumer slot properties.

| Property | Type | Values | Default |
| --- | --- | --- | --- |
| `Property` | variant | `Receipt` \| `Transaction Success` | `Transaction Success` |

## Structure

### Root dimensions (default variant)

| Dimension | Value | Token / provenance |
| --- | ---: | --- |
| Width | 343 | measured |
| Height | 546 | measured |
| Padding | 16 | `spacing/sm` |
| Item spacing | 16 | `space-16` |
| Corner radius | 12 | measured |
| Stroke | 1 | measured |
| Layout | Vertical, fixed width, hug height | measured |

### Anatomy

```text
Receipt
├── bg (decorative frame)
└── contents (decorative layout frame)
    ├── Header / transaction confirmation
    ├── Transaction information
    ├── Amount and fee information
    ├── From information
    ├── To information
    ├── Date and transaction information
    └── Footer guidance
```

The `Receipt` variant has the same width (`343`) and padding (`16`), with an extracted height of `470`. Its contents frame is `311 × 438`; the transaction-success default contents frame is `311 × 514`.

## Color

Color evidence is derived from the extracted Figma `colorWalk` and semantic variables. The source reports the `Colors semantic` collection in both `Light` and `Dark` modes.

| Semantic token evidence | Usage |
| --- | --- |
| `Background/Primary` | Receipt surface/background |
| `Border/Primary` | Root and divider borders |
| `Content/Primary` | Primary text and amount |
| `Content/Neutral` | Supporting text |
| `Core/black` | Watermark/decorative strokes |
| `State/success` | Transaction-success status treatment |
| `text/base/400`, `text/base/600` | Text hierarchy |

The extractor warns that 25 raw-hex entries inside crossed instance boundaries were dropped; tokened entries were preserved. Re-extract if exact nested-instance color snapshots are required.

## Voice and accessibility

- Treat the receipt as a read-only transaction summary.
- Expose the confirmation heading before transaction details.
- Read amount and transaction type before sender/recipient details.
- Group date/time and transaction/reference IDs as related information.
- Preserve the logical order of the visual receipt; decorative `bg` content should not create an additional focus stop.
- Localize all user-facing strings and format currency, date/time, and identifiers according to the consumer locale.

Extracted text examples include `Transaction Confirmed`, `Transfer`, `From`, `To`, `Amount`, `Date&Time:`, `Transaction ID:`, `Ref 1:`, `Ref 2:`, and footer guidance. These are extraction examples, not hardcoded runtime copy requirements.

## Known gaps and provenance

- No interactive states, boolean properties, or consumer slots were extracted.
- `bg` and `contents` are classified as decorative non-instance frames.
- Exact nested instance colors are incomplete where the extractor crossed instance boundaries.
- This document is generated from the provided base JSON and extracted evidence; it does not invent values absent from the source.

<!-- render-meta: schemaVersion=1; sectionTargets=0/0; groupTargets=0/0 -->
