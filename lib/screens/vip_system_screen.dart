import 'package:flutter/material.dart';
import '../models/vip_system.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_container.dart';

class VipSystemScreen extends StatefulWidget {
  const VipSystemScreen({super.key});

  @override
  State<VipSystemScreen> createState() => _VipSystemScreenState();
}

class _VipSystemScreenState extends State<VipSystemScreen> {
  int _expandedTier = -1;

  final vipTiers = [
    VipTier(
      tier: 1,
      name: 'VIP 1',
      color: '#4A90E2',
      badge: '🎖️',
      monthlyPrice: 99,
      benefits: [
        'Extra 10% coin bonus',
        'Priority in room',
        'VIP badge display',
        'Gift animations priority',
      ],
      avatarFrames: ['frame_vip1'],
      description: 'Entry level VIP with basic benefits',
    ),
    VipTier(
      tier: 2,
      name: 'VIP 2',
      color: '#7B68EE',
      badge: '🎖️⭐',
      monthlyPrice: 149,
      benefits: [
        'Extra 20% coin bonus',
        'Priority in room',
        'Custom name color',
        'VIP lounge access',
        'Special gift animations',
      ],
      avatarFrames: ['frame_vip2_a', 'frame_vip2_b'],
      description: 'Enhanced VIP with more perks',
    ),
    VipTier(
      tier: 3,
      name: 'VIP 3',
      color: '#FF6B6B',
      badge: '👑',
      monthlyPrice: 199,
      benefits: [
        'Extra 30% coin bonus',
        'Premium room entry',
        'Custom badge design',
        'VIP lounge access',
        'Exclusive gift animations',
        'Monthly reward',
      ],
      avatarFrames: ['frame_vip3_a', 'frame_vip3_b', 'frame_vip3_c'],
      description: 'Premium VIP with exclusive benefits',
    ),
    VipTier(
      tier: 4,
      name: 'VIP 4',
      color: '#FFD700',
      badge: '👑✨',
      monthlyPrice: 299,
      benefits: [
        'Extra 40% coin bonus',
        'VIP room priority',
        'Exclusive badge',
        'VIP lounge + private room',
        'Premium animations',
        'Weekly reward',
        'Voice effects',
      ],
      avatarFrames: [
        'frame_vip4_a',
        'frame_vip4_b',
        'frame_vip4_c',
        'frame_vip4_d',
      ],
      description: 'Elite VIP tier',
    ),
    VipTier(
      tier: 5,
      name: 'SVIP 1',
      color: '#FF1493',
      badge: '✨💎',
      monthlyPrice: 399,
      benefits: [
        'Extra 50% coin bonus',
        'SVIP room exclusive',
        'Luxury badge design',
        'Private SVIP lounge',
        'Legendary animations',
        'Daily reward',
        'Voice effects + distortion',
        'Priority PK battles',
      ],
      avatarFrames: [
        'frame_svip1_a',
        'frame_svip1_b',
        'frame_svip1_c',
        'frame_svip1_d',
        'frame_svip1_e',
      ],
      description: 'SVIP exclusive membership',
    ),
    VipTier(
      tier: 6,
      name: 'SVIP 2',
      color: '#00CED1',
      badge: '👑✨💎',
      monthlyPrice: 599,
      benefits: [
        'Extra 100% coin bonus',
        'SVIP room exclusive',
        'Platinum badge',
        'Private SVIP lounge + penthouse',
        'Mythical animations',
        'Daily rewards + bonus',
        'All voice effects',
        'Priority PK + tournament entry',
        'Account assistant',
        'Birthday gift',
      ],
      avatarFrames: [
        'frame_svip2_a',
        'frame_svip2_b',
        'frame_svip2_c',
        'frame_svip2_d',
        'frame_svip2_e',
        'frame_svip2_f',
      ],
      description: 'Ultimate SVIP membership',
    ),
  ];

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
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'VIP System',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                  GlassContainer(
                    onTap: () => Navigator.pop(context),
                    padding: const EdgeInsets.all(10),
                    borderRadius: 14,
                    child: const Icon(Icons.close, size: 22),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // VIP Tiers List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                itemCount: vipTiers.length,
                itemBuilder: (context, index) {
                  final tier = vipTiers[index];
                  final isExpanded = _expandedTier == index;
                  final isSvip = tier.tier >= 5;

                  return GestureDetector(
                    onTap: () =>
                        setState(() => _expandedTier = isExpanded ? -1 : index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        gradient: isSvip
                            ? LinearGradient(
                                colors: [
                                  AppColors.accentLight.withAlpha(
                                    (0.15 * 255).toInt(),
                                  ),
                                  AppColors.accentLight.withAlpha(
                                    (0.05 * 255).toInt(),
                                  ),
                                ],
                              )
                            : null,
                        color: isSvip
                            ? null
                            : AppColors.glassLight.withAlpha(
                                (0.08 * 255).toInt(),
                              ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSvip
                              ? AppColors.accentLight.withAlpha(
                                  (0.3 * 255).toInt(),
                                )
                              : AppColors.borderLight.withAlpha(
                                  (0.1 * 255).toInt(),
                                ),
                          width: isSvip ? 1.5 : 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Text(
                                  tier.badge,
                                  style: const TextStyle(fontSize: 32),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tier.name,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        tier.description,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$${tier.monthlyPrice}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        color: AppColors.accentLight,
                                      ),
                                    ),
                                    const Text(
                                      '/month',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Icon(
                                  isExpanded
                                      ? Icons.expand_less
                                      : Icons.expand_more,
                                  color: AppColors.accentLight,
                                ),
                              ],
                            ),
                          ),
                          if (isExpanded) ...[
                            Divider(
                              color: AppColors.borderLight.withAlpha(
                                (0.1 * 255).toInt(),
                              ),
                              height: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Benefits',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  ...tier.benefits.map((benefit) {
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            isSvip ? '✨' : '⭐',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              benefit,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Upgrading to ${tier.name}...',
                                                ),
                                                backgroundColor:
                                                    AppColors.accentLight,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors:
                                                    AppColors.accentGradient,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Text(
                                              'Upgrade Now',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
