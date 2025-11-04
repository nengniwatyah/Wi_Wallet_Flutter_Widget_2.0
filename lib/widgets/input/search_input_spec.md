# SearchInput Widget Specification

## Overview
`SearchInput` เป็น custom Flutter widget สำหรับรับ input การค้นหา พร้อม visual feedback แบบ real-time รองรับทั้ง dark และ light mode

https://www.figma.com/design/D7WVaC8n3foVLo6S3HuPn8/New-Wi-Wallet-2.0?node-id=7066-6064&t=sYCnD6dsF9QpTyn1-4

## Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_svg: ^2.0.0
  google_fonts: ^6.0.0
```

## Required Assets
- `lib/assets/images/search-02.svg` - ไอคอนสำหรับการค้นหา
- `lib/assets/images/cancel-circle.svg` - ไอคอนสำหรับปุ่ม clear

## Theme System Requirements
Widget ต้องการ `ThemeColors` helper class ที่รองรับ color tokens ดังนี้:

### Dark Mode Colors
- `fill/base/300`: #1A1A1A (background)
- `stroke/base/200`: #4A4A4A (border default)
- `stroke/base/600`: #787878 (search icon)
- `text/base/400`: #ffffff73 (placeholder)
- `text/base/600`: #FFFFFF (active text)
- `primary/400`: สี border เมื่อ focus

### Light Mode Colors
- `fill/base/300`: #F5F5F5 (background)
- `stroke/base/200`: border default
- `stroke/base/600`: search icon
- `text/base/400`: placeholder
- `text/base/600`: active text
- `primary/400`: สี border เมื่อ focus

## Properties

### Input Parameters
| Property | Type | Required | Default | Description |
|----------|------|----------|---------|-------------|
| `controller` | `TextEditingController?` | No | `null` | Controller สำหรับควบคุม TextField |
| `initialValue` | `String?` | No | `''` | ค่าเริ่มต้นของ input |
| `onChanged` | `ValueChanged<String>?` | No | `null` | Callback เมื่อค่าใน input เปลี่ยน |

## Features

### 1. Search Icon
- แสดงไอคอน search-02 ด้านซ้าย input เสมอ
- ขนาด 16×16px
- สี (default): `stroke/base/600`
- สี (focus): `text/base/600` (#FFFFFF dark mode, #0F0F0F light mode)

### 2. Clear Button
- แสดงไอคอน cancel-circle เมื่อมีข้อความใน input
- กดเพื่อลบข้อความทั้งหมด
- ซ่อนอัตโนมัติเมื่อไม่มีข้อความ
- ขนาด 16×16px
- สี: `stroke/base/600`

### 3. Input Field
- รับข้อความทุกประเภท
- Placeholder: "Search"
- Font: Noto Sans Thai, 15px, line-height 1.33

### 3. State Management

#### Default State
- Border: `stroke/base/200`
- Background: `fill/base/300`
- Search icon: `stroke/base/600`
- Placeholder: `text/base/400`
- Clear button: ซ่อน

#### Focus State (คลิกที่ input)
- Border: `primary/400`
- Search icon: `text/base/600`
- Cursor: `text/base/600`

#### Has Text State (กรอกข้อความ)
- Input text: `text/base/600`
- Clear button: แสดง

## Usage Examples

### Basic Usage
```dart
SearchInput(
  onChanged: (value) {
    print('Search: $value');
  },
)
```

### With Controller
```dart
final controller = TextEditingController();

SearchInput(
  controller: controller,
  onChanged: (value) {
    print('Search: $value');
  },
)
```

### With Initial Value
```dart
SearchInput(
  initialValue: 'keyword',
  onChanged: (value) {
    print('Search: $value');
  },
)
```

## Dimensions
- Input height: 44px
- Input padding: 12px
- Border radius: 8px
- Border width: 1px
- Gap between icon and text: 8px
- Icon size: 16×16px

## Typography
- Font family: Noto Sans Thai (Google Fonts)
- Input text size: 15px (line height: 1.33)

## Behavior Flow

### User Interaction Flow
1. **Initial State**: Input ว่าง, border และ text เป็นสีปกติ, ไม่มี clear button
2. **Click Input**: Border เปลี่ยนเป็นสี `primary/400`, search icon เปลี่ยนเป็นสี `text/base/600`
3. **Type Text**: Text เปลี่ยนเป็นสี `text/base/600`, clear button ปรากฏ
4. **Click Clear**: ข้อความถูกลบ, clear button หายไป, เรียก `onChanged('')`
5. **Click Outside**: Border กลับเป็นสีปกติ, search icon กลับเป็นสี `stroke/base/600`

## Integration Checklist
- [ ] ติดตั้ง dependencies: `flutter_svg`, `google_fonts`
- [ ] เพิ่ม search-02.svg และ cancel-circle.svg ใน assets
- [ ] สร้าง ThemeColors helper class พร้อม color tokens
- [ ] กำหนด theme colors สำหรับ dark และ light mode
- [ ] Import SearchInput widget
- [ ] ทดสอบการทำงานใน dark/light mode
- [ ] ทดสอบ clear button และ icon color changes

## Notes
- Widget รองรับ responsive width (ใช้ `double.infinity`)
- รองรับ Thai language ด้วย Noto Sans Thai font
- Memory management: dispose controllers และ listeners อัตโนมัติ
