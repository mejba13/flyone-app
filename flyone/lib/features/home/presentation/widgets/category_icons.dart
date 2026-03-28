import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_constants.dart';

class CategoryIcons extends StatelessWidget {
  final Function(String) onCategoryTap;
  final bool isDarkBackground;

  const CategoryIcons({super.key, required this.onCategoryTap, this.isDarkBackground = false});

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
          isDarkBackground: isDarkBackground,
        ),
        _CategoryItem(
          icon: Icons.flight_rounded,
          label: 'Flights',
          onTap: () => onCategoryTap('flight'),
          isDarkBackground: isDarkBackground,
        ),
        _CategoryItem(
          icon: Icons.sailing_rounded,
          label: 'Boats',
          onTap: () => onCategoryTap('boat'),
          isDarkBackground: isDarkBackground,
        ),
        _CategoryItem(
          icon: Icons.directions_bus_rounded,
          label: 'Bus',
          onTap: () => onCategoryTap('bus'),
          isDarkBackground: isDarkBackground,
        ),
      ],
    );
  }
}

class _CategoryItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final String? badge;
  final VoidCallback onTap;
  final bool isDarkBackground;

  const _CategoryItem({
    required this.icon,
    required this.label,
    this.badge,
    required this.onTap,
    required this.isDarkBackground,
  });

  @override
  State<_CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<_CategoryItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 1.0,
    );
    _scale = Tween<double>(begin: 1.0, end: AppConstants.pressScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.forward();
  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
    widget.onTap();
  }
  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scale,
        child: SizedBox(
          width: 72,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: widget.isDarkBackground
                          ? Colors.white.withValues(alpha: 0.12)
                          : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                      border: widget.isDarkBackground
                          ? Border.all(color: Colors.white.withValues(alpha: 0.15), width: 1)
                          : null,
                    ),
                    child: Icon(widget.icon,
                        color: widget.isDarkBackground ? Colors.white : AppColors.deepPurple,
                        size: 24),
                  ),
                  if (widget.badge != null)
                    Positioned(
                      top: -7,
                      right: -7,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.teal,
                          borderRadius: BorderRadius.circular(10),
                          border: widget.isDarkBackground
                              ? Border.all(color: AppColors.deepPurple, width: 1.5)
                              : null,
                        ),
                        child: Text(
                          widget.badge!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            height: 1.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                widget.label,
                style: AppTypography.overline.copyWith(
                  color: widget.isDarkBackground
                      ? Colors.white.withValues(alpha: 0.9)
                      : AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
