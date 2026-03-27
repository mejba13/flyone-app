class LoyaltyInfo {
  final int points;
  final String tier;
  final int nextTierPoints;
  final double progressPercent;

  const LoyaltyInfo({
    required this.points,
    required this.tier,
    required this.nextTierPoints,
    required this.progressPercent,
  });
}
