import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';

enum BankType {
  scb,
  kbank,
  bbl,
  krungsri,
}

class DrawerDepositChannel extends StatelessWidget {
  final VoidCallback? onClose;
  final Function(BankType)? onBankSelected;

  const DrawerDepositChannel({
    super.key,
    this.onClose,
    this.onBankSelected,
  });

  String _getBankName(BankType bank) {
    switch (bank) {
      case BankType.scb:
        return 'Siam Commercial Bank';
      case BankType.kbank:
        return 'Kasikorn Bank';
      case BankType.bbl:
        return 'Bangkok Bank Mobile Banking';
      case BankType.krungsri:
        return 'Bank of Ayudhya';
    }
  }

  String _getBankLogo(BankType bank) {
    switch (bank) {
      case BankType.scb:
        return 'lib/assets/images/brands=SCB.svg';
      case BankType.kbank:
        return 'lib/assets/images/brands=KBANK.svg';
      case BankType.bbl:
        return 'lib/assets/images/brands=Bangkok Bank.svg';
      case BankType.krungsri:
        return 'lib/assets/images/brands=Krungsri.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final brightnessKey = Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: screenHeight * 0.5,
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: ThemeColors.get(brightnessKey, 'fill/base/100'),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(brightnessKey),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildLabelContainer(brightnessKey),
                  const SizedBox(height: 16),
                  _buildBankItem(brightnessKey, BankType.scb),
                  const SizedBox(height: 16),
                  _buildBankItem(brightnessKey, BankType.bbl),
                  const SizedBox(height: 16),
                  _buildBankItem(brightnessKey, BankType.kbank),
                  const SizedBox(height: 16),
                  _buildBankItem(brightnessKey, BankType.krungsri),
                  const SizedBox(height: 16),
                  _buildBankItem(brightnessKey, BankType.scb),
                  const SizedBox(height: 16),
                  _buildBankItem(brightnessKey, BankType.bbl),
                  const SizedBox(height: 16),
                  _buildBankItem(brightnessKey, BankType.kbank),
                  const SizedBox(height: 16),
                  _buildBankItem(brightnessKey, BankType.krungsri),
                  const SizedBox(height: 140),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String brightnessKey) {
    return SizedBox(
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'เลือกช่องทางฝาก',
                style: GoogleFonts.notoSansThai(
                  fontSize: 15,
                  height: 1.33,
                  fontWeight: FontWeight.w700,
                  color: ThemeColors.get(brightnessKey, 'text/base/600'),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                ThemeColors.get(brightnessKey, 'text/base/600'),
                BlendMode.srcIn,
              ),
              child: SvgPicture.asset(
                'lib/assets/images/cancel-01.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelContainer(String brightnessKey) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ThemeColors.get(brightnessKey, 'fill/base/600'),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Mobile Banking',
          style: GoogleFonts.notoSansThai(
            fontSize: 10,
            height: 1.2,
            fontWeight: FontWeight.w600,
            color: ThemeColors.get(brightnessKey, 'text/base/600'),
          ),
        ),
      ),
    );
  }

  Widget _buildBankItem(String brightnessKey, BankType bank) {
    return GestureDetector(
      onTap: () => onBankSelected?.call(bank),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: ThemeColors.get(brightnessKey, 'fill/base/300'),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              _getBankLogo(bank),
              width: 26,
              height: 26,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                _getBankName(bank),
                style: GoogleFonts.notoSansThai(
                  fontSize: 15,
                  height: 1.33,
                  fontWeight: FontWeight.w400,
                  color: ThemeColors.get(brightnessKey, 'text/base/600'),
                ),
              ),
            ),
            SvgPicture.asset(
              'lib/assets/images/arrow-right-01.svg',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
