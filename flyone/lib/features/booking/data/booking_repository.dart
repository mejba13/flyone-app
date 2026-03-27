import '../../../core/utils/result.dart';
import '../domain/models/booking.dart';

abstract class BookingRepository {
  Future<Result<Booking>> createBooking(Booking booking);
  List<Addon> getAvailableAddons();
  List<List<int>> getSeatMap();
}
