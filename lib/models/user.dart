class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.vipTier,
    required this.coins,
    required this.level,
    required this.isOnline,
    this.bio = '',
    this.followers = 0,
    this.following = 0,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final int vipTier;
  final int coins;
  final int level;
  final bool isOnline;
  final String bio;
  final int followers;
  final int following;

  String get vipLabel {
    if (vipTier >= 5) return 'SVIP $vipTier';
    if (vipTier > 0) return 'VIP $vipTier';
    return 'Member';
  }

  bool get isSvip => vipTier >= 5;
}
