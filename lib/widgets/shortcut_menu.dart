import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mcp_test_app/config/themes/theme_color.dart';


// This widget represents a single item in a shortcut menu.
class ShortcutMenuItem extends StatelessWidget {
  /// The text label for the shortcut item.
  final String label;

  /// The icon widget to display. If null, a default transfer icon is used.
  final Widget? icon;

  /// The color for the top arrow of the transfer icon.
  /// Defaults to yellow (#F2C564).
  final Color topArrowColor;

  /// The color for the bottom arrow of the transfer icon.
  /// If null, defaults to the theme's 'text/base/600' color.
  final Color? bottomArrowColor;

  const ShortcutMenuItem({
    super.key,
    required this.label,
    this.icon,
    this.topArrowColor = const Color(0xFFF2C564),
    this.bottomArrowColor,
  });
  
  Color _getBottomArrowColor(BuildContext context) {
    if (bottomArrowColor != null) {
      return bottomArrowColor!;
    }
    return ThemeColors.get(
      Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
      'text/base/600',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString('lib/assets/images/arrow-data-transfer-horizontal.svg'),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox.shrink();
        }
        
        // Replace colors in the SVG
        String svgData = snapshot.data!;
        svgData = svgData.replaceAll(
          'stroke="#F2C564"', 
          'stroke="#${topArrowColor.toARGB32().toRadixString(16).substring(2)}"'
        );
        final arrowColor = _getBottomArrowColor(context);
        svgData = svgData.replaceAll(
          'stroke="white"', 
          'stroke="#${arrowColor.toARGB32().toRadixString(16).substring(2)}"'
        );
        
        return _buildContent(svgData, context);
      },
    );
  }
  
  Widget _buildContent(String svgData, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: ThemeColors.get(
              Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
              'fill/base/300',
            ),
            borderRadius: BorderRadius.circular(46),
          ),
          child: Center(
            child: icon ??
                SizedBox(
                  width: 24,
                  height: 24,
                  child: SvgPicture.string(
                    svgData,
                    width: 24,
                    height: 24,
                  ),
                ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: ThemeColors.get(
              Theme.of(context).brightness == Brightness.light ? 'light' : 'dark',
              'text/base/600',
            ),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

}


