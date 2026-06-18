import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/gift.dart';
import '../theme/app_colors.dart';
import 'glass_container.dart';
import 'svga_animation.dart';

class GiftPanel extends StatefulWidget {
  const GiftPanel({
    super.key,
    required this.gifts,
    required this.coins,
    required this.onSend,
    required this.onClose,
  });

  final List<GiftItem> gifts;
  final int coins;
  final void Function(GiftItem gift) onSend;
  final VoidCallback onClose;

  @override
  State<GiftPanel> createState() => _GiftPanelState();
}

class _GiftPanelState extends State<GiftPanel> with SingleTickerProviderStateMixin {
  GiftCategory _selected = GiftCategory.popular;
  GiftItem? _selectedGift;

  static const _tabs = {
    GiftCategory.popular: 'Popular',
    GiftCategory.luxury: 'Luxury',
    GiftCategory.lucky: 'Lucky',
    GiftCategory.svip: 'SVIP',
  };

  @override
  Widget build(BuildContext context) {
    final filtered = widget.gifts.where((g) => g.category == _selected).toList();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navy800,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(top: BorderSide(color: AppColors.glassBorder)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textMuted,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 8),
            child: Row(
              children: [
                const Text(
                  'Send Gift',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
                const Spacer(),
                GlassContainer(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  borderRadius: 12,
                  child: Row(
                    children: [
                      const Icon(Icons.monetization_on_rounded, color: AppColors.gold400, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        '${widget.coins}',
                        style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.gold400),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: widget.onClose,
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: GiftCategory.values.map((cat) {
                final selected = _selected == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(_tabs[cat]!),
                    selected: selected,
                    onSelected: (_) => setState(() {
                      _selected = cat;
                      _selectedGift = null;
                    }),
                    selectedColor: AppColors.teal500,
                    backgroundColor: AppColors.navy600,
                    labelStyle: TextStyle(
                      color: selected ? AppColors.navy900 : AppColors.textSecondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                    side: BorderSide(
                      color: selected ? AppColors.teal400 : AppColors.glassBorder,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 130,
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.85,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final gift = filtered[index];
                final isSelected = _selectedGift?.id == gift.id;
                return GestureDetector(
                  onTap: () => setState(() => _selectedGift = gift),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.teal500.withValues(alpha: 0.15) : AppColors.navy700,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? AppColors.teal400 : AppColors.glassBorder,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (gift.lottieAsset != null)
                          SizedBox(
                            height: 36,
                            child: Lottie.asset(gift.lottieAsset!, repeat: true),
                          )
                        else
                          Text(gift.emoji, style: const TextStyle(fontSize: 28)),
                        const SizedBox(height: 4),
                        Text(
                          gift.name,
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${gift.price}',
                          style: const TextStyle(fontSize: 9, color: AppColors.gold400),
                        ),
                        if (gift.isLucky)
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppColors.red500,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              'x${gift.multiplier}',
                              style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _selectedGift == null ? null : () => widget.onSend(_selectedGift!),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.teal500,
                  disabledBackgroundColor: AppColors.navy600,
                  foregroundColor: AppColors.navy900,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  _selectedGift == null ? 'Select a gift' : 'Send ${_selectedGift!.name}',
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GiftSendOverlay extends StatelessWidget {
  const GiftSendOverlay({
    super.key,
    required this.gift,
    required this.senderName,
    required this.onComplete,
  });

  final GiftItem gift;
  final String senderName;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), onComplete);

    return Material(
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (gift.svgaAsset != null)
              SizedBox(
                width: 280,
                height: 280,
                child: SvgaAnimation(
                  assetPath: gift.svgaAsset!,
                  width: 280,
                  height: 280,
                ),
              )
            else if (gift.lottieAsset != null)
              SizedBox(
                width: 200,
                height: 200,
                child: Lottie.asset(gift.lottieAsset!, repeat: false),
              )
            else
              Text(gift.emoji, style: const TextStyle(fontSize: 80)),
            const SizedBox(height: 16),
            Text(
              '$senderName sent ${gift.name}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            if (gift.isLucky)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Lucky x${gift.multiplier}! 🎉',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: AppColors.gold400,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
