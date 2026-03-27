abstract class TrackingRepository {
  Stream<Map<String, dynamic>> getVehiclePosition(String bookingId);
}
