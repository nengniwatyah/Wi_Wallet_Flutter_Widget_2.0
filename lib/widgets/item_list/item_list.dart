import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';

enum ItemListType { common, transaction }

class ItemList extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? iconPath;
  final VoidCallback? onTap;
  final String? trailingText;
  final bool?
  isSelected; // If not null, shows radio button. true = checked, false = unchecked.
  final ItemListType type;
  final String? amount;
  final Color? amountColor;

  const ItemList({
    super.key,
    this.title = 'History',
    this.subtitle,
    this.iconPath,
    this.onTap,
    this.trailingText,
    this.isSelected,
    this.type = ItemListType.common,
    this.amount,
    this.amountColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeMode =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: type == ItemListType.transaction ? 72 : 56,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: ThemeColors.get(themeMode, 'fill/base/300'),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Leading Icon
            SizedBox(
              width: type == ItemListType.transaction ? 40 : 24,
              height: type == ItemListType.transaction ? 40 : 24,
              child:
                  type == ItemListType.transaction
                      ? SvgPicture.asset(
                        'lib/assets/images/logo-wi.svg',
                        width: 40,
                        height: 40,
                      )
                      : (iconPath != null
                          ? SvgPicture.asset(iconPath!, width: 24, height: 24)
                          : _buildPlaceholderIcon(context, themeMode)),
            ),
            const SizedBox(width: 12),
            // Title & Subtitle
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: 'Noto Sans Thai',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 16 / 13,
                      color: ThemeColors.get(themeMode, 'text/base/600'),
                    ),
                  ),
                  if (subtitle != null && type == ItemListType.transaction) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontFamily: 'Noto Sans Thai',
                        fontSize: 10, // Updated to 10px as per Figma
                        fontWeight: FontWeight.w400,
                        height: 12 / 10, // Updated line height
                        color: ThemeColors.get(themeMode, 'text/base/400'),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            // Trailing Widget
            _buildTrailingWidget(context, themeMode),
          ],
        ),
      ),
    );
  }

  Widget _buildTrailingWidget(BuildContext context, String themeMode) {
    if (type == ItemListType.transaction && amount != null) {
      return Text(
        amount!,
        style: TextStyle(
          fontFamily: 'Noto Sans Thai',
          fontSize: 13,
          fontWeight: FontWeight.w600,
          height: 16 / 13,
          color: amountColor ?? ThemeColors.get(themeMode, 'text/base/success'),
        ),
      );
    } else if (isSelected != null) {
      // Radio Button State
      return SizedBox(
        width: 24,
        height: 24,
        child: SvgPicture.asset(
          isSelected!
              ? 'lib/assets/images/radio_button_check.svg'
              : 'lib/assets/images/radio_button_uncheck.svg',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
          colorFilter:
              isSelected!
                  ? null // Keep original color for checked (usually yellow/primary)
                  : ColorFilter.mode(
                    ThemeColors.get(themeMode, 'text/base/600'),
                    BlendMode.srcIn,
                  ),
        ),
      );
    } else if (trailingText != null) {
      // Text State
      return Text(
        trailingText!,
        style: TextStyle(
          fontFamily: 'Noto Sans Thai',
          fontSize: 13,
          fontWeight:
              FontWeight.w500, // Assuming medium weight for trailing text
          height: 16 / 13,
          color: ThemeColors.get(themeMode, 'text/base/600'),
        ),
      );
    } else {
      // Default Arrow State
      return SizedBox(
        width: 24,
        height: 24,
        child: SvgPicture.asset(
          'lib/assets/images/arrow-right-01.svg',
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            ThemeColors.get(themeMode, 'primary/400'),
            BlendMode.srcIn,
          ),
        ),
      );
    }
  }

  Widget _buildPlaceholderIcon(BuildContext context, String themeMode) {
    return SvgPicture.asset(
      'lib/assets/images/Transaction History.svg',
      width: 24,
      height: 24,
      colorFilter: ColorFilter.mode(
        ThemeColors.get(themeMode, 'text/base/600'),
        BlendMode.srcIn,
      ),
    );
  }
}
