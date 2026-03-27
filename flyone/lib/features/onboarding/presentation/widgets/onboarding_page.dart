import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;

  // Secondary orbiting icons for the illustration
  final List<IconData>? orbitIcons;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
    this.orbitIcons,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Elaborate illustration: concentric circles + orbiting icons
          SizedBox(
            width: 240,
            height: 240,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outermost concentric circle — 5% opacity
                Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconColor.withValues(alpha: 0.05),
                  ),
                ),
                // Middle concentric circle — 10% opacity
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: iconColor.withValues(alpha: 0.10),
                  ),
                ),
                // Inner concentric circle — 20% opacity
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightLilac.withValues(alpha: 0.25),
                  ),
                ),
                // Core icon circle with gradient + shadow
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.lightLilac,
                        iconColor.withValues(alpha: 0.6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: iconColor.withValues(alpha: 0.30),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Icon(icon, size: 48, color: AppColors.deepPurple),
                ),
                // Orbiting icon — top-right
                if (orbitIcons != null && orbitIcons!.isNotEmpty)
                  Positioned(
                    top: 20,
                    right: 20,
                    child: _OrbitIcon(
                      icon: orbitIcons![0],
                      color: iconColor,
                      size: 36,
                    ),
                  ),
                // Orbiting icon — bottom-left
                if (orbitIcons != null && orbitIcons!.length > 1)
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: _OrbitIcon(
                      icon: orbitIcons![1],
                      color: AppColors.teal,
                      size: 32,
                    ),
                  ),
                // Orbiting icon — bottom-right (smaller accent)
                if (orbitIcons != null && orbitIcons!.length > 2)
                  Positioned(
                    bottom: 32,
                    right: 24,
                    child: _OrbitIcon(
                      icon: orbitIcons![2],
                      color: AppColors.deepPurple,
                      size: 28,
                    ),
                  ),
              ],
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

class _OrbitIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const _OrbitIcon({
    required this.icon,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.15),
        border: Border.all(
          color: color.withValues(alpha: 0.25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, size: size * 0.5, color: color),
    );
  }
}
