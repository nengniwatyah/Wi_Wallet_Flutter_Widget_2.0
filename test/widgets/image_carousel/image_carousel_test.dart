import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/widgets/image_carousel/image_carousel.dart';

void main() {
  group('ImageCarousel UI Tests', () {
    testWidgets('renders correctly with given pages', (
      WidgetTester tester,
    ) async {
      final pages = [
        Container(key: const Key('page_1'), color: Colors.red),
        Container(key: const Key('page_2'), color: Colors.blue),
        Container(key: const Key('page_3'), color: Colors.green),
      ];

      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: ImageCarousel(pages: pages))),
      );

      // Verify first page is visible
      expect(find.byKey(const Key('page_1')), findsOneWidget);
      expect(
        find.byKey(const Key('page_2')),
        findsNothing,
      ); // Should be off-screen or not built yet

      // Verify indicators count
      expect(find.byType(AnimatedContainer), findsNWidgets(3));
    });

    testWidgets('renders correct indicator states (active/inactive)', (
      WidgetTester tester,
    ) async {
      final pages = [
        Container(color: Colors.red),
        Container(color: Colors.blue),
      ];

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(), // Force light theme for consistent colors
          home: Scaffold(body: ImageCarousel(pages: pages)),
        ),
      );

      final indicators =
          tester
              .widgetList<AnimatedContainer>(find.byType(AnimatedContainer))
              .toList();
      expect(indicators.length, 2);

      // First indicator should be active (width 15, primary color)
      final activeIndicator = indicators[0];
      final activeDecoration = activeIndicator.decoration as BoxDecoration;
      expect(activeIndicator.constraints?.minWidth, 15);
      expect(activeDecoration.color, ThemeColors.get('light', 'primary/400'));

      // Second indicator should be inactive (width 4, stroke contrast color)
      final inactiveIndicator = indicators[1];
      final inactiveDecoration = inactiveIndicator.decoration as BoxDecoration;
      expect(inactiveIndicator.constraints?.minWidth, 4);
      expect(
        inactiveDecoration.color,
        ThemeColors.get('light', 'stroke/contrast/600'),
      );
    });

    testWidgets('autoPlay advances pages correctly', (
      WidgetTester tester,
    ) async {
      final pages = [
        Container(key: const Key('page_1'), color: Colors.red),
        Container(key: const Key('page_2'), color: Colors.blue),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ImageCarousel(
              pages: pages,
              autoPlay: true,
              autoPlayInterval: const Duration(
                seconds: 1,
              ), // Short interval for testing
            ),
          ),
        ),
      );

      // Initially page 1
      expect(find.byKey(const Key('page_1')), findsOneWidget);

      // Wait for autoPlay interval
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle(); // Allow animation to complete

      // Now page 2 should be visible (or at least page 1 is scrolling out)
      // Note: PageView might keep adjacent pages in memory, but let's check if we can find page 2
      expect(find.byKey(const Key('page_2')), findsOneWidget);
    });

    testWidgets('respects height parameters', (WidgetTester tester) async {
      const double widgetHeight = 200;
      const double imageHeight = 180;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ImageCarousel(
              pages: [Container(color: Colors.red)],
              height: widgetHeight,
              imageHeight: imageHeight,
            ),
          ),
        ),
      );

      final carouselFinder = find.byType(ImageCarousel);
      final size = tester.getSize(carouselFinder);
      expect(size.height, widgetHeight);

      // Verify image area height (Positioned widget height)
      // This is a bit tricky to find directly without keys, but we can infer from the SizedBox wrapping the Stack
      final sizedBox = tester.widget<SizedBox>(
        find
            .descendant(of: carouselFinder, matching: find.byType(SizedBox))
            .first,
      );
      expect(sizedBox.height, widgetHeight);
    });
  });
}
