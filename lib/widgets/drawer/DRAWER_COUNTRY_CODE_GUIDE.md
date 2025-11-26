# DrawerCountryCode Widget

Bottom sheet drawer for country code selection with search functionality.

## 📋 Overview

`DrawerCountryCode` เป็น bottom sheet drawer ที่แสดงรายการประเทศพร้อมรหัสโทรศัพท์ มีฟีเจอร์ค้นหาและแสดง empty state เมื่อไม่พบผลลัพธ์

## 🎨 Design Specs (Based on Figma)

https://www.figma.com/design/D7WVaC8n3foVLo6S3HuPn8/New-Wi-Wallet-2.0?node-id=7066-12739

### Layout
- **Height**: 80% ของหน้าจอ (0.80 * screen height)
- **Border Radius**: 16px (top corners only)
- **Background**: `fill/base/100`
- **Padding**: 16px all sides

### States
1. **Default State** - แสดงรายการประเทศ
2. **Empty State** - แสดงเมื่อไม่พบผลการค้นหา

### Components Structure
1. **Header** (16px padding)
   - Title: "Mobile Number" (center aligned)
   - Close Button (right aligned)
   - Font: Noto Sans Thai, 15px, weight 600, line-height 1.51

2. **Search Bar** (reused SearchInput widget)
   - 8px gap from header
   - Full width with 16px horizontal padding

3. **Content** (Scrollable)
   - **Default**: List of country items
     - Layout: Flag (32x24) > Code > Name
     - Each item: 12px padding, 12px radius
     - Background: `fill/base/300`
     - Border: `stroke/base/200`
     - 8px gap between items
   - **Empty**: Empty state display (96px from search input)
     - Search_Empty.png image (144px width)
     - 16px gap to title
     - Title: i18n `noResultsFound` (22px, weight 600)
     - 4px gap to description
     - Description: i18n `pleaseTryAgain` (15px, weight 400)

## 📦 Import

```dart
import 'package:mcp_test_app/widgets/drawer/drawer_country_code.dart';
```

## 🚀 Usage

### Define Country Data

```dart
final countries = [
  CountryCode(
    name: 'Thailand',
    code: '+66',
    flagAsset: 'lib/assets/images/flag_th.svg',
  ),
  CountryCode(
    name: 'United States',
    code: '+1',
    flagAsset: 'lib/assets/images/flag_us.svg',
  ),
];
```

### Show Drawer

```dart
DrawerCountryCode.show(
  context,
  title: 'Mobile Number',
  countries: countries,
  onCountrySelected: (country) {
    print('Selected: ${country.name} ${country.code}');
  },
  onClose: () {
    print('Drawer closed');
  },
);
```

## 🌟 Behaviour

- แสดงเป็น modal bottom sheet จากด้านล่างของหน้าจอ
- ความสูงคงที่ 80% ของหน้าจอ
- **ปิดได้เฉพาะจากปุ่ม X เท่านั้น** (isDismissible: false, enableDrag: false)
- กดนอก area หรือ swipe down จะไม่มีผลอะไร
- Background มืดโปร่งใสด้านหลัง drawer พร้อม 10px blur effect
- Search แบบ real-time (ค้นหาทั้งชื่อประเทศและรหัส)
- แสดง empty state เมื่อไม่พบผลการค้นหา
- เลือกประเทศแล้วปิด drawer อัตโนมัติ

## 🎯 Properties

### CountryCode Model

| Property    | Type     | Required | Description           |
|-------------|----------|----------|-----------------------|
| `name`      | `String` | Yes      | ชื่อประเทศ            |
| `code`      | `String` | Yes      | รหัสโทรศัพท์ (เช่น +66) |
| `flagAsset` | `String` | Yes      | Path ของรูปธงชาติ     |

### DrawerCountryCode Widget

| Property              | Type                        | Required | Default | Description                    |
|-----------------------|-----------------------------|----------|---------|--------------------------------|
| `title`               | `String`                    | Yes      | -       | หัวข้อของ drawer               |
| `countries`           | `List<CountryCode>`         | Yes      | -       | รายการประเทศทั้งหมด           |
| `onCountrySelected`   | `Function(CountryCode)?`    | No       | null    | Callback เมื่อเลือกประเทศ     |
| `onClose`             | `VoidCallback?`             | No       | null    | Callback เมื่อกดปุ่มปิด        |

## 🎨 Design Tokens Used

### Colors
- `fill/base/100` - Drawer background
- `fill/base/300` - Country item background
- `text/base/600` - Primary text (title, country name)
- `text/base/400` - Secondary text (country code, empty description)
- `stroke/base/200` - Country item border

### Typography
- **Header Title**: 15px, weight 600, line-height 1.51
- **Country Name**: 15px, weight 400, line-height 1.33
- **Country Code**: 15px, weight 400, line-height 1.33
- **Empty Title**: 22px, weight 600, line-height 1.51
- **Empty Description**: 15px, weight 400, line-height 1.33

### Spacing
- Header padding: 16px all sides
- Search bar gap: 16px from header
- Country item padding: 12px all sides
- Country item gap: 8px between items
- Content padding: 16px horizontal

## 🔄 Component Composition

```
DrawerCountryCode
├── Backdrop (blur + overlay)
└── Container (80% height)
    ├── Header
    │   ├── Invisible Icon (spacing)
    │   ├── Title (center)
    │   └── Close Button (right)
    ├── SearchInput (reused widget)
    └── Content (Scrollable)
        ├── Default State
        │   └── ListView of Country Items
        └── Empty State
            ├── Search_Empty.png
            ├── Empty Title
            └── Empty Description
```

## 🧪 Preview

รันตัวอย่างพร้อมสลับธีมได้ที่:

```bash
flutter run lib/widgets/drawer/preview_drawer_country_code.dart
```

### Preview Features
- ✅ Theme switching (light/dark mode)
- ✅ 50 mock countries for scroll testing
- ✅ Styled button with ThemeColors (`primary/400`, `text/contrast/600`)
- ✅ SnackBar feedback on selection
- ✅ Empty state testing (search for non-existent country)

## 📱 Material Design Compliance

Widget นี้ปฏิบัติตาม Material Design guidelines สำหรับ bottom sheets:
- Modal bottom sheet behavior
- **No swipe to dismiss** (requires explicit button action)
- **No tap outside to dismiss** (requires explicit button action)
- Backdrop overlay with blur effect
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
        color: ThemeColors.get(brightnessKey, 'fill/base/100').withValues(alpha: 0.9),
      ),
    ),
  ),
```

## ⚠️ Notes & Recommendations

1. **Height**: ใช้ 80% ของหน้าจอ เหมาะสำหรับรายการปานกลาง
2. **Search**: ค้นหาแบบ real-time ทั้งชื่อและรหัสประเทศ
3. **Empty State**: แสดงอัตโนมัติเมื่อไม่พบผลการค้นหา
4. **Theme Support**: รองรับ light/dark mode อัตโนมัติ
5. **Reused Components**: ใช้ SearchInput widget สำหรับ search bar
6. **Dismiss Behavior**: ปิดได้เฉพาะจากปุ่ม X หรือเลือกประเทศเท่านั้น
7. **Localization**: ควร localize title และ empty state messages
8. **Flag Assets**: ต้องเตรียมรูปธงชาติสำหรับแต่ละประเทศ

## 🌐 Localization Support

Widget รองรับ i18n สำหรับ empty state messages:

### Localization Keys

| Key                | EN                  | TH                    | ZH           | RU                          | MY                  |
|--------------------|---------------------|-----------------------|--------------|-----------------------------|-----------------|
| `noResultsFound`   | No results found    | ไม่พบผลการค้นหา       | 未找到结果    | Результаты не найдены       | ရလဒ်မတွေ့ရှိပါဘူး |
| `pleaseTryAgain`   | Please try again    | กรุณาลองใหม่อีกครั้ง  | 请再试一次    | Пожалуйста, попробуйте еще раз | အမှန်အတွက် တွင်းတွင်းပါ |

### Usage with Localization

```dart
final l10n = AppLocalizations.of(context)!;

DrawerCountryCode.show(
  context,
  title: l10n.mobileNumberPlaceholder,
  countries: countries,
  onCountrySelected: (country) {
    // Handle selection
  },
);
```

### Dynamic Country List

```dart
// Load from API or local data
final countries = await loadCountries();

DrawerCountryCode.show(
  context,
  title: 'Select Country',
  countries: countries,
  onCountrySelected: (country) {
    setState(() {
      selectedCountry = country;
    });
  },
);
```

### Integration with MobileCodeInput

```dart
MobileCodeInput(
  countryCode: selectedCountry?.code ?? '+66',
  flagAsset: selectedCountry?.flagAsset ?? 'lib/assets/images/flag_th.svg',
  onCountryCodeTap: () {
    DrawerCountryCode.show(
      context,
      title: 'Mobile Number',
      countries: countries,
      onCountrySelected: (country) {
        setState(() {
          selectedCountry = country;
        });
      },
    );
  },
);
```

## 🔧 Customization

### Change Height Ratio

```dart
// In drawer_country_code.dart
height: screenHeight * 0.80, // Change from 0.75 to 0.80 (80%)
```

### Empty State Spacing

```dart
// Modify _buildEmptyState method spacing
Padding(
  padding: const EdgeInsets.only(top: 96), // 96px from search input
  child: Column(
    children: [
      Image.asset('lib/assets/images/Search_Empty.png', width: 144),
      const SizedBox(height: 16), // Gap between image and text
      Text(
        AppLocalizations.of(context)!.noResultsFound,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: ThemeColors.get(brightnessKey, 'text/base/600'),
        ),
      ),
      const SizedBox(height: 4), // Gap between title and description
      Text(
        AppLocalizations.of(context)!.pleaseTryAgain,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: ThemeColors.get(brightnessKey, 'text/base/400'),
        ),
      ),
    ],
  ),
)
```

### Add Country Sorting

```dart
@override
void initState() {
  super.initState();
  _filteredCountries = widget.countries
    ..sort((a, b) => a.name.compareTo(b.name));
}
```

## 🔗 Related Widgets

- `SearchInput` - Search bar component (reused)
- `MobileCodeInput` - Mobile number input with country code
- `DrawerBalanceDetail` - Balance detail drawer
- `DrawerReviewTransaction` - Transaction review drawer

## 📊 Use Cases

1. **Country Code Selection** - เลือกรหัสประเทศสำหรับเบอร์โทรศัพท์
2. **Phone Number Input** - ใช้ร่วมกับ MobileCodeInput
3. **International Calling** - เลือกประเทศปลายทาง
4. **Registration Forms** - เลือกประเทศในฟอร์มลงทะเบียน

## 🆚 Comparison with Other Drawers

| Feature                  | DrawerCountryCode        | DrawerBalanceDetail     | DrawerReviewTransaction |
|--------------------------|--------------------------|-------------------------|-------------------------|
| **Purpose**              | Country selection        | Balance breakdown       | Transaction review      |
| **Search**               | Yes (SearchInput)        | No                      | No                      |
| **Empty State**          | Yes (with image)         | No                      | No                      |
| **List Items**           | Selectable countries     | Static info             | Static info             |
| **Dismiss Behavior**     | Button + selection       | Button only             | Button + swipe/tap      |
| **Height**               | 80%                      | 80%                     | 80%                     |

---

**Based on Figma Design**: Component ถูกสร้างตาม Figma spec node `CountryCodeList` (state=default, state=empty) ใน New Wi Wallet 2.0 design system
