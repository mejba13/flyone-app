class SearchResult {
  final String id;
  final String carrierName;
  final String carrierLogo;
  final String travelClass;
  final String departureCode;
  final String arrivalCode;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final double rating;
  final double pricePerPax;
  final String currency;
  final bool canReschedule;
  final String transportMode;
  final bool isFavorite;

  const SearchResult({
    required this.id,
    required this.carrierName,
    required this.carrierLogo,
    required this.travelClass,
    required this.departureCode,
    required this.arrivalCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.rating,
    required this.pricePerPax,
    this.currency = '\$',
    this.canReschedule = true,
    required this.transportMode,
    this.isFavorite = false,
  });

  SearchResult copyWith({bool? isFavorite}) {
    return SearchResult(
      id: id,
      carrierName: carrierName,
      carrierLogo: carrierLogo,
      travelClass: travelClass,
      departureCode: departureCode,
      arrivalCode: arrivalCode,
      departureTime: departureTime,
      arrivalTime: arrivalTime,
      duration: duration,
      rating: rating,
      pricePerPax: pricePerPax,
      currency: currency,
      canReschedule: canReschedule,
      transportMode: transportMode,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
