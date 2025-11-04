import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';

enum ButtonType {
  primary,
  secondary,
  amount,
}

class Buttons extends StatefulWidget {
  final String text;
  final ButtonType type;
  final bool enabled;
  final VoidCallback? onPressed;

  const Buttons({
    super.key,
    required this.text,
    this.type = ButtonType.primary,
    this.enabled = true,
    this.onPressed,
  });

  @override
  State<Buttons> createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final brightnessKey = Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';

    Color backgroundColor;
    Color textColor;
    Color? borderColor;
    List<BoxShadow>? boxShadow;

    if (!widget.enabled) {
      if (widget.type == ButtonType.secondary) {
        backgroundColor = ThemeColors.get(brightnessKey, 'fill/contrast/100');
        textColor = ThemeColors.get(brightnessKey, 'fill/contrast/600');
        borderColor = null;
        boxShadow = [
          BoxShadow(
            color: const Color(0x10182828).withValues(alpha: 0.05),
            offset: const Offset(0, 1),
            blurRadius: 2,
          ),
        ];
      } else {
        backgroundColor = ThemeColors.get(brightnessKey, 'fill/base/300');
        textColor = ThemeColors.get(brightnessKey, 'text/base/400');
        borderColor = ThemeColors.get(brightnessKey, 'stroke/base/200');
      }
    } else {
      switch (widget.type) {
        case ButtonType.primary:
          backgroundColor = ThemeColors.get(brightnessKey, 'primary/400');
          textColor = ThemeColors.get(brightnessKey, 'fill/contrast/600');
          borderColor = null;
          break;
        case ButtonType.secondary:
          backgroundColor = ThemeColors.get(brightnessKey, 'fill/contrast/600');
          textColor = brightnessKey == 'light' 
              ? const Color(0xFFFFFFFF) 
              : ThemeColors.get(brightnessKey, 'text/base/600');
          borderColor = ThemeColors.get(brightnessKey, 'text/base/600');
          boxShadow = [
            BoxShadow(
              color: const Color(0x10182828).withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ];
          break;
        case ButtonType.amount:
          backgroundColor = ThemeColors.get(brightnessKey, 'fill/contrast/600');
          textColor = brightnessKey == 'light' 
              ? const Color(0xFFFFFFFF) 
              : ThemeColors.get(brightnessKey, 'text/base/600');
          borderColor = ThemeColors.get(brightnessKey, 'text/base/600');
          boxShadow = [
            BoxShadow(
              color: const Color(0x10182828).withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ];
          break;
      }
    }

    return GestureDetector(
      onTapDown: widget.enabled ? (_) => setState(() => _isPressed = true) : null,
      onTapUp: widget.enabled ? (_) => setState(() => _isPressed = false) : null,
      onTapCancel: widget.enabled ? () => setState(() => _isPressed = false) : null,
      onTap: widget.enabled ? widget.onPressed : null,
      child: AnimatedScale(
        scale: _isPressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(999),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1)
              : null,
          boxShadow: boxShadow,
        ),
          child: Center(
            child: Text(
              widget.type == ButtonType.amount ? widget.text.replaceAll('฿', '') : widget.text,
              style: GoogleFonts.notoSansThai(
                fontSize: 15,
                height: 1.33,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
