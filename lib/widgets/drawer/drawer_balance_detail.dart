import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart' as theme;
import 'package:mcp_test_app/widgets/button/buttons.dart';
import 'package:mcp_test_app/widgets/announce/announcement_warning.dart';

class DrawerBalanceDetail extends StatelessWidget {
  final String totalBalanceLabel;
  final String totalBalanceAmount;
  final String currency;
  final String holdAmountLabel;
  final String holdAmountValue;
  final String ledgerBalanceLabel;
  final String ledgerBalanceValue;
  final String warningText;
  final String buttonText;
  final VoidCallback? onClose;

  const DrawerBalanceDetail({
    super.key,
    required this.totalBalanceLabel,
    required this.totalBalanceAmount,
    this.currency = 'THB',
    required this.holdAmountLabel,
    required this.holdAmountValue,
    required this.ledgerBalanceLabel,
    required this.ledgerBalanceValue,
    required this.warningText,
    this.buttonText = 'OK',
    this.onClose,
  });

  static Future<void> show(
    BuildContext context, {
    required String totalBalanceLabel,
    required String totalBalanceAmount,
    String currency = 'THB',
    required String holdAmountLabel,
    required String holdAmountValue,
    required String ledgerBalanceLabel,
    required String ledgerBalanceValue,
    required String warningText,
    String buttonText = 'OK',
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.5),
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: DrawerBalanceDetail(
        totalBalanceLabel: totalBalanceLabel,
        totalBalanceAmount: totalBalanceAmount,
        currency: currency,
        holdAmountLabel: holdAmountLabel,
        holdAmountValue: holdAmountValue,
        ledgerBalanceLabel: ledgerBalanceLabel,
        ledgerBalanceValue: ledgerBalanceValue,
        warningText: warningText,
        buttonText: buttonText,
        onClose: () => Navigator.pop(context),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightnessKey = Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.75,
      decoration: BoxDecoration(
        color: theme.ThemeColors.get(brightnessKey, 'fill/base/100'),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              'Balance Detail',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansThai(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                height: 1.51,
                color: theme.ThemeColors.get(brightnessKey, 'text/base/600'),
              ),
            ),
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Image
                  Image.asset(
                    'lib/assets/images/full-wallet.png',
                    width: 144,
                    height: 144,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 144,
                      color: theme.ThemeColors.get(brightnessKey, 'fill/base/300'),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Balance Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.ThemeColors.get(brightnessKey, 'fill/base/300'),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Total Balance
                        Text(
                          totalBalanceLabel,
                          style: GoogleFonts.notoSansThai(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.51,
                            color: theme.ThemeColors.get(brightnessKey, 'text/base/600'),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$totalBalanceAmount $currency',
                          style: GoogleFonts.notoSansThai(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            height: 1.27,
                            color: theme.ThemeColors.get(brightnessKey, 'success/500'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Divider
                        Container(
                          height: 1,
                          color: theme.ThemeColors.get(brightnessKey, 'stroke/base/200'),
                        ),
                        const SizedBox(height: 16),
                        // Hold Amount
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  holdAmountLabel,
                                  style: GoogleFonts.notoSansThai(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    height: 1.23,
                                    color: theme.ThemeColors.get(brightnessKey, 'text/base/400'),
                                  ),
                                ),
                                Text(
                                  ' *',
                                  style: GoogleFonts.notoSansThai(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    height: 1.23,
                                    color: const Color(0xFFFF2729),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  holdAmountValue,
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.notoSansThai(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    height: 1.23,
                                    color: theme.ThemeColors.get(brightnessKey, 'text/base/600'),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  currency,
                                  style: GoogleFonts.notoSansThai(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    height: 1.23,
                                    color: theme.ThemeColors.get(brightnessKey, 'text/base/600'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Ledger Balance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ledgerBalanceLabel,
                              style: GoogleFonts.notoSansThai(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                height: 1.23,
                                color: theme.ThemeColors.get(brightnessKey, 'text/base/400'),
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  ledgerBalanceValue,
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.notoSansThai(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    height: 1.23,
                                    color: theme.ThemeColors.get(brightnessKey, 'text/base/600'),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  currency,
                                  style: GoogleFonts.notoSansThai(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    height: 1.23,
                                    color: theme.ThemeColors.get(brightnessKey, 'text/base/600'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Warning
                  Builder(
                    builder: (context) {
                      final textColor = theme.ThemeColors.get(brightnessKey, 'text/base/warning');
                      return AnnouncementWarning(
                        title: '',
                        description: '',
                        descriptionSpans: [
                          TextSpan(
                            text: '*Hold Amount',
                            style: TextStyle(color: textColor, fontWeight: FontWeight.w700),
                          ),
                          TextSpan(
                            text: warningText.replaceFirst('*Hold Amount', ''),
                            style: TextStyle(color: textColor),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // OK Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
            child: Buttons(
              text: buttonText,
              type: ButtonType.primary,
              onPressed: onClose,
            ),
          ),
        ],
      ),
    );
  }
}
