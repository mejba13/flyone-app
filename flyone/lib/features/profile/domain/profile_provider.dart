import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/user_repository.dart';
import '../data/mock_user_repository.dart';
import '../../loyalty/data/loyalty_repository.dart';
import '../../loyalty/data/mock_loyalty_repository.dart';
import '../../loyalty/domain/models/loyalty_info.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) => MockUserRepository());
final loyaltyRepositoryProvider = Provider<LoyaltyRepository>((ref) => MockLoyaltyRepository());

final userProfileProvider = FutureProvider<Map<String, String>>((ref) async {
  return ref.read(userRepositoryProvider).getUserProfile();
});

final loyaltyInfoProvider = Provider<LoyaltyInfo>((ref) {
  return ref.read(loyaltyRepositoryProvider).getLoyaltyInfo();
});
