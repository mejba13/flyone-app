import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class LocationSelector extends StatelessWidget {
  final String from;
  final String to;
  final VoidCallback onSwap;
  final VoidCallback? onFromTap;
  final VoidCallback? onToTap;

  const LocationSelector({
    super.key,
    required this.from,
    required this.to,
    required this.onSwap,
    this.onFromTap,
    this.onToTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LocationField(label: 'From', value: from, icon: Icons.circle_outlined, onTap: onFromTap),
              const SizedBox(height: 16),
              _LocationField(label: 'To', value: to, icon: Icons.location_on_rounded, onTap: onToTap),
            ],
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: onSwap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.teal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.swap_vert_rounded, color: Colors.white, size: 22),
          ),
        )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .rotate(begin: 0, end: 0, duration: 1.ms),
      ],
    );
  }
}

class _LocationField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback? onTap;

  const _LocationField({required this.label, required this.value, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTypography.caption),
              Text(value, style: AppTypography.body.copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
