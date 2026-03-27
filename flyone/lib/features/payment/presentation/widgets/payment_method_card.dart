import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/payment_method.dart';

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  // Brand-specific accent colors
  Color get _brandColor => switch (method.brand) {
    'Visa' => const Color(0xFF1A1F71),
    'Mastercard' => const Color(0xFFEB6000),
    'AMEX' => const Color(0xFF007B5E),
    _ => AppColors.deepPurple,
  };

  IconData get _brandIcon => switch (method.brand) {
    'Visa' => Icons.credit_card,
    'Mastercard' => Icons.credit_card,
    'AMEX' => Icons.credit_card,
    _ => Icons.credit_card,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected
              ? _brandColor.withValues(alpha: 0.06)
              : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? _brandColor : AppColors.divider,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Brand icon container with brand color
            Container(
              width: 44,
              height: 34,
              decoration: BoxDecoration(
                color: _brandColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(_brandIcon, color: _brandColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        method.brand,
                        style: AppTypography.bodySmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      // Default badge
                      if (method.isDefault) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Default',
                            style: AppTypography.label.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\u2022\u2022\u2022\u2022 ${method.lastFour}',
                    style: AppTypography.caption,
                  ),
                ],
              ),
            ),
            // Custom radio indicator
            _CustomRadio(isSelected: isSelected, color: _brandColor),
          ],
        ),
      ),
    );
  }
}

class _CustomRadio extends StatelessWidget {
  final bool isSelected;
  final Color color;

  const _CustomRadio({required this.isSelected, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color : AppColors.textSecondary.withValues(alpha: 0.4),
          width: isSelected ? 2 : 1.5,
        ),
      ),
      child: isSelected
          ? Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
            )
          : null,
    );
  }
}
