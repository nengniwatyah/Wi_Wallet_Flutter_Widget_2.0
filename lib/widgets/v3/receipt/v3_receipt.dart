import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/themes/v3/v3_color_palette.dart';
import '../../../config/themes/v3/v3_dimensions.dart';
import '../../../config/themes/v3/v3_primitives.dart';
import '../../../config/themes/v3/v3_theme_scope.dart';
import '../../../config/themes/v3/v3_typography.dart';

const _kSenderLogoAsset = 'lib/assets/images/brands=SCB.svg';
const _kMerchantLogoAsset = 'lib/assets/images/brands=SCB.svg';
const _kQrAsset = 'lib/assets/images/receipt/qr.png';
const _kBackgroundAsset = 'lib/assets/images/receipt/receipt_background.svg';
const _kHeaderLogoAsset = 'lib/assets/images/receipt/wiwallet-logo.svg';

/// Read-only payment receipt based on the legacy [ReceiptImageComponent].
///
/// The content and asset paths remain caller-owned, while visual primitives are
/// resolved through Theme V3 semantic tokens.
class V3Receipt extends StatelessWidget {
  const V3Receipt({
    super.key,
    required this.amount,
    required this.fee,
    required this.senderName,
    required this.senderAccount,
    required this.merchantName,
    this.merchantAccount = '',
    required this.dateTime,
    required this.transactionId,
    required this.merchantRefId,
    required this.billerId,
    required this.ref1,
    this.ref2 = '',
    this.ref3 = '',
    required this.footerNoteOne,
    required this.footerNoteTwo,
    this.transactionDetailRowCount = 7,
    this.senderLogoAssetPath = _kSenderLogoAsset,
    this.merchantLogoAssetPath = _kMerchantLogoAsset,
    this.qrAssetPath = _kQrAsset,
    this.backgroundSvgAssetPath = _kBackgroundAsset,
    this.backgroundImageUrl,
    this.headerLogoAssetPath = _kHeaderLogoAsset,
  });

  final String amount;
  final String fee;
  final String senderName;
  final String senderAccount;
  final String merchantName;
  final String merchantAccount;
  final String dateTime;
  final String transactionId;
  final String merchantRefId;
  final String billerId;
  final String ref1;
  final String ref2;
  final String ref3;
  final String footerNoteOne;
  final String footerNoteTwo;
  final int transactionDetailRowCount;
  final String? senderLogoAssetPath;
  final String? merchantLogoAssetPath;
  final String? qrAssetPath;
  final String? backgroundSvgAssetPath;
  final String? backgroundImageUrl;
  final String? headerLogoAssetPath;

  @override
  Widget build(BuildContext context) {
    final colors = V3ThemeScope.colorsOf(context);
    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: 'Payment receipt',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.backgroundWhite,
          border: Border.all(color: colors.borderPrimary),
          borderRadius: BorderRadius.zero,
          boxShadow: V3PrimitiveShadows.lg,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.zero,
          child: Stack(
            children: [
              Positioned.fill(
                child: _ReceiptBackground(
                  svgPath: backgroundSvgAssetPath,
                  imageUrl: backgroundImageUrl,
                  colors: colors,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(V3Spacing.space16),
                child: Opacity(
                  opacity: 0.85,
                  child: LayoutBuilder(
                    builder:
                        (context, constraints) => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _ReceiptHeader(
                              logoPath: headerLogoAssetPath,
                              colors: colors,
                            ),
                            const _V3ReceiptGap(),
                            const _V3ReceiptDivider(),
                            const _V3ReceiptGap(),
                            _PartyRow(
                              label: 'From',
                              name: senderName,
                              account: senderAccount,
                              logoPath: senderLogoAssetPath,
                              colors: colors,
                            ),
                            const _V3ReceiptGap(),
                            _PartyRow(
                              label: 'To',
                              name: merchantName,
                              account: merchantAccount,
                              logoPath: merchantLogoAssetPath,
                              colors: colors,
                            ),
                            const _V3ReceiptGap(),
                            const _V3ReceiptDivider(),
                            const _V3ReceiptGap(),
                            _AmountAndQr(
                              amount: amount,
                              fee: fee,
                              qrPath: qrAssetPath,
                              availableWidth: constraints.maxWidth,
                              colors: colors,
                            ),
                            const _V3ReceiptGap(),
                            const _V3ReceiptDivider(),
                            const _V3ReceiptGap(),
                            _Details(
                              rows: [
                                ('Date&Time:', dateTime),
                                ('Transaction ID:', transactionId),
                                ('Merchant Ref ID:', merchantRefId),
                                ('Biller ID:', billerId),
                                ('Ref 1:', ref1),
                                ('Ref 2:', ref2.isEmpty ? ref1 : ref2),
                                ('Ref 3:', ref3.isEmpty ? ref1 : ref3),
                              ],
                              rowCount: transactionDetailRowCount,
                              colors: colors,
                            ),
                            const _V3ReceiptGap(),
                            const _V3ReceiptDivider(),
                            const _V3ReceiptGap(),
                            _Footer(
                              first: footerNoteOne,
                              second: footerNoteTwo,
                              colors: colors,
                            ),
                          ],
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReceiptHeader extends StatelessWidget {
  const _ReceiptHeader({required this.logoPath, required this.colors});

  final String? logoPath;
  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(
          'Payment',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: V3Typography.headingExtraTiny.copyWith(
            color: colors.contentPrimary,
          ),
        ),
      ),
      const SizedBox(width: V3Spacing.space16),
      if (logoPath != null && logoPath!.isNotEmpty)
        SizedBox(
          width: 86,
          height: 20,
          child: SvgPicture.asset(logoPath!, fit: BoxFit.contain),
        )
      else
        Text(
          'wi wallet',
          style: V3Typography.labelTiny.copyWith(
            color: colors.contentExtensionNavy,
          ),
        ),
    ],
  );
}

class _PartyRow extends StatelessWidget {
  const _PartyRow({
    required this.label,
    required this.name,
    required this.account,
    required this.logoPath,
    required this.colors,
  });

  final String label;
  final String name;
  final String account;
  final String? logoPath;
  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: V3Spacing.space40,
        child: Text(
          label,
          style: V3Typography.labelTiny.copyWith(
            color: colors.contentSecondary,
          ),
        ),
      ),
      const SizedBox(width: V3Spacing.space12),
      SizedBox.square(
        dimension: 48,
        child: _CircleLogo(path: logoPath, colors: colors),
      ),
      const SizedBox(width: V3Spacing.space12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: V3Typography.labelTiny.copyWith(
                color: colors.contentPrimary,
              ),
            ),
            if (account.isNotEmpty) ...[
              const SizedBox(height: V3Spacing.space4),
              Text(
                account,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: V3Typography.paragraphTiny.copyWith(
                  color: colors.contentSecondary,
                ),
              ),
            ],
          ],
        ),
      ),
    ],
  );
}

class _CircleLogo extends StatelessWidget {
  const _CircleLogo({required this.path, required this.colors});

  final String? path;
  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) {
    if (path != null && path!.isNotEmpty) {
      return ClipOval(child: SvgPicture.asset(path!, fit: BoxFit.cover));
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.backgroundExtensionGold,
      ),
      child: Center(
        child: Text(
          'W',
          style: V3Typography.headingTiny.copyWith(color: colors.contentWhite),
        ),
      ),
    );
  }
}

class _AmountAndQr extends StatelessWidget {
  const _AmountAndQr({
    required this.amount,
    required this.fee,
    required this.qrPath,
    required this.availableWidth,
    required this.colors,
  });

  final String amount;
  final String fee;
  final String? qrPath;
  final double availableWidth;
  final V3ColorPalette colors;

  Widget get _amount => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        amount,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: V3Typography.headingTiny.copyWith(color: colors.contentPrimary),
      ),
      const SizedBox(height: V3Spacing.space4),
      Text(
        fee,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: V3Typography.paragraphTiny.copyWith(
          color: colors.contentSecondary,
        ),
      ),
    ],
  );

  Widget get _qr => SizedBox.square(
    dimension: 78,
    child:
        qrPath != null && qrPath!.isNotEmpty
            ? Image.asset(qrPath!, fit: BoxFit.cover)
            : DecoratedBox(
              decoration: BoxDecoration(
                color: colors.backgroundWhite,
                border: Border.all(color: colors.borderSecondary),
              ),
              child: Icon(
                Icons.qr_code_2,
                color: colors.contentPrimary,
                size: 56,
              ),
            ),
  );

  @override
  Widget build(BuildContext context) {
    if (availableWidth < 340) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _amount,
          const SizedBox(height: V3Spacing.space16),
          Align(alignment: Alignment.centerRight, child: _qr),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _amount),
        const SizedBox(width: V3Spacing.space16),
        _qr,
      ],
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({
    required this.rows,
    required this.rowCount,
    required this.colors,
  });

  final List<(String, String)> rows;
  final int rowCount;
  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) {
    final visibleRows = rows.take(rowCount.clamp(0, rows.length));
    return Column(
      children: [
        for (final row in visibleRows) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  row.$1,
                  style: V3Typography.paragraphTiny.copyWith(
                    color: colors.contentSecondary,
                  ),
                ),
              ),
              const SizedBox(width: V3Spacing.space8),
              Expanded(
                child: Text(
                  row.$2,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: V3Typography.paragraphTiny.copyWith(
                    color: colors.contentSecondary,
                  ),
                ),
              ),
            ],
          ),
          if (row != visibleRows.last) const SizedBox(height: V3Spacing.space8),
        ],
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.first,
    required this.second,
    required this.colors,
  });

  final String first;
  final String second;
  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _Bullet(text: first, colors: colors),
      const SizedBox(height: V3Spacing.space4),
      _Bullet(text: second, colors: colors),
    ],
  );
}

class _Bullet extends StatelessWidget {
  const _Bullet({required this.text, required this.colors});

  final String text;
  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '•',
        style: V3Typography.paragraphTiny.copyWith(
          color: colors.contentSecondary,
        ),
      ),
      const SizedBox(width: V3Spacing.space8),
      Expanded(
        child: Text(
          text,
          style: V3Typography.paragraphTiny.copyWith(
            color: colors.contentSecondary,
          ),
        ),
      ),
    ],
  );
}

class _V3ReceiptGap extends StatelessWidget {
  const _V3ReceiptGap();

  @override
  Widget build(BuildContext context) =>
      const SizedBox(height: V3Spacing.space16);
}

class _V3ReceiptDivider extends StatelessWidget {
  const _V3ReceiptDivider();

  @override
  Widget build(BuildContext context) {
    final colors = V3ThemeScope.colorsOf(context);
    return ColoredBox(
      color: colors.borderPrimary,
      child: const SizedBox(height: 1),
    );
  }
}

class _ReceiptBackground extends StatelessWidget {
  const _ReceiptBackground({
    required this.svgPath,
    required this.imageUrl,
    required this.colors,
  });

  final String? svgPath;
  final String? imageUrl;
  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(imageUrl!, fit: BoxFit.cover);
    }
    if (svgPath != null && svgPath!.isNotEmpty) {
      return SvgPicture.asset(svgPath!, fit: BoxFit.cover);
    }
    return CustomPaint(painter: _ReceiptWatermarkPainter(colors.borderPrimary));
  }
}

class _ReceiptWatermarkPainter extends CustomPainter {
  const _ReceiptWatermarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withValues(alpha: 0.28)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.6;
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.max(size.width, size.height) * 0.9;
    for (var i = 1; i <= 10; i++) {
      canvas.drawCircle(center, maxRadius / 10 * i, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ReceiptWatermarkPainter oldDelegate) =>
      oldDelegate.color != color;
}
