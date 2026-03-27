class PaymentMethod {
  final String id;
  final String type;
  final String name;
  final String lastFour;
  final String brand;
  final bool isDefault;

  const PaymentMethod({
    required this.id,
    required this.type,
    required this.name,
    required this.lastFour,
    required this.brand,
    this.isDefault = false,
  });
}
