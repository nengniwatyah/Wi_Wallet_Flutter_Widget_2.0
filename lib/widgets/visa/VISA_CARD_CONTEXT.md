# VisaCard Widget - Complete Implementation Guide

## Overview

VisaCard is a Flutter widget that displays a virtual Visa card with gradient background, logo, expiry date, card type, and masked card number. Perfect for fintech and banking applications.

```
┌─────────────────────────────────────────┐
│ [VISA Logo]              12/28          │
│                                         │
│ Virtual Card                            │
│ •••• 1234                               │
└─────────────────────────────────────────┘
```

## Widget Specifications

| Property | Value | Description |
|----------|-------|-------------|
| **Width** | `double.infinity` | Full width of parent container |
| **Height** | `106px` | Fixed height |
| **Border Radius** | `16px` | Rounded corners |
| **Padding** | `16px horizontal, 16px vertical` | Internal spacing |
| **Gradient** | `#0F0F0F → #757575` | Dark to gray gradient |
| **Shadow** | `blur: 6, offset: (0,3), opacity: 0.05` | Subtle drop shadow |

### Visual Elements

| Element | Size | Color | Font |
|---------|------|-------|------|
| **Visa Logo** | 50×16px | White | SVG |
| **Expiry Date** | 13px | text/contrast/600 | Medium (500) |
| **Card Type** | 11px | text/contrast/600 | Medium (500) |
| **Card Number** | 12px | White | Medium (500) |

## Design Tokens

| Token | Light Mode | Dark Mode | Usage |
|-------|-----------|-----------|-------|
| `text/contrast/600` | `#FFFFFF99` (60% opacity) | `#FFFFFF99` | Expiry date, card type text |

## Required Dependencies

### 1. Flutter Packages

Add to `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_svg: ^2.0.0  # For SVG logo rendering
```

### 2. Custom Classes

**ThemeColors** (`lib/config/themes/theme_color.dart`):

```dart
class ThemeColors {
  static Color? get(String theme, String key) {
    final colors = theme == 'light' ? _lightColors : _darkColors;
    return colors[key];
  }

  static final Map<String, Color> _lightColors = {
    'text/contrast/600': Color(0x99FFFFFF),
    // ... other tokens
  };

  static final Map<String, Color> _darkColors = {
    'text/contrast/600': Color(0x99FFFFFF),
    // ... other tokens
  };
}
```

### 3. Assets

**Visa Logo SVG** (`lib/assets/images/logo_visa.svg`):

```svg
<svg width="50" height="16" viewBox="0 0 50 16" fill="none" xmlns="http://www.w3.org/2000/svg">
  <!-- Visa logo paths -->
</svg>
```

Add to `pubspec.yaml`:

```yaml
flutter:
  assets:
    - lib/assets/images/logo_visa.svg
```

## Installation

### Step 1: Copy Widget File

Copy `visa_card.dart` to your project:

```
your_project/
└── lib/
    └── widgets/
        └── visa/
            └── visa_card.dart
```

### Step 2: Copy ThemeColors Class

Copy `theme_color.dart` to your project:

```
your_project/
└── lib/
    └── config/
        └── themes/
            └── theme_color.dart
```

### Step 3: Add Visa Logo Asset

1. Create directory: `lib/assets/images/`
2. Add `logo_visa.svg` file
3. Update `pubspec.yaml` assets section

### Step 4: Install Packages

```bash
flutter pub add flutter_svg
flutter pub get
```

## Usage Examples

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'widgets/visa/visa_card.dart';

class MyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: VisaCard(),
      ),
    );
  }
}
```

### In ListView

```dart
ListView(
  padding: EdgeInsets.all(16),
  children: [
    VisaCard(),
    SizedBox(height: 16),
    // Other widgets
  ],
)
```

### With Custom Width Container

```dart
Container(
  width: 350,
  child: VisaCard(),
)
```

### Complete Screen Example

```dart
import 'package:flutter/material.dart';
import 'widgets/visa/visa_card.dart';

class CardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cards'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Virtual Card',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            VisaCard(),
            SizedBox(height: 24),
            // Other content
          ],
        ),
      ),
    );
  }
}
```

## Customization Guide

### 1. Change Card Dimensions

```dart
Container(
  width: double.infinity,
  height: 120, // Change from 106 to 120
  // ... rest of code
)
```

### 2. Modify Gradient Colors

```dart
gradient: LinearGradient(
  begin: Alignment(0.5, 1.92),
  end: Alignment(1.11, -0.57),
  colors: [
    Color(0xFF1A1A1A), // Change start color
    Color(0xFF4A4A4A), // Change end color
  ],
)
```

### 3. Update Expiry Date

```dart
Text(
  '06/25', // Change expiry date
  style: Theme.of(context).textTheme.labelMedium?.copyWith(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: ThemeColors.get('light', 'text/contrast/600'),
  ),
)
```

### 4. Change Card Type Text

```dart
Text(
  'Physical Card', // Change from 'Virtual Card'
  style: Theme.of(context).textTheme.labelMedium?.copyWith(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: ThemeColors.get('light', 'text/contrast/600'),
  ),
)
```

### 5. Modify Card Number Display

```dart
Row(
  children: [
    // Show 3 groups of dots instead of 1
    ...List.generate(
      3, // Change from 1 to 3
      (_) => Padding(
        padding: EdgeInsets.only(right: 8),
        child: Text(
          '••••',
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
      ),
    ),
    Text(
      '5678', // Change last 4 digits
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.white,
        letterSpacing: 1.5,
      ),
    ),
  ],
)
```

### 6. Replace Visa Logo with Mastercard

```dart
SvgPicture.asset(
  'lib/assets/images/logo_mastercard.svg', // Change logo
  width: 50,
  height: 30, // Adjust height for Mastercard
  colorFilter: ColorFilter.mode(
    Colors.white,
    BlendMode.srcIn,
  ),
)
```

### 7. Add Card Holder Name

```dart
Column(
  mainAxisSize: MainAxisSize.min,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // ... existing header code
    
    SizedBox(height: 12),
    
    // Add card holder name
    Text(
      'JOHN DOE',
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
    ),
    
    // ... rest of code
  ],
)
```

### 8. Make Widget Interactive

```dart
GestureDetector(
  onTap: () {
    // Handle card tap
    print('Card tapped');
  },
  child: Container(
    // ... existing container code
  ),
)
```

## Layout Structure

```
Container (width: full, height: 106px)
├── BoxDecoration
│   ├── borderRadius: 16px
│   ├── gradient: #0F0F0F → #757575
│   └── boxShadow: blur 6, offset (0,3)
│
└── Column (padding: 16px)
    ├── Row (Header)
    │   ├── SvgPicture (Visa Logo) - 50×16px
    │   └── Text (Expiry Date) - 13px
    │
    ├── SizedBox (12px)
    │
    ├── Text (Card Type) - 11px
    │
    ├── SizedBox (4px)
    │
    └── Row (Card Number)
        ├── Text (Dots) - 12px
        ├── SizedBox (8px)
        └── Text (Last 4 digits) - 12px
```

## Theme Support

The widget uses `ThemeColors.get()` for consistent theming:

```dart
// Light mode
ThemeColors.get('light', 'text/contrast/600')

// Dark mode (if needed)
ThemeColors.get('dark', 'text/contrast/600')
```

To detect theme automatically:

```dart
final brightness = Theme.of(context).brightness;
final theme = brightness == Brightness.light ? 'light' : 'dark';

Text(
  '12/28',
  style: TextStyle(
    color: ThemeColors.get(theme, 'text/contrast/600'),
  ),
)
```

## Common Issues & Solutions

### Issue 1: SVG Logo Not Showing

**Error**: `Unable to load asset: lib/assets/images/logo_visa.svg`

**Solution**:
1. Verify file exists at `lib/assets/images/logo_visa.svg`
2. Check `pubspec.yaml` has correct asset path:
```yaml
flutter:
  assets:
    - lib/assets/images/logo_visa.svg
```
3. Run `flutter pub get`
4. Restart app

### Issue 2: ThemeColors Not Found

**Error**: `Undefined class 'ThemeColors'`

**Solution**:
1. Copy `theme_color.dart` to `lib/config/themes/`
2. Update import path in `visa_card.dart`:
```dart
import '../../config/themes/theme_color.dart';
```

### Issue 3: Card Overflows Parent

**Error**: `RenderFlex overflowed`

**Solution**:
Wrap in `SingleChildScrollView` or ensure parent has enough height:
```dart
SingleChildScrollView(
  child: VisaCard(),
)
```

### Issue 4: Text Color Not Showing

**Problem**: Text appears invisible

**Solution**:
Verify `ThemeColors` has the token defined:
```dart
static final Map<String, Color> _lightColors = {
  'text/contrast/600': Color(0x99FFFFFF), // Must exist
};
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `key` | `Key?` | `null` | Widget key for identification |

**Note**: Current implementation has no customizable properties. To add properties:

```dart
class VisaCard extends StatelessWidget {
  final String cardNumber;
  final String expiryDate;
  final String cardType;
  
  const VisaCard({
    super.key,
    required this.cardNumber,
    required this.expiryDate,
    this.cardType = 'Virtual Card',
  });
  
  @override
  Widget build(BuildContext context) {
    // Use properties in widget
  }
}
```

## Best Practices

1. **Always wrap in padding**: Add 16px padding around the card for proper spacing
2. **Use in scrollable views**: Wrap in `SingleChildScrollView` or `ListView` for better UX
3. **Maintain aspect ratio**: Keep height at 106px for optimal card proportions
4. **Test on multiple devices**: Verify gradient and text visibility on different screen sizes
5. **Secure card data**: Never hardcode real card numbers in production code

## Performance Considerations

- **SVG Caching**: `flutter_svg` automatically caches SVG assets
- **Const Constructors**: Widget uses `const` for better performance
- **Minimal Rebuilds**: Stateless widget ensures no unnecessary rebuilds
- **Gradient Performance**: Linear gradient is GPU-accelerated

## Migration Guide

### From Other Card Widgets

If migrating from another card widget:

1. **Replace widget import**:
```dart
// Old
import 'package:old_package/credit_card.dart';

// New
import 'widgets/visa/visa_card.dart';
```

2. **Update widget usage**:
```dart
// Old
CreditCard(
  cardNumber: '1234',
  expiryDate: '12/28',
)

// New
VisaCard()
```

3. **Adjust layout**:
```dart
// Old - may have different dimensions
Container(height: 200, child: CreditCard())

// New - fixed 106px height
VisaCard()
```

## Version Compatibility

- **Flutter**: >= 3.0.0
- **Dart**: >= 3.0.0
- **flutter_svg**: >= 2.0.0

## File Structure

```
your_project/
├── lib/
│   ├── assets/
│   │   └── images/
│   │       └── logo_visa.svg
│   ├── config/
│   │   └── themes/
│   │       └── theme_color.dart
│   └── widgets/
│       └── visa/
│           ├── visa_card.dart
│           └── VISA_CARD_CONTEXT.md
└── pubspec.yaml
```

## License

This widget is part of the mcp_test_app project.

## Support

For issues or questions:
1. Check this documentation first
2. Verify all dependencies are installed
3. Ensure assets are properly configured
4. Test on a clean Flutter project

---

**Last Updated**: 2024
**Widget Version**: 1.0.0
**Compatibility**: Flutter 3.0+
