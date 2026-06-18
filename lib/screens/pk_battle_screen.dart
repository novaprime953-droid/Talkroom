import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../services/app_repository.dart';
import '../models/user.dart';
import '../theme/app_colors.dart';
import '../widgets/avatar_frame.dart';
import '../widgets/glass_container.dart';

class PkBattleScreen extends StatefulWidget {
  const PkBattleScreen({super.key});

  @override
  State<PkBattleScreen> createState() => _PkBattleScreenState();
}

class _PkBattleScreenState extends State<PkBattleScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  int _redScore = 8420;
  int _blueScore = 7890;
  final double _timer = 180;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = _redScore + _blueScore;
    final redPercent = total > 0 ? _redScore / total : 0.5;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.navy900,
              const Color(0xFF1E1033),
              AppColors.navy800,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: Lottie.asset('assets/lottie/match/match.json'),
                      ),
                      const SizedBox(height: 8),
                      _buildScoreBar(redPercent),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: _buildFighter(AppRepository.instance.micUsers[0], true)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: ScaleTransition(
                              scale: Tween<double>(begin: 0.9, end: 1.1).animate(_pulseController),
                              child: Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: AppColors.svipGradient),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.purple500.withValues(alpha: 0.5),
                                      blurRadius: 20,
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'VS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(child: _buildFighter(AppRepository.instance.micUsers[2], false)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildTimer(),
                      const SizedBox(height: 24),
                      _buildSupporters(),
                      const SizedBox(height: 24),
                      _buildActionButtons(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
          const Expanded(
            child: Text(
              'PK Battle Arena',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            borderRadius: 12,
            child: const Row(
              children: [
                Icon(Icons.remove_red_eye_outlined, size: 14, color: AppColors.teal400),
                SizedBox(width: 4),
                Text('5.6K', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildScoreBar(double redPercent) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('$_redScore', style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.red500)),
            Text('$_blueScore', style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.blue500)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 16,
            child: Row(
              children: [
                Expanded(flex: (redPercent * 100).round(), child: Container(color: AppColors.red500)),
                Expanded(flex: ((1 - redPercent) * 100).round(), child: Container(color: AppColors.blue500)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFighter(AppUser user, bool isRed) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: 20,
      borderColor: isRed ? AppColors.red500.withValues(alpha: 0.5) : AppColors.blue500.withValues(alpha: 0.5),
      child: Column(
        children: [
          AvatarFrame(user: user, size: 72, isSpeaking: true),
          const SizedBox(height: 10),
          Text(user.name, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: isRed ? AppColors.red500 : AppColors.blue500,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              isRed ? 'RED TEAM' : 'BLUE TEAM',
              style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimer() {
    final minutes = (_timer / 60).floor();
    final seconds = (_timer % 60).floor();
    return GlassContainer(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      borderRadius: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.timer_outlined, color: AppColors.gold400),
          const SizedBox(width: 10),
          Text(
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: AppColors.gold400,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupporters() {
    return GlassContainer(
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Top Supporters', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          ...AppRepository.instance.micUsers.take(3).map(
            (u) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  AvatarFrame(user: u, size: 32, showBadge: false),
                  const SizedBox(width: 10),
                  Expanded(child: Text(u.name, style: const TextStyle(fontSize: 13))),
                  Text('${u.coins}', style: const TextStyle(color: AppColors.gold400, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => setState(() => _redScore += 100),
            icon: const Icon(Icons.favorite_rounded),
            label: const Text('Support Red'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red500,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => setState(() => _blueScore += 100),
            icon: const Icon(Icons.favorite_rounded),
            label: const Text('Support Blue'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue500,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ],
    );
  }
}
