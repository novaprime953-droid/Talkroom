enum PkStatus { waiting, live, finished }

class PkBattle {
  const PkBattle({
    required this.id,
    required this.player1Id,
    required this.player1Name,
    required this.player1Avatar,
    required this.player1Vip,
    required this.player2Id,
    required this.player2Name,
    required this.player2Avatar,
    required this.player2Vip,
    required this.player1Score,
    required this.player2Score,
    required this.status,
    required this.startTime,
    required this.durationSeconds,
    this.winnerId,
    this.endTime,
    this.supporters1 = const [],
    this.supporters2 = const [],
  });

  final String id;
  final String player1Id;
  final String player1Name;
  final String player1Avatar;
  final int player1Vip;
  final String player2Id;
  final String player2Name;
  final String player2Avatar;
  final int player2Vip;
  final int player1Score;
  final int player2Score;
  final PkStatus status;
  final DateTime startTime;
  final int durationSeconds;
  final String? winnerId;
  final DateTime? endTime;
  final List<String> supporters1;
  final List<String> supporters2;

  int get elapsedSeconds => DateTime.now().difference(startTime).inSeconds;
  int get remainingSeconds => durationSeconds - elapsedSeconds;
  double get progressPercent => elapsedSeconds / durationSeconds;
}

class LuckyGift {
  const LuckyGift({
    required this.id,
    required this.name,
    required this.basePrice,
    required this.currentMultiplier,
    required this.maxMultiplier,
    required this.animationUrl,
    required this.minReward,
    required this.maxReward,
  });

  final String id;
  final String name;
  final int basePrice;
  final int currentMultiplier;
  final int maxMultiplier;
  final String animationUrl;
  final int minReward;
  final int maxReward;

  int get finalPrice => basePrice * currentMultiplier;
  int get potentialReward => (minReward + maxReward) ~/ 2 * currentMultiplier;
}

class LuckyGiftResult {
  const LuckyGiftResult({
    required this.senderId,
    required this.senderName,
    required this.giftId,
    required this.giftName,
    required this.multiplier,
    required this.reward,
    required this.timestamp,
    required this.winAnimation,
  });

  final String senderId;
  final String senderName;
  final String giftId;
  final String giftName;
  final int multiplier;
  final int reward;
  final DateTime timestamp;
  final String winAnimation;
}

class Jackpot {
  const Jackpot({
    required this.totalAmount,
    required this.participants,
    required this.winChance,
  });

  final int totalAmount;
  final int participants;
  final double winChance; // percentage
}
