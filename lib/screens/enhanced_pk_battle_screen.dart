import 'package:flutter/material.dart';
import '../models/pk_battle.dart';
import '../models/user.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_container.dart';

class EnhancedPkBattleScreen extends StatefulWidget {
  final PkBattle? initialBattle;

  const EnhancedPkBattleScreen({super.key, this.initialBattle});

  @override
  State<EnhancedPkBattleScreen> createState() => _EnhancedPkBattleScreenState();
}

class _EnhancedPkBattleScreenState extends State<EnhancedPkBattleScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late PkBattle _battle;

  final player1Supporters = [
    AppUser(
      id: 's1',
      name: 'Supporter 1',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      vipTier: 2,
      coins: 1000,
      level: 25,
      isOnline: true,
    ),
    AppUser(
      id: 's2',
      name: 'Supporter 2',
      avatarUrl: 'https://i.pravatar.cc/150?img=2',
      vipTier: 1,
      coins: 500,
      level: 18,
      isOnline: true,
    ),
  ];

  final player2Supporters = [
    AppUser(
      id: 's3',
      name: 'Fan 1',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      vipTier: 3,
      coins: 2000,
      level: 30,
      isOnline: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _battle =
        widget.initialBattle ??
        PkBattle(
          id: 'pk_001',
          player1Id: 'p1',
          player1Name: 'Alex Chen',
          player1Avatar: 'https://i.pravatar.cc/150?img=10',
          player1Vip: 6,
          player2Id: 'p2',
          player2Name: 'Jordan Smith',
          player2Avatar: 'https://i.pravatar.cc/150?img=11',
          player2Vip: 5,
          player1Score: 450,
          player2Score: 380,
          status: PkStatus.live,
          startTime: DateTime.now().subtract(const Duration(seconds: 45)),
          durationSeconds: 180,
          supporters1: ['s1', 's2'],
          supporters2: ['s3'],
        );
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.backgroundGradient,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with Timer
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GlassContainer(
                      onTap: () => Navigator.pop(context),
                      padding: const EdgeInsets.all(10),
                      borderRadius: 14,
                      child: const Icon(Icons.close, size: 22),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: AppColors.accentGradient,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${(_battle.remainingSeconds).clamp(0, 999)}s',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    GlassContainer(
                      padding: const EdgeInsets.all(10),
                      borderRadius: 14,
                      child: const Icon(Icons.share, size: 22),
                    ),
                  ],
                ),
              ),

              // Progress Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    value: _battle.progressPercent,
                    minHeight: 6,
                    backgroundColor: AppColors.borderLight.withAlpha(
                      (0.1 * 255).toInt(),
                    ),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.lerp(
                        const Color(0xFF00CED1),
                        const Color(0xFFFF1493),
                        _battle.progressPercent,
                      )!,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // VS Screen
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GlassContainer(
                  padding: const EdgeInsets.all(20),
                  borderRadius: 24,
                  child: Column(
                    children: [
                      // Players Info
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildPlayerCard(
                            name: _battle.player1Name,
                            avatar: _battle.player1Avatar,
                            vip: _battle.player1Vip,
                            score: _battle.player1Score,
                            isWinning:
                                _battle.player1Score > _battle.player2Score,
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: AppColors.accentGradient,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                'VS',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          _buildPlayerCard(
                            name: _battle.player2Name,
                            avatar: _battle.player2Avatar,
                            vip: _battle.player2Vip,
                            score: _battle.player2Score,
                            isWinning:
                                _battle.player2Score > _battle.player1Score,
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // Score Bars
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value:
                                        _battle.player1Score /
                                        (_battle.player1Score +
                                                _battle.player2Score)
                                            .toDouble(),
                                    minHeight: 8,
                                    backgroundColor: AppColors.borderLight
                                        .withAlpha((0.1 * 255).toInt()),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          Color(0xFF00CED1),
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${_battle.player1Score} pts',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF00CED1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value:
                                        _battle.player2Score /
                                        (_battle.player1Score +
                                                _battle.player2Score)
                                            .toDouble(),
                                    minHeight: 8,
                                    backgroundColor: AppColors.borderLight
                                        .withAlpha((0.1 * 255).toInt()),
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          Color(0xFFFF1493),
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${_battle.player2Score} pts',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFF1493),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Supporters Section
              if (player1Supporters.isNotEmpty ||
                  player2Supporters.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Supporters',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          // Player 1 Supporters
                          Expanded(
                            child: SizedBox(
                              height: 80,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: player1Supporters.length,
                                itemBuilder: (context, index) {
                                  final supporter = player1Supporters[index];
                                  return Container(
                                    width: 70,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFF00CED1),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 18,
                                          backgroundImage: NetworkImage(
                                            supporter.avatarUrl,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'L${supporter.level}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Player 2 Supporters
                          Expanded(
                            child: SizedBox(
                              height: 80,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: player2Supporters.length,
                                itemBuilder: (context, index) {
                                  final supporter = player2Supporters[index];
                                  return Container(
                                    width: 70,
                                    margin: const EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFFFF1493),
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 18,
                                          backgroundImage: NetworkImage(
                                            supporter.avatarUrl,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'L${supporter.level}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Supporting Player 1...'),
                            backgroundColor: Color(0xFF00CED1),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF00CED1,
                            ).withAlpha((0.2 * 255).toInt()),
                            border: Border.all(color: const Color(0xFF00CED1)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Support P1 🎁',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: Color(0xFF00CED1),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Supporting Player 2...'),
                            backgroundColor: Color(0xFFFF1493),
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFFFF1493,
                            ).withAlpha((0.2 * 255).toInt()),
                            border: Border.all(color: const Color(0xFFFF1493)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Support P2 🎁',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 13,
                              color: Color(0xFFFF1493),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerCard({
    required String name,
    required String avatar,
    required int vip,
    required int score,
    required bool isWinning,
  }) {
    final isSvip = vip >= 5;
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(radius: 36, backgroundImage: NetworkImage(avatar)),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isSvip
                        ? [const Color(0xFFFF1493), const Color(0xFF00CED1)]
                        : [const Color(0xFF7B68EE), const Color(0xFF4A90E2)],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isSvip ? 'SVIP' : 'VIP',
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ),
        if (isWinning)
          const Text(
            'Leading! 🔥',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Colors.amber,
            ),
          ),
      ],
    );
  }
}
