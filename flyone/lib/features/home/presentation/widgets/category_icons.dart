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

class _CategoryItem extends StatefulWidget {
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
    _scale = Tween<double>(begin: 1.0, end: 0.95).animate(
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
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.lightLilac.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lightLilac.withValues(alpha: 0.45),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(widget.icon, color: AppColors.deepPurple, size: 28),
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
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.teal.withValues(alpha: 0.4),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
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
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: AppTypography.caption.copyWith(color: AppColors.textPrimary),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
