# NavigatorBar Widget - Complete Implementation Guide

## Overview
NavigatorBar is a custom bottom navigation bar widget with 5 navigation items (4 regular items + 1 center floating action button). It features rounded top corners, theme support (light/dark), and internationalization.

## Visual Structure
```
┌─────────────────────────────────────────┐
│  Home    Deposit   [SCAN]  Convert  Setting │
│   🏠       💰       ⭕       🔄       ⚙️   │
└─────────────────────────────────────────┘
```

## Widget Specifications

### Dimensions
- **Height**: 92.0 pixels (fixed)
- **Width**: Full screen width
- **Border Radius**: 16.0 pixels (top corners only)
- **Blur Effect**: 10px backdrop blur (sigmaX: 10, sigmaY: 10)
- **Icon Size**: 24.0 x 24.0 pixels (navigation items)
- **Center Button Icon**: 32.0 x 32.0 pixels

### Design Tokens Used
| Token | Usage | Light Mode | Dark Mode |
|-------|-------|------------|-----------|
| `fill/base/300` | Background color | #F5F5F5 | #1A1A1A |
| `alt/base/300` | Top border | rgba(255,255,255,0.1) | rgba(255,255,255,0.1) |
| `stroke/contrast/600` | Center button border | rgba(255,255,255,0.1) | rgba(255,255,255,0.1) |
| `text/base/600` | Home icon & text (active) | rgba(0,0,0,0.6) | rgba(255,255,255,0.6) |
| `primary/400` | Center button background | #4CAF50 | #4CAF50 |
| `fill/contrast/600` | Center button icon & foreground | #FFFFFF | #FFFFFF |

## Required Dependencies

### 1. Flutter Packages (pubspec.yaml)
```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.0
  flutter_svg: ^2.0.0
```

### 2. Custom Dependencies
You need these custom implementations in your project:

#### a. ThemeColors System
```dart
// lib/config/themes/theme_color.dart
class ThemeColors {
  static Color? get(String theme, String token) {
    // Returns color based on theme ('light' or 'dark') and token name
    // Example: ThemeColors.get('light', 'fill/base/300')
  }
}
```

#### b. SVG Icon Helper
```dart
// lib/assets/hugeicons/huge_icons.dart
Widget createHugeIcon(String path, Color? color, {double? width, double? height}) {
  return SvgPicture.asset(
    path,
    width: width,
    height: height,
    colorFilter: color != null 
      ? ColorFilter.mode(color, BlendMode.srcIn) 
      : null,
  );
}
```

#### c. Internationalization (i18n)
```dart
// lib/generated/intl/app_localizations.dart
class AppLocalizations {
  String get home => 'Home';
  String get deposit => 'Deposit';
  String get convert => 'Convert';
  String get setting => 'Setting';
  
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
}
```

## Installation Steps

### Step 1: Copy Icon Assets
Place these SVG files in `lib/assets/images/`:
- `home-09.svg` - Home icon
- `wallet-add-02.svg` - Deposit icon
- `exchange-03.svg` - Convert icon
- `list-setting.svg` - Setting icon
- `iris-scan.svg` - Center scan button icon

### Step 2: Copy Icon Path Constants
```dart
const String homeIcon = 'lib/assets/images/home-09.svg';
const String depositIcon = 'lib/assets/images/wallet-add-02.svg';
const String convertIcon = 'lib/assets/images/exchange-03.svg';
const String settingIcon = 'lib/assets/images/list-setting.svg';
const String irisScanIcon = 'lib/assets/images/iris-scan.svg';
```

### Step 3: Copy NavigatorBar Widget
Copy the entire `NavigatorBar` class from the source file (between `START` and `END` markers).

### Step 4: Import Required Packages
```dart
import 'dart:ui'; // Required for ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:your_project/config/themes/theme_color.dart';
import 'package:your_project/assets/hugeicons/huge_icons.dart';
import 'package:your_project/generated/intl/app_localizations.dart';
```

## Usage Examples

### Basic Usage
```dart
Scaffold(
  extendBody: true,
  bottomNavigationBar: NavigatorBar(),
)
```

### With Custom Opacity
```dart
Scaffold(
  extendBody: true,
  bottomNavigationBar: NavigatorBar(opacity: 0.95),
)
```

### Complete Example with Scaffold
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.get(
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
        'fill/base/300'
      ),
      extendBody: true,
      body: YourContentHere(),
      bottomNavigationBar: NavigatorBar(),
    );
  }
}
```

## Customization Guide

### 1. Change Navigation Items
Modify the navigation items in the widget:

```dart
// Replace icon and text for each item
createHugeIcon(yourIcon, color, width: 24.0, height: 24.0),
Text(
  'Your Label',
  style: Theme.of(context).textTheme.labelSmall?.copyWith(
    color: ThemeColors.get(brightnessKey, 'text/base/600'),
  ),
),
```

### 2. Add Navigation Logic
Add onTap handlers to navigation items:

```dart
GestureDetector(
  onTap: () {
    // Navigate to home
    Navigator.pushNamed(context, '/home');
  },
  child: Column(
    children: [
      createHugeIcon(homeIcon, color, width: 24.0, height: 24.0),
      Text('Home'),
    ],
  ),
)
```

### 3. Customize Center Button Action
Modify the center button's onPressed:

```dart
ElevatedButton(
  onPressed: () {
    // Your custom action
    Navigator.pushNamed(context, '/scan');
  },
  // ... rest of button styling
)
```

### 4. Change Colors
Replace design tokens with your own:

```dart
// Background
color: ThemeColors.get(brightnessKey, 'your/custom/token')

// Or use direct colors
color: Color(0xFFF5F5F5)
```

### 5. Adjust Dimensions
```dart
Container(
  height: 80.0, // Change height
  decoration: BoxDecoration(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20.0), // Change radius
      topRight: Radius.circular(20.0),
    ),
  ),
)
```

## Layout Structure

### Container Hierarchy
```
Stack (Main wrapper with clipBehavior: Clip.none)
├── ClipRRect (Blur container)
│   └── BackdropFilter (10px blur effect)
│       └── Container (Background with border)
│           └── Row (Navigation items)
│               ├── Expanded (Left section)
│               │   └── Row
│               │       ├── Column (Home)
│               │       └── Column (Deposit)
│               ├── SizedBox (72px gap for center button)
│               └── Expanded (Right section)
│                   └── Row
│                       ├── Column (Convert)
│                       └── Column (Setting)
└── Positioned (Center button - outside ClipRRect)
    └── ElevatedButton (Floating action)
```

### Padding Values
- **Left section**: `EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 0.0, 34.0)`
- **Right section**: `EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 20.0, 34.0)`
- **Center gap**: `SizedBox(width: 72.0)`

## Theme Support

### Brightness Detection
```dart
final brightnessKey = Theme.of(context).brightness == Brightness.light 
  ? 'light' 
  : 'dark';
```

### Using Theme-Aware Colors
```dart
ThemeColors.get(brightnessKey, 'fill/base/300')
```

## Internationalization (i18n)

### Supported Languages
The widget uses `AppLocalizations` for text labels:
- English (en)
- Thai (th)
- Chinese (zh)
- Russian (ru)
- Myanmar (my)

### Adding New Languages
1. Add translations to your i18n files
2. Widget automatically uses `AppLocalizations.of(context)!.labelName`

## Common Issues & Solutions

### Issue 1: Icons Not Showing
**Solution**: Ensure SVG files are in `lib/assets/images/` and declared in `pubspec.yaml`:
```yaml
flutter:
  assets:
    - lib/assets/images/
```

### Issue 2: ThemeColors.get() Error
**Solution**: Implement ThemeColors class or replace with direct Color values:
```dart
// Replace
color: ThemeColors.get('light', 'fill/base/300')

// With
color: Color(0xFFF5F5F5)
```

### Issue 3: AppLocalizations Not Found
**Solution**: Replace with hardcoded strings or implement i18n:
```dart
// Replace
Text(AppLocalizations.of(context)!.home)

// With
Text('Home')
```

### Issue 4: createHugeIcon() Not Found
**Solution**: Replace with standard Icon or SvgPicture.asset:
```dart
// Replace
createHugeIcon(homeIcon, color, width: 24.0, height: 24.0)

// With
SvgPicture.asset(
  homeIcon,
  width: 24.0,
  height: 24.0,
  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
)
```

## Properties

### NavigatorBar Parameters
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `opacity` | `double` | `0.9` | Background opacity (0.0 - 1.0) |
| `key` | `Key?` | `null` | Widget key |

## Best Practices

1. **Use with extendBody**: Set `extendBody: true` in Scaffold for proper overlay effect
2. **Background Color**: Match Scaffold background with NavigatorBar for seamless look
3. **Blur Effect**: 10px backdrop blur creates glass-morphism effect
4. **Safe Area**: Widget handles safe area automatically with padding
5. **Responsive**: Widget adapts to screen width automatically
6. **Accessibility**: Ensure sufficient color contrast for text and icons
7. **Clipping**: Stack with clipBehavior: Clip.none prevents center button clipping

## Performance Considerations

- Widget rebuilds only when theme changes
- SVG icons are cached by flutter_svg
- No animations = minimal performance impact
- Stateless widget = efficient rendering

## Migration from Other Navigation Bars

### From BottomNavigationBar
```dart
// Before
BottomNavigationBar(
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    // ...
  ],
)

// After
NavigatorBar()
```

### From Custom Navigation
Replace your custom implementation with NavigatorBar and adjust:
1. Icon paths
2. Color tokens
3. Navigation logic
4. Dimensions if needed

## Version Compatibility

- **Flutter**: 3.0.0 or higher
- **Dart**: 2.17.0 or higher
- **flutter_svg**: 2.0.0 or higher
- **provider**: 6.0.0 or higher

## License & Credits

This widget is part of the mcp_test_app project. Feel free to use and modify for your projects.

## Support

For issues or questions:
1. Check the "Common Issues & Solutions" section
2. Review the complete source code in `navigator_bar.dart`
3. Ensure all dependencies are properly installed
