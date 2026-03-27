import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/payment_repository.dart';
import '../data/mock_payment_repository.dart';
import 'models/payment_method.dart';

final paymentRepositoryProvider = Provider<PaymentRepository>(
  (ref) => MockPaymentRepository(),
);

final paymentMethodsProvider = Provider<List<PaymentMethod>>((ref) => const [
  PaymentMethod(id: '1', type: 'card', name: 'Visa', lastFour: '4242', brand: 'Visa', isDefault: true),
  PaymentMethod(id: '2', type: 'card', name: 'Mastercard', lastFour: '8888', brand: 'Mastercard'),
  PaymentMethod(id: '3', type: 'card', name: 'AMEX', lastFour: '1234', brand: 'AMEX'),
]);

final selectedPaymentMethodProvider = StateProvider<String>((ref) => '1');

final walletBalanceProvider = Provider<double>((ref) {
  return ref.watch(paymentRepositoryProvider).getWalletBalance();
});
