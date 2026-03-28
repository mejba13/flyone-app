import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_bookings_data.dart';
import 'models/booking_summary.dart';

final bookingsProvider = FutureProvider<List<BookingSummary>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 400));
  return MockBookingsData.bookings;
});
