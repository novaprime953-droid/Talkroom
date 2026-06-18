enum GiftCategory { popular, luxury, lucky, svip }

class GiftItem {
  const GiftItem({
    required this.id,
    required this.name,
    required this.emoji,
    required this.price,
    required this.category,
    this.isLucky = false,
    this.multiplier,
    this.svgaAsset,
    this.lottieAsset,
  });

  final String id;
  final String name;
  final String emoji;
  final int price;
  final GiftCategory category;
  final bool isLucky;
  final int? multiplier;
  final String? svgaAsset;
  final String? lottieAsset;
}
