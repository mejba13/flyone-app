import '../../../core/utils/result.dart';
import 'payment_repository.dart';

class MockPaymentRepository implements PaymentRepository {
  @override
  Future<Result<String>> processPayment(String methodId, double amount) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Success('TXN-FLY-2024-001');
  }

  @override
  double getWalletBalance() => 150.0;
}
