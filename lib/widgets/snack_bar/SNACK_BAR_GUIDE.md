# SnackBar Guide

The `SnackBarWidget` is a custom notification component designed to provide feedback to the user. It supports three variants: Success, Warning, and Error.

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

## Properties

| Property | Type | Description |
|---|---|---|
| `title` | `String` | The main title of the notification. |
| `type` | `SnackBarType` | The variant of the SnackBar. |

## Example

```dart
SnackBarWidget.show(
  context,
  title: 'Payment Failed',
  type: SnackBarType.error,
);
```

## Preview

To preview the SnackBar widget interactively, run the preview file:

```bash
flutter run -t lib/widgets/snack_bar/preview_snack_bar.dart
```

## Testing

Unit and Integration tests are available to ensure the widget renders correctly and adheres to design specifications.

**Test File:** `test/widgets/snack_bar/snack_bar_test.dart`

**Run Tests:**

```bash
flutter test test/widgets/snack_bar/snack_bar_test.dart
```

**Test Coverage:**
- **UI Tests:** Verifies title rendering, icon presence, border radius (6px), and background color for all variants.
- **Integration Tests:** Verifies that `SnackBarWidget.show` correctly triggers the display of the SnackBar using `ScaffoldMessenger`.
