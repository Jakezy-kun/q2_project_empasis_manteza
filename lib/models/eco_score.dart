class EcoScore {
  final double deviceHealthScore;
  final int deviceAge;
  final String deviceType;
  final double marketDemand;
  final double environmentalImpact;

  EcoScore({
    required this.deviceHealthScore,
    required this.deviceAge,
    required this.deviceType,
    this.marketDemand = 1.0,
    this.environmentalImpact = 1.0,
  });

  double calculateEcoScore() {
    double baseScore = deviceHealthScore;

    double ageFactor = 1.0 - (deviceAge / 60);
    ageFactor = ageFactor.clamp(0.3, 1.0);

    double typeFactor = _getDeviceTypeFactor();

    return (baseScore * ageFactor * typeFactor * marketDemand * environmentalImpact)
        .clamp(0, 100);
  }

  double _getDeviceTypeFactor() {
    switch (deviceType.toLowerCase()) {
      case 'laptop':
        return 1.2;
      case 'tablet':
        return 1.1;
      case 'phone':
        return 1.0;
      case 'accessories':
        return 0.8;
      default:
        return 1.0;
    }
  }

  double calculateTradeInValue(double originalPrice) {
    final ecoScore = calculateEcoScore();
    final valuePercentage = 0.1 + (ecoScore / 100 * 0.5);
    return originalPrice * valuePercentage;
  }

  String getEcoRating() {
    final score = calculateEcoScore();
    if (score >= 85) return '🌿 Excellent';
    if (score >= 70) return '✅ Good';
    if (score >= 50) return '⚠️ Fair';
    return '❌ Poor';
  }
}