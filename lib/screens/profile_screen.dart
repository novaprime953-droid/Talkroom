import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../models/user.dart';
import '../theme/app_colors.dart';
import '../widgets/avatar_frame.dart';
import '../widgets/glass_container.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockData.currentUser;

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
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                  GlassContainer(
                    padding: const EdgeInsets.all(10),
                    borderRadius: 14,
                    child: const Icon(Icons.settings_outlined, size: 22),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              GlassContainer(
                padding: const EdgeInsets.all(24),
                borderRadius: 28,
                child: Column(
                  children: [
                    AvatarFrame(user: user, size: 96),
                    const SizedBox(height: 16),
                    Text(
                      user.name,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: AppColors.svipGradient),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        user.vipLabel,
                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.bio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatItem(label: 'Followers', value: '${user.followers}'),
                        _StatItem(label: 'Following', value: '${user.following}'),
                        _StatItem(label: 'Level', value: '${user.level}'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildWalletCard(user.coins),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'VIP Tier Frames',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final tier = index + 1;
                    final demoUser = AppUser(
                      id: 't$tier',
                      name: 'Tier $tier',
                      avatarUrl: user.avatarUrl,
                      vipTier: tier,
                      coins: 0,
                      level: tier * 10,
                      isOnline: true,
                    );
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          AvatarFrame(user: demoUser, size: 56, showBadge: true),
                          const SizedBox(height: 6),
                          Text(
                            tier >= 5 ? 'SVIP $tier' : 'VIP $tier',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppColors.vipColorForTier(tier),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              _buildMenuItem(Icons.diamond_outlined, 'VIP Center', 'Unlock exclusive perks'),
              _buildMenuItem(Icons.card_giftcard_outlined, 'Gift History', 'View sent & received'),
              _buildMenuItem(Icons.emoji_events_outlined, 'Achievements', '12 badges earned'),
              _buildMenuItem(Icons.help_outline_rounded, 'Help & Support', 'FAQ and contact'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletCard(int coins) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: 20,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: AppColors.vipGradient),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.account_balance_wallet_rounded, color: AppColors.navy900),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('My Coins', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                Text(
                  '$coins',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.gold400),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.teal500,
              foregroundColor: AppColors.navy900,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Recharge', style: TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: 16,
        child: Row(
          children: [
            Icon(icon, color: AppColors.teal400),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
      ],
    );
  }
}
