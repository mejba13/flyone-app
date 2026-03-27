import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class FlyoneThemeExtension extends ThemeExtension<FlyoneThemeExtension> {
  final Color lightLilac;
  final Color deepPurple;
  final Color teal;
  final Color softWhite;
  final Color cardBackground;
  final Color badgeBackground;
  final Color shimmerBase;
  final Color shimmerHighlight;

  const FlyoneThemeExtension({
    required this.lightLilac,
    required this.deepPurple,
    required this.teal,
    required this.softWhite,
    required this.cardBackground,
    required this.badgeBackground,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  @override
  FlyoneThemeExtension copyWith({
    Color? lightLilac,
    Color? deepPurple,
    Color? teal,
    Color? softWhite,
    Color? cardBackground,
    Color? badgeBackground,
    Color? shimmerBase,
    Color? shimmerHighlight,
  }) {
    return FlyoneThemeExtension(
      lightLilac: lightLilac ?? this.lightLilac,
      deepPurple: deepPurple ?? this.deepPurple,
      teal: teal ?? this.teal,
      softWhite: softWhite ?? this.softWhite,
      cardBackground: cardBackground ?? this.cardBackground,
      badgeBackground: badgeBackground ?? this.badgeBackground,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
    );
  }

  @override
  FlyoneThemeExtension lerp(FlyoneThemeExtension? other, double t) {
    if (other == null) return this;
    return FlyoneThemeExtension(
      lightLilac: Color.lerp(lightLilac, other.lightLilac, t)!,
      deepPurple: Color.lerp(deepPurple, other.deepPurple, t)!,
      teal: Color.lerp(teal, other.teal, t)!,
      softWhite: Color.lerp(softWhite, other.softWhite, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      badgeBackground: Color.lerp(badgeBackground, other.badgeBackground, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
    );
  }

  static const light = FlyoneThemeExtension(
    lightLilac: AppColors.lightLilac,
    deepPurple: AppColors.deepPurple,
    teal: AppColors.teal,
    softWhite: AppColors.softWhite,
    cardBackground: AppColors.cardBackground,
    badgeBackground: AppColors.badgeBackground,
    shimmerBase: AppColors.shimmerBase,
    shimmerHighlight: AppColors.shimmerHighlight,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.softWhite,
      colorScheme: ColorScheme.light(
        primary: AppColors.deepPurple,
        secondary: AppColors.teal,
        surface: AppColors.softWhite,
        onPrimary: Colors.white,
        onSecondary: AppColors.deepPurple,
        onSurface: AppColors.textPrimary,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.softWhite,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.deepPurple,
        ),
        iconTheme: const IconThemeData(color: AppColors.deepPurple),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.deepPurple,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 2,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.deepPurple, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      extensions: const [FlyoneThemeExtension.light],
    );
  }
}
