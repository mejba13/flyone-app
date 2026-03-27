import '../../../core/utils/result.dart';

abstract class PaymentRepository {
  Future<Result<String>> processPayment(String methodId, double amount);
  double getWalletBalance();
}
