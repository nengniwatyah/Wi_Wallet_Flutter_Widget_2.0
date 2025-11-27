import 'package:flutter/material.dart';
import 'package:mcp_test_app/widgets/loading/pre_loading.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:provider/provider.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';
import 'package:mcp_test_app/providers/theme_provider.dart';
import 'package:mcp_test_app/providers/locale_provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: const PreviewPreLoadingApp(),
    ),
  );
}

class PreviewPreLoadingApp extends StatelessWidget {
  const PreviewPreLoadingApp({super.key});

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
            textTheme:
                localeProvider.locale?.languageCode == 'th'
                    ? GoogleFonts.notoSansThaiTextTheme()
                    : GoogleFonts.notoSansTextTheme(),
          ),
          darkTheme: ThemeData.dark().copyWith(
            textTheme:
                localeProvider.locale?.languageCode == 'th'
                    ? GoogleFonts.notoSansThaiTextTheme()
                    : GoogleFonts.notoSansTextTheme(),
          ),
          themeMode: themeProvider.themeMode,
          home: const PreviewPreLoadingPage(),
        );
      },
    );
  }
}

class PreviewPreLoadingPage extends StatefulWidget {
  const PreviewPreLoadingPage({super.key});

  @override
  State<PreviewPreLoadingPage> createState() => _PreviewPreLoadingPageState();
}

class _PreviewPreLoadingPageState extends State<PreviewPreLoadingPage> {
  final bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    return Scaffold(
      backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/300'),
      appBar: AppBar(
        title: Text(
          'PreLoading Preview',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: ThemeColors.get(brightnessKey, 'text/base/600'),
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/100'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                  color: ThemeColors.get(brightnessKey, 'text/base/600'),
                ),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Content to demonstrate blur
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: 20,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        Colors.primaries[index % Colors.primaries.length],
                    child: Text('${index + 1}'),
                  ),
                  title: Text('List Item ${index + 1}'),
                  subtitle: const Text(
                    'This content should be blurred when loading is active.',
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                ),
              );
            },
          ),

          // PreLoading Overlay
          if (_isLoading) const PreLoading(),
        ],
      ),
    );
  }
}
