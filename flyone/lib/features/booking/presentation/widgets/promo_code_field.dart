import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PromoCodeField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onApply;
  final bool isApplied;

  const PromoCodeField({
    super.key,
    required this.controller,
    required this.onApply,
    this.isApplied = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter promo code',
              hintStyle: AppTypography.bodySmall,
              prefixIcon: const Icon(Icons.local_offer_rounded, color: AppColors.textSecondary, size: 20),
              suffixIcon: isApplied
                  ? const Icon(Icons.check_circle, color: AppColors.success, size: 20)
                  : null,
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: onApply,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.teal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text('Apply', style: AppTypography.buttonSmall),
        ),
      ],
    );
  }
}
