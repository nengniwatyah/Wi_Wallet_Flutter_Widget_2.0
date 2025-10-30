import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';
import 'package:mcp_test_app/widgets/buttons.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeProvider.locale,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,
          home: const PreviewButtons(),
        );
      },
    );
  }
}

class PreviewButtons extends StatelessWidget {
  const PreviewButtons({super.key});

  DropdownMenuItem<Locale> _buildDropdownItem(BuildContext context, Locale locale, String text, String brightnessKey) {
    return DropdownMenuItem(
      value: locale,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: ThemeColors.get(brightnessKey, 'text/base/600'),
        ),
      ),
    );
  }

  Locale _getCurrentLocale(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);
    for (var locale in AppLocalizations.supportedLocales) {
      if (locale.languageCode == currentLocale.languageCode) {
        return locale;
      }
    }
    return const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    final brightnessKey = Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    return Scaffold(
      backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/300'),
      appBar: AppBar(
        title: const Text('Buttons Preview'),
        backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/100'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: ThemeColors.get(brightnessKey, 'fill/base/100'),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Locale>(
                    value: _getCurrentLocale(context),
                    isExpanded: true,
                    icon: Icon(Icons.language, color: ThemeColors.get(brightnessKey, 'text/base/600')),
                    dropdownColor: ThemeColors.get(brightnessKey, 'fill/base/200'),
                    items: [
                      _buildDropdownItem(context, const Locale('en'), 'English', brightnessKey),
                      _buildDropdownItem(context, const Locale('th'), 'ภาษาไทย', brightnessKey),
                      _buildDropdownItem(context, const Locale('zh'), '中文', brightnessKey),
                      _buildDropdownItem(context, const Locale('ru'), 'Русский', brightnessKey),
                      _buildDropdownItem(context, const Locale('my'), 'မြန်မာ', brightnessKey),
                    ],
                    onChanged: (Locale? newLocale) {
                      if (newLocale != null) {
                        Provider.of<LocaleProvider>(context, listen: false).setLocale(newLocale);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: ThemeColors.get(brightnessKey, 'fill/base/100'),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
      
                  children: [
                    Text(
                      'Primary Enabled',
                      style: TextStyle(
                        color: ThemeColors.get(brightnessKey, 'text/base/600'),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Buttons(
                      text: AppLocalizations.of(context)!.primaryButton,
                      type: ButtonType.primary,
                      enabled: true,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Primary button pressed')),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Secondary Enabled',
                      style: TextStyle(
                        color: ThemeColors.get(brightnessKey, 'text/base/600'),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Buttons(
                      text: AppLocalizations.of(context)!.secondaryButton,
                      type: ButtonType.secondary,
                      enabled: true,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Secondary button pressed')),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Secondary Disabled',
                      style: TextStyle(
                        color: ThemeColors.get(brightnessKey, 'text/base/600'),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Buttons(
                      text: AppLocalizations.of(context)!.secondaryButton,
                      type: ButtonType.secondary,
                      enabled: false,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Amount Enabled',
                      style: TextStyle(
                        color: ThemeColors.get(brightnessKey, 'text/base/600'),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Buttons(
                      text: '฿100',
                      type: ButtonType.amount,
                      enabled: true,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Amount button pressed')),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
