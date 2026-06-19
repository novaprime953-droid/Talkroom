// Wallet & Payment Service
import { Wallet, Transaction, Gift } from '@/models';

class WalletService {
  private wallets: Map<string, Wallet> = new Map();
  private transactions: Map<string, Transaction[]> = new Map();
  private gifts: Map<string, Gift> = new Map();

  /**
   * Initialize wallet for user
   * Equivalent to NiuChat's WalletService.initializeWallet()
   */
  async initializeWallet(userId: string, initialDiamonds: number = 0): Promise<Wallet> {
    const wallet: Wallet = {
      userId,
      diamonds: initialDiamonds,
      coins: 0,
      totalDiamondsEarned: initialDiamonds,
      totalDiamondsSpent: 0,
      updatedAt: new Date(),
    };

    this.wallets.set(userId, wallet);
    this.transactions.set(userId, []);

    return wallet;
  }

  /**
   * Get wallet balance
   */
  async getWallet(userId: string): Promise<Wallet | null> {
    return this.wallets.get(userId) || null;
  }

  /**
   * Add diamonds (recharge or reward)
   * Equivalent to NiuChat's ChargeService.addDiamonds()
   */
  async addDiamonds(
    userId: string,
    amount: number,
    type: 'recharge' | 'reward' | 'gift_reward',
    reference?: string
  ): Promise<Transaction> {
    let wallet = this.wallets.get(userId);
    if (!wallet) {
      wallet = await this.initializeWallet(userId);
    }

    wallet.diamonds += amount;
    wallet.totalDiamondsEarned += amount;
    wallet.updatedAt = new Date();

    const transaction: Transaction = {
      id: `txn_${Date.now()}_${Math.random()}`,
      userId,
      type,
      amount,
      currency: 'diamonds',
      status: 'completed',
      reference,
      createdAt: new Date(),
      completedAt: new Date(),
    };

    if (!this.transactions.has(userId)) {
      this.transactions.set(userId, []);
    }
    this.transactions.get(userId)?.push(transaction);

    return transaction;
  }

  /**
   * Spend diamonds (gifts, pk rewards, etc)
   * Equivalent to NiuChat's WalletService.spendDiamonds()
   */
  async spendDiamonds(
    userId: string,
    amount: number,
    type: 'gift' | 'reward' | 'item_purchase',
    description?: string
  ): Promise<Transaction | null> {
    const wallet = this.wallets.get(userId);
    if (!wallet || wallet.diamonds < amount) {
      return null; // Insufficient balance
    }

    wallet.diamonds -= amount;
    wallet.totalDiamondsSpent += amount;
    wallet.updatedAt = new Date();

    const transaction: Transaction = {
      id: `txn_${Date.now()}_${Math.random()}`,
      userId,
      type,
      amount,
      currency: 'diamonds',
      status: 'completed',
      description,
      createdAt: new Date(),
      completedAt: new Date(),
    };

    this.transactions.get(userId)?.push(transaction);

    return transaction;
  }

  /**
   * Get transaction history
   */
  async getTransactionHistory(userId: string, limit: number = 50): Promise<Transaction[]> {
    const transactions = this.transactions.get(userId) || [];
    return transactions.slice(-limit).reverse();
  }

  /**
   * Register a gift
   */
  registerGift(gift: Gift): void {
    this.gifts.set(gift.id, gift);
  }

  /**
   * Get gift by ID
   */
  getGift(giftId: string): Gift | null {
    return this.gifts.get(giftId) || null;
  }

  /**
   * Get all gifts
   */
  getAllGifts(): Gift[] {
    return Array.from(this.gifts.values());
  }

  /**
   * Get gifts by category
   */
  getGiftsByCategory(category: 'lucky' | 'super' | 'normal' | 'special'): Gift[] {
    return Array.from(this.gifts.values()).filter(g => g.category === category);
  }

  /**
   * Calculate gift combo bonus
   * Equivalent to NiuChat's GiftService.calculateComboBonus()
   */
  calculateComboBonus(giftIds: string[], multiplier: number = 1.0): number {
    let bonus = 0;
    const uniqueGifts = new Set(giftIds);

    for (const giftId of uniqueGifts) {
      const gift = this.gifts.get(giftId);
      if (gift?.comboable) {
        bonus += gift.diamondCost * 0.1; // 10% combo bonus per unique gift
      }
    }

    return Math.floor(bonus * multiplier);
  }

  /**
   * Check balance and validate purchase
   */
  async validatePurchase(userId: string, amount: number): Promise<boolean> {
    const wallet = this.wallets.get(userId);
    return wallet ? wallet.diamonds >= amount : false;
  }

  /**
   * Get wallet statistics
   */
  async getWalletStats(userId: string): Promise<{
    balance: number;
    totalEarned: number;
    totalSpent: number;
    transactionCount: number;
  } | null> {
    const wallet = this.wallets.get(userId);
    if (!wallet) return null;

    return {
      balance: wallet.diamonds,
      totalEarned: wallet.totalDiamondsEarned,
      totalSpent: wallet.totalDiamondsSpent,
      transactionCount: this.transactions.get(userId)?.length || 0,
    };
  }
}

export default new WalletService();
