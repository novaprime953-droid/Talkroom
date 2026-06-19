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
    this.roomsHosted = 0,
    this.giftsReceived = 0,
    this.pkWins = 0,
    this.avatarFrameId = '',
    this.backgroundColor = '',
    this.isMuted = false,
    this.isMicOn = false,
    this.taskCompleted = 0,
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
  final int roomsHosted;
  final int giftsReceived;
  final int pkWins;
  final String avatarFrameId;
  final String backgroundColor;
  final bool isMuted;
  final bool isMicOn;
  final int taskCompleted;

  String get vipLabel {
    if (vipTier >= 5) return 'SVIP ${vipTier - 4}';
    if (vipTier > 0) return 'VIP $vipTier';
    return 'Member';
  }

  bool get isSvip => vipTier >= 5;

  AppUser copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    int? vipTier,
    int? coins,
    int? level,
    bool? isOnline,
    String? bio,
    int? followers,
    int? following,
    int? roomsHosted,
    int? giftsReceived,
    int? pkWins,
    String? avatarFrameId,
    String? backgroundColor,
    bool? isMuted,
    bool? isMicOn,
    int? taskCompleted,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      vipTier: vipTier ?? this.vipTier,
      coins: coins ?? this.coins,
      level: level ?? this.level,
      isOnline: isOnline ?? this.isOnline,
      bio: bio ?? this.bio,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      roomsHosted: roomsHosted ?? this.roomsHosted,
      giftsReceived: giftsReceived ?? this.giftsReceived,
      pkWins: pkWins ?? this.pkWins,
      avatarFrameId: avatarFrameId ?? this.avatarFrameId,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      isMuted: isMuted ?? this.isMuted,
      isMicOn: isMicOn ?? this.isMicOn,
      taskCompleted: taskCompleted ?? this.taskCompleted,
    );
  }
}
