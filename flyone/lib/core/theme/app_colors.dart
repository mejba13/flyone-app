import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary palette
  static const Color lightLilac = Color(0xFFD6CCFF);
  static const Color deepPurple = Color(0xFF2D2654);
  static const Color teal = Color(0xFF5BCFCF);
  static const Color softWhite = Color(0xFFF8F9FC);

  // Semantic
  static const Color cardBackground = Colors.white;
  static const Color divider = Color(0xFFE8E8EE);
  static const Color textPrimary = deepPurple;
  static const Color textSecondary = Color(0xFF8E8EA0);
  static const Color error = Color(0xFFE53935);
  static const Color success = Color(0xFF43A047);
  static const Color warning = Color(0xFFFFA726);
  static const Color badgeBackground = lightLilac;
  static const Color shimmerBase = Color(0xFFE8E5F0);
  static const Color shimmerHighlight = Color(0xFFF3F0FA);

  // Additional semantic
  static const Color surfaceVariant = Color(0xFFF0EDFF);
  static const Color onSurfaceVariant = Color(0xFF6B6B80);
  static const Color shadowColor = Color(0x1A2D2654);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [lightLilac, teal],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [deepPurple, Color(0xFF4A3F7A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [teal, Color(0xFF4DB8B8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
