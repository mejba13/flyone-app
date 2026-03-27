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
      child: Stack(
        children: [
          // Decorative star/diamond pattern on the right side
          Positioned(
            right: -8,
            top: -8,
            child: Opacity(
              opacity: 0.12,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.diamond_rounded, color: Colors.white, size: 28),
                      const SizedBox(width: 6),
                      const Icon(Icons.star_rounded, color: Colors.white, size: 20),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      const Icon(Icons.diamond_rounded, color: Colors.white, size: 22),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.workspace_premium_rounded, color: AppColors.teal, size: 24),
                  const SizedBox(width: 8),
                  // Tier name in a pill badge with teal accent
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.teal.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.teal.withValues(alpha: 0.5), width: 1),
                    ),
                    child: Text(
                      info.tier,
                      style: AppTypography.heading3.copyWith(color: AppColors.teal),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${info.points} pts',
                    style: AppTypography.bodySmall.copyWith(color: AppColors.teal),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Progress bar with milestone markers
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Progress bar background
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: info.progressPercent,
                      backgroundColor: Colors.white24,
                      color: AppColors.teal,
                      minHeight: 8,
                    ),
                  ),
                  // Milestone dots at 25%, 50%, 75%
                  for (final pct in [0.25, 0.50, 0.75])
                    Positioned(
                      left: (MediaQuery.of(context).size.width - 32 - 48) * pct - 4,
                      top: -3,
                      child: Container(
                        width: 6,
                        height: 14,
                        decoration: BoxDecoration(
                          color: info.progressPercent >= pct
                              ? Colors.white
                              : Colors.white38,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${info.nextTierPoints - info.points} points to Navigator',
                style: AppTypography.caption.copyWith(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
