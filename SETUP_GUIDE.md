# Setup Guide - Flutter Foundation App

Complete guide to set up and customize this foundation for your project.

## 📋 Prerequisites

- Flutter SDK ^3.7.2
- Dart SDK
- Git
- IDE (VS Code recommended with Flutter extension)

## 🚀 Initial Setup

### 1. Clone and Install

```bash
git clone https://github.com/yourusername/flutter_test_app.git
cd flutter_test_app
flutter pub get
flutter gen-l10n
```

### 2. Verify Installation

```bash
flutter doctor
flutter run
```

## 🎨 Customization Guide

### Change App Name

**1. Update `pubspec.yaml`:**
```yaml
name: your_app_name
description: "Your app description"
```

**2. Update localization files:**
```json
// lib/l10n/app_en.arb
{
  "app_name": "Your App Name"
}
```

**3. Update platform-specific files:**

**iOS:** `ios/Runner/Info.plist`
```xml
<key>CFBundleName</key>
<string>Your App Name</string>
```

**Android:** `android/app/src/main/AndroidManifest.xml`
```xml
<application
    android:label="Your App Name"
```

### Change App Icon

```bash
# Install flutter_launcher_icons
flutter pub add dev:flutter_launcher_icons

# Add to pubspec.yaml
flutter_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"

# Generate icons
flutter pub run flutter_launcher_icons
```

### Change Primary Color

Edit `lib/config/themes/theme_color.dart`:

```dart
static final Map<String, Color> light = {
  'primary/400': _hex('#YOUR_COLOR'), // Change this
  // ...
};

static final Map<String, Color> dark = {
  'primary/400': _hex('#YOUR_COLOR'), // Change this
  // ...
};
```

## 🌍 Add New Language

### Step 1: Create ARB File

Create `lib/l10n/app_ja.arb` (for Japanese):

```json
{
  "app_name": "私のアプリ",
  "home": "ホーム",
  "settings": "設定",
  "transfer": "送金",
  "top_up": "チャージ",
  "bill": "請求書",
  "deposit": "入金",
  "convert": "変換",
  "setting": "設定",
  "light_theme": "ライトテーマ",
  "dark_theme": "ダークテーマ"
}
```

### Step 2: Update MaterialApp

```dart
supportedLocales: const [
  Locale('en'),
  Locale('th'),
  Locale('zh'),
  Locale('ru'),
  Locale('my'),
  Locale('ja'), // Add new language
],
```

### Step 3: Add Font Support (if needed)

```dart
theme: ThemeData(
  textTheme: locale?.languageCode == 'ja'
    ? GoogleFonts.notoSansJpTextTheme()
    : GoogleFonts.notoSansTextTheme(),
),
```

### Step 4: Generate

```bash
flutter gen-l10n
```

## 🧩 Add Custom Widget

### Step 1: Create Widget File

Create `lib/widgets/my_custom_widget.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:your_app/config/themes/theme_color.dart';

class MyCustomWidget extends StatelessWidget {
  final String title;
  
  const MyCustomWidget({
    super.key,
    required this.title,
  });

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
      ),
      child: Text(
        title,
        style: TextStyle(
          color: ThemeColors.get(brightnessKey, 'text/base/600'),
        ),
      ),
    );
  }
}
```

### Step 2: Create Preview (Optional)

Create `lib/widgets/preview_my_custom_widget.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:your_app/widgets/my_custom_widget.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    body: Center(
      child: MyCustomWidget(title: 'Test'),
    ),
  ),
));
```

## 🎯 Add New Design Token

### Step 1: Add Color to theme_color.dart

```dart
static final Map<String, Color> light = {
  // ... existing colors
  'custom/brand/100': _hex('#FFE5E5'),
  'custom/brand/400': _hex('#FF5733'),
  'custom/brand/600': _hex('#C70039'),
};

static final Map<String, Color> dark = {
  // ... existing colors
  'custom/brand/100': _hex('#4D1F1F'),
  'custom/brand/400': _hex('#FF8C66'),
  'custom/brand/600': _hex('#FFB399'),
};
```

### Step 2: Use in Your App

```dart
Container(
  color: ThemeColors.get(brightnessKey, 'custom/brand/400'),
)
```

## 📱 Platform-Specific Setup

### iOS Setup

```bash
cd ios
pod install
cd ..
```

**Minimum iOS Version:** Edit `ios/Podfile`
```ruby
platform :ios, '12.0'
```

### Android Setup

**Minimum SDK:** Edit `android/app/build.gradle`
```gradle
minSdkVersion 21
targetSdkVersion 34
```

### Web Setup

```bash
flutter build web
```

**Deploy to Firebase Hosting:**
```bash
firebase init hosting
firebase deploy
```

## 🔧 Development Tips

### Hot Reload

```bash
# Press 'r' in terminal for hot reload
# Press 'R' for hot restart
# Press 'q' to quit
```

### Debug Mode

```bash
flutter run --debug
```

### Release Build

```bash
# Android
flutter build apk --release
flutter build appbundle --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

### Clean Build

```bash
flutter clean
flutter pub get
flutter gen-l10n
flutter run
```

## 🧪 Testing Setup

### Create Test File

Create `test/widgets/my_widget_test.dart`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:your_app/widgets/my_custom_widget.dart';

void main() {
  testWidgets('MyCustomWidget displays title', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: MyCustomWidget(title: 'Test'),
      ),
    );

    expect(find.text('Test'), findsOneWidget);
  });
}
```

### Run Tests

```bash
flutter test
flutter test --coverage
```

## 📦 Add Dependencies

```bash
# Add package
flutter pub add package_name

# Add dev dependency
flutter pub add dev:package_name

# Update packages
flutter pub upgrade
```

## 🐛 Troubleshooting

### Localization Not Working

```bash
flutter clean
flutter pub get
flutter gen-l10n
flutter run
```

### Theme Colors Not Updating

- Restart app (hot restart with 'R')
- Check brightness key is correct
- Verify color key exists in theme_color.dart

### Build Errors

```bash
flutter clean
flutter pub get
cd ios && pod install && cd ..  # iOS only
flutter run
```

### Font Not Loading

- Check `pubspec.yaml` has `google_fonts` dependency
- Verify internet connection (fonts load from Google)
- Check font name spelling

## 📚 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design 3](https://m3.material.io/)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)

## 💡 Best Practices

1. **Always use design tokens** - Never hardcode colors
2. **Test on both themes** - Light and dark mode
3. **Test all languages** - Ensure UI doesn't break
4. **Use const constructors** - Better performance
5. **Follow naming conventions** - Consistent code style
6. **Write tests** - Ensure code quality
7. **Document complex logic** - Help future developers

## 🆘 Need Help?

- 📖 Check [README.md](README.md)
- 💬 Open [Discussion](https://github.com/yourusername/flutter_test_app/discussions)
- 🐛 Report [Issue](https://github.com/yourusername/flutter_test_app/issues)

---

Happy coding! 🚀
