import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../loyalty/domain/models/loyalty_info.dart';

class LoyaltyTierBadge extends StatelessWidget {
  final LoyaltyInfo info;

  const LoyaltyTierBadge({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.deepPurple, Color(0xFF4A3F7A)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.workspace_premium_rounded, color: AppColors.teal, size: 24),
              const SizedBox(width: 8),
              Text(info.tier, style: AppTypography.heading3.copyWith(color: Colors.white)),
              const Spacer(),
              Text(
                '${info.points} pts',
                style: AppTypography.bodySmall.copyWith(color: AppColors.teal),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: info.progressPercent,
              backgroundColor: Colors.white24,
              color: AppColors.teal,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${info.nextTierPoints - info.points} points to Navigator',
            style: AppTypography.caption.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
