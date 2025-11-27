import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieSkeleton extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? lottieAsset;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  const LottieSkeleton({
    super.key,
    required this.isLoading,
    required this.child,
    this.lottieAsset,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Stack(
      children: [
        // The real child, invisible, to maintain layout size
        Opacity(opacity: 0, child: child),
        // The Lottie animation filling the space
        Positioned.fill(
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: Lottie.asset(
              lottieAsset ?? 'lib/assets/lottie/wi_skeleton.json',
              width: width,
              height: height,
              fit: BoxFit.fill,
              repeat: true,
            ),
          ),
        ),
      ],
    );
  }
}
