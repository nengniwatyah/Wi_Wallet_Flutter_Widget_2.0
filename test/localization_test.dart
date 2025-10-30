import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';

void main() {
  group('Localization Tests for All Supported Languages', () {
    // Define a map of expected localized strings for app_name and welcome_message
    final Map<String, Map<String, String>> localizedStrings = {
      'en': {
        'app_name': 'Test App',
        'welcome_message': 'Welcome',
      },
      'my': {
        'app_name': 'စမ်းသပ်အက်ပ်',
        'welcome_message': 'ကြိုဆိုပါတယ်',
      },
      'ru': {
        'app_name': 'Тестовое приложение',
        'welcome_message': 'Добро пожаловать',
      },
      'th': {
        'app_name': 'แอปทดสอบ',
        'welcome_message': 'ยินดีต้อนรับ',
      },
      'zh': {
        'app_name': '测试应用',
        'welcome_message': '欢迎',
      },
    };

    // Iterate over each supported locale and create a test case
    localizedStrings.forEach((languageCode, expectedValues) {
      testWidgets('Localization for $languageCode loads correctly', (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: localizedStrings.keys.map((code) => Locale(code)).toList(),
            locale: Locale(languageCode),
            home: Builder(
              builder: (BuildContext context) {
                return Column(
                  children: [
                    Text(AppLocalizations.of(context)!.app_name),
                    Text(AppLocalizations.of(context)!.welcome_message),
                  ],
                );
              },
            ),
          ),
        );

        // Verify app_name
        expect(find.text(expectedValues['app_name']!), findsOneWidget);
        // Verify welcome_message
        expect(find.text(expectedValues['welcome_message']!), findsOneWidget);
      });
    });
  });
}
