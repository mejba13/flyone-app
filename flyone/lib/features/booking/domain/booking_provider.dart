import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/booking_repository.dart';
import '../data/mock_booking_repository.dart';
import 'models/booking.dart';

final bookingRepositoryProvider = Provider<BookingRepository>(
  (ref) => MockBookingRepository(),
);

final addonsProvider = StateNotifierProvider<AddonsNotifier, List<Addon>>((ref) {
  final repo = ref.read(bookingRepositoryProvider);
  return AddonsNotifier(repo.getAvailableAddons());
});

class AddonsNotifier extends StateNotifier<List<Addon>> {
  AddonsNotifier(super.addons);

  void toggle(String id) {
    state = state.map((a) => a.id == id ? a.copyWith(isSelected: !a.isSelected) : a).toList();
  }
}

final selectedSeatProvider = StateProvider<String?>((ref) => null);
final promoCodeProvider = StateProvider<String?>((ref) => null);
final promoDiscountProvider = StateProvider<double>((ref) => 0);
