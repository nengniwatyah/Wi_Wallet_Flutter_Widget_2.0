import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mcp_test_app/main.dart'; // Import your main.dart where MyApp and providers are defined

void main() {
  group('Font Localization Tests', () {
    testWidgets('Noto Sans Thai is used for Thai locale', (WidgetTester tester) async {
      final localeProvider = LocaleProvider();
      localeProvider.setLocale(const Locale('th'));

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider.value(value: localeProvider),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Get the TextTheme from the MaterialApp
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      final textTheme = materialApp.theme?.textTheme;

      // Verify that a specific text style (e.g., bodyMedium) uses Noto Sans Thai
      expect(textTheme?.bodyMedium?.fontFamily, startsWith('NotoSansThai'));
      expect(textTheme?.headlineMedium?.fontFamily, startsWith('NotoSansThai'));
      expect(textTheme?.titleLarge?.fontFamily, startsWith('NotoSansThai'));
    });

    testWidgets('Noto Sans is used for English locale', (WidgetTester tester) async {
      final localeProvider = LocaleProvider();
      localeProvider.setLocale(const Locale('en'));

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemeProvider()),
            ChangeNotifierProvider.value(value: localeProvider),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Get the TextTheme from the MaterialApp
      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      final textTheme = materialApp.theme?.textTheme;

      // Verify that a specific text style (e.g., bodyMedium) uses Noto Sans
      expect(textTheme?.bodyMedium?.fontFamily, startsWith('NotoSans'));
      expect(textTheme?.headlineMedium?.fontFamily, startsWith('NotoSans'));
      expect(textTheme?.titleLarge?.fontFamily, startsWith('NotoSans'));
      expect(textTheme?.bodyMedium?.fontFamily, isNot(startsWith('NotoSansThai')));
    });
  });
}
