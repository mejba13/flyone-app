import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PriceBreakdown extends StatelessWidget {
  final double basePrice;
  final double addonsTotal;
  final double discount;
  final int passengers;

  const PriceBreakdown({
    super.key,
    required this.basePrice,
    required this.addonsTotal,
    required this.discount,
    required this.passengers,
  });

  double get total => (basePrice + addonsTotal) * passengers - discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.lightLilac.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _Row('Base fare', '\$${basePrice.toInt()} x $passengers'),
          if (addonsTotal > 0) _Row('Add-ons', '\$${addonsTotal.toInt()}'),
          if (discount > 0) _Row('Discount', '-\$${discount.toInt()}', isDiscount: true),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: _DashedDivider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('Total', style: AppTypography.heading3.copyWith(fontWeight: FontWeight.w700)),
                  if (discount > 0) ...[
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.local_offer_rounded, size: 11, color: AppColors.success),
                          const SizedBox(width: 3),
                          Text(
                            'You save \$${discount.toInt()}',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
              Text(
                '\$${total.toInt()}',
                style: AppTypography.heading1.copyWith(color: AppColors.deepPurple),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashedDivider extends StatelessWidget {
  const _DashedDivider();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 6.0;
        const dashSpace = 4.0;
        final count = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          children: List.generate(count, (_) => Container(
            width: dashWidth,
            height: 1,
            margin: const EdgeInsets.only(right: dashSpace),
            color: AppColors.divider,
          )),
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool isDiscount;

  const _Row(this.label, this.value, {this.isDiscount = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodySmall),
          Text(value, style: AppTypography.bodySmall.copyWith(
            color: isDiscount ? AppColors.success : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          )),
        ],
      ),
    );
  }
}
