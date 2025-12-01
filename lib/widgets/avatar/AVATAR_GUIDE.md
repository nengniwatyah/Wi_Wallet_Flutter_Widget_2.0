# Avatar Widget Guide

## Overview
The `Avatar` widget is a reusable component designed to display a user's profile image (or a default placeholder), name, handle, and an optional status badge. It supports loading states with skeleton animations and is fully themable.

## File Structure
- **`lib/widgets/avatar/avatar.dart`**: The main widget implementation.
- **`lib/widgets/avatar/preview_avatar.dart`**: A preview page demonstrating various states and configurations of the `Avatar` widget.

## API Reference

### `Avatar` Class

| Parameter | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `imageUrl` | `String?` | `null` | URL of the profile image. |
| `assetPath` | `String?` | `null` | Local asset path of the profile image (used if `imageUrl` is null). |
| `name` | `String` | **Required** | The display name of the user. |
| `handle` | `String` | **Required** | The user's handle or secondary text (e.g., username, masked mobile). |
| `radius` | `double` | `24` | The radius of the avatar circle. |
| `isLoading` | `bool` | `false` | If `true`, displays a skeleton loading animation. |
| `status` | `AvatarStatus` | `AvatarStatus.none` | Status badge to display (`none`, `danger`, `warning`). |
| `onQrTap` | `VoidCallback?` | `null` | Callback when the QR code icon is tapped (currently unused in UI). |

### `AvatarStatus` Enum
- `none`: No status badge.
- `danger`: Red status badge (e.g., for alerts).
- `warning`: Yellow status badge (e.g., for pending actions).

## Usage Examples

### 1. Basic Usage
Displays an avatar from a local asset with a name and handle.

```dart
Avatar(
  name: 'Tony Stark',
  handle: '@tony.stark',
  assetPath: 'lib/assets/images/avatar-demo.png',
)
```

### 2. With Status Badge
Displays a "danger" status badge on the avatar.

```dart
Avatar(
  name: 'Tony Stark',
  handle: '@tony.stark',
  assetPath: 'lib/assets/images/avatar-demo.png',
  status: AvatarStatus.danger,
)
```

### 3. Loading State
Displays a skeleton loading animation for the avatar and text.

```dart
Avatar(
  name: 'Loading...',
  handle: '...',
  isLoading: true,
)
```

### 4. Masked Mobile Number (Best Practice)
When displaying a masked mobile number, it is recommended to use a `Tooltip` to allow users to view the full number.

```dart
Tooltip(
  message: 'Mobile: 081-234-5678', // Full number for accessibility/tooltip
  child: Avatar(
    name: '****5678', // Masked number
    handle: 'Tony Stark',
    assetPath: 'lib/assets/images/avatar-demo.png',
  ),
)
```

## Reuse Guidelines

### Integration
- **Import**: `import 'package:mcp_test_app/widgets/avatar/avatar.dart';`
- **Theming**: The widget automatically adapts to light and dark modes using `ThemeColors`. Ensure your app's `ThemeProvider` is set up correctly.
- **Layout**: The `Avatar` widget is designed to fit within a `Row` or `Column`. It has a fixed height based on the `radius` but expands horizontally to fill available space (via `Expanded` on the text column).

### Customization
- **Empty State**: If both `imageUrl` and `assetPath` are null, a default "add user" icon is displayed.
- **Text Styling**: Text colors are pulled from `ThemeColors` (`text/base/600`). To change this, you would need to modify `avatar.dart` or wrap the `Avatar` in a `Theme` override (though direct modification is preferred for consistency).

## Preview
Run `lib/widgets/avatar/preview_avatar.dart` to see the widget in action. This file contains a `PreviewAvatarPage` that showcases all the examples mentioned above.
