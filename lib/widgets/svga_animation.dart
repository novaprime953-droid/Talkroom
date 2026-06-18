import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Animated visual stand-in for bundled SVGA assets.
/// SVGA binary playback needs a native plugin; this widget provides
/// a polished motion graphic fallback keyed to the asset name.
class SvgaAnimation extends StatefulWidget {
  const SvgaAnimation({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
  });

  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  State<SvgaAnimation> createState() => _SvgaAnimationState();
}

class _SvgaAnimationState extends State<SvgaAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool get _isEntry => widget.assetPath.contains('svip_enter');
  bool get _isLucky => widget.assetPath.contains('lucky_gift');
  bool get _isSuper => widget.assetPath.contains('super_gift');

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _isEntry ? 2200 : 1600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (_isEntry) return _buildEntryEffect();
          if (_isLucky) return _buildLuckyEffect();
          if (_isSuper) return _buildSuperEffect();
          return _buildGenericEffect();
        },
      ),
    );
  }

  Widget _buildEntryEffect() {
    final t = _controller.value;
    return Stack(
      alignment: Alignment.center,
      children: [
        ...List.generate(3, (i) {
          final scale = 0.6 + ((t + i * 0.33) % 1.0) * 0.8;
          return Transform.scale(
            scale: scale,
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.gold400.withValues(alpha: 0.4 - i * 0.1),
                  width: 2,
                ),
              ),
            ),
          );
        }),
        Icon(Icons.auto_awesome_rounded, color: AppColors.gold400.withValues(alpha: 0.9), size: 28),
        Positioned(
          right: 4,
          child: Transform.rotate(
            angle: t * math.pi * 2,
            child: const Icon(Icons.star_rounded, color: AppColors.teal300, size: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildLuckyEffect() {
    final t = _controller.value;
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: t * math.pi * 2,
          child: Icon(Icons.casino_rounded, color: AppColors.gold400, size: 36),
        ),
        ...List.generate(6, (i) {
          final angle = (i / 6) * math.pi * 2 + t * math.pi * 2;
          return Transform.translate(
            offset: Offset(math.cos(angle) * 22, math.sin(angle) * 22),
            child: Text('🪙', style: TextStyle(fontSize: 10 + (i % 2) * 4)),
          );
        }),
      ],
    );
  }

  Widget _buildSuperEffect() {
    final t = _controller.value;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 56 + t * 20,
          height: 56 + t * 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.purple500.withValues(alpha: 0.6),
                Colors.transparent,
              ],
            ),
          ),
        ),
        const Text('🔥', style: TextStyle(fontSize: 40)),
      ],
    );
  }

  Widget _buildGenericEffect() {
    return Icon(
      Icons.bolt_rounded,
      color: AppColors.teal400.withValues(alpha: 0.8),
      size: 32,
    );
  }
}
