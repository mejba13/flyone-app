import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  // ── Border Radius ─────────────────────────────────────────────
  static const double radiusSmall = 12.0;
  static const double radiusMedium = 16.0;
  static const double radiusLarge = 24.0;

  // ── Spacing (4px grid) ────────────────────────────────────────
  static const double spaceXS = 4.0;
  static const double spaceSM = 8.0;
  static const double spaceMD = 12.0;
  static const double spaceLG = 16.0;
  static const double spaceXL = 20.0;
  static const double spaceXXL = 24.0;
  static const double spaceXXXL = 32.0;

  // ── Opacity ───────────────────────────────────────────────────
  static const double opacityDim = 0.06;
  static const double opacityLight = 0.12;
  static const double opacityMedium = 0.35;
  static const double opacityStrong = 0.60;

  // ── Shadows ───────────────────────────────────────────────────
  static const List<BoxShadow> shadowSubtle = [
    BoxShadow(
      color: Color(0x0F2D2654), // deepPurple at 0.06
      blurRadius: 8,
      offset: Offset(0, 2),
    ),
  ];

  static const List<BoxShadow> shadowElevated = [
    BoxShadow(
      color: Color(0x1A2D2654), // deepPurple at 0.10
      blurRadius: 16,
      offset: Offset(0, 4),
    ),
  ];

  // ── Animation ─────────────────────────────────────────────────
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animNormal = Duration(milliseconds: 300);
  static const Duration animSlow = Duration(milliseconds: 450);
  static const Curve animSpring = Curves.easeOutBack;
  static const Curve animEase = Curves.easeOut;
  static const double pressScale = 0.96;
  static const Duration staggerInterval = Duration(milliseconds: 80);

  // ── Component Sizes ───────────────────────────────────────────
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 36.0;
  static const double iconButtonSize = 44.0;
}
