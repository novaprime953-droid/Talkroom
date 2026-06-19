enum TransactionType { gift, purchase, recharge, reward, pk, lucky, task }

class Transaction {
  const Transaction({
    required this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.timestamp,
    required this.newBalance,
    this.relatedUserId,
    this.relatedItemId,
  });

  final String id;
  final TransactionType type;
  final int amount;
  final String description;
  final DateTime timestamp;
  final int newBalance;
  final String? relatedUserId;
  final String? relatedItemId;

  bool get isExpense =>
      type != TransactionType.recharge && type != TransactionType.reward;
}

class Wallet {
  const Wallet({
    required this.userId,
    required this.coins,
    required this.diamonds,
    required this.vipPoints,
    required this.totalSpent,
    required this.totalEarned,
    required this.transactions,
  });

  final String userId;
  final int coins;
  final int diamonds;
  final int vipPoints;
  final int totalSpent;
  final int totalEarned;
  final List<Transaction> transactions;

  Wallet copyWith({
    int? coins,
    int? diamonds,
    int? vipPoints,
    int? totalSpent,
    int? totalEarned,
    List<Transaction>? transactions,
  }) {
    return Wallet(
      userId: userId,
      coins: coins ?? this.coins,
      diamonds: diamonds ?? this.diamonds,
      vipPoints: vipPoints ?? this.vipPoints,
      totalSpent: totalSpent ?? this.totalSpent,
      totalEarned: totalEarned ?? this.totalEarned,
      transactions: transactions ?? this.transactions,
    );
  }
}

class DailyTask {
  const DailyTask({
    required this.id,
    required this.title,
    required this.description,
    required this.reward,
    required this.progress,
    required this.requirement,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  final String description;
  final int reward;
  final int progress;
  final int requirement;
  final bool isCompleted;

  double get progressPercent => (progress / requirement).clamp(0, 1);
}
