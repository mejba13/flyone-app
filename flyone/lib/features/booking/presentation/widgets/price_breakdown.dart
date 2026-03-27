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
      padding: const EdgeInsets.all(16),
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
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: AppColors.divider),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTypography.heading3),
              Text('\$${total.toInt()}', style: AppTypography.heading2.copyWith(color: AppColors.deepPurple)),
            ],
          ),
        ],
      ),
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
