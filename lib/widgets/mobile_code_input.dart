import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';

class MobileCodeInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String countryCode;
  final String flagAsset;
  final VoidCallback? onCountryCodeTap;
  final int maxLength;

  const MobileCodeInput({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.countryCode = '+66',
    this.flagAsset = 'lib/assets/images/flag_th.svg',
    this.onCountryCodeTap,
    this.maxLength = 10,
  });

  @override
  State<MobileCodeInput> createState() => _MobileCodeInputState();
}

class _MobileCodeInputState extends State<MobileCodeInput> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  bool _hasText = false;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue ?? '');
    _hasText = _controller.text.isNotEmpty;
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  void _onTextChanged() {
    setState(() {
      _hasText = _controller.text.isNotEmpty;
    });
  }

  void _onFocusChanged() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _focusNode.removeListener(_onFocusChanged);
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightnessKey = Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';
    
    final borderColor = _hasFocus
        ? ThemeColors.get(brightnessKey, 'primary/400')
        : ThemeColors.get(brightnessKey, 'stroke/base/200');
    final backgroundColor = ThemeColors.get(brightnessKey, 'fill/base/300');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: widget.onCountryCodeTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  widget.flagAsset,
                  width: 32,
                  height: 24,
                ),
                const SizedBox(width: 4),
                Text(
                  widget.countryCode,
                  style: GoogleFonts.notoSansThai(
                    fontSize: 15,
                    height: 1.33,
                    color: ThemeColors.get(brightnessKey, 'text/base/600'),
                  ),
                ),
                SvgPicture.asset(
                  'lib/assets/images/arrow-down-01.svg',
                  width: 24,
                  height: 24,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              cursorColor: ThemeColors.get(brightnessKey, 'text/base/600'),
              style: GoogleFonts.notoSansThai(
                fontSize: 15,
                height: 1.33,
                color: _hasText
                    ? ThemeColors.get(brightnessKey, 'text/base/600')
                    : ThemeColors.get(brightnessKey, 'text/base/400'),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                isDense: true,
                hintText: 'เบอร์มือถือ',
                hintStyle: GoogleFonts.notoSansThai(
                  fontSize: 15,
                  height: 1.33,
                  color: ThemeColors.get(brightnessKey, 'text/base/400'),
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.maxLength),
              ],
              onChanged: widget.onChanged,
            ),
          ),
          if (_hasText)
            GestureDetector(
              onTap: () {
                _controller.clear();
                widget.onChanged?.call('');
              },
              child: SvgPicture.asset(
                'lib/assets/images/cancel-circle.svg',
                width: 16,
                height: 16,
                colorFilter: ColorFilter.mode(
                  ThemeColors.get(brightnessKey, 'stroke/base/600'),
                  BlendMode.srcIn,
                ),
              ),
            ),
        ],
      ),
        ),
        const SizedBox(height: 4),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '${_controller.text.length}/${widget.maxLength}',
            style: GoogleFonts.notoSansThai(
              fontSize: 15,
              height: 1.33,
              color: ThemeColors.get(brightnessKey, 'text/base/400'),
            ),
          ),
        ),
      ],
    );
  }
}
