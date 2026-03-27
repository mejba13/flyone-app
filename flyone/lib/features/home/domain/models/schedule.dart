class Schedule {
  final String id;
  final String carrierName;
  final String carrierLogo;
  final String tripType;
  final String departureCode;
  final String arrivalCode;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String date;
  final String travelClass;
  final String baggage;
  final String transportMode;

  const Schedule({
    required this.id,
    required this.carrierName,
    required this.carrierLogo,
    required this.tripType,
    required this.departureCode,
    required this.arrivalCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.date,
    required this.travelClass,
    required this.baggage,
    required this.transportMode,
  });
}
