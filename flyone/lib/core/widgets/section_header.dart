import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_constants.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceXL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.heading3),
          if (onViewAll != null)
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                'VIEW ALL',
                style: AppTypography.label.copyWith(
                  color: AppColors.teal,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
