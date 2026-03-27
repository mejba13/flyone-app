class SearchQuery {
  final String from;
  final String to;
  final String fromCode;
  final String toCode;
  final DateTime date;
  final int passengers;
  final String travelClass;
  final bool isRoundTrip;
  final String transportMode;

  const SearchQuery({
    required this.from,
    required this.to,
    required this.fromCode,
    required this.toCode,
    required this.date,
    this.passengers = 1,
    this.travelClass = 'Economy',
    this.isRoundTrip = false,
    this.transportMode = 'all',
  });
}
