import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PreLoading extends StatelessWidget {
  const PreLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blur background
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: const Color.fromRGBO(0, 0, 0, 0.5)),
          ),
        ),
        // Lottie Animation
        Center(
          child: Lottie.asset(
            'lib/assets/lottie/wi_loader.json',
            width: 240,
            height: 240,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
