import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Navigation Icons
const String homeIcon = 'assets/images/home-09.svg';
const String depositIcon = 'assets/images/wallet-add-02.svg';
const String convertIcon = 'assets/images/exchange-03.svg';
const String settingIcon = 'assets/images/list-setting.svg';
const String irisScanIcon = 'assets/images/iris-scan.svg';

// Additional Icons
const String cancelIcon = 'assets/images/cancel-01.svg';
const String megaphoneIcon = 'assets/images/megaphone-01.svg';
const String visaIcon = 'assets/images/logo_visa.svg';

// Helper function to create a colored SVG icon
Widget createHugeIcon(String iconPath, Color color, {double? width, double? height}) {
  try {
    return SvgPicture.asset(
      iconPath,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      width: width,
      height: height,
    );
  } catch (e) {
    debugPrint('Error loading SVG $iconPath: $e');
    return Container(
      width: width ?? 24,
      height: height ?? 24,
      color: Colors.red.withValues(alpha: 0.3),
      child: Center(
        child: Text(
          '!',
          style: TextStyle(
            color: Colors.red,
            fontSize: (width ?? 24) * 0.8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
