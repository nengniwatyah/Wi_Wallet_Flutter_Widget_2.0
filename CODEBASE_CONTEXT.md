# Flutter Test App - Codebase Context

## 📋 ภาพรวมโปรเจค

**ชื่อโปรเจค:** test_app  
**เวอร์ชัน:** 1.0.0+1  
**Flutter SDK:** ^3.7.2  
**ประเภท:** Multi-platform Flutter Application (iOS, Android, Web, macOS, Linux, Windows)

## 🎯 จุดประสงค์

แอปพลิเคชัน Flutter ที่รองรับหลายภาษา (i10n) และหลาย theme (light/dark mode) พร้อมระบบ UI components ที่ออกแบบมาสำหรับแอปพลิเคชันทางการเงิน

## 📁 โครงสร้างโปรเจค

```
lib/
├── assets/              # ไฟล์ assets (icons, images)
├── config/              # การตั้งค่า theme และ constants
├── core/                # Core utilities และ providers
├── generated/           # Generated localization files
├── l10n/                # Localization files (.arb)
├── widgets/             # Reusable widgets
└── main.dart            # Entry point
```

## 🔧 Dependencies หลัก

### UI & Design
- `flutter_svg: ^2.0.9` - แสดง SVG icons
- `google_fonts: ^6.1.0` - Google Fonts integration
- `hugeicons: ^0.0.9` - Icon library

### State Management
- `provider: ^6.1.1` - State management solution

### Localization
- `flutter_localizations` - Flutter localization support
- `intl: ^0.20.2` - Internationalization

### Development
- `flutter_lints: ^5.0.0` - Linting rules
- `flutter_gen` - Code generation

## 🌍 Localization (i10n)

### ภาษาที่รองรับ
- 🇬🇧 English (en)
- 🇹🇭 ไทย (th)
- 🇨🇳 中文 (zh)
- 🇷🇺 Русский (ru)
- 🇲🇲 မြန်မာ (my)

### การตั้งค่า
- ARB files: `lib/l10n/app_{locale}.arb`
- Generated files: `lib/generated/intl/`
- Configuration: `l10n.yaml`

### Font Support
- ภาษาไทย: Noto Sans Thai
- ภาษาอื่นๆ: Noto Sans

### 📖 วิธีการสร้างและใช้งาน i10n (Step by Step)

#### 🆕 สร้างระบบ i10n ใหม่ตั้งแต่ต้น

**Step 1:** ติดตั้ง dependencies
```yaml
# pubspec.yaml
dependencies:
  flutter_localizations:
    sdk: flutter
  intl: ^0.20.2
```

**Step 2:** สร้างไฟล์ `l10n.yaml` ที่ root
```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
output-dir: lib/generated/intl
```

**Step 3:** สร้างโฟลเดอร์และไฟล์ ARB
```bash
mkdir -p lib/l10n
```

**Step 4:** สร้าง `lib/l10n/app_en.arb` (template)
```json
{
  "app_name": "My App",
  "@app_name": {
    "description": "Application name"
  },
  "home": "Home",
  "settings": "Settings"
}
```

**Step 5:** สร้างไฟล์ภาษาอื่น `lib/l10n/app_th.arb`
```json
{
  "app_name": "แอปของฉัน",
  "home": "หน้าหลัก",
  "settings": "ตั้งค่า"
}
```

**Step 6:** Generate localization files
```bash
flutter gen-l10n
```

**Step 7:** Setup MaterialApp
```dart
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:test_app/generated/intl/app_localizations.dart';

MaterialApp(
  localizationsDelegates: [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: const [
    Locale('en'),
    Locale('th'),
  ],
  home: HomePage(),
)
```

**Step 8:** ใช้งานใน widget
```dart
Text(AppLocalizations.of(context)!.home)
```

#### ➕ เพิ่มภาษาใหม่

**Step 1:** สร้างไฟล์ `lib/l10n/app_zh.arb`
```json
{
  "app_name": "我的应用",
  "home": "主页",
  "settings": "设置"
}
```

**Step 2:** เพิ่ม locale ใน supportedLocales
```dart
supportedLocales: const [
  Locale('en'),
  Locale('th'),
  Locale('zh'), // เพิ่มภาษาจีน
],
```

**Step 3:** Generate อีกครั้ง
```bash
flutter gen-l10n
```

#### 🔄 เปลี่ยนภาษา Runtime

**Step 1:** สร้าง LocaleProvider
```dart
class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;
  
  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}
```

**Step 2:** Setup Provider
```dart
ChangeNotifierProvider(
  create: (context) => LocaleProvider(),
  child: MyApp(),
)
```

**Step 3:** ใช้ locale ใน MaterialApp
```dart
Consumer<LocaleProvider>(
  builder: (context, localeProvider, child) {
    return MaterialApp(
      locale: localeProvider.locale,
      // ... other properties
    );
  },
)
```

**Step 4:** เปลี่ยนภาษา
```dart
Provider.of<LocaleProvider>(context, listen: false)
  .setLocale(Locale('th'));
```

#### 📝 เพิ่มข้อความที่มี Parameters

**Step 1:** เพิ่มใน ARB file
```json
{
  "greeting": "Hello, {name}!",
  "@greeting": {
    "placeholders": {
      "name": {
        "type": "String"
      }
    }
  },
  "items_count": "{count} items",
  "@items_count": {
    "placeholders": {
      "count": {
        "type": "int"
      }
    }
  }
}
```

**Step 2:** Generate และใช้งาน
```dart
Text(AppLocalizations.of(context)!.greeting('John'))
Text(AppLocalizations.of(context)!.items_count(5))
```

## 🎨 Theme System

### Color Scheme
ระบบสีที่ครอบคลุมทั้ง light และ dark mode:

**Light Mode:**
- Background: `#F5F5F5`
- Surface: `#FFFFFF`
- Primary: `#FFC23D` (Yellow/Gold)
- Text: `#0F0F0F`

**Dark Mode:**
- Background: `#1A1A1A`
- Surface: `#242424`
- Primary: `#F2C564` (Yellow/Gold)
- Text: `#FFFFFF`

### Theme Categories
- **Primary Colors** - สีหลักของแอป
- **Accent Colors** - สีเสริม (amber, blue, brown, green, indigo, pink, purple, red, teal, violet)
- **Semantic Colors** - info, success, warning, danger
- **Text Colors** - base และ contrast variants
- **Fill Colors** - พื้นหลังและ surface
- **Stroke Colors** - เส้นขอบและ borders
- **Utility Colors** - black, white, transparent, shade, tint

### Theme Provider
```dart
ThemeProvider - จัดการ ThemeMode (light/dark)
LocaleProvider - จัดการ Locale switching
```

### 📖 วิธีการสร้างและใช้งาน Theme (Step by Step)

#### 🆕 สร้างระบบ Theme ใหม่ตั้งแต่ต้น

**Step 1:** สร้างไฟล์ `lib/config/themes/theme_color.dart`
```dart
import 'package:flutter/material.dart';

class ThemeColors {
  static Color _hex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }

  static final Map<String, Color> light = {
    'primary/400': _hex('#FFC23D'),
    'fill/base/100': _hex('#FFFFFF'),
    'fill/base/300': _hex('#F5F5F5'),
    'text/base/600': _hex('#0F0F0F'),
    'stroke/base/100': _hex('#EDEDED'),
  };

  static final Map<String, Color> dark = {
    'primary/400': _hex('#F2C564'),
    'fill/base/100': _hex('#242424'),
    'fill/base/300': _hex('#1A1A1A'),
    'text/base/600': _hex('#FFFFFF'),
    'stroke/base/100': _hex('#383838'),
  };

  static Color get(String theme, String key) {
    if (theme == 'light') {
      return light[key] ?? dark[key] ?? Colors.transparent;
    } else {
      return dark[key] ?? light[key] ?? Colors.transparent;
    }
  }
}
```

**Step 2:** สร้าง ThemeProvider
```dart
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light 
      ? ThemeMode.dark 
      : ThemeMode.light;
    notifyListeners();
  }
}
```

**Step 3:** Setup Provider
```dart
ChangeNotifierProvider(
  create: (context) => ThemeProvider(),
  child: MyApp(),
)
```

**Step 4:** สร้าง ColorScheme ใน `lib/config/themes/base_theme.dart`
```dart
class BaseTheme {
  static final ColorScheme lightColorScheme = ColorScheme(
    primary: ThemeColors.get('light', 'primary/400'),
    surface: ThemeColors.get('light', 'fill/base/100'),
    onSurface: ThemeColors.get('light', 'text/base/600'),
    brightness: Brightness.light,
  );

  static final ColorScheme darkColorScheme = ColorScheme(
    primary: ThemeColors.get('dark', 'primary/400'),
    surface: ThemeColors.get('dark', 'fill/base/100'),
    onSurface: ThemeColors.get('dark', 'text/base/600'),
    brightness: Brightness.dark,
  );
}
```

**Step 5:** Setup MaterialApp
```dart
Consumer<ThemeProvider>(
  builder: (context, themeProvider, child) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: BaseTheme.lightColorScheme,
        useMaterial3: true,
      ),
      darkTheme: ThemeData.from(
        colorScheme: BaseTheme.darkColorScheme,
        useMaterial3: true,
      ),
      themeMode: themeProvider.themeMode,
      home: HomePage(),
    );
  },
)
```

**Step 6:** ใช้งานใน widget
```dart
final brightnessKey = Theme.of(context).brightness == Brightness.light 
  ? 'light' 
  : 'dark';

Container(
  color: ThemeColors.get(brightnessKey, 'fill/base/300'),
  child: Text(
    'Hello',
    style: TextStyle(
      color: ThemeColors.get(brightnessKey, 'text/base/600'),
    ),
  ),
)
```

#### ➕ เพิ่มสีใหม่

**Step 1:** เพิ่มใน `theme_color.dart`
```dart
static final Map<String, Color> light = {
  // ... existing colors
  'custom/brand/500': _hex('#FF5733'),
  'custom/accent/400': _hex('#3498DB'),
};

static final Map<String, Color> dark = {
  // ... existing colors
  'custom/brand/500': _hex('#FF8C66'),
  'custom/accent/400': _hex('#5DADE2'),
};
```

**Step 2:** ใช้งาน
```dart
ThemeColors.get(brightnessKey, 'custom/brand/500')
```

#### 🔄 เปลี่ยน Theme Runtime

**วิธีที่ 1:** ใช้ Provider โดยตรง
```dart
Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
```

**วิธีที่ 2:** ใช้ Consumer กับ Switch
```dart
Consumer<ThemeProvider>(
  builder: (context, themeProvider, _) {
    return Switch(
      value: themeProvider.themeMode == ThemeMode.dark,
      onChanged: (value) => themeProvider.toggleTheme(),
    );
  },
)
```

#### 🎨 สร้าง Theme-aware Widget

**Step 1:** สร้าง widget ที่รองรับ theme
```dart
class ThemedCard extends StatelessWidget {
  final Widget child;
  
  const ThemedCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final brightnessKey = Theme.of(context).brightness == Brightness.light 
      ? 'light' 
      : 'dark';
    
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ThemeColors.get(brightnessKey, 'fill/base/100'),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ThemeColors.get(brightnessKey, 'stroke/base/100'),
        ),
      ),
      child: child,
    );
  }
}
```

**Step 2:** ใช้งาน
```dart
ThemedCard(
  child: Text('Content'),
)
```

#### 📐 Color Token Naming Convention

```
รูปแบบ: {category}/{variant}/{intensity}

หมวดหมู่:
- fill/      -> สีพื้นหลัง
- text/      -> สีข้อความ
- stroke/    -> สีเส้นขอบ
- primary/   -> สีหลัก
- success/   -> สีสำเร็จ
- danger/    -> สีอันตราย
- warning/   -> สีเตือน
- info/      -> สีข้อมูล

Variant:
- base       -> สีพื้นฐาน
- contrast   -> สีตัดกัน

Intensity: 100-600 (100=อ่อนที่สุด, 600=เข้มที่สุด)

ตัวอย่าง:
- fill/base/300      -> พื้นหลังหลัก
- text/base/600      -> ข้อความหลัก (เข้มสุด)
- primary/400        -> สีหลักของแอป
- stroke/contrast/600 -> เส้นขอบแบบ contrast
```

## 🧩 Widgets Components

### 1. VisaCard (`lib/widgets/visa/visa_card.dart`)
- แสดงบัตร Visa แบบ gradient
- ข้อมูล: หมายเลขบัตร, วันหมดอายุ, ยอดเงิน
- รองรับ responsive design

**ปัญหาที่แก้ไข:**
- ✅ RenderFlex overflow - ใช้ SingleChildScrollView
- ✅ Null check operator - ลบ AppLocalizations dependency

### 2. AnnouncementStack (`lib/widgets/announce/announcement.dart`)
- แสดงประกาศแบบ stack cards
- Animation: slide out และ promote
- รองรับหลายข้อความ
- ปุ่มปิดสำหรับการ์ดหน้าสุด

**Features:**
- Animated card transitions
- Circular message rotation
- Customizable messages
- Debug mode support

### 3. ShortcutMenuItem (`lib/widgets/shortcut_menu.dart`)
- Menu item พร้อม icon และ label
- รองรับ SVG color customization
- Responsive design

### 4. NavigatorBar (`lib/widgets/navigator_bar/navigator_bar.dart`)
- Bottom navigation bar
- 5 menu items: Home, Deposit, Scan (center), Convert, Setting
- Scan button แบบ floating
- รองรับ opacity adjustment

## 🏗️ Architecture Patterns

### State Management
- **Provider Pattern** - ใช้สำหรับ theme และ locale management
- **StatelessWidget** - ใช้สำหรับ UI components ที่ไม่มี state
- **StatefulWidget** - ใช้สำหรับ components ที่มี animation หรือ state

### Code Organization
```
widgets/
├── {feature}/
│   ├── {widget}.dart          # Main widget
│   └── preview_{widget}.dart  # Preview/testing widget
```

## 📱 Platform Support

### Configured Platforms
- ✅ iOS (Xcode project)
- ✅ Android (Gradle project)
- ✅ Web
- ✅ macOS
- ✅ Linux
- ✅ Windows

### Platform-specific Files
- iOS: `ios/Runner/`
- Android: `android/app/`
- Web: `web/`
- macOS: `macos/Runner/`

## 🔍 Code Quality

### Linting
- ใช้ `flutter_lints: ^5.0.0`
- Configuration: `analysis_options.yaml`
- รองรับ recommended lints

### Best Practices ที่ใช้
- ✅ Material Design 3 (useMaterial3: true)
- ✅ Responsive design (MediaQuery)
- ✅ Theme-aware components
- ✅ Localization support
- ✅ SVG assets
- ✅ Type-safe color system

## ⚠️ ปัญหาที่พบและแก้ไข

### 1. RenderFlex Overflow
**ปัญหา:** Column overflow ใน VisaCardPreview  
**แก้ไข:** ใช้ SingleChildScrollView wrapper

### 2. Null Check Operator Error
**ปัญหา:** AppLocalizations.of(context)! เป็น null  
**แก้ไข:** ใช้ hardcoded string แทนใน preview widgets

### 3. Import Issues
**แก้ไข:** ลบ unused imports (AppLocalizations ใน visa_card.dart)

## 🚀 การพัฒนาต่อ

### Recommendations
1. **State Management** - พิจารณาใช้ Riverpod หรือ Bloc สำหรับ complex state
2. **API Integration** - เพิ่ม repository pattern สำหรับ data layer
3. **Testing** - เพิ่ม unit tests และ widget tests
4. **Navigation** - implement proper routing (go_router)
5. **Error Handling** - เพิ่ม global error handling
6. **Performance** - optimize image loading และ caching

### Missing Features
- ❌ Navigation routing
- ❌ API integration
- ❌ Local storage (SharedPreferences/Hive)
- ❌ Authentication
- ❌ Unit tests
- ❌ Integration tests

## 📝 Naming Conventions

### Files
- `snake_case.dart` - ไฟล์ Dart
- `preview_{widget}.dart` - Preview widgets

### Classes
- `PascalCase` - Class names
- `camelCase` - Variables และ methods

### Assets
- `kebab-case.svg` - SVG files
- `lib/assets/images/` - Image directory

## 🎯 Key Features

1. **Multi-language Support** - 5 ภาษา
2. **Theme Switching** - Light/Dark mode
3. **Responsive Design** - รองรับหลายขนาดหน้าจอ
4. **Custom Theme System** - ระบบสีที่ครอบคลุม
5. **Reusable Components** - Widget library
6. **Animation Support** - Smooth transitions

## 📊 Project Stats

- **Total Widgets:** 4 main components
- **Supported Languages:** 5
- **Theme Colors:** 100+ color tokens
- **Platforms:** 6 platforms
- **Dependencies:** 8 main packages

---

**Last Updated:** 2024  
**Maintained By:** Development Team
