// User Service - User Management and Profile
import { User, UserProfile, UserStats } from '@/models';

class UserService {
  private users: Map<string, User> = new Map();
  private userProfiles: Map<string, UserProfile> = new Map();
  private userStats: Map<string, UserStats> = new Map();

  /**
   * Create/Register new user
   * Equivalent to NiuChat's LoginService.registerUser()
   */
  async createUser(data: {
    email: string;
    phone?: string;
    username: string;
    password: string;
    avatar?: string;
    country?: string;
  }): Promise<User> {
    const userId = `user_${Date.now()}_${Math.random()}`;
    
    const user: User = {
      id: userId,
      email: data.email,
      phone: data.phone,
      username: data.username,
      avatar: data.avatar,
      country: data.country,
      createdAt: new Date(),
      updatedAt: new Date(),
      isActive: true,
    };

    this.users.set(userId, user);

    // Initialize profile
    this.userProfiles.set(userId, {
      userId,
      level: 1,
      experience: 0,
      totalGiftsReceived: 0,
      totalGiftsSent: 0,
      totalDiamondsSpent: 0,
      averageRoomTime: 0,
      roomsVisited: 0,
      followers: 0,
      following: 0,
      bio: '',
      badges: [],
    });

    // Initialize stats
    this.userStats.set(userId, {
      userId,
      totalRoomsJoined: 0,
      totalMessagesInRooms: 0,
      totalGiftsSent: 0,
      totalDiamondsSpent: 0,
      pkWins: 0,
      pkLosses: 0,
      winRate: 0,
      currentStreak: 0,
      averageRoomDuration: 0,
    });

    return user;
  }

  /**
   * Get user by ID
   */
  async getUserById(userId: string): Promise<User | null> {
    return this.users.get(userId) || null;
  }

  /**
   * Get user by email
   */
  async getUserByEmail(email: string): Promise<User | null> {
    return Array.from(this.users.values()).find(u => u.email === email) || null;
  }

  /**
   * Update user profile
   */
  async updateUserProfile(userId: string, updates: Partial<User>): Promise<User | null> {
    const user = this.users.get(userId);
    if (!user) return null;

    const updated = { ...user, ...updates, updatedAt: new Date() };
    this.users.set(userId, updated);
    return updated;
  }

  /**
   * Get user profile
   */
  async getUserProfile(userId: string): Promise<UserProfile | null> {
    return this.userProfiles.get(userId) || null;
  }

  /**
   * Get user stats
   */
  async getUserStats(userId: string): Promise<UserStats | null> {
    return this.userStats.get(userId) || null;
  }

  /**
   * Update user level and experience
   * Equivalent to NiuChat's LevelService.updateLevel()
   */
  async addExperience(userId: string, amount: number): Promise<void> {
    const profile = this.userProfiles.get(userId);
    if (!profile) return;

    profile.experience += amount;
    
    // Level up every 1000 exp
    const newLevel = Math.floor(profile.experience / 1000) + 1;
    if (newLevel > profile.level) {
      profile.level = newLevel;
    }
  }

  /**
   * Add badge to user
   */
  async addBadge(userId: string, badge: {
    id: string;
    name: string;
    icon: string;
    description: string;
  }): Promise<void> {
    const profile = this.userProfiles.get(userId);
    if (!profile) return;

    // Avoid duplicates
    if (!profile.badges.some(b => b.id === badge.id)) {
      profile.badges.push({
        ...badge,
        acquiredAt: new Date(),
      });
    }
  }

  /**
   * Update gift statistics
   */
  async recordGiftSent(userId: string, diamondAmount: number): Promise<void> {
    const profile = this.userProfiles.get(userId);
    const stats = this.userStats.get(userId);
    
    if (profile) {
      profile.totalGiftsSent++;
      profile.totalDiamondsSpent += diamondAmount;
    }

    if (stats) {
      stats.totalGiftsSent++;
      stats.totalDiamondsSpent += diamondAmount;
    }
  }

  /**
   * Update gift received
   */
  async recordGiftReceived(userId: string): Promise<void> {
    const profile = this.userProfiles.get(userId);
    if (profile) {
      profile.totalGiftsReceived++;
    }
  }

  /**
   * Record room visit
   */
  async recordRoomVisit(userId: string, durationMinutes: number): Promise<void> {
    const profile = this.userProfiles.get(userId);
    const stats = this.userStats.get(userId);

    if (profile) {
      profile.roomsVisited++;
      profile.averageRoomTime = (profile.averageRoomTime + durationMinutes) / 2;
    }

    if (stats) {
      stats.totalRoomsJoined++;
      stats.averageRoomDuration = (stats.averageRoomDuration + durationMinutes) / 2;
    }
  }

  /**
   * Follow user
   */
  async followUser(userId: string, targetUserId: string): Promise<void> {
    const userProfile = this.userProfiles.get(userId);
    const targetProfile = this.userProfiles.get(targetUserId);

    if (userProfile) userProfile.following++;
    if (targetProfile) targetProfile.followers++;
  }

  /**
   * Unfollow user
   */
  async unfollowUser(userId: string, targetUserId: string): Promise<void> {
    const userProfile = this.userProfiles.get(userId);
    const targetProfile = this.userProfiles.get(targetUserId);

    if (userProfile) userProfile.following = Math.max(0, userProfile.following - 1);
    if (targetProfile) targetProfile.followers = Math.max(0, targetProfile.followers - 1);
  }

  /**
   * Search users
   */
  async searchUsers(query: string, limit: number = 20): Promise<User[]> {
    const results = Array.from(this.users.values()).filter(user =>
      user.username.toLowerCase().includes(query.toLowerCase()) ||
      user.email.toLowerCase().includes(query.toLowerCase())
    );
    return results.slice(0, limit);
  }

  /**
   * Get top users by level
   */
  async getTopUsersByLevel(limit: number = 100): Promise<Array<User & { level: number }>> {
    const usersWithLevel = Array.from(this.users.values()).map(user => ({
      ...user,
      level: this.userProfiles.get(user.id)?.level || 1,
    }));
    
    return usersWithLevel
      .sort((a, b) => b.level - a.level)
      .slice(0, limit);
  }
}

export default new UserService();
