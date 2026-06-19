// Data Models - TypeScript Interfaces
// Based on NiuChat decompiled models

// ============ USER & AUTH ============

export interface User {
  id: string;
  username: string;
  email: string;
  phone?: string;
  avatar?: string;
  bio?: string;
  country?: string;
  gender?: 'M' | 'F' | 'Other';
  createdAt: Date;
  updatedAt: Date;
  isActive: boolean;
  lastSeen?: Date;
}

export interface AuthRequest {
  email?: string;
  phone?: string;
  password: string;
  otp?: string;
}

export interface AuthResponse {
  token: string;
  user: User;
  expiresIn: number;
}

export interface UserProfile {
  userId: string;
  level: number;
  experience: number;
  totalGiftsReceived: number;
  totalGiftsSent: number;
  totalDiamondsSpent: number;
  averageRoomTime: number; // minutes
  roomsVisited: number;
  followers: number;
  following: number;
  bio: string;
  badges: Badge[];
}

export interface Badge {
  id: string;
  name: string;
  icon: string;
  description: string;
  acquiredAt: Date;
}

export interface UserStats {
  userId: string;
  totalRoomsJoined: number;
  totalMessagesInRooms: number;
  totalGiftsSent: number;
  totalDiamondsSpent: number;
  pkWins: number;
  pkLosses: number;
  winRate: number;
  currentStreak: number;
  averageRoomDuration: number;
}

// ============ ROOMS ============

export interface Room {
  id: string;
  name: string;
  description?: string;
  ownerId: string;
  category: string; // 'Dating', 'Gaming', 'Music', 'Business', etc.
  thumbnail?: string;
  members: RoomMember[];
  currentMemberCount: number;
  maxMembers: number;
  isPrivate: boolean;
  isPK: boolean;
  createdAt: Date;
  updatedAt: Date;
  status: 'active' | 'inactive' | 'closed';
  language?: string;
  vipOnly?: boolean;
  minLevel?: number;
}

export interface RoomMember {
  userId: string;
  username: string;
  avatar?: string;
  role: 'owner' | 'moderator' | 'member';
  joinedAt: Date;
  microphoneOn: boolean;
  speakerOn: boolean;
  muted: boolean;
  level: number;
}

export interface RoomSettings {
  roomId: string;
  autoClose: boolean;
  allowMessages: boolean;
  allowGifts: boolean;
  allowPK: boolean;
  moderationLevel: 'strict' | 'medium' | 'relaxed';
  language: string;
  password?: string;
}

// ============ MESSAGES ============

export interface Message {
  id: string;
  roomId: string;
  userId: string;
  username: string;
  avatar?: string;
  content: string;
  type: 'text' | 'system' | 'gift' | 'pk_update';
  metadata?: Record<string, any>;
  createdAt: Date;
  isDeleted: boolean;
}

export interface MessageThread {
  roomId: string;
  messages: Message[];
  totalCount: number;
}

// ============ GIFTS ============

export interface Gift {
  id: string;
  name: string;
  description: string;
  icon: string;
  animation: string;
  diamondCost: number;
  category: 'lucky' | 'super' | 'normal' | 'special';
  rarity: 'common' | 'rare' | 'epic' | 'legendary';
  comboable: boolean;
}

export interface GiftTransaction {
  id: string;
  senderId: string;
  senderUsername: string;
  receiverId: string;
  receiverUsername: string;
  roomId?: string;
  giftId: string;
  giftName: string;
  quantity: number;
  totalDiamonds: number;
  createdAt: Date;
}

// ============ PK BATTLES ============

export interface PKBattle {
  id: string;
  roomId: string;
  initiatorId: string;
  initiatorUsername: string;
  challengerId: string;
  challengerUsername: string;
  status: 'pending' | 'ongoing' | 'completed';
  startTime: Date;
  endTime?: Date;
  initiatorScore: number;
  challengerScore: number;
  winner?: string;
  rewards?: PKReward;
}

export interface PKReward {
  winnerId: string;
  diamonds: number;
  experience: number;
  badge?: string;
}

export interface BattleStats {
  userId: string;
  totalPKs: number;
  totalWins: number;
  totalLosses: number;
  winRate: number;
  currentWinStreak: number;
  maxWinStreak: number;
  totalDiamondsWon: number;
}

// ============ WALLET & PAYMENTS ============

export interface Wallet {
  userId: string;
  diamonds: number;
  coins: number;
  totalDiamondsEarned: number;
  totalDiamondsSpent: number;
  updatedAt: Date;
}

export interface Transaction {
  id: string;
  userId: string;
  type: 'recharge' | 'gift' | 'reward' | 'refund' | 'withdrawal';
  amount: number;
  currency: string; // 'diamonds', 'coins', 'usd'
  status: 'pending' | 'completed' | 'failed' | 'cancelled';
  paymentMethod?: string; // 'card', 'paypal', 'google_play', 'apple_pay'
  reference?: string; // external transaction ID
  description?: string;
  createdAt: Date;
  completedAt?: Date;
}

// ============ VIP & SVIP ============

export interface VIPTier {
  id: string;
  level: number; // 1-7
  name: string;
  monthlyDiamonds: number;
  monthlyCoins: number;
  bonusPercentage: number;
  icon: string;
  color: string;
  benefits: string[];
  monthlyPrice: number;
  annualPrice?: number;
}

export interface SVIPTier {
  id: string;
  level: number; // 1-6
  name: string;
  monthlyDiamonds: number;
  monthlyCoins: number;
  bonusPercentage: number;
  icon: string;
  color: string;
  badge: string;
  benefits: string[];
  monthlyPrice: number;
  annualPrice?: number;
  exclusiveRooms: boolean;
  prioritySupport: boolean;
}

export interface Subscription {
  id: string;
  userId: string;
  tierType: 'vip' | 'svip';
  tierId: string;
  tierLevel: number;
  startDate: Date;
  endDate: Date;
  autoRenew: boolean;
  status: 'active' | 'expired' | 'cancelled';
}

// ============ LEADERBOARD & RANKING ============

export interface Ranking {
  rank: number;
  userId: string;
  username: string;
  avatar?: string;
  score: number;
  giftsSent: number;
  roomsVisited: number;
  level: number;
  badge?: string;
}

export interface RankStats {
  userId: string;
  dailyRank: number;
  weeklyRank: number;
  monthlyRank: number;
  allTimeRank: number;
  currentScore: number;
  dailyScore: number;
  weeklyScore: number;
  monthlyScore: number;
}

// ============ DAILY TASKS ============

export interface DailyTask {
  id: string;
  title: string;
  description: string;
  type: 'login' | 'gift' | 'room' | 'pk' | 'message';
  requirement: number; // e.g., "send 5 gifts"
  reward: TaskReward;
  difficulty: 'easy' | 'medium' | 'hard';
  icon: string;
}

export interface TaskReward {
  diamonds?: number;
  coins?: number;
  experience?: number;
  badge?: string;
}

export interface UserTaskProgress {
  userId: string;
  taskId: string;
  progress: number;
  completed: boolean;
  completedAt?: Date;
}

// ============ ADMIN ============

export interface Report {
  id: string;
  reporterId: string;
  reportedUserId?: string;
  reportedRoomId?: string;
  reportType: 'harassment' | 'inappropriate' | 'spam' | 'other';
  description: string;
  evidence?: string[];
  status: 'open' | 'investigating' | 'resolved' | 'dismissed';
  createdAt: Date;
  resolvedAt?: Date;
  resolution?: string;
}

export interface AdminConfig {
  maintenanceMode: boolean;
  maintenanceMessage?: string;
  maxRoomsPerUser: number;
  maxMembersPerRoom: number;
  initialDiamonds: number;
  initialCoins: number;
  minLevelForGifts: number;
  minLevelForPK: number;
}
