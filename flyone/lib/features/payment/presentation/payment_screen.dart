import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../core/widgets/toast_notification.dart';
import '../domain/payment_provider.dart';
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
            ...methods.asMap().entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: PaymentMethodCard(
                method: entry.value,
                isSelected: entry.value.id == selected,
                onTap: () => ref.read(selectedPaymentMethodProvider.notifier).state = entry.value.id,
              ).animate().fadeIn(delay: (100 * entry.key).ms, duration: 300.ms),
            )),
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightLilac.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _SummaryRow('Subtotal', '\$81'),
                  _SummaryRow('Add-ons', '\$25'),
                  _SummaryRow('Discount', '-\$24', isDiscount: true),
                  const Divider(color: AppColors.divider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTypography.heading3),
                      Text('\$82', style: AppTypography.heading2.copyWith(color: AppColors.deepPurple)),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms, duration: 300.ms),
            const SizedBox(height: 24),
            PillButton(
              label: 'Pay \$82',
              onPressed: () {
                ToastNotification.show(context, message: 'Payment successful!', type: ToastType.success);
                context.push('/eticket');
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
