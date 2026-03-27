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
        ...addons.map((addon) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _AddonCard(
            addon: addon,
            icon: _icon(addon.iconType),
            onToggle: () => onToggle(addon.id),
          ),
        )),
      ],
    );
  }
}

class _AddonCard extends StatefulWidget {
  final Addon addon;
  final IconData icon;
  final VoidCallback onToggle;

  const _AddonCard({
    required this.addon,
    required this.icon,
    required this.onToggle,
  });

  @override
  State<_AddonCard> createState() => _AddonCardState();
}

class _AddonCardState extends State<_AddonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _checkController;
  late Animation<double> _checkScale;

  @override
  void initState() {
    super.initState();
    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _checkScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.3), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _checkController, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_AddonCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.addon.isSelected && !oldWidget.addon.isSelected) {
      _checkController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSelected = widget.addon.isSelected;

    return GestureDetector(
      onTap: widget.onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFEDE8FF), AppColors.surfaceVariant],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? AppColors.deepPurple : AppColors.divider,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Icon in teal rounded container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.teal.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(widget.icon, color: AppColors.teal, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.addon.name,
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(widget.addon.description, style: AppTypography.caption),
                ],
              ),
            ),
            // Price pill badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.deepPurple.withValues(alpha: 0.1)
                    : AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '\$${widget.addon.price.toInt()}',
                style: AppTypography.caption.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isSelected ? AppColors.deepPurple : AppColors.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Animated check icon
            AnimatedBuilder(
              animation: _checkScale,
              builder: (context, child) => Transform.scale(
                scale: _checkScale.value,
                child: child,
              ),
              child: Icon(
                isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
                color: isSelected ? AppColors.deepPurple : AppColors.textSecondary,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
