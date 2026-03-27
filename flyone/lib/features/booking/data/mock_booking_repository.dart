import '../../../core/utils/result.dart';
import '../domain/models/booking.dart';
import 'booking_repository.dart';

class MockBookingRepository implements BookingRepository {
  @override
  Future<Result<Booking>> createBooking(Booking booking) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Success(booking);
  }

  @override
  List<Addon> getAvailableAddons() => const [
    Addon(id: '1', name: 'Extra Baggage', description: '20kg additional', price: 25, iconType: IconType.baggage),
    Addon(id: '2', name: 'In-flight Meal', description: 'Premium meal set', price: 15, iconType: IconType.meal),
    Addon(id: '3', name: 'Travel Insurance', description: 'Full coverage', price: 12, iconType: IconType.insurance),
    Addon(id: '4', name: 'Lounge Access', description: 'Airport lounge', price: 35, iconType: IconType.lounge),
  ];

  @override
  List<List<int>> getSeatMap() => [
    // 0 = available, 1 = occupied, 2 = premium
    [0, 0, 2, 2, 0, 0],
    [0, 1, 0, 0, 1, 0],
    [0, 0, 0, 0, 0, 0],
    [1, 1, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 1, 1, 0, 0],
    [0, 0, 0, 0, 0, 0],
  ];
}
