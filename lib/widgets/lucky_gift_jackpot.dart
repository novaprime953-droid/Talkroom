import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../models/pk_battle.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';

class LuckyGiftJackpot extends StatefulWidget {
  final VoidCallback? onClose;
  final Function(LuckyGift)? onSendGift;

  const LuckyGiftJackpot({super.key, this.onClose, this.onSendGift});

  @override
  State<LuckyGiftJackpot> createState() => _LuckyGiftJackpotState();
}

class _LuckyGiftJackpotState extends State<LuckyGiftJackpot>
    with TickerProviderStateMixin {
  late AnimationController _spinController;
  late AnimationController _pulseController;
  int _selectedMultiplier = 1;
  final int _totalJackpot = 50000;

  final luckyGifts = [
    LuckyGift(
      id: 'lucky_1',
      name: 'Lucky Box',
      basePrice: 50,
      currentMultiplier: 1,
      maxMultiplier: 5,
      animationUrl: 'assets/lottie/gift/diamond/lucky_1.json',
      minReward: 50,
      maxReward: 250,
    ),
    LuckyGift(
      id: 'lucky_2',
      name: 'Mystery Gift',
      basePrice: 100,
      currentMultiplier: 2,
      maxMultiplier: 10,
      animationUrl: 'assets/lottie/gift/diamond/lucky_2.json',
      minReward: 100,
      maxReward: 1000,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _spinController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.glassLight.withAlpha((0.15 * 255).toInt()),
            AppColors.glassDark.withAlpha((0.1 * 255).toInt()),
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '🎰 Lucky Gifts',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                GlassContainer(
                  onTap: widget.onClose,
                  padding: const EdgeInsets.all(8),
                  borderRadius: 12,
                  child: const Icon(Icons.close, size: 20),
                ),
              ],
            ),
          ),

          // Jackpot Display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GlassContainer(
              padding: const EdgeInsets.all(16),
              borderRadius: 20,
              child: Column(
                children: [
                  const Text(
                    'Jackpot Pool',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Text(
                        '💰 $_totalJackpot',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Color.lerp(
                            AppColors.accentLight,
                            Colors.yellow,
                            _pulseController.value,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Win up to 100x your gift value!',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Multiplier Wheel
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Multiplier',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFFFF1493).withAlpha((0.15 * 255).toInt()),
                        const Color(0xFF00CED1).withAlpha((0.15 * 255).toInt()),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.borderLight.withAlpha(
                        (0.2 * 255).toInt(),
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      AnimatedBuilder(
                        animation: _spinController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _spinController.value * 2 * math.pi,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: AppColors.accentGradient,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${_selectedMultiplier}x',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: _spinMultiplier,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: AppColors.accentGradient,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Spin Wheel!',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Lucky Gifts
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: luckyGifts.length,
              itemBuilder: (context, index) {
                final gift = luckyGifts[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.glassLight.withAlpha((0.08 * 255).toInt()),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.borderLight.withAlpha(
                        (0.1 * 255).toInt(),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: AppColors.accentGradient,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text('🎁', style: TextStyle(fontSize: 28)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              gift.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Win: ${gift.minReward}-${gift.maxReward} (×$_selectedMultiplier)',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _sendLuckyGift(gift),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: AppColors.accentGradient,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${gift.basePrice * _selectedMultiplier}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.glassLight.withAlpha((0.05 * 255).toInt()),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.borderLight.withAlpha((0.1 * 255).toInt()),
                ),
              ),
              child: Row(
                children: [
                  const Text('ℹ️', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Every gift increases the jackpot! Win big with lucky multipliers.',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _spinMultiplier() {
    _spinController.forward(from: 0).then((_) {
      setState(() {
        _selectedMultiplier =
            math.Random().nextInt(9) + 1; // 1 to 10 multiplier
      });
    });
  }

  void _sendLuckyGift(LuckyGift gift) {
    final reward =
        gift.minReward +
        math.Random().nextInt(gift.maxReward - gift.minReward) *
            _selectedMultiplier;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '🎉 You won $reward coins! (${gift.name} ×$_selectedMultiplier)',
        ),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.pop(context);
  }
}
