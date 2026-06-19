class VipTier {
  const VipTier({
    required this.tier,
    required this.name,
    required this.color,
    required this.badge,
    required this.benefits,
    required this.monthlyPrice,
    required this.avatarFrames,
    this.description = '',
  });

  final int tier;
  final String name;
  final String color; // hex color
  final String badge; // emoji or asset path
  final List<String> benefits;
  final int monthlyPrice;
  final List<String> avatarFrames;
  final String description;
}

class SvipBenefit {
  const SvipBenefit({
    required this.level,
    required this.name,
    required this.icon,
    required this.entryAnimation,
    required this.badgeUrl,
    required this.roomBackground,
    required this.benefits,
  });

  final int level;
  final String name;
  final String icon;
  final String entryAnimation;
  final String badgeUrl;
  final String roomBackground;
  final List<String> benefits;
}

class AvatarFrame {
  const AvatarFrame({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rarity,
    required this.requirement,
  });

  final String id;
  final String name;
  final String imageUrl;
  final String rarity; // common, rare, epic, legendary
  final String requirement; // VIP level requirement
}
