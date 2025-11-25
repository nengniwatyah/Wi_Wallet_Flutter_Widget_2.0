import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart' as theme;

enum SnackBarType { success, warning, error }

class SnackBarWidget extends StatelessWidget {
  const SnackBarWidget({
    super.key,
    required this.title,
    required this.description,
    required this.type,
    this.onClose,
  });

  final String title;
  final String description;
  final SnackBarType type;
  final VoidCallback? onClose;

  static void show(
    BuildContext context, {
    required String title,
    required String description,
    required SnackBarType type,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SnackBarWidget(
          title: title,
          description: description,
          type: type,
          onClose: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: EdgeInsets.zero,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  String get _iconPath {
    switch (type) {
      case SnackBarType.success:
        return 'lib/assets/images/checkmark-circle-01.svg';
      case SnackBarType.warning:
        return 'lib/assets/images/Alert Icon.svg';
      case SnackBarType.error:
        return 'lib/assets/images/cancel-circle.svg';
    }
  }

  String get _backgroundColorKey {
    switch (type) {
      case SnackBarType.success:
        return 'success/600';
      case SnackBarType.warning:
        return 'warning/600';
      case SnackBarType.error:
        return 'danger/600';
    }
  }

  String get _textColorKey {
    switch (type) {
      case SnackBarType.success:
        return 'text/base/success';
      case SnackBarType.warning:
        return 'text/base/warning';
      case SnackBarType.error:
        return 'text/base/danger';
    }
  }

  String get _iconColorKey {
    switch (type) {
      case SnackBarType.success:
        return 'success/500';
      case SnackBarType.warning:
        return 'warning/500';
      case SnackBarType.error:
        return 'danger/500';
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    final backgroundColor = theme.ThemeColors.get(
      brightnessKey,
      _backgroundColorKey,
    );
    final textColor = theme.ThemeColors.get(brightnessKey, _textColorKey);
    final iconColor = theme.ThemeColors.get(brightnessKey, _iconColorKey);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          SvgPicture.asset(
            _iconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.notoSansThaiTextTheme().bodySmall
                      ?.copyWith(
                        color: textColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.notoSansThaiTextTheme().bodySmall
                      ?.copyWith(
                        color: textColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                ),
              ],
            ),
          ),
          // Close Button
          if (onClose != null)
            GestureDetector(
              onTap: onClose,
              child: SvgPicture.asset(
                'lib/assets/images/cancel-01.svg',
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),
              ),
            ),
        ],
      ),
    );
  }
}
