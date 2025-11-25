# SnackBar Guide

The `SnackBarWidget` is a custom notification component designed to provide feedback to the user. It supports four variants: Success, Warning, Error, and Info.

## Usage

Import the widget:

```dart
import 'package:mcp_test_app/widgets/snack_bar/snack_bar.dart';
```

Show the SnackBar using the static `show` method:

```dart
SnackBarWidget.show(
  context,
  title: 'Success',
  description: 'Operation completed successfully.',
  type: SnackBarType.success,
);
```

## Variants

The `SnackBarType` enum defines the visual style of the SnackBar:

| Type | Description | Icon | Color |
|---|---|---|---|
| `SnackBarType.success` | Used for successful operations. | Check Circle | Green |
| `SnackBarType.warning` | Used for warnings or alerts. | Alert Triangle | Amber |
| `SnackBarType.error` | Used for errors or failures. | Cancel Circle | Red |
| `SnackBarType.info` | Used for informational messages. | Info Circle | Blue/Teal |

## Properties

| Property | Type | Description |
|---|---|---|
| `title` | `String` | The main title of the notification. |
| `description` | `String` | The detailed message of the notification. |
| `type` | `SnackBarType` | The variant of the SnackBar. |
| `onClose` | `VoidCallback?` | Optional callback when the close button is tapped. (Handled automatically in `show` method) |

## Example

```dart
SnackBarWidget.show(
  context,
  title: 'Payment Failed',
  description: 'Please check your balance and try again.',
  type: SnackBarType.error,
);
```

## Preview

To preview the SnackBar widget interactively, run the preview file:

```bash
flutter run -t lib/widgets/snack_bar/preview_snack_bar.dart
```
