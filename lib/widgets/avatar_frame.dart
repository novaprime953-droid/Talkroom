import 'package:flutter/material.dart';
import '../models/user.dart';
import '../theme/app_colors.dart';

class AvatarFrame extends StatelessWidget {
  const AvatarFrame({
    super.key,
    required this.user,
    this.size = 64,
    this.showBadge = true,
    this.isSpeaking = false,
  });

  final AppUser user;
  final double size;
  final bool showBadge;
  final bool isSpeaking;

  @override
  Widget build(BuildContext context) {
    final tierColor = AppColors.vipColorForTier(user.vipTier);
    final frameWidth = user.vipTier >= 5 ? 3.5 : user.vipTier > 0 ? 2.5 : 1.5;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            if (isSpeaking)
              Container(
                width: size + 16,
                height: size + 16,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.teal400.withValues(alpha: 0.5),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            if (user.vipTier >= 5)
              Container(
                width: size + 12,
                height: size + 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: SweepGradient(
                    colors: [
                      tierColor,
                      AppColors.gold400,
                      AppColors.purple500,
                      tierColor,
                    ],
                  ),
                ),
              ),
            Container(
              width: size + frameWidth * 2,
              height: size + frameWidth * 2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: user.vipTier > 0 ? tierColor : AppColors.glassBorder,
                  width: frameWidth,
                ),
                boxShadow: user.vipTier >= 4
                    ? [
                        BoxShadow(
                          color: tierColor.withValues(alpha: 0.4),
                          blurRadius: 12,
                        ),
                      ]
                    : null,
              ),
              child: Padding(
                padding: EdgeInsets.all(frameWidth),
                child: CircleAvatar(
                  radius: size / 2,
                  backgroundImage: NetworkImage(user.avatarUrl),
                ),
              ),
            ),
            if (showBadge && user.vipTier > 0)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: user.isSvip
                          ? AppColors.svipGradient
                          : AppColors.vipGradient,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.navy900, width: 1.5),
                  ),
                  child: Text(
                    user.isSvip ? 'S${user.vipTier}' : 'V${user.vipTier}',
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: AppColors.navy900,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
