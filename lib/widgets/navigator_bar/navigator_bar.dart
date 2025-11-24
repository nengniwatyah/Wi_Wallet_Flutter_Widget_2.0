import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mcp_test_app/assets/hugeicons/huge_icons.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:provider/provider.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

// ============================================================================
// REUSABLE WIDGET: NavigatorBar
// ============================================================================
// To use this widget in your project, copy the following:
// 1. Icon paths constants (lines below)
// 2. NavigatorBar class (search for "START: NavigatorBar Widget")
// ============================================================================

// Icon paths
const String homeIcon = 'lib/assets/images/home-09.svg';
const String depositIcon = 'lib/assets/images/wallet-add-02.svg';
const String convertIcon = 'lib/assets/images/exchange-03.svg';
const String settingIcon = 'lib/assets/images/list-setting.svg';
const String irisScanIcon = 'lib/assets/images/iris-scan.svg';

// ============================================================================
// PREVIEW ONLY: ThemeProvider, LocaleProvider, main(), NavigatorBarPreview
// ============================================================================
// The code below is for preview/testing purposes only.
// You don't need to copy this to your project.
// ============================================================================

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
      child: const NavigatorBarPreview(),
    ),
  );
}

class NavigatorBarPreview extends StatelessWidget {
  const NavigatorBarPreview({super.key});

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
    return Consumer2<ThemeProvider, LocaleProvider>(
      builder: (context, themeProvider, localeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeProvider.locale,
          theme: ThemeData.light().copyWith(
            textTheme: localeProvider.locale?.languageCode == 'th'
                ? GoogleFonts.notoSansThaiTextTheme()
                : GoogleFonts.notoSansTextTheme(),
          ),
          darkTheme: ThemeData.dark().copyWith(
            textTheme: localeProvider.locale?.languageCode == 'th'
                ? GoogleFonts.notoSansThaiTextTheme()
                : GoogleFonts.notoSansTextTheme(),
          ),
          themeMode: themeProvider.themeMode,
          home: Builder(
            builder: (context) {
              final brightnessKey = Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Navigator Bar Preview'),
                  actions: [
                    IconButton(
                      icon: Icon(
                        themeProvider.themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
                      ),
                      onPressed: () => themeProvider.toggleTheme(),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
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
                ),
                extendBody: true,
                bottomNavigationBar: NavigatorBar(),
              );
            },
          ),
        );
      },
    );
  }
}

// ============================================================================
// START: NavigatorBar Widget
// ============================================================================
// Copy this class to use NavigatorBar in your project.
// Dependencies required:
// - ThemeColors.get() for design tokens
// - createHugeIcon() for SVG icons
// - AppLocalizations for i18n
// ============================================================================

class NavigatorBar extends StatelessWidget {
  const NavigatorBar({super.key, this.opacity = 0.9});

  final double opacity; // 0.0 to 1.0
  
  // Scan button constants
  static const double _scanButtonSize = 56.0; // Total button diameter
  static const double _scanButtonPadding = 12.0; // Button padding
  static const double _scanIconSize = 32.0; // Icon size

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.viewPadding.bottom > 0 
        ? mediaQuery.viewPadding.bottom 
        : mediaQuery.padding.bottom;
    final brightnessKey = Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 62.0,
              decoration: BoxDecoration(
                color: ThemeColors.get(
                  Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                  'fill/base/300'
                ).withValues(alpha: opacity),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                border: Border(
                  top: BorderSide(
                    color: ThemeColors.get(
                      Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                      'alt/base/300'
                    ),
                    width: 1,
                  ),
                ),
              ),
              child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      createHugeIcon(homeIcon, ThemeColors.get(
                        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                        'text/base/600'
                      ), width: 24.0, height: 24.0),
                      Text(
                        AppLocalizations.of(context)!.navigatorHome,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                          color: ThemeColors.get(
                            Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                            'text/base/600'
                          ),
                          letterSpacing: 0.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      createHugeIcon(
                        depositIcon,
                        ThemeColors.get(
                          Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                          'stroke/contrast/600'
                        ),
                        width: 24.0,
                        height: 24.0,
                      ),
                      Text(
                        AppLocalizations.of(context)!.navigatorHomeDeposit,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                          color: ThemeColors.get(
                            Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                            'stroke/contrast/600'
                          ),
                          letterSpacing: 0.0,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 72.0),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      createHugeIcon(
                        convertIcon,
                        ThemeColors.get(
                          Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                          'stroke/contrast/600'
                        ),
                        width: 24.0,
                        height: 24.0,
                      ),
                      Text(
                        AppLocalizations.of(context)!.navigatorHomeConvert,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                          color: ThemeColors.get(
                            Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                            'stroke/contrast/600'
                          ),
                          letterSpacing: 0.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      createHugeIcon(
                        settingIcon,
                        ThemeColors.get(
                          Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                          'stroke/contrast/600'
                        ),
                        width: 24.0,
                        height: 24.0,
                      ),
                      Text(
                        AppLocalizations.of(context)!.navigatorHomeSetting,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontSize: Theme.of(context).textTheme.labelSmall!.fontSize,
                          color: ThemeColors.get(
                            Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                            'stroke/contrast/600'
                          ),
                          letterSpacing: 0.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
            ),
          ),
        ),
                Positioned(
                  bottom: 18,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: SizedBox(
                      width: _scanButtonSize,
                      height: _scanButtonSize,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle scan button tap
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(_scanButtonPadding),
                          backgroundColor: ThemeColors.get(
                            Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                            'primary/400'
                          ),
                          foregroundColor: ThemeColors.get(
                            Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                            'fill/contrast/600'
                          ),
                          side: BorderSide(
                            color: ThemeColors.get(
                              Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                              'stroke/contrast/600'
                            ),
                            width: 1,
                          ),
                        ),
                        child: createHugeIcon(
                          irisScanIcon,
                          ThemeColors.get(
                            Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
                            'fill/contrast/600'
                          ),
                          width: _scanIconSize,
                          height: _scanIconSize,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        if (bottomPadding > 0)
          ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: bottomPadding,
                color: ThemeColors.get(brightnessKey, 'fill/base/300').withValues(alpha: opacity),
              ),
            ),
          ),
      ],
    );
  }
}

// ============================================================================
// END: NavigatorBar Widget
// ============================================================================
