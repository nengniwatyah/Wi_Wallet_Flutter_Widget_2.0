import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart' as theme;
import 'package:mcp_test_app/widgets/button/buttons.dart';
import 'package:mcp_test_app/widgets/announce/announcement_warning.dart';
import 'package:mcp_test_app/generated/intl/app_localizations.dart';

import 'package:mcp_test_app/widgets/skeleton/lottie_skeleton.dart';

class DrawerBalanceDetail extends StatelessWidget {
  final String totalBalanceAmount;
  final String currency;
  final String holdAmountLabel;
  final String holdAmountValue;
  final String ledgerBalanceLabel;
  final String ledgerBalanceValue;
  final String warningText;
  final String buttonText;
  final VoidCallback? onClose;
  final bool isLoading;
  final bool showButton;

  const DrawerBalanceDetail({
    super.key,
    required this.totalBalanceAmount,
    this.currency = 'THB',
    required this.holdAmountLabel,
    required this.holdAmountValue,
    required this.ledgerBalanceLabel,
    required this.ledgerBalanceValue,
    required this.warningText,
    this.buttonText = 'OK',
    this.onClose,
    this.isLoading = false,
    this.showButton = true,
  });

  static Future<void> show(
    BuildContext context, {
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
      builder:
          (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: DrawerBalanceDetail(
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
    final l10n = AppLocalizations.of(context)!;
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final bottomPadding =
        mediaQuery.viewPadding.bottom > 0
            ? mediaQuery.viewPadding.bottom
            : mediaQuery.padding.bottom;

    return Container(
      height: screenHeight * 0.80,
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
            child: LottieSkeleton(
              isLoading: isLoading,
              borderRadius: BorderRadius.circular(8),
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
          ),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Image
                  LottieSkeleton(
                    isLoading: isLoading,
                    borderRadius: BorderRadius.circular(
                      72,
                    ), // Circular for image
                    child: Image.asset(
                      'lib/assets/images/full-wallet.png',
                      width: 144,
                      height: 144,
                      fit: BoxFit.cover,
                      errorBuilder:
                          (_, __, ___) => Container(
                            height: 144,
                            color: theme.ThemeColors.get(
                              brightnessKey,
                              'fill/base/300',
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Balance Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.ThemeColors.get(
                        brightnessKey,
                        'fill/base/300',
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        // Total Balance
                        LottieSkeleton(
                          isLoading: isLoading,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            l10n.homeDrawerDetailTotalBalance,
                            style: GoogleFonts.notoSansThai(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 1.51,
                              color: theme.ThemeColors.get(
                                brightnessKey,
                                'text/base/600',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        LottieSkeleton(
                          isLoading: isLoading,
                          borderRadius: BorderRadius.circular(4),
                          child: Text(
                            '$totalBalanceAmount $currency',
                            style: GoogleFonts.notoSansThai(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              height: 1.27,
                              color: theme.ThemeColors.get(
                                brightnessKey,
                                'success/500',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Divider
                        Container(
                          height: 1,
                          color: theme.ThemeColors.get(
                            brightnessKey,
                            'stroke/base/200',
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Hold Amount
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LottieSkeleton(
                              isLoading: isLoading,
                              borderRadius: BorderRadius.circular(4),
                              child: Row(
                                children: [
                                  Text(
                                    holdAmountLabel,
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      height: 1.23,
                                      color: theme.ThemeColors.get(
                                        brightnessKey,
                                        'text/base/400',
                                      ),
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
                            ),
                            LottieSkeleton(
                              isLoading: isLoading,
                              borderRadius: BorderRadius.circular(4),
                              child: Row(
                                children: [
                                  Text(
                                    holdAmountValue,
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      height: 1.23,
                                      color: theme.ThemeColors.get(
                                        brightnessKey,
                                        'text/base/600',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    currency,
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      height: 1.23,
                                      color: theme.ThemeColors.get(
                                        brightnessKey,
                                        'text/base/600',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Ledger Balance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LottieSkeleton(
                              isLoading: isLoading,
                              borderRadius: BorderRadius.circular(4),
                              child: Text(
                                ledgerBalanceLabel,
                                style: GoogleFonts.notoSansThai(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  height: 1.23,
                                  color: theme.ThemeColors.get(
                                    brightnessKey,
                                    'text/base/400',
                                  ),
                                ),
                              ),
                            ),
                            LottieSkeleton(
                              isLoading: isLoading,
                              borderRadius: BorderRadius.circular(4),
                              child: Row(
                                children: [
                                  Text(
                                    ledgerBalanceValue,
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      height: 1.23,
                                      color: theme.ThemeColors.get(
                                        brightnessKey,
                                        'text/base/600',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    currency,
                                    style: GoogleFonts.notoSansThai(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      height: 1.23,
                                      color: theme.ThemeColors.get(
                                        brightnessKey,
                                        'text/base/600',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Warning
                  LottieSkeleton(
                    isLoading: isLoading,
                    borderRadius: BorderRadius.circular(8),
                    child: Builder(
                      builder: (context) {
                        final textColor = theme.ThemeColors.get(
                          brightnessKey,
                          'text/base/warning',
                        );
                        return AnnouncementWarning(
                          title: '',
                          description: '',
                          descriptionSpans: [
                            TextSpan(
                              text: '*Hold Amount',
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: warningText.replaceFirst(
                                '*Hold Amount',
                                '',
                              ),
                              style: TextStyle(color: textColor),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // OK Button
          if (showButton)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: LottieSkeleton(
                isLoading: isLoading,
                borderRadius: BorderRadius.circular(24), // Button radius
                child: Buttons(
                  text: buttonText,
                  type: ButtonType.primary,
                  onPressed: onClose,
                ),
              ),
            ),
          if (bottomPadding > 0)
            ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  height: bottomPadding,
                  color: theme.ThemeColors.get(
                    brightnessKey,
                    'fill/base/100',
                  ).withValues(alpha: 0.9),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
