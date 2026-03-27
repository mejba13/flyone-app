import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../core/widgets/toast_notification.dart';
import '../domain/payment_provider.dart';
import '../../booking/domain/booking_provider.dart';
import '../../search/domain/search_provider.dart';
import 'widgets/payment_method_card.dart';
import 'widgets/wallet_balance.dart';
import 'widgets/add_card_form.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methods = ref.watch(paymentMethodsProvider);
    final selected = ref.watch(selectedPaymentMethodProvider);
    final balance = ref.watch(walletBalanceProvider);
    final addons = ref.watch(addonsProvider);
    final discount = ref.watch(promoDiscountProvider);
    final selectedRoute = ref.watch(selectedResultProvider);
    final basePrice = selectedRoute?.pricePerPax ?? 81.0;
    final addonsTotal = addons.where((a) => a.isSelected).fold(0.0, (s, a) => s + a.price);
    final total = basePrice + addonsTotal - discount;

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WalletBalance(balance: balance).animate().fadeIn(duration: 300.ms),
            const SizedBox(height: 24),
            Text('Payment Methods', style: AppTypography.heading3),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Column(
                children: methods.asMap().entries.map((entry) {
                  final isLast = entry.key == methods.length - 1;
                  return Column(
                    children: [
                      PaymentMethodCard(
                        method: entry.value,
                        isSelected: entry.value.id == selected,
                        onTap: () => ref.read(selectedPaymentMethodProvider.notifier).state = entry.value.id,
                      ).animate().fadeIn(delay: (100 * entry.key).ms, duration: 300.ms),
                      if (!isLast)
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Divider(height: 1, color: AppColors.divider),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            const AddCardForm().animate().fadeIn(delay: 400.ms, duration: 300.ms),
            const SizedBox(height: 16),
            // BNPL option
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  const Icon(Icons.schedule_rounded, color: AppColors.teal),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Buy Now, Pay Later', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                        Text('Split into 3 monthly payments', style: AppTypography.caption),
                      ],
                    ),
                  ),
                  Switch(value: false, onChanged: (_) {}, activeThumbColor: AppColors.teal),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms, duration: 300.ms),
            const SizedBox(height: 24),
            // Order summary
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.surfaceVariant, Color(0xFFE8E4FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.receipt_long_rounded, size: 16, color: AppColors.deepPurple),
                      const SizedBox(width: 6),
                      Text(
                        'Order Summary',
                        style: AppTypography.caption.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.deepPurple,
                          letterSpacing: 0.4,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _SummaryRow('Subtotal', '\$${basePrice.toStringAsFixed(0)}'),
                  _SummaryRow('Add-ons', '\$${addonsTotal.toStringAsFixed(0)}'),
                  _SummaryRow('Discount', '-\$${discount.toStringAsFixed(0)}', isDiscount: true),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: _DashedLine(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTypography.heading3.copyWith(fontWeight: FontWeight.w700)),
                      Text('\$${total.toStringAsFixed(0)}', style: AppTypography.heading1.copyWith(color: AppColors.deepPurple)),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms, duration: 300.ms),
            const SizedBox(height: 24),
            PillButton(
              label: 'Pay \$${total.toStringAsFixed(0)}',
              onPressed: () {
                ToastNotification.show(context, message: 'Payment successful!', type: ToastType.success);
                context.go('/eticket');
              },
              width: double.infinity,
            ).animate().fadeIn(delay: 700.ms, duration: 300.ms),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _DashedLine extends StatelessWidget {
  const _DashedLine();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 6.0;
        const dashSpace = 4.0;
        final count = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          children: List.generate(
            count,
            (_) => Container(
              width: dashWidth,
              height: 1,
              margin: const EdgeInsets.only(right: dashSpace),
              color: AppColors.divider,
            ),
          ),
        );
      },
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDiscount;

  const _SummaryRow(this.label, this.value, {this.isDiscount = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodySmall),
          Text(value, style: AppTypography.bodySmall.copyWith(
            color: isDiscount ? AppColors.success : null, fontWeight: FontWeight.w600,
          )),
        ],
      ),
    );
  }
}
