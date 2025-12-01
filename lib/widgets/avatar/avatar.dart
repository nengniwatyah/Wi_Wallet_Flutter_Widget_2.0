import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mcp_test_app/widgets/skeleton/lottie_skeleton.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';

enum AvatarStatus { none, danger, warning }

/// A Profile Card widget that displays an avatar, name, handle, and a QR code action.
///
/// This widget matches the design from Figma Node 7202:33736.
/// It supports a loading state via [LottieSkeleton].
class Avatar extends StatelessWidget {
  /// The URL of the image to display.
  final String? imageUrl;

  /// The local asset path of the image to display.
  /// Used if [imageUrl] is null.
  final String? assetPath;

  /// The display name of the user.
  final String name;

  /// The handle/username of the user (e.g. @niwat.yah).
  final String handle;

  /// The radius of the avatar circle. Defaults to 24.
  final double radius;

  /// Whether the widget should display a loading skeleton.
  final bool isLoading;

  /// The status of the user, displayed as a badge.
  final AvatarStatus status;

  /// Callback for when the QR code icon is tapped.
  final VoidCallback? onQrTap;

  const Avatar({
    super.key,
    this.imageUrl,
    this.assetPath,
    required this.name,
    required this.handle,
    this.radius = 24,
    this.isLoading = false,
    this.status = AvatarStatus.none,
    this.onQrTap,
  });

  @override
  Widget build(BuildContext context) {
    final brightnessKey =
        Theme.of(context).brightness == Brightness.light ? 'light' : 'dark';

    ImageProvider? backgroundImage;
    if (imageUrl != null) {
      backgroundImage = NetworkImage(imageUrl!);
    } else if (assetPath != null) {
      backgroundImage = AssetImage(assetPath!);
    }

    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: ThemeColors.get(brightnessKey, 'fill/base/100'),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Avatar with Skeleton and Status Badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              LottieSkeleton(
                isLoading: isLoading,
                borderRadius: BorderRadius.circular(radius),
                child: CircleAvatar(
                  radius: radius,
                  backgroundImage: backgroundImage,
                  backgroundColor: ThemeColors.get(
                    brightnessKey,
                    'fill/base/200',
                  ),
                  child:
                      backgroundImage == null
                          ? SvgPicture.asset(
                            'lib/assets/images/user-add-01.svg',
                            width: radius, // Adjust size as needed
                            height: radius,
                            colorFilter: ColorFilter.mode(
                              ThemeColors.get(brightnessKey, 'text/base/600'),
                              BlendMode.srcIn,
                            ),
                          )
                          : null,
                ),
              ),
              if (status != AvatarStatus.none)
                Positioned(
                  top: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    status == AvatarStatus.danger
                        ? 'lib/assets/images/statusdanger.svg'
                        : 'lib/assets/images/statuswarning.svg',
                    width: 18,
                    height: 18,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          // Text Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name
                LottieSkeleton(
                  isLoading: isLoading,
                  borderRadius: BorderRadius.circular(4),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.get(brightnessKey, 'text/base/600'),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Handle
                LottieSkeleton(
                  isLoading: isLoading,
                  borderRadius: BorderRadius.circular(4),
                  child: Text(
                    handle,
                    style: TextStyle(
                      fontSize: 10,
                      color: ThemeColors.get(brightnessKey, 'text/base/600'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
