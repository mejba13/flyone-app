import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_home_data.dart';
import 'models/schedule.dart';
import 'models/destination.dart';
import 'models/voucher.dart';

final schedulesProvider = FutureProvider<List<Schedule>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 600));
  return MockHomeData.schedules;
});

final destinationsProvider = FutureProvider<List<Destination>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 800));
  return MockHomeData.destinations;
});

final vouchersProvider = Provider<List<Voucher>>((ref) {
  return MockHomeData.vouchers;
});

final userPointsProvider = Provider<int>((ref) => MockHomeData.userPoints);
