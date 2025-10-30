import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/themes/theme_color.dart';

// ============================================================
// VISA CARD WIDGET - START
// ============================================================
// Dependencies required:
// 1. flutter_svg package (pubspec.yaml)
// 2. ThemeColors class (../../config/themes/theme_color.dart)
// 3. logo_visa.svg asset (lib/assets/images/logo_visa.svg)
// ============================================================

class VisaCard extends StatelessWidget {
  const VisaCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Main card container with gradient background
    return Container(
      width: double.infinity,
      height: 106,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment(0.5, 1.92),
          end: Alignment(1.11, -0.57),
          colors: [Color(0xFF0F0F0F), Color(0xFF757575)],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            offset: const Offset(0, 3),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Visa logo and expiry date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Visa logo (requires logo_visa.svg asset)
              SvgPicture.asset(
                'lib/assets/images/logo_visa.svg',
                width: 50,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
              // Expiry date (customize as needed)
              Text(
                '12/28',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: ThemeColors.get('light', 'text/contrast/600'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Card type label
          Text(
            'Virtual Card',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: ThemeColors.get('light', 'text/contrast/600'),
            ),
          ),
          const SizedBox(height: 4),

          // Card number (masked with last 4 digits)
          Row(
            children: [
              ...List.generate(
                1,
                (_) => Flexible(
                  child: Text(
                    '••••',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  '1234',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================================================
// VISA CARD WIDGET - END
// ============================================================
