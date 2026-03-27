import 'tracking_repository.dart';

class MockTrackingRepository implements TrackingRepository {
  @override
  Stream<Map<String, dynamic>> getVehiclePosition(String bookingId) async* {
    final stops = ['Jakarta (CGK)', 'Karawang', 'Cikampek', 'Purwakarta', 'Bandung (BDG)'];
    for (int i = 0; i < stops.length; i++) {
      await Future.delayed(const Duration(seconds: 3));
      yield {
        'currentStop': stops[i],
        'progress': (i + 1) / stops.length,
        'eta': '${(stops.length - i - 1) * 25} min',
        'speed': '120 km/h',
      };
    }
  }
}
