import '../domain/models/loyalty_info.dart';
import 'loyalty_repository.dart';

class MockLoyaltyRepository implements LoyaltyRepository {
  @override
  LoyaltyInfo getLoyaltyInfo() => const LoyaltyInfo(
        points: 320,
        tier: 'Explorer',
        nextTierPoints: 1000,
        progressPercent: 0.32,
      );
}
