import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/payment_method.dart';

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({super.key, required this.method, required this.isSelected, required this.onTap});

  IconData get _brandIcon => switch (method.brand) {
    'Visa' => Icons.credit_card,
    'Mastercard' => Icons.credit_card,
    _ => Icons.credit_card,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightLilac.withValues(alpha: 0.3) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? AppColors.deepPurple : AppColors.divider),
        ),
        child: Row(
          children: [
            Icon(_brandIcon, color: AppColors.deepPurple, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(method.brand, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                  Text('\u2022\u2022\u2022\u2022 ${method.lastFour}', style: AppTypography.caption),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.deepPurple : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
