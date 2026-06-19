import 'package:flutter/material.dart';
import '../models/gift.dart';
import '../models/user.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';

class EnhancedGiftPanel extends StatefulWidget {
  final VoidCallback? onClose;
  final Function(GiftItem, int) onSendGift;
  final AppUser? receiver;

  const EnhancedGiftPanel({
    super.key,
    this.onClose,
    required this.onSendGift,
    this.receiver,
  });

  @override
  State<EnhancedGiftPanel> createState() => _EnhancedGiftPanelState();
}

class _EnhancedGiftPanelState extends State<EnhancedGiftPanel> {
  late GiftCategory _selectedCategory = GiftCategory.popular;
  int _selectedQuantity = 1;
  GiftItem? _selectedGift;

  final gifts = {
    GiftCategory.popular: [
      GiftItem(
        id: 'p1',
        name: 'Rose',
        emoji: '🌹',
        price: 1,
        category: GiftCategory.popular,
        description: 'Beautiful red rose',
        rarity: 'common',
      ),
      GiftItem(
        id: 'p2',
        name: 'Cake',
        emoji: '🎂',
        price: 3,
        category: GiftCategory.popular,
        description: 'Sweet birthday cake',
        rarity: 'common',
      ),
      GiftItem(
        id: 'p3',
        name: 'Diamond',
        emoji: '💎',
        price: 5,
        category: GiftCategory.popular,
        description: 'Shiny diamond',
        rarity: 'rare',
      ),
      GiftItem(
        id: 'p4',
        name: 'Crown',
        emoji: '👑',
        price: 10,
        category: GiftCategory.popular,
        description: 'Royal crown',
        rarity: 'epic',
      ),
    ],
    GiftCategory.luxury: [
      GiftItem(
        id: 'l1',
        name: 'Yacht',
        emoji: '⛵',
        price: 100,
        category: GiftCategory.luxury,
        description: 'Luxurious yacht',
        rarity: 'epic',
      ),
      GiftItem(
        id: 'l2',
        name: 'Sports Car',
        emoji: '🏎️',
        price: 150,
        category: GiftCategory.luxury,
        description: 'High-speed sports car',
        rarity: 'legendary',
      ),
    ],
    GiftCategory.lucky: [
      GiftItem(
        id: 'lk1',
        name: 'Lucky Gift',
        emoji: '🎁',
        price: 50,
        category: GiftCategory.lucky,
        isLucky: true,
        multiplier: 2,
        description: 'Mystery lucky gift',
        rarity: 'mythic',
      ),
    ],
    GiftCategory.svip: [
      GiftItem(
        id: 'sv1',
        name: 'SVIP Exclusive',
        emoji: '✨',
        price: 200,
        category: GiftCategory.svip,
        description: 'SVIP member exclusive',
        rarity: 'legendary',
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final currentGifts = gifts[_selectedCategory] ?? [];

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
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
        border: Border(
          top: BorderSide(
            color: AppColors.borderLight.withAlpha((0.2 * 255).toInt()),
          ),
        ),
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
                  'Send Gift',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
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

          // Category Tabs
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: GiftCategory.values.map((cat) {
                final isSelected = cat == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = cat),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(colors: AppColors.accentGradient)
                          : null,
                      color: isSelected
                          ? null
                          : AppColors.glassLight.withAlpha(
                              (0.05 * 255).toInt(),
                            ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.accentLight
                            : AppColors.borderLight.withAlpha(
                                (0.1 * 255).toInt(),
                              ),
                      ),
                    ),
                    child: Text(
                      cat.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 12),

          // Gift Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
              itemCount: currentGifts.length,
              itemBuilder: (context, index) {
                final gift = currentGifts[index];
                final isSelected = _selectedGift?.id == gift.id;

                return GestureDetector(
                  onTap: () => setState(() => _selectedGift = gift),
                  child: GlassContainer(
                    borderRadius: 16,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.accentLight
                          : AppColors.borderLight.withAlpha(
                              (0.1 * 255).toInt(),
                            ),
                      width: isSelected ? 2 : 1,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(gift.emoji, style: const TextStyle(fontSize: 32)),
                        const SizedBox(height: 4),
                        Text(
                          '${gift.price}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accentLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // Selected Gift Details & Send Button
          if (_selectedGift != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  GlassContainer(
                    padding: const EdgeInsets.all(12),
                    borderRadius: 16,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedGift!.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  _selectedGift!.description,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _selectedGift!.emoji,
                              style: const TextStyle(fontSize: 28),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () => setState(
                                      () => _selectedQuantity =
                                          (_selectedQuantity - 1).clamp(1, 99),
                                    ),
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: AppColors.accentLight.withAlpha(
                                          (0.2 * 255).toInt(),
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(Icons.remove, size: 16),
                                    ),
                                  ),
                                  Text(
                                    'x$_selectedQuantity',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => setState(
                                      () => _selectedQuantity =
                                          (_selectedQuantity + 1).clamp(1, 99),
                                    ),
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: AppColors.accentLight.withAlpha(
                                          (0.2 * 255).toInt(),
                                        ),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: const Icon(Icons.add, size: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: AppColors.accentGradient,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${_selectedGift!.price * _selectedQuantity} 💰',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      if (_selectedGift != null) {
                        widget.onSendGift(_selectedGift!, _selectedQuantity);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: AppColors.accentGradient,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        'Send Gift',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
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
