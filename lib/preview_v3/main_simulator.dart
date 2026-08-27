import 'package:flutter/material.dart';

import '../widgets/v3/splash/preview_v3_splash_animation.dart';
import 'preview_app.dart';

/// Native debug entrypoint for the Widget V3 preview host.
///
/// Select a preview with `--dart-define=V3_PREVIEW_SLUG=<category>/<Widget>`.
///
/// Every run through this entrypoint plays the "wi splash"
/// [V3SplashAnimationPreview] first as a pre-loading screen, then redirects
/// to the requested preview (resolved the same way [V3PreviewRoute] always
/// has, via [rawSlug]).
///
/// Exception: when [rawSlug] itself resolves to the splash preview (e.g.
/// `V3_PREVIEW_SLUG=splash/V3SplashAnimation`), the destination screen omits
/// the CTA — looping "back to splash" while already viewing
/// [V3SplashAnimationPreview] has nothing meaningful to do, and this keeps
/// that debug view identical to the raw preview file's own output. This is
/// handled in `_V3SimulatorLoopDestination`, not in
/// `preview_v3_splash_animation.dart` itself, which has no knowledge of the
/// CTA or this loop.
///
/// See `docs/v3/V3_SIMULATOR_DEBUG_PREVIEW.md` for the operational source of
/// truth on this behavior.
///
/// Simulator-only default: when `V3_PREVIEW_SLUG` is not passed, this
/// entrypoint opens [_defaultSimulatorPreviewSlug] instead of falling back to
/// the registry's first entry (what [V3PreviewRoute] does when `main.dart`
/// Web or `preview_app.dart` are used with an empty slug). This keeps the
/// Simulator debug flow landing on a stable, chosen destination across runs
/// without touching the shared Web-facing default.
const _defaultSimulatorPreviewSlug = 'header/V3Header';

void main() {
  const rawSlug = String.fromEnvironment('V3_PREVIEW_SLUG');
  final effectiveSlug =
      rawSlug.trim().isEmpty ? _defaultSimulatorPreviewSlug : rawSlug;
  runApp(V3SimulatorSplashLoopApp(rawSlug: effectiveSlug));
}

class V3SimulatorSplashLoopApp extends StatelessWidget {
  const V3SimulatorSplashLoopApp({super.key, required this.rawSlug});

  final String rawSlug;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Widget V3 Simulator Debug Preview',
      home: V3SimulatorSplashLoopHost(rawSlug: rawSlug),
    );
  }
}

/// Owns the splash <-> destination loop state so neither
/// [V3SplashAnimationPreview] nor [V3PreviewRoute] needs to know about the
/// other.
class V3SimulatorSplashLoopHost extends StatefulWidget {
  const V3SimulatorSplashLoopHost({super.key, required this.rawSlug});

  final String rawSlug;

  @override
  State<V3SimulatorSplashLoopHost> createState() =>
      _V3SimulatorSplashLoopHostState();
}

class _V3SimulatorSplashLoopHostState extends State<V3SimulatorSplashLoopHost> {
  bool _showSplash = true;

  void _goToDestination() => setState(() => _showSplash = false);

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return V3SplashAnimationPreview(
        key: const ValueKey('v3-simulator-splash-loop-splash'),
        onCompleted: _goToDestination,
      );
    }
    return _V3SimulatorLoopDestination(
      key: const ValueKey('v3-simulator-splash-loop-destination'),
      rawSlug: widget.rawSlug,
    );
  }
}

/// Renders the requested preview using the same resolution
/// [V3PreviewRoute] always uses.
class _V3SimulatorLoopDestination extends StatelessWidget {
  const _V3SimulatorLoopDestination({super.key, required this.rawSlug});

  final String rawSlug;

  @override
  Widget build(BuildContext context) {
    return V3PreviewRoute(rawSlug: rawSlug);
  }
}
