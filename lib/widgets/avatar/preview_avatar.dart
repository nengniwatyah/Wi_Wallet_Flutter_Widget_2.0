import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';
import 'avatar.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,
          home: const PreviewAvatarPage(),
        );
      },
    );
  }
}

class PreviewAvatarPage extends StatelessWidget {
  const PreviewAvatarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';

    return Scaffold(
      backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/300'),
      appBar: AppBar(
        title: const Text('Avatar Preview'),
        backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/100'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return IconButton(
                icon: Icon(
                  themeProvider.themeMode == ThemeMode.light
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(context, 'Default (Asset)', brightnessKey),
              const Avatar(
                radius: 24,
                isLoading: false,
                assetPath: 'lib/assets/images/avatar-demo.png',
                name: '****6789',
                handle: 'Tony Stark',
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(context, 'Status Danger', brightnessKey),
              const Avatar(
                radius: 24,
                isLoading: false,
                assetPath: 'lib/assets/images/avatar-demo.png',
                name: '****6789',
                handle: 'Tony Stark',
                status: AvatarStatus.danger,
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(context, 'Status Warning', brightnessKey),
              const Avatar(
                radius: 24,
                isLoading: false,
                assetPath: 'lib/assets/images/avatar-demo.png',
                name: '****6789',
                handle: 'Tony Stark',
                status: AvatarStatus.warning,
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(context, 'Empty State', brightnessKey),
              const Avatar(
                radius: 24,
                isLoading: false,
                name: 'New User',
                handle: 'New User',
                // No imageUrl or assetPath provided, triggers empty state
              ),
              const SizedBox(height: 24),
              _buildSectionHeader(context, 'Loading State', brightnessKey),
              const Avatar(
                radius: 24,
                isLoading: true,
                name: 'Loading Name',
                handle: 'Loading Handle',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    String brightnessKey,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: ThemeColors.get(brightnessKey, 'text/base/600'),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
