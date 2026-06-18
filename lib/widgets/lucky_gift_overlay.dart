import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../theme/app_colors.dart';

class LuckyGiftOverlay extends StatefulWidget {
  const LuckyGiftOverlay({
    super.key,
    required this.multiplier,
    required this.onComplete,
  });

  final int multiplier;
  final VoidCallback onComplete;

  @override
  State<LuckyGiftOverlay> createState() => _LuckyGiftOverlayState();
}

class _LuckyGiftOverlayState extends State<LuckyGiftOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) widget.onComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black87,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Lottie.asset(
              'assets/lottie/lucky_number.json',
              fit: BoxFit.cover,
            ),
          ),
          ScaleTransition(
            scale: _scale,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🎰', style: TextStyle(fontSize: 64)),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: AppColors.vipGradient,
                  ).createShader(bounds),
                  child: Text(
                    'LUCKY x${widget.multiplier}!',
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Jackpot reward unlocked!',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
