import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:mcp_test_app/config/themes/base_theme.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';

// Import the generated directories variable
import 'widgetbook.directories.g.dart';

void main() {
  runApp(const WidgetbookApp());
}

@widgetbook.App()
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // Use the generated directories variable
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: ThemeData.from(
                colorScheme: BaseTheme.lightColorScheme,
                useMaterial3: true,
              ).copyWith(
                scaffoldBackgroundColor: ThemeColors.get(
                  'light',
                  'fill/base/300',
                ),
              ),
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: ThemeData.from(
                colorScheme: BaseTheme.darkColorScheme,
                useMaterial3: true,
              ).copyWith(
                scaffoldBackgroundColor: ThemeColors.get(
                  'dark',
                  'fill/base/300',
                ),
              ),
            ),
          ],
        ),
        TextScaleAddon(min: 1.0, max: 2.0),
        LocalizationAddon(
          locales: const [Locale('en'), Locale('th')],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
        ),
        InspectorAddon(enabled: true),
      ],
    );
  }
}
