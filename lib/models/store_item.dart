enum StoreCategory { coins, vip, vipPass, avatar, frame }

class StoreItem {
  const StoreItem({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.imageUrl,
    this.isBestSeller = false,
    this.isLimited = false,
    this.durationDays,
    this.coinAmount,
    this.vipPoints,
    this.discountPercent = 0,
    this.originalPrice,
  });

  final String id;
  final String name;
  final String description;
  final StoreCategory category;
  final int price;
  final String imageUrl;
  final bool isBestSeller;
  final bool isLimited;
  final int? durationDays;
  final int? coinAmount;
  final int? vipPoints;
  final int discountPercent;
  final int? originalPrice;

  int get finalPrice => originalPrice ?? price;
  bool get hasDiscount => discountPercent > 0;
}

class StoreSection {
  const StoreSection({
    required this.id,
    required this.title,
    required this.items,
  });

  final String id;
  final String title;
  final List<StoreItem> items;
}

class CoinPackage {
  const CoinPackage({
    required this.id,
    required this.coinAmount,
    required this.price,
    required this.bonusCoins,
    this.isMostPopular = false,
  });

  final String id;
  final int coinAmount;
  final int price;
  final int bonusCoins;
  final bool isMostPopular;

  int get totalCoins => coinAmount + bonusCoins;
}
