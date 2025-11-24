# ItemList Widget Guide

## Overview
The `ItemList` widget is a versatile, theme-aware menu item component designed for settings screens and lists. It supports multiple trailing states (arrow, text, radio button) with consistent styling across the application. The widget follows the project's design token system and adapts seamlessly to light/dark themes.

## Design Specifications

### Dimensions
- **Height**: 56px (fixed)
- **Padding**: 16px horizontal
- **Border Radius**: 12px
- **Icon Size**: 24x24px
- **Spacing**: 8px between icon and text

### Typography
- **Title Font**: Noto Sans Thai
- **Title Font Size**: 13px
- **Title Line Height**: 16px (1.23 ratio)
- **Title Font Weight**: 600 (Semi-Bold)
- **Trailing Text Font Weight**: 500 (Medium)

### States
The widget supports three trailing states:
1. **Arrow State** (Default): Shows a right-pointing arrow
2. **Text State**: Displays custom text (e.g., "English", "฿100")
3. **Radio Button State**: Shows check/uncheck radio button

## Design Token Usage

### Container
- **Background**: `fill/base/300`
- **Border Radius**: 12px
- **No Border**: Border was removed for cleaner appearance

### Leading Icon
- **Default Icon**: `Transaction History.svg`
- **Color**: `text/base/600` (adapts to theme)
- **Size**: 24x24px

### Title Text
- **Color**: `text/base/600`
- **Font**: Noto Sans Thai
- **Weight**: 600

### Trailing Elements

#### Arrow Icon
- **Asset**: `arrow-right-01.svg`
- **Color**: `primary/400` (#F2C564)
- **Size**: 24x24px

#### Text
- **Color**: `text/base/600`
- **Font**: Noto Sans Thai
- **Weight**: 500

#### Radio Button
- **Checked**: `radio_button_check.svg` (original color preserved)
- **Unchecked**: `radio_button_uncheck.svg` with `text/base/600` color filter
- **Size**: 24x24px with `BoxFit.contain`

## Code Review Analysis

### ✅ Compliant with Project Standards
1. **Design Tokens**: Properly uses `ThemeColors.get()` for all colors
2. **Theme Awareness**: Correctly implements light/dark mode switching
3. **Typography**: Uses Noto Sans Thai for multi-language support
4. **SVG Assets**: Properly handles SVG icons with flutter_svg
5. **Flexible API**: Supports multiple use cases with optional parameters
6. **Color Filters**: Intelligently applies color filters for theme adaptation

### ✅ Strong Points
1. **Three Distinct States**: Clean separation of arrow/text/radio states
2. **Theme Adaptation**: All colors adapt to light/dark mode
3. **Consistent Sizing**: All elements use fixed, predictable sizes
4. **Default Fallback**: Provides sensible defaults (Transaction History icon)
5. **Radio Button Handling**: Proper visual consistency between checked/unchecked states

### 💡 Design Decisions
1. **No Border**: Removed for cleaner, more modern appearance
2. **Fixed Height**: 56px ensures consistent list item height
3. **Radio Button Colors**: Unchecked state uses theme color for better visibility
4. **Icon Flexibility**: Allows custom icon path while providing default

## Usage Examples

### Basic Arrow State (Navigation)
```dart
ItemList(
  title: 'History',
  onTap: () => Navigator.push(...),
)
```

### Custom Icon with Arrow
```dart
ItemList(
  title: 'Account',
  iconPath: 'lib/assets/images/home-09.svg',
  onTap: () => Navigator.push(...),
)
```

### Text State (Display Value)
```dart
ItemList(
  title: 'Language',
  trailingText: 'English',
  onTap: () => showLanguagePicker(),
)
```

### Radio Button State (Selection)
```dart
ItemList(
  title: 'Option 1',
  isSelected: true,
  onTap: () => selectOption(1),
)

ItemList(
  title: 'Option 2',
  isSelected: false,
  onTap: () => selectOption(2),
)
```

## Parameters

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `title` | String | No | 'History' | Main text label |
| `iconPath` | String? | No | null | Custom SVG icon path |
| `onTap` | VoidCallback? | No | null | Tap handler |
| `trailingText` | String? | No | null | Text to show instead of arrow |
| `isSelected` | bool? | No | null | Radio button state (null = no radio) |

## Integration Guidelines

### When to Use
- Settings screens
- Navigation menus
- Selection lists
- Account/profile options
- Language/currency pickers

### State Priority
1. If `isSelected != null`: Show radio button
2. Else if `trailingText != null`: Show text
3. Else: Show arrow (default)

### Icon Guidelines
- Use 24x24px SVG icons
- Ensure icons work in both light/dark themes
- Keep icons simple and recognizable
- Provide custom `iconPath` for specific items

## File Structure
```
lib/widgets/item_list/
├── item_list.dart              # Main widget
├── preview_item_list.dart      # Preview with all states
└── ITEM_LIST_GUIDE.md         # This documentation
```

## Testing

### Widget Tests
The widget includes comprehensive tests covering:
- Default arrow state rendering
- Trailing text state rendering
- Radio button state rendering (checked/unchecked)
- Icon display verification

Test file: `test/item_list_test.dart`

## Preview Features
The preview file (`preview_item_list.dart`) demonstrates:
- Default state with arrow
- Text state with custom trailing text
- Radio button states (selected/unselected)
- Theme switching (light/dark)
- Multi-language support
- Interactive tap feedback

## Future Enhancements

### Potential Improvements
1. **Badge Support**: Add notification badge for leading icon
2. **Subtitle**: Support for secondary text line
3. **Loading State**: Show spinner during async operations
4. **Swipe Actions**: Delete/edit actions with swipe gestures
5. **Dividers**: Optional divider between items
6. **Accessibility**: Enhanced screen reader support

### Material Icon Integration
Consider using Material Icons for radio buttons:
```dart
// Instead of SVG
Icon(
  isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
  size: 24,
  color: ThemeColors.get(themeMode, isSelected ? 'primary/400' : 'text/base/600'),
)
```

## Dependencies
- `flutter/material.dart`: Core Flutter widgets
- `flutter_svg/flutter_svg.dart`: SVG asset rendering
- `ThemeColors`: Project design token system

## Compliance Score: 95/100

The widget excellently follows project conventions with:
- ✅ Consistent design token usage
- ✅ Proper theme adaptation
- ✅ Clean, maintainable code
- ✅ Comprehensive state handling
- ✅ Good documentation and tests

Minor improvements could include Material icon support and additional accessibility features.
