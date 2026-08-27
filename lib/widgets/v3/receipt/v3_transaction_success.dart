import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/themes/v3/v3_color_palette.dart';
import '../../../config/themes/v3/v3_dimensions.dart';
import '../../../config/themes/v3/v3_primitives.dart';
import '../../../config/themes/v3/v3_theme_scope.dart';
import '../../../config/themes/v3/v3_typography.dart';

const _kCheckAsset = 'lib/assets/images/receipt/check.svg';
const _kSenderLogoAsset = 'lib/assets/images/brands=SCB.svg';
const _kQrAsset = 'lib/assets/images/receipt/qr.png';
const _kBackgroundAsset = 'lib/assets/images/receipt/receipt_background.svg';

enum V3TransactionSuccessProperty { receipt, transactionSuccess }

/// Read-only transaction receipt mapped to the Receipt Figma component set.
///
/// Visible copy, formatted values, logos and QR content are owned by the
/// caller so the widget remains localizable and does not depend on app assets.
class V3TransactionSuccess extends StatelessWidget {
  const V3TransactionSuccess({
    super.key,
    required this.confirmationTitle,
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
    required this.footerNoteOne,
    required this.footerNoteTwo,
    this.property = V3TransactionSuccessProperty.transactionSuccess,
    this.transactionType = '',
    this.senderLabel = '',
    this.merchantLabel = '',
    this.amountLabel = '',
    this.feeLabel = '',
    this.dateTimeLabel = '',
    this.transactionIdLabel = '',
    this.merchantRefIdLabel = '',
    this.billerIdLabel = '',
    this.ref1Label = '',
    this.ref2Label = '',
    this.ref2 = '',
    this.ref3Label = '',
    this.ref3 = '',
    this.transactionDetailRowCount = 7,
    this.checkIcon,
    this.senderLogo,
    this.merchantLogo,
    this.qrCode,
    this.background,
  });

  final V3TransactionSuccessProperty property;
  final String confirmationTitle;
  final String transactionType;
  final String amount;
  final String amountLabel;
  final String fee;
  final String feeLabel;
  final String senderLabel;
  final String senderName;
  final String senderAccount;
  final String merchantLabel;
  final String merchantName;
  final String merchantAccount;
  final String dateTimeLabel;
  final String dateTime;
  final String transactionIdLabel;
  final String transactionId;
  final String merchantRefIdLabel;
  final String merchantRefId;
  final String billerIdLabel;
  final String billerId;
  final String ref1Label;
  final String ref1;
  final String ref2Label;
  final String ref2;
  final String ref3Label;
  final String ref3;
  final String footerNoteOne;
  final String footerNoteTwo;
  final int transactionDetailRowCount;
  final Widget? checkIcon;
  final Widget? senderLogo;
  final Widget? merchantLogo;
  final Widget? qrCode;
  final Widget? background;

  @override
  Widget build(BuildContext context) {
    final colors = V3ThemeScope.colorsOf(context);
    final radius = BorderRadius.circular(V3Radii.roundedXl);
    final effectiveCheckIcon = checkIcon ?? SvgPicture.asset(_kCheckAsset);
    final effectiveSenderLogo =
        senderLogo ??
        ClipOval(child: SvgPicture.asset(_kSenderLogoAsset, fit: BoxFit.cover));
    final effectiveMerchantLogo =
        merchantLogo ??
        ClipOval(child: SvgPicture.asset(_kSenderLogoAsset, fit: BoxFit.cover));
    final effectiveQrCode = qrCode ?? Image.asset(_kQrAsset, fit: BoxFit.cover);
    final effectiveBackground =
        background ?? SvgPicture.asset(_kBackgroundAsset, fit: BoxFit.cover);

    return Semantics(
      container: true,
      explicitChildNodes: true,
      label: confirmationTitle,
      child: SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colors.backgroundWhite,
            borderRadius: radius,
            border: Border.all(color: colors.borderPrimary),
            boxShadow: V3PrimitiveShadows.lg,
          ),
          child: ClipRRect(
            borderRadius: radius,
            child: Stack(
              children: [
                Positioned.fill(child: effectiveBackground),
                Padding(
                  padding: const EdgeInsets.all(V3Spacing.space16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Opacity(
                      opacity: 0.85,
                      child: LayoutBuilder(
                        builder:
                            (context, constraints) => Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (property ==
                                    V3TransactionSuccessProperty
                                        .transactionSuccess)
                                  _Confirmation(
                                    icon: effectiveCheckIcon,
                                    title: confirmationTitle,
                                    colors: colors,
                                  )
                                else
                                  _ReceiptHeader(
                                    title: confirmationTitle,
                                    transactionType: transactionType,
                                    colors: colors,
                                  ),
                                const _ReceiptGap(),
                                const _ReceiptDivider(),
                                const _ReceiptGap(),
                                _PartyRow(
                                  label: senderLabel,
                                  name: senderName,
                                  account: senderAccount,
                                  logo: effectiveSenderLogo,
                                ),
                                const _ReceiptGap(),
                                _MerchantRow(
                                  label: merchantLabel,
                                  name: merchantName,
                                  account: merchantAccount,
                                  logo: effectiveMerchantLogo,
                                  colors: colors,
                                ),
                                const _ReceiptGap(),
                                const _ReceiptDivider(),
                                const _ReceiptGap(),
                                _AmountSection(
                                  type: transactionType,
                                  amountLabel: amountLabel,
                                  amount: amount,
                                  feeLabel: feeLabel,
                                  fee: fee,
                                  qrCode: effectiveQrCode,
                                  availableWidth: constraints.maxWidth,
                                  colors: colors,
                                ),
                                const _ReceiptGap(),
                                const _ReceiptDivider(),
                                const _ReceiptGap(),
                                SizedBox(
                                  width: constraints.maxWidth,
                                  child: _DetailSection(
                                    rows: _detailRows,
                                    rowCount: transactionDetailRowCount,
                                  ),
                                ),
                                const _ReceiptGap(),
                                const _ReceiptDivider(),
                                const _ReceiptGap(),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<_ReceiptDetail> get _detailRows => [
    _ReceiptDetail(dateTimeLabel, dateTime),
    _ReceiptDetail(transactionIdLabel, transactionId),
    _ReceiptDetail(merchantRefIdLabel, merchantRefId),
    _ReceiptDetail(billerIdLabel, billerId),
    _ReceiptDetail(ref1Label, ref1),
    _ReceiptDetail(ref2Label, ref2.isEmpty ? ref1 : ref2),
    _ReceiptDetail(ref3Label, ref3.isEmpty ? ref1 : ref3),
  ];
}

class _Confirmation extends StatelessWidget {
  const _Confirmation({
    required this.icon,
    required this.title,
    required this.colors,
  });

  final Widget? icon;
  final String title;
  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        icon ?? Icon(Icons.check_circle, size: 52, color: colors.stateSuccess),
        const SizedBox(height: V3Spacing.space16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: V3Typography.headingTiny.copyWith(
            color: colors.contentPrimary,
          ),
        ),
      ],
    );
  }
}

class _ReceiptHeader extends StatelessWidget {
  const _ReceiptHeader({
    required this.title,
    required this.transactionType,
    required this.colors,
  });

  final String title;
  final String transactionType;
  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: V3Typography.headingExtraTiny.copyWith(
              color: colors.contentPrimary,
            ),
          ),
        ),
        if (transactionType.isNotEmpty)
          Text(
            transactionType,
            style: V3Typography.labelTiny.copyWith(
              color: colors.contentSecondary,
            ),
          ),
      ],
    );
  }
}

class _PartyRow extends StatelessWidget {
  const _PartyRow({
    required this.label,
    required this.name,
    required this.account,
    this.logo,
  });

  final String label;
  final String name;
  final String account;
  final Widget? logo;

  @override
  Widget build(BuildContext context) {
    final colors = V3ThemeScope.colorsOf(context);
    return Row(
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
          child:
              logo ??
              Icon(
                Icons.account_circle_outlined,
                color: colors.contentExtensionNavy,
                size: 48,
              ),
        ),
        const SizedBox(width: V3Spacing.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                softWrap: true,
                style: V3Typography.labelTiny.copyWith(
                  color: colors.contentPrimary,
                ),
              ),
              const SizedBox(height: V3Spacing.space4),
              Text(
                account,
                softWrap: true,
                style: V3Typography.paragraphTiny.copyWith(
                  color: colors.contentSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MerchantRow extends StatelessWidget {
  const _MerchantRow({
    required this.label,
    required this.name,
    required this.account,
    required this.logo,
    required this.colors,
  });

  final String label;
  final String name;
  final String account;
  final Widget? logo;
  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        SizedBox.square(dimension: 48, child: logo),
        const SizedBox(width: V3Spacing.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                softWrap: true,
                style: V3Typography.labelTiny.copyWith(
                  color: colors.contentPrimary,
                ),
              ),
              if (account.isNotEmpty) ...[
                const SizedBox(height: V3Spacing.space4),
                Text(
                  account,
                  softWrap: true,
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
}

class _AmountSection extends StatelessWidget {
  const _AmountSection({
    required this.type,
    required this.amountLabel,
    required this.amount,
    required this.feeLabel,
    required this.fee,
    required this.qrCode,
    required this.availableWidth,
    required this.colors,
  });

  final String type;
  final String amountLabel;
  final String amount;
  final String feeLabel;
  final String fee;
  final Widget? qrCode;
  final double availableWidth;
  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) {
    final amountBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (type.isNotEmpty)
          Text(
            type,
            style: V3Typography.labelTiny.copyWith(
              color: colors.contentSecondary,
            ),
          ),
        if (type.isNotEmpty) const SizedBox(height: V3Spacing.space4),
        if (amountLabel.isNotEmpty)
          Text(
            amountLabel,
            style: V3Typography.labelTiny.copyWith(
              color: colors.contentSecondary,
            ),
          ),
        Text(
          amount,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: V3Typography.headingTiny.copyWith(
            color: colors.contentPrimary,
          ),
        ),
        const SizedBox(height: V3Spacing.space4),
        Text(
          '$feeLabel $fee'.trim(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: V3Typography.paragraphTiny.copyWith(
            color: colors.contentSecondary,
          ),
        ),
      ],
    );
    final qr = SizedBox.square(
      // Figma-measured size; no matching semantic dimension token exists.
      dimension: 78,
      child: qrCode ?? _FallbackQr(colors: colors),
    );
    if (availableWidth < 340) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          amountBlock,
          const SizedBox(height: V3Spacing.space16),
          Align(alignment: Alignment.centerRight, child: qr),
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: amountBlock),
        const SizedBox(width: V3Spacing.space16),
        qr,
      ],
    );
  }
}

class _FallbackQr extends StatelessWidget {
  const _FallbackQr({required this.colors});

  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.backgroundWhite,
        border: Border.all(color: colors.borderSecondary),
      ),
      child: Center(
        child: Icon(Icons.qr_code_2, size: 56, color: colors.contentPrimary),
      ),
    );
  }
}

class _ReceiptDetail {
  const _ReceiptDetail(this.label, this.value);

  final String label;
  final String value;
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.rows, required this.rowCount});

  final List<_ReceiptDetail> rows;
  final int rowCount;

  @override
  Widget build(BuildContext context) {
    final visibleRows = rows.take(rowCount.clamp(0, rows.length)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < visibleRows.length; i++) ...[
          _DetailRow(detail: visibleRows[i]),
          if (i < visibleRows.length - 1)
            const SizedBox(height: V3Spacing.space8),
        ],
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.detail});

  final _ReceiptDetail detail;

  @override
  Widget build(BuildContext context) {
    final colors = V3ThemeScope.colorsOf(context);
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              detail.label,
              softWrap: true,
              style: V3Typography.paragraphTiny.copyWith(
                color: colors.contentSecondary,
              ),
            ),
          ),
          const SizedBox(width: V3Spacing.space8),
          Expanded(
            flex: 2,
            child: Text(
              detail.value,
              textAlign: TextAlign.right,
              softWrap: true,
              style: V3Typography.paragraphTiny.copyWith(
                color: colors.contentSecondary,
              ),
            ),
          ),
        ],
      ),
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _BulletLine(text: first, colors: colors),
        const SizedBox(height: V3Spacing.space4),
        _BulletLine(text: second, colors: colors),
      ],
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({required this.text, required this.colors});

  final String text;
  final V3ColorPalette colors;

  @override
  Widget build(BuildContext context) {
    return Row(
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
            softWrap: true,
            style: V3Typography.paragraphTiny.copyWith(
              color: colors.contentSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _ReceiptGap extends StatelessWidget {
  const _ReceiptGap();

  @override
  Widget build(BuildContext context) =>
      const SizedBox(height: V3Spacing.space16);
}

class _ReceiptDivider extends StatelessWidget {
  const _ReceiptDivider();

  @override
  Widget build(BuildContext context) {
    final colors = V3ThemeScope.colorsOf(context);
    return Divider(height: 1, thickness: 1, color: colors.borderPrimary);
  }
}
