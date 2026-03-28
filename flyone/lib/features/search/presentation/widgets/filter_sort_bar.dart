import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_constants.dart';
import '../../../../core/theme/app_typography.dart';

class FilterSortBar extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const FilterSortBar(
      {super.key, required this.selectedFilter, required this.onFilterChanged});

  // Maps filter name to a leading icon
  static IconData _iconFor(String filter) {
    return switch (filter) {
      'Best' => Icons.auto_awesome_rounded,
      'Price' => Icons.attach_money_rounded,
      'Duration' => Icons.access_time_rounded,
      'Rating' => Icons.star_rounded,
      'Departure' => Icons.arrow_upward_rounded,
      _ => Icons.filter_list_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final filters = ['Best', 'Price', 'Duration', 'Rating', 'Departure'];
    return SizedBox(
      height: 42,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isActive = filter == selectedFilter;
          return GestureDetector(
            onTap: () => onFilterChanged(filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOutCubic,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? AppColors.deepPurple : Colors.white,
                borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                border: Border.all(
                  color: isActive ? AppColors.deepPurple : AppColors.divider,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _iconFor(filter),
                    size: 13,
                    color: isActive
                        ? Colors.white
                        : AppColors.textSecondary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    filter,
                    style: AppTypography.caption.copyWith(
                      color: isActive
                          ? Colors.white
                          : AppColors.textSecondary,
                      fontWeight:
                          isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
