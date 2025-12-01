# Image Carousel Guide

The `ImageCarousel` widget is a responsive carousel component designed to display a series of images or widgets with navigation indicators.

## Design Spec
- **Figma Node:** `7225:1100`
- **Dimensions:**
  - Total Height: `150px`
  - Image Height: `134px`
  - Width: Responsive (Design base: `343px`)
- **Indicators:**
  - Active: `primary/400`, 15x4px, Radius 3px
  - Inactive: `stroke/contrast/600`, 4x4px, Radius 3px
  - Gap: 4px
  - Position: Bottom center

## Usage

Import the widget:

```dart
import 'package:mcp_test_app/widgets/image_carousel/image_carousel.dart';
```

Basic usage with a list of widgets:

```dart
ImageCarousel(
  pages: [
    Image.asset('assets/images/banner1.png', fit: BoxFit.cover),
    Image.asset('assets/images/banner2.png', fit: BoxFit.cover),
    Image.asset('assets/images/banner3.png', fit: BoxFit.cover),
  ],
)
```

With Auto-play:

```dart
ImageCarousel(
  autoPlay: true,
  autoPlayInterval: Duration(seconds: 5),
  pages: [
    // ... widgets
  ],
)
```

## Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `pages` | `List<Widget>` | Required | The list of widgets to display in the carousel. |
| `height` | `double` | `150` | The total height of the widget (including indicators). |
| `imageHeight` | `double` | `134` | The height of the image/content area. |
| `autoPlay` | `bool` | `false` | Whether to auto-scroll the carousel. |
| `autoPlayInterval` | `Duration` | `3s` | The duration between auto-scrolls. |

## Dependencies

- `flutter/material.dart`
- `mcp_test_app/config/themes/theme_color.dart`
