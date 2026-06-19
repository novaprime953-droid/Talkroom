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
    this.description = '',
    this.rarity = 'common',
    this.animationDuration = 2000,
    this.isCombo = false,
    this.comboPrice,
    this.comboCount = 1,
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
  final String description;
  final String rarity; // common, rare, epic, legendary, mythic
  final int animationDuration;
  final bool isCombo;
  final int? comboPrice;
  final int comboCount;

  int get finalPrice => comboPrice ?? price;
  int get totalGifts => comboCount;

  bool get isSuperGift => category == GiftCategory.luxury;
  bool get isSvipGift => category == GiftCategory.svip;
}

class GiftAnimation {
  const GiftAnimation({
    required this.giftId,
    required this.senderId,
    required this.senderName,
    required this.senderVip,
    required this.receiverId,
    required this.receiverName,
    required this.giftName,
    required this.emoji,
    required this.animationAsset,
    required this.animationType,
    required this.timestamp,
    this.quantity = 1,
  });

  final String giftId;
  final String senderId;
  final String senderName;
  final int senderVip;
  final String receiverId;
  final String receiverName;
  final String giftName;
  final String emoji;
  final String animationAsset;
  final String animationType; // svga, lottie, mp4
  final DateTime timestamp;
  final int quantity;
}

class GiftSection {
  const GiftSection({required this.category, required this.gifts});

  final GiftCategory category;
  final List<GiftItem> gifts;
}
