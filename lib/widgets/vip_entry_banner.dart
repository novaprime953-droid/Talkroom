import 'package:flutter/material.dart';
import '../models/user.dart';
import '../theme/app_colors.dart';
import 'svga_animation.dart';

class VipEntryBanner extends StatefulWidget {
  const VipEntryBanner({
    super.key,
    required this.user,
    required this.svgaAsset,
    required this.onComplete,
  });

  final AppUser user;
  final String svgaAsset;
  final VoidCallback onComplete;

  @override
  State<VipEntryBanner> createState() => _VipEntryBannerState();
}

class _VipEntryBannerState extends State<VipEntryBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));
    _slideController.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tierColor = AppColors.vipColorForTier(widget.user.vipTier);

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: widget.user.isSvip
                ? AppColors.svipGradient.map((c) => c.withValues(alpha: 0.85)).toList()
                : AppColors.vipGradient.map((c) => c.withValues(alpha: 0.85)).toList(),
          ),
          boxShadow: [
            BoxShadow(
              color: tierColor.withValues(alpha: 0.4),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 72,
              height: 72,
              child: SvgaAnimation(
                assetPath: widget.svgaAsset,
                width: 72,
                height: 72,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.isSvip ? 'SVIP ENTRANCE' : 'VIP ENTRANCE',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      widget.user.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(widget.user.avatarUrl),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
