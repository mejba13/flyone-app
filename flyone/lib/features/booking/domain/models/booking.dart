class Booking {
  final String id;
  final String carrierName;
  final String departureCode;
  final String arrivalCode;
  final String departureTime;
  final String arrivalTime;
  final String date;
  final String travelClass;
  final double basePrice;
  final List<Addon> addons;
  final String? promoCode;
  final double discount;
  final List<Passenger> passengers;
  final String? selectedSeat;

  const Booking({
    required this.id,
    required this.carrierName,
    required this.departureCode,
    required this.arrivalCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.date,
    required this.travelClass,
    required this.basePrice,
    this.addons = const [],
    this.promoCode,
    this.discount = 0,
    this.passengers = const [],
    this.selectedSeat,
  });

  double get totalPrice {
    final addonsTotal = addons.where((a) => a.isSelected).fold(0.0, (sum, a) => sum + a.price);
    return (basePrice + addonsTotal) * (passengers.isEmpty ? 1 : passengers.length) - discount;
  }
}

class Passenger {
  final String name;
  final String email;
  final String phone;

  const Passenger({required this.name, required this.email, required this.phone});
}

class Addon {
  final String id;
  final String name;
  final String description;
  final double price;
  final IconType iconType;
  final bool isSelected;

  const Addon({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.iconType,
    this.isSelected = false,
  });

  Addon copyWith({bool? isSelected}) => Addon(
    id: id, name: name, description: description,
    price: price, iconType: iconType,
    isSelected: isSelected ?? this.isSelected,
  );
}

enum IconType { baggage, meal, insurance, lounge }
