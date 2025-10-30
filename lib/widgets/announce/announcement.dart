import 'package:flutter/material.dart';
import 'package:mcp_test_app/assets/hugeicons/huge_icons.dart';
import 'package:mcp_test_app/config/themes/theme_constants.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart' as theme;
import 'package:mcp_test_app/generated/intl/app_localizations.dart';


// Preview widget for AnnouncementStack
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Announcement Preview',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: const Center(
          child: AnnouncementStackPreview(),
        ),
      ),
    );
  }
}

class AnnouncementStackPreview extends StatelessWidget {
  const AnnouncementStackPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.announcement,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: theme.ThemeColors.get('light', 'text/contrast/600'),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: 375, // iPhone 8 width
            padding: const EdgeInsets.all(16),
            child: AnnouncementStack(
              messages: const [
                'The money withdrawal system will return to service as usual. From 31/05/2022 at 4:30 PM (Thailand time) onwards.',
                'We are currently upgrading our security infrastructure. Services will resume by 31/05/2022 at 5:00 PM (Thailand time).',
                'Your account has been verified successfully. All features are now fully accessible from 01/06/2022 at 8:00 AM (Thailand time).',
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(AppLocalizations.of(context)!.viewAll),
        ],
      ),
    );
  }
}

class AnnouncementStack extends StatefulWidget {
  const AnnouncementStack({
    super.key, 
    this.messages = const [], 
    this.onClose,
    this.debugMode = false
  });

  final List<String> messages;
  final VoidCallback? onClose;
  final bool debugMode;

  @override
  State<AnnouncementStack> createState() => _AnnouncementStackState();
}

class _AnnouncementStackState extends State<AnnouncementStack>
    with TickerProviderStateMixin {
  late List<String> _messages;

  late AnimationController _slideOutController;
  late Animation<Offset> _slideOutAnimation;
  late AnimationController _promoteController;
  late Animation<Offset> _promoteAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    // Initialize messages
    _messages =
        widget.messages.isNotEmpty
            ? List.from(widget.messages)
            : [
              'The money withdrawal system will return to service as usual. From 31/05/2022 at 4:30 PM (Thailand time) onwards.',
              'We are currently upgrading our security infrastructure. Services will resume by 31/05/2022 at 5:00 PM (Thailand time).',
              'Your account has been verified successfully. All features are now fully accessible from 01/06/2022 at 8:00 AM (Thailand time).',
            ];

    // Initialize animations
    _slideOutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideOutAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.2, 0),
    ).animate(
      CurvedAnimation(parent: _slideOutController, curve: Curves.easeInOut),
    );

    _promoteController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _promoteAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _promoteController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didUpdateWidget(AnnouncementStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages != oldWidget.messages) {
      setState(() {
        _messages = List.from(widget.messages);
      });
    }
  }

  @override
  void dispose() {
    _slideOutController.dispose();
    _promoteController.dispose();
    super.dispose();
  }

  Future<void> _handleClose() async {
    if (_isAnimating || _messages.length <= 1) return;
    _isAnimating = true;

    await _slideOutController.forward();

    setState(() {
      final removed = _messages.removeAt(0);
      _messages.add(removed);
    });

    _slideOutController.reset();
    await _promoteController.forward();
    _promoteController.reset();

    _isAnimating = false;
    widget.onClose?.call();
  }

  void updateMessages(List<String> newMessages) {
    if (mounted) {
      setState(() {
        _messages = List.from(newMessages);
      });
    }
  }

  Widget _buildCard(String text, {bool isFront = false, Color? color}) {
    return Container(
      constraints: const BoxConstraints(minHeight: 65),
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        8,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: createHugeIcon(
              megaphoneIcon,
              theme.ThemeColors.get('light', 'text/contrast/600'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: theme.ThemeColors.get('light', 'text/contrast/600'),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (isFront)
            GestureDetector(
              onTap: _handleClose,
              child: createHugeIcon(
                cancelIcon,
                theme.ThemeColors.get('light', 'text/contrast/600'),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            key: const ValueKey('card_3'),
            top: 0,
            left: 16,
            right: 16,
            child: Transform.scale(
              scale: 0.9,
              alignment: Alignment.topCenter,
              child: Container(
                constraints: const BoxConstraints(minHeight: 65),
                decoration: BoxDecoration(
                  color: theme.ThemeColors.get('light', 'fill/base/300'),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Positioned(
            key: const ValueKey('card_2'),
            top: AppSpacing.xs,
            left: AppSpacing.md,
            right: AppSpacing.md,
            child: SlideTransition(
              position: _promoteAnimation,
              child: Transform.scale(
                scale: 0.95,
                alignment: Alignment.topCenter,
                child: _buildCard(_messages[1], color: const Color(0xFF141414)),
              ),
            ),
          ),
          Positioned(
            key: const ValueKey('card_1'),
            top: 0,
            left: 16,
            right: 16,
            child: SlideTransition(
              position: _slideOutAnimation,
              child: _buildCard(
                _messages[0],
                isFront: true,
                color: const Color(0xFF1A1A1A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
