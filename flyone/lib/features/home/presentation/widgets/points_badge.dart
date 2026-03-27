import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PointsBadge extends StatelessWidget {
  final int points;

  const PointsBadge({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.lightLilac, AppColors.surfaceVariant],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightLilac.withValues(alpha: 0.5),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Star with subtle glow
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.teal.withValues(alpha: 0.25),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: AppColors.teal,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star_rounded, color: Colors.white, size: 14),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Text(
            '$points points',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
