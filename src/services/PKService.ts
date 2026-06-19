// PK Battle Service
import { PKBattle, BattleStats } from '@/models';

class PKService {
  private battles: Map<string, PKBattle> = new Map();
  private battleStats: Map<string, BattleStats> = new Map();

  /**
   * Initiate PK battle
   * Equivalent to NiuChat's PKService.initiateBattle()
   */
  async initiateBattle(
    roomId: string,
    initiatorId: string,
    initiatorUsername: string,
    challengerId: string,
    challengerUsername: string
  ): Promise<PKBattle> {
    const battleId = `pk_${Date.now()}_${Math.random()}`;

    const battle: PKBattle = {
      id: battleId,
      roomId,
      initiatorId,
      initiatorUsername,
      challengerId,
      challengerUsername,
      status: 'pending',
      startTime: new Date(),
      initiatorScore: 0,
      challengerScore: 0,
    };

    this.battles.set(battleId, battle);

    // Initialize stats if not exists
    if (!this.battleStats.has(initiatorId)) {
      this.battleStats.set(initiatorId, {
        userId: initiatorId,
        totalPKs: 0,
        totalWins: 0,
        totalLosses: 0,
        winRate: 0,
        currentWinStreak: 0,
        maxWinStreak: 0,
        totalDiamondsWon: 0,
      });
    }

    if (!this.battleStats.has(challengerId)) {
      this.battleStats.set(challengerId, {
        userId: challengerId,
        totalPKs: 0,
        totalWins: 0,
        totalLosses: 0,
        winRate: 0,
        currentWinStreak: 0,
        maxWinStreak: 0,
        totalDiamondsWon: 0,
      });
    }

    return battle;
  }

  /**
   * Accept battle
   */
  async acceptBattle(battleId: string): Promise<PKBattle | null> {
    const battle = this.battles.get(battleId);
    if (!battle) return null;

    battle.status = 'ongoing';
    battle.startTime = new Date();

    return battle;
  }

  /**
   * Reject/Cancel battle
   */
  async rejectBattle(battleId: string): Promise<boolean> {
    const battle = this.battles.get(battleId);
    if (!battle) return false;

    this.battles.delete(battleId);
    return true;
  }

  /**
   * Update battle score
   * Called when gifts are sent during PK
   */
  async updateScore(
    battleId: string,
    playerId: string,
    scoreIncrease: number
  ): Promise<PKBattle | null> {
    const battle = this.battles.get(battleId);
    if (!battle || battle.status !== 'ongoing') return null;

    if (battle.initiatorId === playerId) {
      battle.initiatorScore += scoreIncrease;
    } else if (battle.challengerId === playerId) {
      battle.challengerScore += scoreIncrease;
    }

    return battle;
  }

  /**
   * End battle and determine winner
   * Equivalent to NiuChat's PKService.endBattle()
   */
  async endBattle(battleId: string): Promise<PKBattle | null> {
    const battle = this.battles.get(battleId);
    if (!battle) return null;

    battle.status = 'completed';
    battle.endTime = new Date();

    let winnerId: string;
    let loserScore: number;
    let winnerScore: number;

    if (battle.initiatorScore > battle.challengerScore) {
      winnerId = battle.initiatorId;
      winnerScore = battle.initiatorScore;
      loserScore = battle.challengerScore;
    } else if (battle.challengerScore > battle.initiatorScore) {
      winnerId = battle.challengerId;
      winnerScore = battle.challengerScore;
      loserScore = battle.initiatorScore;
    } else {
      // Draw
      battle.winner = 'draw';
      return battle;
    }

    battle.winner = winnerId;

    // Update stats
    const initiatorStats = this.battleStats.get(battle.initiatorId)!;
    const challengerStats = this.battleStats.get(battle.challengerId)!;

    initiatorStats.totalPKs++;
    challengerStats.totalPKs++;

    if (winnerId === battle.initiatorId) {
      initiatorStats.totalWins++;
      initiatorStats.currentWinStreak++;
      initiatorStats.maxWinStreak = Math.max(
        initiatorStats.maxWinStreak,
        initiatorStats.currentWinStreak
      );

      challengerStats.totalLosses++;
      challengerStats.currentWinStreak = 0;
    } else {
      challengerStats.totalWins++;
      challengerStats.currentWinStreak++;
      challengerStats.maxWinStreak = Math.max(
        challengerStats.maxWinStreak,
        challengerStats.currentWinStreak
      );

      initiatorStats.totalLosses++;
      initiatorStats.currentWinStreak = 0;
    }

    // Update win rates
    initiatorStats.winRate = (initiatorStats.totalWins / initiatorStats.totalPKs) * 100;
    challengerStats.winRate = (challengerStats.totalWins / challengerStats.totalPKs) * 100;

    // Award diamonds (example: score difference in diamonds)
    const diamondReward = Math.floor((winnerScore - loserScore) / 100);
    battle.rewards = {
      winnerId,
      diamonds: diamondReward,
      experience: 100,
    };

    return battle;
  }

  /**
   * Get battle by ID
   */
  async getBattle(battleId: string): Promise<PKBattle | null> {
    return this.battles.get(battleId) || null;
  }

  /**
   * Get user battle stats
   */
  async getBattleStats(userId: string): Promise<BattleStats | null> {
    return this.battleStats.get(userId) || null;
  }

  /**
   * Get active battles in room
   */
  async getActiveBattlesInRoom(roomId: string): Promise<PKBattle[]> {
    return Array.from(this.battles.values()).filter(
      b => b.roomId === roomId && b.status === 'ongoing'
    );
  }

  /**
   * Get pending battles for user
   */
  async getPendingBattles(userId: string): Promise<PKBattle[]> {
    return Array.from(this.battles.values()).filter(
      b => (b.initiatorId === userId || b.challengerId === userId) && b.status === 'pending'
    );
  }

  /**
   * Get battle history for user
   */
  async getBattleHistory(userId: string, limit: number = 50): Promise<PKBattle[]> {
    const userBattles = Array.from(this.battles.values()).filter(
      b =>
        (b.initiatorId === userId || b.challengerId === userId) &&
        b.status === 'completed'
    );

    return userBattles.slice(-limit).reverse();
  }
}

export default new PKService();
