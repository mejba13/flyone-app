import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.lightLilac.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: AppColors.lightLilac,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 60, color: iconColor),
              ),
            ),
          ),
          const SizedBox(height: 48),
          Text(
            title,
            style: AppTypography.heading1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: AppTypography.body.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
