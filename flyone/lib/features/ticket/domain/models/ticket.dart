class Ticket {
  final String id;
  final String pnr;
  final String tripType;
  final String carrierName;
  final String carrierLogo;
  final String departureCode;
  final String arrivalCode;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String date;
  final String gate;
  final String terminal;
  final String passengerName;
  final String seatNumber;
  final String travelClass;
  final String barcodeData;

  const Ticket({
    required this.id,
    required this.pnr,
    required this.tripType,
    required this.carrierName,
    required this.carrierLogo,
    required this.departureCode,
    required this.arrivalCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.date,
    required this.gate,
    required this.terminal,
    required this.passengerName,
    required this.seatNumber,
    required this.travelClass,
    required this.barcodeData,
  });
}
