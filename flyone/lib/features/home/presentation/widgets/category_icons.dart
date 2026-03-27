import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class CategoryIcons extends StatelessWidget {
  final Function(String) onCategoryTap;

  const CategoryIcons({super.key, required this.onCategoryTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _CategoryItem(
          icon: Icons.train_rounded,
          label: 'Trains',
          badge: '20%',
          onTap: () => onCategoryTap('train'),
        ),
        _CategoryItem(
          icon: Icons.flight_rounded,
          label: 'Flights',
          onTap: () => onCategoryTap('flight'),
        ),
        _CategoryItem(
          icon: Icons.sailing_rounded,
          label: 'Boats',
          onTap: () => onCategoryTap('boat'),
        ),
        _CategoryItem(
          icon: Icons.directions_bus_rounded,
          label: 'Bus',
          onTap: () => onCategoryTap('bus'),
        ),
      ],
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? badge;
  final VoidCallback onTap;

  const _CategoryItem({
    required this.icon,
    required this.label,
    this.badge,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.lightLilac.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: AppColors.deepPurple, size: 28),
              ),
              if (badge != null)
                Positioned(
                  top: -6,
                  right: -6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.teal,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badge!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTypography.caption.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
