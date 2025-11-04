import 'package:flutter/material.dart';
import 'package:mcp_test_app/config/themes/base_theme.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';
import 'package:mcp_test_app/widgets/card/card_review_transaction.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
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

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;

  Locale? get locale => _locale;

  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }
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
          theme: ThemeData.from(
            colorScheme: BaseTheme.lightColorScheme,
            useMaterial3: true,
          ).copyWith(
            textTheme: GoogleFonts.notoSansThaiTextTheme(),
            scaffoldBackgroundColor: ThemeColors.get('light', 'fill/base/300'),
          ),
          darkTheme: ThemeData.from(
            colorScheme: BaseTheme.darkColorScheme,
            useMaterial3: true,
          ).copyWith(
            textTheme: GoogleFonts.notoSansThaiTextTheme(),
            scaffoldBackgroundColor: ThemeColors.get('dark', 'fill/base/300'),
          ),
          themeMode: themeProvider.themeMode,
          home: const CardReviewTransactionPreview(),
        );
      },
    );
  }
}

class CardReviewTransactionPreview extends StatelessWidget {
  const CardReviewTransactionPreview({super.key});

  DropdownMenuItem<Locale> _buildDropdownItem(
    BuildContext context,
    Locale locale,
    String text,
    String brightnessKey,
  ) {
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
    for (final locale in AppLocalizations.supportedLocales) {
      if (locale.languageCode == currentLocale.languageCode) {
        return locale;
      }
    }
    return const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    final brightnessKey = Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/100'),
      appBar: AppBar(
        title: Text(l10n.cardReviewPreviewTitle),
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
            CardReviewTransaction(
              totalAmount: l10n.cardReviewTotalAmountMock,
              feeAmount: l10n.cardReviewFeeAmountMock,
              currency: l10n.cardReviewCurrencyMock,
              fromLabel: l10n.cardReviewFromLabel,
              fromValue: l10n.cardReviewFromValueMock,
              mobileLabel: l10n.cardReviewMobileLabel,
              mobileValue: l10n.cardReviewMobileValueMock,
              toLabel: l10n.cardReviewToLabel,
              toValue: l10n.cardReviewToValueMock,
              accountNameLabel: l10n.cardReviewAccountNameLabel,
              accountNameValue: l10n.cardReviewAccountNameValueMock,
              accountNumberLabel: l10n.cardReviewAccountNumberLabel,
              accountNumberValue: l10n.cardReviewAccountNumberValueMock,
            ),
          ],
        ),
      ),
    );
  }
}
