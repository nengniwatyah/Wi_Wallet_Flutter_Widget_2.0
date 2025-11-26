import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/widgets/image_carousel/image_carousel.dart';

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
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.themeMode,
          home: const PreviewImageCarousel(),
        );
      },
    );
  }
}

class PreviewImageCarousel extends StatefulWidget {
  const PreviewImageCarousel({super.key});

  @override
  State<PreviewImageCarousel> createState() => _PreviewImageCarouselState();
}

class _PreviewImageCarouselState extends State<PreviewImageCarousel> {
  int _countdown = 6;
  late final Stream<int> _timerStream;

  @override
  void initState() {
    super.initState();
    _timerStream = Stream.periodic(const Duration(seconds: 1), (i) {
      if (_countdown == 1) {
        _countdown = 6;
      } else {
        _countdown--;
      }
      return _countdown;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.themeMode == ThemeMode.dark;
    final brightnessKey = isDark ? 'dark' : 'light';

    // Example list of banner image paths
    final List<String> bannerPaths = [
      'lib/assets/images/test-banner.png',
      'lib/assets/images/test-banner2.png',
      'lib/assets/images/test-banner3.png',
      'lib/assets/images/test-banner4.png',
      'lib/assets/images/test-banner5.png',
    ];

    return Scaffold(
      backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/100'),
      appBar: AppBar(
        title: Text(
          'Image Carousel Preview',
          style: TextStyle(
            color: ThemeColors.get(brightnessKey, 'text/base/600'),
          ),
        ),
        backgroundColor: ThemeColors.get(brightnessKey, 'fill/base/100'),
        actions: [
          Row(
            children: [
              Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                color: ThemeColors.get(brightnessKey, 'text/base/600'),
              ),
              Switch(
                value: isDark,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Auto Play Carousel',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: ThemeColors.get(brightnessKey, 'text/base/600'),
                  ),
                ),
                StreamBuilder<int>(
                  stream: _timerStream,
                  initialData: 6,
                  builder: (context, snapshot) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: ThemeColors.get(brightnessKey, 'primary/400'),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Next slide in: ${snapshot.data}s',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ImageCarousel(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 6),
              pages:
                  bannerPaths.map((path) {
                    return AspectRatio(
                      aspectRatio: 343 / 134,
                      child: Image.asset(path, fit: BoxFit.cover),
                    );
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
