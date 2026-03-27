import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/tracking_repository.dart';
import '../data/mock_tracking_repository.dart';

final trackingRepositoryProvider = Provider<TrackingRepository>(
  (ref) => MockTrackingRepository(),
);

final trackingStreamProvider =
    StreamProvider.family<Map<String, dynamic>, String>((ref, bookingId) {
  return ref.read(trackingRepositoryProvider).getVehiclePosition(bookingId);
});
