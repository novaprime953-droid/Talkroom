import '../models/chat_message.dart';
import '../models/gift.dart';
import '../models/room.dart';
import '../models/user.dart';

class MockData {
  static const currentUser = AppUser(
    id: 'u1',
    name: 'Nova Star',
    avatarUrl: 'https://i.pravatar.cc/150?img=32',
    vipTier: 5,
    coins: 128500,
    level: 42,
    isOnline: true,
    bio: 'Voice room host · Music lover · Night owl',
    followers: 8420,
    following: 312,
  );

  static const rooms = <VoiceRoom>[
    VoiceRoom(
      id: 'r1',
      title: 'Midnight Jazz Lounge',
      hostName: 'Luna Beats',
      hostAvatar: 'https://i.pravatar.cc/150?img=5',
      listeners: 2847,
      category: 'Music',
      tags: ['Chill', 'VIP Only'],
      isLive: true,
      coverGradient: [0xFF0F766E, 0xFF134E4A],
      isPk: false,
    ),
    VoiceRoom(
      id: 'r2',
      title: 'PK Battle Arena',
      hostName: 'Thunder King',
      hostAvatar: 'https://i.pravatar.cc/150?img=12',
      listeners: 5621,
      category: 'PK',
      tags: ['Live PK', 'Hot'],
      isLive: true,
      coverGradient: [0xFF7C3AED, 0xFFBE185D],
      isPk: true,
    ),
    VoiceRoom(
      id: 'r3',
      title: 'Arabic Poetry Circle',
      hostName: 'Amira',
      hostAvatar: 'https://i.pravatar.cc/150?img=9',
      listeners: 1204,
      category: 'Culture',
      tags: ['Poetry', 'Open Mic'],
      isLive: true,
      coverGradient: [0xFF1D4ED8, 0xFF312E81],
    ),
    VoiceRoom(
      id: 'r4',
      title: 'Lucky Gift Party',
      hostName: 'Gold Rush',
      hostAvatar: 'https://i.pravatar.cc/150?img=15',
      listeners: 3890,
      category: 'Party',
      tags: ['Lucky Gifts', 'Jackpot'],
      isLive: true,
      coverGradient: [0xFFB45309, 0xFF92400E],
    ),
    VoiceRoom(
      id: 'r5',
      title: 'Talk Room Official',
      hostName: 'Talk Room Team',
      hostAvatar: 'https://i.pravatar.cc/150?img=60',
      listeners: 9102,
      category: 'Official',
      tags: ['Featured', 'New'],
      isLive: true,
      coverGradient: [0xFF0E7490, 0xFF164E63],
    ),
  ];

  static const exploreCategories = [
    'Trending',
    'Music',
    'PK Battle',
    'Party',
    'Gaming',
    'Dating',
    'Culture',
    'New Hosts',
  ];

  static const gifts = <GiftItem>[
    GiftItem(
      id: 'g1',
      name: 'Rose',
      emoji: '🌹',
      price: 10,
      category: GiftCategory.popular,
      lottieAsset: 'assets/lottie/gift/marquee/data.json',
    ),
    GiftItem(
      id: 'g2',
      name: 'Diamond',
      emoji: '💎',
      price: 500,
      category: GiftCategory.luxury,
      lottieAsset: 'assets/lottie/gift/diamond/data.json',
    ),
    GiftItem(
      id: 'g3',
      name: 'Crown',
      emoji: '👑',
      price: 1000,
      category: GiftCategory.luxury,
    ),
    GiftItem(
      id: 'g4',
      name: 'Rocket',
      emoji: '🚀',
      price: 2000,
      category: GiftCategory.luxury,
    ),
    GiftItem(
      id: 'g5',
      name: 'Lucky Star',
      emoji: '⭐',
      price: 50,
      category: GiftCategory.lucky,
      isLucky: true,
      multiplier: 10,
      svgaAsset: 'assets/svga/yogo_lucky_gift_10.svga',
    ),
    GiftItem(
      id: 'g6',
      name: 'Lucky Gold',
      emoji: '🪙',
      price: 100,
      category: GiftCategory.lucky,
      isLucky: true,
      multiplier: 50,
      svgaAsset: 'assets/svga/yogo_lucky_gift_50.svga',
    ),
    GiftItem(
      id: 'g7',
      name: 'Lucky Jackpot',
      emoji: '🎰',
      price: 500,
      category: GiftCategory.lucky,
      isLucky: true,
      multiplier: 100,
      svgaAsset: 'assets/svga/yogo_lucky_gift_100.svga',
    ),
    GiftItem(
      id: 'g8',
      name: 'Super Gift I',
      emoji: '🔥',
      price: 5000,
      category: GiftCategory.svip,
      svgaAsset: 'assets/svga/yogo_super_gift_1.svga',
    ),
    GiftItem(
      id: 'g9',
      name: 'Super Gift II',
      emoji: '⚡',
      price: 10000,
      category: GiftCategory.svip,
      svgaAsset: 'assets/svga/yogo_super_gift_2.svga',
    ),
    GiftItem(
      id: 'g10',
      name: 'Super Gift III',
      emoji: '🌟',
      price: 20000,
      category: GiftCategory.svip,
      svgaAsset: 'assets/svga/yogo_super_gift_3.svga',
    ),
  ];

  static const micUsers = [
    AppUser(
      id: 'm1',
      name: 'Luna Beats',
      avatarUrl: 'https://i.pravatar.cc/150?img=5',
      vipTier: 6,
      coins: 500000,
      level: 88,
      isOnline: true,
    ),
    AppUser(
      id: 'm2',
      name: 'Echo',
      avatarUrl: 'https://i.pravatar.cc/150?img=11',
      vipTier: 3,
      coins: 12000,
      level: 35,
      isOnline: true,
    ),
    AppUser(
      id: 'm3',
      name: 'Shadow',
      avatarUrl: 'https://i.pravatar.cc/150?img=33',
      vipTier: 5,
      coins: 89000,
      level: 52,
      isOnline: true,
    ),
    AppUser(
      id: 'm4',
      name: 'Crystal',
      avatarUrl: 'https://i.pravatar.cc/150?img=25',
      vipTier: 2,
      coins: 4500,
      level: 21,
      isOnline: true,
    ),
  ];

  static List<ChatMessage> roomMessages = [
    ChatMessage(
      id: 'c1',
      userName: 'System',
      content: 'Welcome to Talk Room! Be respectful.',
      type: ChatMessageType.system,
      timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
    ChatMessage(
      id: 'c2',
      userName: 'Echo',
      content: 'Great vibes tonight! 🎵',
      type: ChatMessageType.text,
      timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      vipTier: 3,
    ),
    ChatMessage(
      id: 'c3',
      userName: 'Shadow',
      content: 'sent Crown to Luna Beats',
      type: ChatMessageType.gift,
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      vipTier: 5,
      giftEmoji: '👑',
    ),
    ChatMessage(
      id: 'c4',
      userName: 'Nova Star',
      content: 'joined the room with SVIP entrance',
      type: ChatMessageType.entry,
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      vipTier: 5,
    ),
  ];

  static const conversations = [
    (name: 'Luna Beats', message: 'Thanks for the gift! 🎁', time: '2m', unread: 2),
    (name: 'PK Team', message: 'Your battle starts in 5 min', time: '15m', unread: 1),
    (name: 'Talk Room Support', message: 'Welcome to Talk Room!', time: '1h', unread: 0),
    (name: 'Gold Rush', message: 'Lucky gift jackpot tonight!', time: '3h', unread: 0),
  ];

  static String svipEntryAsset(int tier) {
    final clamped = tier.clamp(1, 6);
    return 'assets/svga/yogo_svip_enter_$clamped.svga';
  }
}
