import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/booking.dart';

class AddonsSection extends StatelessWidget {
  final List<Addon> addons;
  final ValueChanged<String> onToggle;

  const AddonsSection({super.key, required this.addons, required this.onToggle});

  IconData _icon(IconType type) => switch (type) {
    IconType.baggage => Icons.luggage_rounded,
    IconType.meal => Icons.restaurant_rounded,
    IconType.insurance => Icons.shield_rounded,
    IconType.lounge => Icons.airline_seat_recline_extra_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Add-ons', style: AppTypography.heading3),
        const SizedBox(height: 12),
        ...addons.map((addon) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: () => onToggle(addon.id),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: addon.isSelected ? AppColors.lightLilac.withValues(alpha: 0.3) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: addon.isSelected ? AppColors.deepPurple : AppColors.divider,
                ),
              ),
              child: Row(
                children: [
                  Icon(_icon(addon.iconType), color: AppColors.teal, size: 22),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(addon.name, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                        Text(addon.description, style: AppTypography.caption),
                      ],
                    ),
                  ),
                  Text('\$${addon.price.toInt()}', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 8),
                  Icon(
                    addon.isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                    color: addon.isSelected ? AppColors.deepPurple : AppColors.textSecondary,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        )),
      ],
    );
  }
}
