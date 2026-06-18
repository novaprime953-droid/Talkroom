export type GiftCategory = "popular" | "luxury" | "lucky" | "svip";

export interface User {
  id: string;
  name: string;
  avatarUrl: string;
  vipTier: number;
  coins: number;
  level: number;
  isOnline: boolean;
  bio?: string;
  followers?: number;
  following?: number;
}

export interface VoiceRoom {
  id: string;
  title: string;
  hostName: string;
  hostAvatar: string;
  listeners: number;
  category: string;
  tags: string[];
  isLive: boolean;
  coverGradient: [number, number];
  micCount: number;
  isPk: boolean;
}

export interface GiftItem {
  id: string;
  name: string;
  emoji: string;
  price: number;
  category: GiftCategory;
  isLucky?: boolean;
  multiplier?: number;
  svgaAsset?: string;
  lottieAsset?: string;
}

export interface ChatMessage {
  id: string;
  userName: string;
  content: string;
  type: "text" | "gift" | "entry" | "system";
  timestamp: string;
  vipTier?: number;
  giftEmoji?: string;
}

export interface Conversation {
  name: string;
  message: string;
  time: string;
  unread: number;
}

export interface PkBattle {
  id: string;
  roomId: string;
  leftName: string;
  rightName: string;
  leftScore: number;
  rightScore: number;
  status: "live" | "scheduled" | "ended";
  startsAt: string;
}

export const currentUser: User = {
  id: "u1",
  name: "Nova Star",
  avatarUrl: "https://i.pravatar.cc/150?img=32",
  vipTier: 5,
  coins: 128500,
  level: 42,
  isOnline: true,
  bio: "Voice room host · Music lover · Night owl",
  followers: 8420,
  following: 312,
};

export const rooms: VoiceRoom[] = [
  {
    id: "r1",
    title: "Midnight Jazz Lounge",
    hostName: "Luna Beats",
    hostAvatar: "https://i.pravatar.cc/150?img=5",
    listeners: 2847,
    category: "Music",
    tags: ["Chill", "VIP Only"],
    isLive: true,
    coverGradient: [0x0f766e, 0x134e4a],
    micCount: 8,
    isPk: false,
  },
  {
    id: "r2",
    title: "PK Battle Arena",
    hostName: "Thunder King",
    hostAvatar: "https://i.pravatar.cc/150?img=12",
    listeners: 5621,
    category: "PK",
    tags: ["Live PK", "Hot"],
    isLive: true,
    coverGradient: [0x7c3aed, 0xbe185d],
    micCount: 8,
    isPk: true,
  },
  {
    id: "r3",
    title: "Arabic Poetry Circle",
    hostName: "Amira",
    hostAvatar: "https://i.pravatar.cc/150?img=9",
    listeners: 1204,
    category: "Culture",
    tags: ["Poetry", "Open Mic"],
    isLive: true,
    coverGradient: [0x1d4ed8, 0x312e81],
    micCount: 8,
    isPk: false,
  },
  {
    id: "r4",
    title: "Lucky Gift Party",
    hostName: "Gold Rush",
    hostAvatar: "https://i.pravatar.cc/150?img=15",
    listeners: 3890,
    category: "Party",
    tags: ["Lucky Gifts", "Jackpot"],
    isLive: true,
    coverGradient: [0xb45309, 0x92400e],
    micCount: 8,
    isPk: false,
  },
  {
    id: "r5",
    title: "Talk Room Official",
    hostName: "Talk Room Team",
    hostAvatar: "https://i.pravatar.cc/150?img=60",
    listeners: 9102,
    category: "Official",
    tags: ["Featured", "New"],
    isLive: true,
    coverGradient: [0x0e7490, 0x164e63],
    micCount: 8,
    isPk: false,
  },
];

export const gifts: GiftItem[] = [
  { id: "g1", name: "Rose", emoji: "🌹", price: 10, category: "popular", lottieAsset: "assets/lottie/gift/marquee/data.json" },
  { id: "g2", name: "Diamond", emoji: "💎", price: 500, category: "luxury", lottieAsset: "assets/lottie/gift/diamond/data.json" },
  { id: "g3", name: "Crown", emoji: "👑", price: 1000, category: "luxury" },
  { id: "g4", name: "Rocket", emoji: "🚀", price: 2000, category: "luxury" },
  { id: "g5", name: "Lucky Star", emoji: "⭐", price: 50, category: "lucky", isLucky: true, multiplier: 10, svgaAsset: "assets/svga/yogo_lucky_gift_10.svga" },
  { id: "g6", name: "Lucky Gold", emoji: "🪙", price: 100, category: "lucky", isLucky: true, multiplier: 50, svgaAsset: "assets/svga/yogo_lucky_gift_50.svga" },
  { id: "g7", name: "Lucky Jackpot", emoji: "🎰", price: 500, category: "lucky", isLucky: true, multiplier: 100, svgaAsset: "assets/svga/yogo_lucky_gift_100.svga" },
  { id: "g8", name: "Super Gift I", emoji: "🔥", price: 5000, category: "svip", svgaAsset: "assets/svga/yogo_super_gift_1.svga" },
  { id: "g9", name: "Super Gift II", emoji: "⚡", price: 10000, category: "svip", svgaAsset: "assets/svga/yogo_super_gift_2.svga" },
  { id: "g10", name: "Super Gift III", emoji: "🌟", price: 20000, category: "svip", svgaAsset: "assets/svga/yogo_super_gift_3.svga" },
];

export const micUsers: User[] = [
  { id: "m1", name: "Luna Beats", avatarUrl: "https://i.pravatar.cc/150?img=5", vipTier: 6, coins: 500000, level: 88, isOnline: true },
  { id: "m2", name: "Echo", avatarUrl: "https://i.pravatar.cc/150?img=11", vipTier: 3, coins: 12000, level: 35, isOnline: true },
  { id: "m3", name: "Shadow", avatarUrl: "https://i.pravatar.cc/150?img=33", vipTier: 5, coins: 89000, level: 52, isOnline: true },
  { id: "m4", name: "Crystal", avatarUrl: "https://i.pravatar.cc/150?img=25", vipTier: 2, coins: 4500, level: 21, isOnline: true },
];

export const roomMessages: ChatMessage[] = [
  { id: "c1", userName: "System", content: "Welcome to Talk Room! Be respectful.", type: "system", timestamp: new Date(Date.now() - 600000).toISOString() },
  { id: "c2", userName: "Echo", content: "Great vibes tonight! 🎵", type: "text", timestamp: new Date(Date.now() - 480000).toISOString(), vipTier: 3 },
  { id: "c3", userName: "Shadow", content: "sent Crown to Luna Beats", type: "gift", timestamp: new Date(Date.now() - 300000).toISOString(), vipTier: 5, giftEmoji: "👑" },
  { id: "c4", userName: "Nova Star", content: "joined the room with SVIP entrance", type: "entry", timestamp: new Date(Date.now() - 120000).toISOString(), vipTier: 5 },
];

export const conversations: Conversation[] = [
  { name: "Luna Beats", message: "Thanks for the gift! 🎁", time: "2m", unread: 2 },
  { name: "PK Team", message: "Your battle starts in 5 min", time: "15m", unread: 1 },
  { name: "Talk Room Support", message: "Welcome to Talk Room!", time: "1h", unread: 0 },
  { name: "Gold Rush", message: "Lucky gift jackpot tonight!", time: "3h", unread: 0 },
];

export const exploreCategories = [
  "Trending", "Music", "PK Battle", "Party", "Gaming", "Dating", "Culture", "New Hosts",
];

export const pkBattles: PkBattle[] = [
  {
    id: "pk1",
    roomId: "r2",
    leftName: "Thunder King",
    rightName: "Shadow",
    leftScore: 12400,
    rightScore: 9800,
    status: "live",
    startsAt: new Date().toISOString(),
  },
  {
    id: "pk2",
    roomId: "r5",
    leftName: "Nova Star",
    rightName: "Crystal",
    leftScore: 0,
    rightScore: 0,
    status: "scheduled",
    startsAt: new Date(Date.now() + 3600000).toISOString(),
  },
];

export const vipTiers = [
  { tier: 1, name: "Bronze", entryAsset: "assets/svga/yogo_svip_enter_1.svga", frameColor: "#94a3b8" },
  { tier: 2, name: "Silver", entryAsset: "assets/svga/yogo_svip_enter_2.svga", frameColor: "#cbd5e1" },
  { tier: 3, name: "Gold", entryAsset: "assets/svga/yogo_svip_enter_3.svga", frameColor: "#fbbf24" },
  { tier: 4, name: "Platinum", entryAsset: "assets/svga/yogo_svip_enter_4.svga", frameColor: "#38bdf8" },
  { tier: 5, name: "Diamond", entryAsset: "assets/svga/yogo_svip_enter_5.svga", frameColor: "#a78bfa" },
  { tier: 6, name: "SVIP", entryAsset: "assets/svga/yogo_svip_enter_6.svga", frameColor: "#f472b6" },
];

export const webPanels = [
  { id: "wallet", name: "Wallet & Recharge", path: "/panels/wallet", description: "Coins, recharge packs, VIP purchase" },
  { id: "events", name: "Events Center", path: "/panels/events", description: "Campaigns, lucky draws, seasonal events" },
  { id: "agency", name: "Agency Center", path: "/panels/agency", description: "Host agency dashboard and payouts" },
  { id: "task", name: "Task Center", path: "/panels/tasks", description: "Daily tasks and reward claims" },
  { id: "rank", name: "Leaderboards", path: "/panels/rank", description: "Room, gift, and PK rankings" },
  { id: "help", name: "Help & Support", path: "/panels/help", description: "FAQ, tickets, live support" },
];

export function getAppConfig(baseUrl: string) {
  return {
    apiBaseUrl: baseUrl,
    appName: "Talk Room",
    version: "1.0.0",
    features: {
      voiceRooms: true,
      gifts: true,
      vip: true,
      svipEntry: true,
      pkBattle: true,
      luckyGifts: true,
      webPanels: true,
    },
    endpoints: {
      rooms: `${baseUrl}/api/rooms`,
      gifts: `${baseUrl}/api/gifts`,
      users: `${baseUrl}/api/users`,
      messages: `${baseUrl}/api/messages`,
      config: `${baseUrl}/api/config`,
      pk: `${baseUrl}/api/pk`,
    },
    webPanels: webPanels.map((p) => ({
      ...p,
      url: `${baseUrl}${p.path}`,
    })),
    svipEntryAssets: vipTiers.map((t) => t.entryAsset),
  };
}
