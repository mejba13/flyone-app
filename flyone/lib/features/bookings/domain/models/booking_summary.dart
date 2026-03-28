enum BookingStatus { upcoming, completed, cancelled }

class BookingSummary {
  final String id;
  final String carrierName;
  final String transportMode;
  final String departureCode;
  final String arrivalCode;
  final String departureTime;
  final String arrivalTime;
  final String date;
  final String duration;
  final String travelClass;
  final double price;
  final String currency;
  final BookingStatus status;
  final String pnr;

  const BookingSummary({
    required this.id,
    required this.carrierName,
    required this.transportMode,
    required this.departureCode,
    required this.arrivalCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.date,
    required this.duration,
    required this.travelClass,
    required this.price,
    this.currency = '\$',
    required this.status,
    required this.pnr,
  });
}
