import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TransportIcon extends StatelessWidget {
  final String mode;
  final double size;
  final Color? color;

  const TransportIcon({
    super.key,
    required this.mode,
    this.size = 24,
    this.color,
  });

  static IconData getIcon(String mode) {
    return switch (mode.toLowerCase()) {
      'flight' || 'airplane' => Icons.flight_rounded,
      'train' || 'rail' => Icons.train_rounded,
      'boat' || 'ferry' => Icons.sailing_rounded,
      'bus' => Icons.directions_bus_rounded,
      _ => Icons.commute_rounded,
    };
  }

  static String getLabel(String mode) {
    return switch (mode.toLowerCase()) {
      'flight' || 'airplane' => 'Flight',
      'train' || 'rail' => 'Train',
      'boat' || 'ferry' => 'Ferry',
      'bus' => 'Bus',
      _ => 'Transport',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 12,
      height: size + 12,
      decoration: BoxDecoration(
        color: AppColors.lightLilac.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        getIcon(mode),
        size: size,
        color: color ?? AppColors.deepPurple,
      ),
    );
  }
}
