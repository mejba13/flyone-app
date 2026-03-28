# Flyone Flutter App Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a complete Flutter travel booking app with 12 screens, 9 mock repositories, clean architecture, Riverpod state management, and a polished 4-color design system.

**Architecture:** Feature-first clean architecture with presentation/domain/data layers per feature. Shared core layer for theme, router, widgets, constants. Mock repository implementations behind abstract interfaces using the Result pattern for error handling.

**Tech Stack:** Flutter 3.x, Dart, flutter_riverpod, go_router, dio, flutter_animate, google_fonts, qr_flutter, shimmer, cached_network_image, intl

---

## Phase 1: Project Setup & Core Infrastructure

### Task 1: Create Flutter project and configure dependencies

**Files:**
- Create: `flyone/pubspec.yaml`
- Create: `flyone/lib/main.dart`
- Create: `flyone/analysis_options.yaml`

- [ ] **Step 1: Create Flutter project**

Run:
```bash
cd /Users/mejba/AndroidStudioProjects/flyone-app
flutter create flyone --org com.ramlit.flyone --platforms ios,android
```

- [ ] **Step 2: Replace pubspec.yaml with dependencies**

Replace `flyone/pubspec.yaml` with:

```yaml
name: flyone
description: AI-powered travel booking platform
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.7.0

dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.6.1
  go_router: ^15.1.2
  dio: ^5.7.0
  flutter_animate: ^4.5.2
  google_fonts: ^6.2.1
  qr_flutter: ^4.1.0
  shimmer: ^3.0.0
  cached_network_image: ^3.4.1
  intl: ^0.19.0
  flutter_svg: ^2.0.17
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/icons/
```

- [ ] **Step 3: Create asset directories and run pub get**

Run:
```bash
cd /Users/mejba/AndroidStudioProjects/flyone-app/flyone
mkdir -p assets/images assets/icons
flutter pub get
```

- [ ] **Step 4: Commit**

```bash
cd /Users/mejba/AndroidStudioProjects/flyone-app/flyone
git add -A
git commit -m "chore: initialize Flutter project with dependencies"
```

---

### Task 2: Build core theme system (colors, typography, theme extension)

**Files:**
- Create: `flyone/lib/core/theme/app_colors.dart`
- Create: `flyone/lib/core/theme/app_typography.dart`
- Create: `flyone/lib/core/theme/app_theme.dart`

- [ ] **Step 1: Create app_colors.dart**

```dart
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
}
```

- [ ] **Step 2: Create app_typography.dart**

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get heading1 => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading2 => GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get heading3 => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get button => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  static TextStyle get buttonSmall => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );
}
```

- [ ] **Step 3: Create app_theme.dart**

```dart
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
    if (other is! FlyoneThemeExtension) return this;
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
```

- [ ] **Step 4: Commit**

```bash
git add -A
git commit -m "feat: add core theme system with 4-color palette and typography"
```

---

### Task 3: Build Result pattern utility

**Files:**
- Create: `flyone/lib/core/utils/result.dart`

- [ ] **Step 1: Create result.dart**

```dart
sealed class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> extends Result<T> {
  final String message;
  final Exception? exception;
  const Failure(this.message, [this.exception]);
}
```

- [ ] **Step 2: Commit**

```bash
git add -A
git commit -m "feat: add Result pattern for error handling"
```

---

### Task 4: Build shared widgets

**Files:**
- Create: `flyone/lib/core/widgets/app_card.dart`
- Create: `flyone/lib/core/widgets/pill_button.dart`
- Create: `flyone/lib/core/widgets/skeleton_loader.dart`
- Create: `flyone/lib/core/widgets/app_bottom_nav.dart`
- Create: `flyone/lib/core/widgets/toast_notification.dart`
- Create: `flyone/lib/core/widgets/rating_stars.dart`
- Create: `flyone/lib/core/widgets/section_header.dart`

- [ ] **Step 1: Create app_card.dart**

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? color;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color ?? AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
```

- [ ] **Step 2: Create pill_button.dart**

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class PillButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final bool isSmall;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;

  const PillButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isOutlined = false,
    this.isSmall = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? AppColors.deepPurple;
    final fgColor = textColor ?? Colors.white;

    return SizedBox(
      width: width,
      height: isSmall ? 40 : 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : bgColor,
          foregroundColor: isOutlined ? bgColor : fgColor,
          elevation: isOutlined ? 0 : 2,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26),
            side: isOutlined
                ? BorderSide(color: bgColor, width: 1.5)
                : BorderSide.none,
          ),
          padding: EdgeInsets.symmetric(horizontal: isSmall ? 20 : 32),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: isSmall ? 18 : 20),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: isSmall ? AppTypography.buttonSmall : AppTypography.button,
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Create skeleton_loader.dart**

```dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../theme/app_colors.dart';

class SkeletonLoader extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonLoader({
    super.key,
    this.width = double.infinity,
    required this.height,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.shimmerBase,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

class SkeletonCard extends StatelessWidget {
  final double height;

  const SkeletonCard({super.key, this.height = 120});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.shimmerBase,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Create app_bottom_nav.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              _NavItem(
                icon: Icons.search_rounded,
                label: 'Search',
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              _NavItem(
                icon: Icons.calendar_today_rounded,
                label: 'Bookings',
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              _NavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                isActive: currentIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? AppColors.lightLilac.withValues(alpha: 0.4) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.deepPurple : AppColors.textSecondary,
              size: 24,
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.deepPurple,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ).animate(target: isActive ? 1 : 0).scale(
            begin: const Offset(0.95, 0.95),
            end: const Offset(1.0, 1.0),
            duration: 200.ms,
          ),
    );
  }
}
```

- [ ] **Step 5: Create toast_notification.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum ToastType { success, error, info }

class ToastNotification {
  static void show(
    BuildContext context, {
    required String message,
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        type: type,
        onDismiss: () => entry.remove(),
        duration: duration,
      ),
    );

    overlay.insert(entry);
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final VoidCallback onDismiss;
  final Duration duration;

  const _ToastWidget({
    required this.message,
    required this.type,
    required this.onDismiss,
    required this.duration,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> {
  @override
  void initState() {
    super.initState();
    Future.delayed(widget.duration, () {
      if (mounted) widget.onDismiss();
    });
  }

  IconData get _icon => switch (widget.type) {
        ToastType.success => Icons.check_circle_rounded,
        ToastType.error => Icons.error_rounded,
        ToastType.info => Icons.info_rounded,
      };

  Color get _color => switch (widget.type) {
        ToastType.success => AppColors.success,
        ToastType.error => AppColors.error,
        ToastType.info => AppColors.teal,
      };

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 16,
      right: 16,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: _color.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: _color.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(_icon, color: _color, size: 22),
              const SizedBox(width: 12),
              Expanded(
                child: Text(message, style: AppTypography.bodySmall.copyWith(color: AppColors.textPrimary)),
              ),
              GestureDetector(
                onTap: widget.onDismiss,
                child: const Icon(Icons.close, size: 18, color: AppColors.textSecondary),
              ),
            ],
          ),
        )
            .animate()
            .slideY(begin: -1, end: 0, duration: 300.ms, curve: Curves.easeOut)
            .fadeIn(duration: 300.ms),
      ),
    );
  }
}
```

- [ ] **Step 6: Create rating_stars.dart**

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double size;
  final bool showValue;

  const RatingStars({
    super.key,
    required this.rating,
    this.size = 16,
    this.showValue = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_rounded, color: AppColors.teal, size: size),
        const SizedBox(width: 4),
        if (showValue)
          Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
              fontSize: size - 2,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
      ],
    );
  }
}
```

- [ ] **Step 7: Create section_header.dart**

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.heading3),
          if (onViewAll != null)
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                'View All',
                style: AppTypography.bodySmall.copyWith(color: AppColors.teal),
              ),
            ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 8: Commit**

```bash
git add -A
git commit -m "feat: add shared widgets (card, button, skeleton, nav, toast, stars, section header)"
```

---

### Task 5: Build GoRouter navigation with ShellRoute

**Files:**
- Create: `flyone/lib/core/router/app_router.dart`
- Create: `flyone/lib/core/router/shell_screen.dart`

- [ ] **Step 1: Create shell_screen.dart**

```dart
import 'package:flutter/material.dart';
import '../widgets/app_bottom_nav.dart';

class ShellScreen extends StatelessWidget {
  final int currentIndex;
  final Widget child;
  final ValueChanged<int> onNavigate;

  const ShellScreen({
    super.key,
    required this.currentIndex,
    required this.child,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onTap: onNavigate,
      ),
    );
  }
}
```

- [ ] **Step 2: Create app_router.dart**

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shell_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/search/presentation/search_screen.dart';
import '../../features/search/presentation/search_results_screen.dart';
import '../../features/booking/presentation/booking_detail_screen.dart';
import '../../features/payment/presentation/payment_screen.dart';
import '../../features/ticket/presentation/eticket_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/notifications/presentation/notifications_screen.dart';
import '../../features/chat/presentation/chat_screen.dart';
import '../../features/tracking/presentation/tracking_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          final location = state.uri.path;
          int currentIndex = 0;
          if (location.startsWith('/search')) currentIndex = 1;
          if (location.startsWith('/bookings')) currentIndex = 2;
          if (location.startsWith('/profile')) currentIndex = 3;

          return ShellScreen(
            currentIndex: currentIndex,
            onNavigate: (index) {
              switch (index) {
                case 0:
                  context.go('/home');
                case 1:
                  context.go('/search');
                case 2:
                  context.go('/bookings');
                case 3:
                  context.go('/profile');
              }
            },
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/search',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SearchScreen(),
            ),
          ),
          GoRoute(
            path: '/bookings',
            pageBuilder: (context, state) => NoTransitionPage(
              child: Scaffold(
                body: Center(child: Text('My Bookings')),
              ),
            ),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/search-results',
        builder: (context, state) => const SearchResultsScreen(),
      ),
      GoRoute(
        path: '/booking-detail',
        builder: (context, state) => const BookingDetailScreen(),
      ),
      GoRoute(
        path: '/payment',
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: '/eticket',
        builder: (context, state) => const ETicketScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/chat',
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: '/tracking',
        builder: (context, state) => const TrackingScreen(),
      ),
    ],
  );
});
```

- [ ] **Step 3: Commit**

```bash
git add -A
git commit -m "feat: add GoRouter navigation with ShellRoute bottom nav"
```

---

### Task 6: Create app entry point (main.dart + app.dart)

**Files:**
- Modify: `flyone/lib/main.dart`
- Create: `flyone/lib/app.dart`

- [ ] **Step 1: Create app.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class FlyoneApp extends ConsumerWidget {
  const FlyoneApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Flyone',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: router,
    );
  }
}
```

- [ ] **Step 2: Update main.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ProviderScope(child: FlyoneApp()));
}
```

- [ ] **Step 3: Commit**

```bash
git add -A
git commit -m "feat: add app entry point with Riverpod and theme"
```

---

## Phase 2: Splash & Onboarding

### Task 7: Build Splash Screen

**Files:**
- Create: `flyone/lib/features/splash/presentation/splash_screen.dart`

- [ ] **Step 1: Create splash_screen.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) context.go('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.lightLilac,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.flight_takeoff_rounded,
                size: 48,
                color: AppColors.deepPurple,
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1), duration: 600.ms, curve: Curves.easeOutBack),
            const SizedBox(height: 24),
            Text('FLYONE', style: AppTypography.heading1.copyWith(letterSpacing: 4))
                .animate()
                .fadeIn(delay: 300.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, delay: 300.ms, duration: 600.ms),
            const SizedBox(height: 8),
            Text('Travel Made Effortless', style: AppTypography.bodySmall)
                .animate()
                .fadeIn(delay: 600.ms, duration: 600.ms),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add -A
git commit -m "feat: add splash screen with animated logo"
```

---

### Task 8: Build Onboarding Screen (3 slides)

**Files:**
- Create: `flyone/lib/features/onboarding/presentation/onboarding_screen.dart`
- Create: `flyone/lib/features/onboarding/presentation/widgets/onboarding_page.dart`

- [ ] **Step 1: Create onboarding_page.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color iconColor;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.lightLilac.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.lightLilac,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 60, color: iconColor),
              ),
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
```

- [ ] **Step 2: Create onboarding_screen.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/pill_button.dart';
import 'widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  final _pages = const [
    OnboardingPage(
      title: 'Travel Made\nEffortless',
      description: 'Book flights, trains, buses and boats all in one place. Your journey starts here.',
      icon: Icons.public_rounded,
      iconColor: AppColors.deepPurple,
    ),
    OnboardingPage(
      title: 'AI-Powered\nPlanning',
      description: 'Smart recommendations, price predictions, and route optimization powered by AI.',
      icon: Icons.auto_awesome_rounded,
      iconColor: AppColors.teal,
    ),
    OnboardingPage(
      title: 'Digital Tickets\n& Tracking',
      description: 'E-tickets with QR codes, real-time tracking, and instant notifications.',
      icon: Icons.qr_code_scanner_rounded,
      iconColor: AppColors.deepPurple,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () => context.go('/home'),
                  child: Text('Skip', style: AppTypography.bodySmall.copyWith(color: AppColors.teal)),
                ),
              ),
            ),
            // Pages
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: _pages,
              ),
            ),
            // Dots + Button
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  // Page dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == i ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == i ? AppColors.deepPurple : AppColors.lightLilac,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  PillButton(
                    label: _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    onPressed: _next,
                    width: double.infinity,
                  ).animate().fadeIn(duration: 300.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add -A
git commit -m "feat: add onboarding with 3 animated slides"
```

---

## Phase 3: Home Dashboard

### Task 9: Create Home mock data and models

**Files:**
- Create: `flyone/lib/features/home/data/mock_home_data.dart`
- Create: `flyone/lib/features/home/domain/home_provider.dart`
- Create: `flyone/lib/features/home/domain/models/schedule.dart`
- Create: `flyone/lib/features/home/domain/models/destination.dart`
- Create: `flyone/lib/features/home/domain/models/voucher.dart`

- [ ] **Step 1: Create schedule.dart**

```dart
class Schedule {
  final String id;
  final String carrierName;
  final String carrierLogo;
  final String tripType;
  final String departureCode;
  final String arrivalCode;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String date;
  final String travelClass;
  final String baggage;
  final String transportMode;

  const Schedule({
    required this.id,
    required this.carrierName,
    required this.carrierLogo,
    required this.tripType,
    required this.departureCode,
    required this.arrivalCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.date,
    required this.travelClass,
    required this.baggage,
    required this.transportMode,
  });
}
```

- [ ] **Step 2: Create destination.dart**

```dart
class Destination {
  final String id;
  final String name;
  final String imageUrl;
  final String price;

  const Destination({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });
}
```

- [ ] **Step 3: Create voucher.dart**

```dart
class Voucher {
  final String id;
  final String title;
  final String subtitle;
  final String discount;
  final String code;
  final String bgColorHex;

  const Voucher({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.discount,
    required this.code,
    required this.bgColorHex,
  });
}
```

- [ ] **Step 4: Create mock_home_data.dart**

```dart
import '../domain/models/schedule.dart';
import '../domain/models/destination.dart';
import '../domain/models/voucher.dart';

class MockHomeData {
  static const schedules = [
    Schedule(
      id: '1',
      carrierName: 'Garuda Airline',
      carrierLogo: '✈️',
      tripType: 'One Way',
      departureCode: 'CGK',
      arrivalCode: 'DPS',
      departureTime: '06:40',
      arrivalTime: '09:25',
      duration: '3hr 55min',
      date: '3 Feb 2024',
      travelClass: 'Business',
      baggage: '5 kg',
      transportMode: 'flight',
    ),
    Schedule(
      id: '2',
      carrierName: 'Whoosh',
      carrierLogo: '🚄',
      tripType: 'One-way',
      departureCode: 'HLM',
      arrivalCode: 'BDG',
      departureTime: '12:30',
      arrivalTime: '14:15',
      duration: '1hr 45min',
      date: '5 Feb 2024',
      travelClass: 'Business',
      baggage: '10 kg',
      transportMode: 'train',
    ),
    Schedule(
      id: '3',
      carrierName: 'Lion Air',
      carrierLogo: '✈️',
      tripType: 'Round Trip',
      departureCode: 'CGK',
      arrivalCode: 'SUB',
      departureTime: '08:00',
      arrivalTime: '09:30',
      duration: '1hr 30min',
      date: '10 Feb 2024',
      travelClass: 'Economy',
      baggage: '20 kg',
      transportMode: 'flight',
    ),
  ];

  static const destinations = [
    Destination(id: '1', name: 'Bali', imageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=400', price: '\$120'),
    Destination(id: '2', name: 'Tokyo', imageUrl: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=400', price: '\$350'),
    Destination(id: '3', name: 'Paris', imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=400', price: '\$420'),
    Destination(id: '4', name: 'Sydney', imageUrl: 'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?w=400', price: '\$380'),
    Destination(id: '5', name: 'Dubai', imageUrl: 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=400', price: '\$280'),
    Destination(id: '6', name: 'Bangkok', imageUrl: 'https://images.unsplash.com/photo-1508009603885-50cf7c579365?w=400', price: '\$95'),
  ];

  static const vouchers = [
    Voucher(id: '1', title: 'New member', subtitle: 'Special discount', discount: '30%', code: 'WELCOME30', bgColorHex: 'D6CCFF'),
    Voucher(id: '2', title: 'Exclusive Deal', subtitle: 'Buy 1 Get 1', discount: 'BOGO', code: 'BOGO2024', bgColorHex: '5BCFCF'),
    Voucher(id: '3', title: 'Weekend Sale', subtitle: 'Limited time', discount: '20%', code: 'WEEKEND20', bgColorHex: 'D6CCFF'),
  ];

  static const int userPoints = 320;
  static const String userName = 'Mejba';
}
```

- [ ] **Step 5: Create home_provider.dart**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/mock_home_data.dart';
import 'models/schedule.dart';
import 'models/destination.dart';
import 'models/voucher.dart';

final schedulesProvider = FutureProvider<List<Schedule>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 600));
  return MockHomeData.schedules;
});

final destinationsProvider = FutureProvider<List<Destination>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 800));
  return MockHomeData.destinations;
});

final vouchersProvider = Provider<List<Voucher>>((ref) {
  return MockHomeData.vouchers;
});

final userPointsProvider = Provider<int>((ref) => MockHomeData.userPoints);
```

- [ ] **Step 6: Commit**

```bash
git add -A
git commit -m "feat: add home dashboard models and mock data providers"
```

---

### Task 10: Build Home Dashboard screen and widgets

**Files:**
- Create: `flyone/lib/features/home/presentation/home_screen.dart`
- Create: `flyone/lib/features/home/presentation/widgets/points_badge.dart`
- Create: `flyone/lib/features/home/presentation/widgets/category_icons.dart`
- Create: `flyone/lib/features/home/presentation/widgets/upcoming_schedule_card.dart`
- Create: `flyone/lib/features/home/presentation/widgets/destination_card.dart`
- Create: `flyone/lib/features/home/presentation/widgets/voucher_carousel.dart`

- [ ] **Step 1: Create points_badge.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PointsBadge extends StatelessWidget {
  final int points;

  const PointsBadge({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.lightLilac.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.teal,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star_rounded, color: Colors.white, size: 14),
          ),
          const SizedBox(width: 8),
          Text(
            '$points points',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.deepPurple,
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Create category_icons.dart**

```dart
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

class _CategoryItem extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                ),
                child: Icon(icon, color: AppColors.deepPurple, size: 28),
              ),
              if (badge != null)
                Positioned(
                  top: -6,
                  right: -6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.teal,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badge!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(label, style: AppTypography.caption.copyWith(color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Create upcoming_schedule_card.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../domain/models/schedule.dart';

class UpcomingScheduleCard extends StatelessWidget {
  final Schedule schedule;
  final VoidCallback? onTap;

  const UpcomingScheduleCard({
    super.key,
    required this.schedule,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Text(schedule.carrierLogo, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(schedule.tripType, style: AppTypography.caption),
                        Text(schedule.date, style: AppTypography.caption.copyWith(color: AppColors.teal)),
                      ],
                    ),
                    Text(schedule.carrierName, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Route row
          Row(
            children: [
              _RoutePoint(code: schedule.departureCode, time: schedule.departureTime),
              Expanded(
                child: Column(
                  children: [
                    Text(schedule.duration, style: AppTypography.caption),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(child: Container(height: 1, color: AppColors.divider)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(Icons.flight_rounded, size: 14, color: AppColors.teal),
                        ),
                        Expanded(child: Container(height: 1, color: AppColors.divider)),
                      ],
                    ),
                  ],
                ),
              ),
              _RoutePoint(code: schedule.arrivalCode, time: schedule.arrivalTime, isArrival: true),
            ],
          ),
          const SizedBox(height: 12),
          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Baggage', style: AppTypography.caption),
                  Text(schedule.baggage, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Type', style: AppTypography.caption),
                  Text(schedule.travelClass, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
              PillButton(
                label: 'See Details',
                isSmall: true,
                isOutlined: true,
                onPressed: onTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoutePoint extends StatelessWidget {
  final String code;
  final String time;
  final bool isArrival;

  const _RoutePoint({required this.code, required this.time, this.isArrival = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isArrival ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(code, style: AppTypography.heading3),
        Text(time, style: AppTypography.caption),
      ],
    );
  }
}
```

- [ ] **Step 4: Create destination_card.dart**

```dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../domain/models/destination.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback? onTap;

  const DestinationCard({super.key, required this.destination, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: destination.imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => const SkeletonLoader(height: 140),
                errorWidget: (_, __, ___) => Container(
                  height: 140,
                  color: AppColors.lightLilac,
                  child: const Icon(Icons.image_rounded, color: AppColors.deepPurple),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withValues(alpha: 0.7), Colors.transparent],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(destination.name, style: AppTypography.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.w600)),
                      Text(destination.price, style: AppTypography.caption.copyWith(color: AppColors.teal)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 5: Create voucher_carousel.dart**

```dart
import 'package:flutter/material.dart';
import 'dart:async';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/voucher.dart';

class VoucherCarousel extends StatefulWidget {
  final List<Voucher> vouchers;

  const VoucherCarousel({super.key, required this.vouchers});

  @override
  State<VoucherCarousel> createState() => _VoucherCarouselState();
}

class _VoucherCarouselState extends State<VoucherCarousel> {
  late final PageController _controller;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.85);
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      _currentPage = (_currentPage + 1) % widget.vouchers.length;
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Color _parseColor(String hex) {
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.vouchers.length,
        onPageChanged: (i) => setState(() => _currentPage = i),
        itemBuilder: (context, index) {
          final voucher = widget.vouchers[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Container(
              decoration: BoxDecoration(
                color: _parseColor(voucher.bgColorHex),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          voucher.title,
                          style: AppTypography.caption.copyWith(color: AppColors.deepPurple),
                        ),
                        Text(
                          voucher.subtitle,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.deepPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          voucher.discount,
                          style: AppTypography.heading1.copyWith(color: AppColors.deepPurple),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.local_offer_rounded, size: 36, color: AppColors.deepPurple),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

- [ ] **Step 6: Create home_screen.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../domain/home_provider.dart';
import 'widgets/points_badge.dart';
import 'widgets/category_icons.dart';
import 'widgets/upcoming_schedule_card.dart';
import 'widgets/destination_card.dart';
import 'widgets/voucher_carousel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedules = ref.watch(schedulesProvider);
    final destinations = ref.watch(destinationsProvider);
    final vouchers = ref.watch(vouchersProvider);
    final points = ref.watch(userPointsProvider);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.deepPurple,
          onRefresh: () async {
            ref.invalidate(schedulesProvider);
            ref.invalidate(destinationsProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      PointsBadge(points: points),
                      const Spacer(),
                      _IconButton(icon: Icons.search_rounded, onTap: () => context.go('/search')),
                      const SizedBox(width: 12),
                      Stack(
                        children: [
                          _IconButton(icon: Icons.notifications_outlined, onTap: () => context.push('/notifications')),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 300.ms),

                const SizedBox(height: 24),

                // Hero text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Travel Made\nEffortless', style: AppTypography.heading1),
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0, duration: 400.ms),

                const SizedBox(height: 24),

                // Category icons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CategoryIcons(
                    onCategoryTap: (mode) => context.go('/search'),
                  ),
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                const SizedBox(height: 32),

                // Upcoming Schedules
                SectionHeader(title: 'Upcoming Schedules', onViewAll: () {}),
                const SizedBox(height: 12),
                schedules.when(
                  data: (data) => SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: data.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) => UpcomingScheduleCard(
                        schedule: data[index],
                        onTap: () => context.push('/eticket'),
                      ).animate().fadeIn(delay: (100 * index).ms, duration: 300.ms)
                          .slideX(begin: 0.2, end: 0, delay: (100 * index).ms, duration: 300.ms),
                    ),
                  ),
                  loading: () => SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: 2,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, __) => const SkeletonCard(height: 200),
                    ),
                  ),
                  error: (e, _) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Error loading schedules', style: AppTypography.bodySmall),
                  ),
                ),

                const SizedBox(height: 32),

                // Recommendations
                SectionHeader(title: 'Recommendations', onViewAll: () {}),
                const SizedBox(height: 12),
                destinations.when(
                  data: (data) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.3,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) => DestinationCard(destination: data[index])
                          .animate()
                          .fadeIn(delay: (100 * index).ms, duration: 300.ms)
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            end: const Offset(1, 1),
                            delay: (100 * index).ms,
                            duration: 300.ms,
                          ),
                    ),
                  ),
                  loading: () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.3,
                      ),
                      itemCount: 4,
                      itemBuilder: (_, __) => const SkeletonCard(height: 140),
                    ),
                  ),
                  error: (e, _) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Error loading destinations', style: AppTypography.bodySmall),
                  ),
                ),

                const SizedBox(height: 32),

                // Vouchers
                SectionHeader(title: 'Vouchers', onViewAll: () {}),
                const SizedBox(height: 12),
                VoucherCarousel(vouchers: vouchers)
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 400.ms),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/chat'),
        backgroundColor: AppColors.deepPurple,
        child: const Icon(Icons.chat_rounded, color: Colors.white),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
          ],
        ),
        child: Icon(icon, color: AppColors.deepPurple, size: 20),
      ),
    );
  }
}
```

- [ ] **Step 7: Commit**

```bash
git add -A
git commit -m "feat: add home dashboard with categories, schedules, destinations, vouchers"
```

---

## Phase 4: Search & Results

### Task 11: Create Search models and mock repository

**Files:**
- Create: `flyone/lib/features/search/domain/models/search_query.dart`
- Create: `flyone/lib/features/search/domain/models/search_result.dart`
- Create: `flyone/lib/features/search/data/search_repository.dart`
- Create: `flyone/lib/features/search/data/mock_search_repository.dart`
- Create: `flyone/lib/features/search/domain/search_provider.dart`

- [ ] **Step 1: Create search_query.dart**

```dart
class SearchQuery {
  final String from;
  final String to;
  final String fromCode;
  final String toCode;
  final DateTime date;
  final int passengers;
  final String travelClass;
  final bool isRoundTrip;
  final String transportMode;

  const SearchQuery({
    required this.from,
    required this.to,
    required this.fromCode,
    required this.toCode,
    required this.date,
    this.passengers = 1,
    this.travelClass = 'Economy',
    this.isRoundTrip = false,
    this.transportMode = 'all',
  });
}
```

- [ ] **Step 2: Create search_result.dart**

```dart
class SearchResult {
  final String id;
  final String carrierName;
  final String carrierLogo;
  final String travelClass;
  final String departureCode;
  final String arrivalCode;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final double rating;
  final double pricePerPax;
  final String currency;
  final bool canReschedule;
  final String transportMode;
  final bool isFavorite;

  const SearchResult({
    required this.id,
    required this.carrierName,
    required this.carrierLogo,
    required this.travelClass,
    required this.departureCode,
    required this.arrivalCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.rating,
    required this.pricePerPax,
    this.currency = '\$',
    this.canReschedule = true,
    required this.transportMode,
    this.isFavorite = false,
  });

  SearchResult copyWith({bool? isFavorite}) {
    return SearchResult(
      id: id,
      carrierName: carrierName,
      carrierLogo: carrierLogo,
      travelClass: travelClass,
      departureCode: departureCode,
      arrivalCode: arrivalCode,
      departureTime: departureTime,
      arrivalTime: arrivalTime,
      duration: duration,
      rating: rating,
      pricePerPax: pricePerPax,
      currency: currency,
      canReschedule: canReschedule,
      transportMode: transportMode,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
```

- [ ] **Step 3: Create search_repository.dart**

```dart
import '../../../core/utils/result.dart';
import '../domain/models/search_result.dart';
import '../domain/models/search_query.dart';

abstract class SearchRepository {
  Future<Result<List<SearchResult>>> search(SearchQuery query);
}
```

- [ ] **Step 4: Create mock_search_repository.dart**

```dart
import '../../../core/utils/result.dart';
import '../domain/models/search_query.dart';
import '../domain/models/search_result.dart';
import 'search_repository.dart';

class MockSearchRepository implements SearchRepository {
  @override
  Future<Result<List<SearchResult>>> search(SearchQuery query) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return Success([
      SearchResult(
        id: '1', carrierName: 'Whoosh', carrierLogo: '🚄',
        travelClass: 'Business', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '06:40', arrivalTime: '07:30', duration: '1hr 50min',
        rating: 4.6, pricePerPax: 81, transportMode: 'train',
      ),
      SearchResult(
        id: '2', carrierName: 'KAI', carrierLogo: '🚄',
        travelClass: 'Economy', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '13:10', arrivalTime: '16:12', duration: '3hr 2min',
        rating: 4.4, pricePerPax: 89, transportMode: 'train',
      ),
      SearchResult(
        id: '3', carrierName: 'Whoosh', carrierLogo: '🚄',
        travelClass: 'Business', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '09:00', arrivalTime: '09:55', duration: '1hr 30min',
        rating: 4.7, pricePerPax: 95, transportMode: 'train',
      ),
      SearchResult(
        id: '4', carrierName: 'Garuda Indonesia', carrierLogo: '✈️',
        travelClass: 'Economy', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '07:15', arrivalTime: '08:25', duration: '1hr 10min',
        rating: 4.5, pricePerPax: 120, transportMode: 'flight',
      ),
      SearchResult(
        id: '5', carrierName: 'Lion Air', carrierLogo: '✈️',
        travelClass: 'Economy', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '14:30', arrivalTime: '15:35', duration: '1hr 5min',
        rating: 4.1, pricePerPax: 75, transportMode: 'flight',
      ),
      SearchResult(
        id: '6', carrierName: 'Pelni Ferry', carrierLogo: '⛴️',
        travelClass: 'Economy', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '08:00', arrivalTime: '14:00', duration: '6hr',
        rating: 3.9, pricePerPax: 45, canReschedule: false, transportMode: 'boat',
      ),
      SearchResult(
        id: '7', carrierName: 'TransJava Bus', carrierLogo: '🚌',
        travelClass: 'Economy', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '22:00', arrivalTime: '06:00', duration: '8hr',
        rating: 4.0, pricePerPax: 35, transportMode: 'bus',
      ),
    ]);
  }
}
```

- [ ] **Step 5: Create search_provider.dart**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/search_repository.dart';
import '../data/mock_search_repository.dart';
import 'models/search_query.dart';
import 'models/search_result.dart';

final searchRepositoryProvider = Provider<SearchRepository>(
  (ref) => MockSearchRepository(),
);

final searchQueryProvider = StateProvider<SearchQuery?>((ref) => null);

final searchResultsProvider = FutureProvider<List<SearchResult>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query == null) return [];
  final repo = ref.read(searchRepositoryProvider);
  final result = await repo.search(query);
  return switch (result) {
    Success(:final data) => data,
    Failure(:final message) => throw Exception(message),
  };
});

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>(
  (ref) => FavoritesNotifier(),
);

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({});

  void toggle(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }
}
```

- [ ] **Step 6: Commit**

```bash
git add -A
git commit -m "feat: add search models, mock repository, and providers"
```

---

### Task 12: Build Search screen

**Files:**
- Create: `flyone/lib/features/search/presentation/search_screen.dart`
- Create: `flyone/lib/features/search/presentation/widgets/trip_type_toggle.dart`
- Create: `flyone/lib/features/search/presentation/widgets/location_selector.dart`
- Create: `flyone/lib/features/search/presentation/widgets/date_picker_field.dart`
- Create: `flyone/lib/features/search/presentation/widgets/passenger_class_selector.dart`

- [ ] **Step 1: Create trip_type_toggle.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class TripTypeToggle extends StatelessWidget {
  final bool isRoundTrip;
  final ValueChanged<bool> onChanged;

  const TripTypeToggle({super.key, required this.isRoundTrip, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.softWhite,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Row(
        children: [
          _ToggleItem(label: 'One Way', isActive: !isRoundTrip, onTap: () => onChanged(false)),
          _ToggleItem(label: 'Round Trip', isActive: isRoundTrip, onTap: () => onChanged(true)),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ToggleItem({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.deepPurple : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTypography.buttonSmall.copyWith(
                color: isActive ? Colors.white : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Create location_selector.dart**

```dart
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
            .rotate(begin: 0, end: 0, duration: 1.ms), // ready for swap trigger
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
```

- [ ] **Step 3: Create date_picker_field.dart**

```dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class DatePickerField extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const DatePickerField({super.key, required this.selectedDate, required this.onDateChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.deepPurple,
                onPrimary: Colors.white,
                surface: AppColors.softWhite,
              ),
            ),
            child: child!,
          ),
        );
        if (picked != null) onDateChanged(picked);
      },
      child: Row(
        children: [
          const Icon(Icons.calendar_today_rounded, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Date', style: AppTypography.caption),
              Text(
                DateFormat('d MMMM yyyy').format(selectedDate),
                style: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: Create passenger_class_selector.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PassengerClassSelector extends StatelessWidget {
  final int passengers;
  final String travelClass;
  final ValueChanged<int> onPassengersChanged;
  final ValueChanged<String> onClassChanged;

  const PassengerClassSelector({
    super.key,
    required this.passengers,
    required this.travelClass,
    required this.onPassengersChanged,
    required this.onClassChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPicker(context),
      child: Row(
        children: [
          const Icon(Icons.person_rounded, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Passenger', style: AppTypography.caption),
              Text(
                '$passengers Passenger${passengers > 1 ? 's' : ''}, $travelClass',
                style: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPicker(BuildContext context) {
    int tempPassengers = passengers;
    String tempClass = travelClass;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Passengers & Class', style: AppTypography.heading3),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Passengers', style: AppTypography.body),
                  Row(
                    children: [
                      IconButton(
                        onPressed: tempPassengers > 1
                            ? () => setModalState(() => tempPassengers--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                        color: AppColors.deepPurple,
                      ),
                      Text('$tempPassengers', style: AppTypography.heading3),
                      IconButton(
                        onPressed: tempPassengers < 9
                            ? () => setModalState(() => tempPassengers++)
                            : null,
                        icon: const Icon(Icons.add_circle_outline),
                        color: AppColors.deepPurple,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('Class', style: AppTypography.body),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['Economy', 'Business', 'First'].map((c) {
                  final isSelected = c == tempClass;
                  return ChoiceChip(
                    label: Text(c),
                    selected: isSelected,
                    selectedColor: AppColors.lightLilac,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.deepPurple : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    onSelected: (_) => setModalState(() => tempClass = c),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onPassengersChanged(tempPassengers);
                    onClassChanged(tempClass);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: Text('Confirm', style: AppTypography.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 5: Create search_screen.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../core/widgets/section_header.dart';
import '../domain/models/search_query.dart';
import '../domain/search_provider.dart';
import '../../home/domain/home_provider.dart';
import '../../home/presentation/widgets/voucher_carousel.dart';
import 'widgets/trip_type_toggle.dart';
import 'widgets/location_selector.dart';
import 'widgets/date_picker_field.dart';
import 'widgets/passenger_class_selector.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  bool _isRoundTrip = false;
  String _from = 'Jakarta';
  String _to = 'Bandung';
  String _fromCode = 'JKT';
  String _toCode = 'BDG';
  DateTime _date = DateTime.now().add(const Duration(days: 7));
  int _passengers = 1;
  String _travelClass = 'Business';

  void _swapLocations() {
    setState(() {
      final tempName = _from;
      final tempCode = _fromCode;
      _from = _to;
      _fromCode = _toCode;
      _to = tempName;
      _toCode = tempCode;
    });
  }

  void _search() {
    ref.read(searchQueryProvider.notifier).state = SearchQuery(
      from: _from,
      to: _to,
      fromCode: _fromCode,
      toCode: _toCode,
      date: _date,
      passengers: _passengers,
      travelClass: _travelClass,
      isRoundTrip: _isRoundTrip,
    );
    context.push('/search-results');
  }

  @override
  Widget build(BuildContext context) {
    final vouchers = ref.watch(vouchersProvider);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with illustration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
              decoration: BoxDecoration(
                color: AppColors.lightLilac.withValues(alpha: 0.3),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  // Back button + grid icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.go('/home'),
                        child: Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.arrow_back, size: 20, color: AppColors.deepPurple),
                        ),
                      ),
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.grid_view_rounded, size: 20, color: AppColors.deepPurple),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Illustration placeholder
                  Container(
                    width: 200, height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.teal.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.train_rounded, size: 60, color: AppColors.teal),
                  ),
                  const SizedBox(height: 16),
                  Text('Find Your\nBest Trip',
                    style: AppTypography.heading1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),

            // Search form
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    TripTypeToggle(isRoundTrip: _isRoundTrip, onChanged: (v) => setState(() => _isRoundTrip = v)),
                    const SizedBox(height: 24),
                    LocationSelector(from: _from, to: _to, onSwap: _swapLocations),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: AppColors.divider),
                    ),
                    DatePickerField(selectedDate: _date, onDateChanged: (d) => setState(() => _date = d)),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: AppColors.divider),
                    ),
                    PassengerClassSelector(
                      passengers: _passengers,
                      travelClass: _travelClass,
                      onPassengersChanged: (v) => setState(() => _passengers = v),
                      onClassChanged: (v) => setState(() => _travelClass = v),
                    ),
                    const SizedBox(height: 24),
                    PillButton(
                      label: 'Search',
                      onPressed: _search,
                      width: double.infinity,
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0, delay: 200.ms, duration: 400.ms),
            ),

            // Vouchers section
            SectionHeader(title: 'Vouchers', onViewAll: () {}),
            const SizedBox(height: 12),
            VoucherCarousel(vouchers: vouchers),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 6: Commit**

```bash
git add -A
git commit -m "feat: add search screen with trip type, location selector, date picker, passengers"
```

---

### Task 13: Build Search Results screen

**Files:**
- Create: `flyone/lib/features/search/presentation/search_results_screen.dart`
- Create: `flyone/lib/features/search/presentation/widgets/route_card.dart`
- Create: `flyone/lib/features/search/presentation/widgets/filter_sort_bar.dart`

- [ ] **Step 1: Create filter_sort_bar.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class FilterSortBar extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const FilterSortBar({super.key, required this.selectedFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    final filters = ['Best', 'Price', 'Duration', 'Rating', 'Departure'];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isActive = filter == selectedFilter;
          return GestureDetector(
            onTap: () => onFilterChanged(filter),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? AppColors.deepPurple : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isActive ? AppColors.deepPurple : AppColors.divider,
                ),
              ),
              child: Text(
                filter,
                style: AppTypography.caption.copyWith(
                  color: isActive ? Colors.white : AppColors.textSecondary,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
```

- [ ] **Step 2: Create route_card.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/rating_stars.dart';
import '../../domain/models/search_result.dart';

class RouteCard extends StatelessWidget {
  final SearchResult result;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onBookmarkTap;
  final VoidCallback onTap;

  const RouteCard({
    super.key,
    required this.result,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onBookmarkTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            // Carrier row
            Row(
              children: [
                Text(result.carrierLogo, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(result.travelClass, style: AppTypography.caption),
                      Text(result.carrierName, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onFavoriteTap,
                  child: Icon(
                    isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: isFavorite ? AppColors.error : AppColors.textSecondary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: onBookmarkTap,
                  child: const Icon(Icons.bookmark_border_rounded, color: AppColors.textSecondary, size: 22),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Route row
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(result.departureCode, style: AppTypography.heading3),
                    Text(result.departureTime, style: AppTypography.caption),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(result.duration, style: AppTypography.caption),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(height: 1.5, color: AppColors.divider),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(width: 6, height: 6,
                                      decoration: const BoxDecoration(color: AppColors.deepPurple, shape: BoxShape.circle)),
                                    Icon(
                                      result.transportMode == 'flight'
                                          ? Icons.flight_rounded
                                          : result.transportMode == 'train'
                                              ? Icons.train_rounded
                                              : result.transportMode == 'boat'
                                                  ? Icons.sailing_rounded
                                                  : Icons.directions_bus_rounded,
                                      size: 16,
                                      color: AppColors.teal,
                                    ),
                                    Container(width: 6, height: 6,
                                      decoration: const BoxDecoration(color: AppColors.teal, shape: BoxShape.circle)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(result.arrivalCode, style: AppTypography.heading3),
                    Text(result.arrivalTime, style: AppTypography.caption),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Footer row
            Row(
              children: [
                RatingStars(rating: result.rating),
                const SizedBox(width: 12),
                if (result.canReschedule)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.teal.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Ability to reschedule',
                      style: AppTypography.caption.copyWith(color: AppColors.teal, fontWeight: FontWeight.w500),
                    ),
                  ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${result.currency} ${result.pricePerPax.toInt()}/pax',
                    style: AppTypography.buttonSmall.copyWith(fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Create search_results_screen.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../domain/search_provider.dart';
import 'widgets/route_card.dart';
import 'widgets/filter_sort_bar.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  ConsumerState<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  String _selectedFilter = 'Best';

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final results = ref.watch(searchResultsProvider);
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back, color: AppColors.deepPurple),
                  ),
                  const Spacer(),
                  const Icon(Icons.share_rounded, color: AppColors.deepPurple, size: 22),
                  const SizedBox(width: 16),
                  const Icon(Icons.more_horiz_rounded, color: AppColors.deepPurple, size: 22),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Search Results', style: AppTypography.heading1),
            ),
            if (query != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: results.when(
                  data: (data) => RichText(
                    text: TextSpan(
                      style: AppTypography.bodySmall,
                      children: [
                        const TextSpan(text: 'There are '),
                        TextSpan(
                          text: '${data.length} search results',
                          style: AppTypography.bodySmall.copyWith(color: AppColors.teal, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: ' from\n${query.from} to ${query.to}'),
                      ],
                    ),
                  ),
                  loading: () => Text('Searching...', style: AppTypography.bodySmall),
                  error: (_, __) => Text('Error', style: AppTypography.bodySmall),
                ),
              ),
              const SizedBox(height: 12),
              // Route summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.lightLilac.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(query.from, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.swap_horiz_rounded, size: 18, color: AppColors.teal),
                      ),
                      Text(query.to, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            FilterSortBar(
              selectedFilter: _selectedFilter,
              onFilterChanged: (f) => setState(() => _selectedFilter = f),
            ),
            const SizedBox(height: 12),
            // Results list
            Expanded(
              child: results.when(
                data: (data) => ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: data.length,
                  itemBuilder: (context, index) => RouteCard(
                    result: data[index],
                    isFavorite: favorites.contains(data[index].id),
                    onFavoriteTap: () => ref.read(favoritesProvider.notifier).toggle(data[index].id),
                    onBookmarkTap: () {},
                    onTap: () => context.push('/booking-detail'),
                  ).animate().fadeIn(delay: (80 * index).ms, duration: 300.ms)
                      .slideY(begin: 0.1, end: 0, delay: (80 * index).ms, duration: 300.ms),
                ),
                loading: () => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 4,
                  itemBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: SkeletonCard(height: 160),
                  ),
                ),
                error: (e, _) => Center(child: Text('Error: $e', style: AppTypography.bodySmall)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Commit**

```bash
git add -A
git commit -m "feat: add search results with route cards, filter bar, favorites"
```

---

## Phase 5: Booking & Payment

### Task 14: Build Booking Detail screen

**Files:**
- Create: `flyone/lib/features/booking/domain/models/booking.dart`
- Create: `flyone/lib/features/booking/data/booking_repository.dart`
- Create: `flyone/lib/features/booking/data/mock_booking_repository.dart`
- Create: `flyone/lib/features/booking/domain/booking_provider.dart`
- Create: `flyone/lib/features/booking/presentation/booking_detail_screen.dart`
- Create: `flyone/lib/features/booking/presentation/widgets/passenger_form.dart`
- Create: `flyone/lib/features/booking/presentation/widgets/seat_selection.dart`
- Create: `flyone/lib/features/booking/presentation/widgets/addons_section.dart`
- Create: `flyone/lib/features/booking/presentation/widgets/promo_code_field.dart`
- Create: `flyone/lib/features/booking/presentation/widgets/price_breakdown.dart`

- [ ] **Step 1: Create booking.dart model**

```dart
class Booking {
  final String id;
  final String carrierName;
  final String departureCode;
  final String arrivalCode;
  final String departureTime;
  final String arrivalTime;
  final String date;
  final String travelClass;
  final double basePrice;
  final List<Addon> addons;
  final String? promoCode;
  final double discount;
  final List<Passenger> passengers;
  final String? selectedSeat;

  const Booking({
    required this.id,
    required this.carrierName,
    required this.departureCode,
    required this.arrivalCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.date,
    required this.travelClass,
    required this.basePrice,
    this.addons = const [],
    this.promoCode,
    this.discount = 0,
    this.passengers = const [],
    this.selectedSeat,
  });

  double get totalPrice {
    final addonsTotal = addons.where((a) => a.isSelected).fold(0.0, (sum, a) => sum + a.price);
    return (basePrice + addonsTotal) * (passengers.isEmpty ? 1 : passengers.length) - discount;
  }
}

class Passenger {
  final String name;
  final String email;
  final String phone;

  const Passenger({required this.name, required this.email, required this.phone});
}

class Addon {
  final String id;
  final String name;
  final String description;
  final double price;
  final IconType iconType;
  final bool isSelected;

  const Addon({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.iconType,
    this.isSelected = false,
  });

  Addon copyWith({bool? isSelected}) => Addon(
    id: id, name: name, description: description,
    price: price, iconType: iconType,
    isSelected: isSelected ?? this.isSelected,
  );
}

enum IconType { baggage, meal, insurance, lounge }
```

- [ ] **Step 2: Create booking_repository.dart and mock**

```dart
// booking_repository.dart
import '../../../core/utils/result.dart';
import '../domain/models/booking.dart';

abstract class BookingRepository {
  Future<Result<Booking>> createBooking(Booking booking);
  List<Addon> getAvailableAddons();
  List<List<int>> getSeatMap();
}
```

```dart
// mock_booking_repository.dart
import '../../../core/utils/result.dart';
import '../domain/models/booking.dart';
import 'booking_repository.dart';

class MockBookingRepository implements BookingRepository {
  @override
  Future<Result<Booking>> createBooking(Booking booking) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Success(booking);
  }

  @override
  List<Addon> getAvailableAddons() => const [
    Addon(id: '1', name: 'Extra Baggage', description: '20kg additional', price: 25, iconType: IconType.baggage),
    Addon(id: '2', name: 'In-flight Meal', description: 'Premium meal set', price: 15, iconType: IconType.meal),
    Addon(id: '3', name: 'Travel Insurance', description: 'Full coverage', price: 12, iconType: IconType.insurance),
    Addon(id: '4', name: 'Lounge Access', description: 'Airport lounge', price: 35, iconType: IconType.lounge),
  ];

  @override
  List<List<int>> getSeatMap() => [
    // 0 = available, 1 = occupied, 2 = premium
    [0, 0, 2, 2, 0, 0],
    [0, 1, 0, 0, 1, 0],
    [0, 0, 0, 0, 0, 0],
    [1, 1, 0, 0, 0, 0],
    [0, 0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0, 0],
    [0, 0, 1, 1, 0, 0],
    [0, 0, 0, 0, 0, 0],
  ];
}
```

- [ ] **Step 3: Create booking_provider.dart**

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/booking_repository.dart';
import '../data/mock_booking_repository.dart';
import 'models/booking.dart';

final bookingRepositoryProvider = Provider<BookingRepository>(
  (ref) => MockBookingRepository(),
);

final addonsProvider = StateNotifierProvider<AddonsNotifier, List<Addon>>((ref) {
  final repo = ref.read(bookingRepositoryProvider);
  return AddonsNotifier(repo.getAvailableAddons());
});

class AddonsNotifier extends StateNotifier<List<Addon>> {
  AddonsNotifier(super.addons);

  void toggle(String id) {
    state = state.map((a) => a.id == id ? a.copyWith(isSelected: !a.isSelected) : a).toList();
  }
}

final selectedSeatProvider = StateProvider<String?>((ref) => null);
final promoCodeProvider = StateProvider<String?>((ref) => null);
final promoDiscountProvider = StateProvider<double>((ref) => 0);
```

- [ ] **Step 4: Create passenger_form.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PassengerForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const PassengerForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Passenger Details', style: AppTypography.heading3),
        const SizedBox(height: 16),
        _buildField('Full Name', nameController, Icons.person_rounded),
        const SizedBox(height: 12),
        _buildField('Email', emailController, Icons.email_rounded),
        const SizedBox(height: 12),
        _buildField('Phone', phoneController, Icons.phone_rounded),
      ],
    );
  }

  Widget _buildField(String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: AppTypography.bodySmall,
        prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
      ),
    );
  }
}
```

- [ ] **Step 5: Create seat_selection.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class SeatSelection extends StatelessWidget {
  final List<List<int>> seatMap;
  final String? selectedSeat;
  final ValueChanged<String> onSeatSelected;

  const SeatSelection({
    super.key,
    required this.seatMap,
    this.selectedSeat,
    required this.onSeatSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Seat', style: AppTypography.heading3),
        const SizedBox(height: 12),
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Legend(color: AppColors.lightLilac.withValues(alpha: 0.5), label: 'Available'),
            _Legend(color: AppColors.textSecondary.withValues(alpha: 0.3), label: 'Occupied'),
            _Legend(color: AppColors.teal.withValues(alpha: 0.3), label: 'Premium'),
            _Legend(color: AppColors.deepPurple, label: 'Selected'),
          ],
        ),
        const SizedBox(height: 16),
        // Seat grid
        Center(
          child: Column(
            children: List.generate(seatMap.length, (row) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(3, (col) => _SeatWidget(
                      seatId: '${String.fromCharCode(65 + row)}${col + 1}',
                      status: seatMap[row][col],
                      isSelected: selectedSeat == '${String.fromCharCode(65 + row)}${col + 1}',
                      onTap: seatMap[row][col] != 1
                          ? () => onSeatSelected('${String.fromCharCode(65 + row)}${col + 1}')
                          : null,
                    )),
                    const SizedBox(width: 24),
                    ...List.generate(3, (col) => _SeatWidget(
                      seatId: '${String.fromCharCode(65 + row)}${col + 4}',
                      status: seatMap[row][col + 3],
                      isSelected: selectedSeat == '${String.fromCharCode(65 + row)}${col + 4}',
                      onTap: seatMap[row][col + 3] != 1
                          ? () => onSeatSelected('${String.fromCharCode(65 + row)}${col + 4}')
                          : null,
                    )),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _SeatWidget extends StatelessWidget {
  final String seatId;
  final int status;
  final bool isSelected;
  final VoidCallback? onTap;

  const _SeatWidget({required this.seatId, required this.status, required this.isSelected, this.onTap});

  Color get _color {
    if (isSelected) return AppColors.deepPurple;
    return switch (status) {
      0 => AppColors.lightLilac.withValues(alpha: 0.5),
      1 => AppColors.textSecondary.withValues(alpha: 0.3),
      2 => AppColors.teal.withValues(alpha: 0.3),
      _ => AppColors.lightLilac,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36, height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            seatId,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 14, height: 14, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}
```

- [ ] **Step 6: Create addons_section.dart**

```dart
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
```

- [ ] **Step 7: Create promo_code_field.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PromoCodeField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onApply;
  final bool isApplied;

  const PromoCodeField({
    super.key,
    required this.controller,
    required this.onApply,
    this.isApplied = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter promo code',
              hintStyle: AppTypography.bodySmall,
              prefixIcon: const Icon(Icons.local_offer_rounded, color: AppColors.textSecondary, size: 20),
              suffixIcon: isApplied
                  ? const Icon(Icons.check_circle, color: AppColors.success, size: 20)
                  : null,
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: onApply,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.teal,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text('Apply', style: AppTypography.buttonSmall),
        ),
      ],
    );
  }
}
```

- [ ] **Step 8: Create price_breakdown.dart**

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PriceBreakdown extends StatelessWidget {
  final double basePrice;
  final double addonsTotal;
  final double discount;
  final int passengers;

  const PriceBreakdown({
    super.key,
    required this.basePrice,
    required this.addonsTotal,
    required this.discount,
    required this.passengers,
  });

  double get total => (basePrice + addonsTotal) * passengers - discount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightLilac.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _Row('Base fare', '\$${basePrice.toInt()} x $passengers'),
          if (addonsTotal > 0) _Row('Add-ons', '\$${addonsTotal.toInt()}'),
          if (discount > 0) _Row('Discount', '-\$${discount.toInt()}', isDiscount: true),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(color: AppColors.divider),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: AppTypography.heading3),
              Text('\$${total.toInt()}', style: AppTypography.heading2.copyWith(color: AppColors.deepPurple)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String label;
  final String value;
  final bool isDiscount;

  const _Row(this.label, this.value, {this.isDiscount = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodySmall),
          Text(value, style: AppTypography.bodySmall.copyWith(
            color: isDiscount ? AppColors.success : AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          )),
        ],
      ),
    );
  }
}
```

- [ ] **Step 9: Create booking_detail_screen.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../core/widgets/toast_notification.dart';
import '../domain/booking_provider.dart';
import 'widgets/passenger_form.dart';
import 'widgets/seat_selection.dart';
import 'widgets/addons_section.dart';
import 'widgets/promo_code_field.dart';
import 'widgets/price_breakdown.dart';

class BookingDetailScreen extends ConsumerStatefulWidget {
  const BookingDetailScreen({super.key});

  @override
  ConsumerState<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends ConsumerState<BookingDetailScreen> {
  final _nameController = TextEditingController(text: 'Mejba Ahmed');
  final _emailController = TextEditingController(text: 'mejba@email.com');
  final _phoneController = TextEditingController(text: '+62 812 3456 7890');
  final _promoController = TextEditingController();
  bool _promoApplied = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addons = ref.watch(addonsProvider);
    final selectedSeat = ref.watch(selectedSeatProvider);
    final repo = ref.read(bookingRepositoryProvider);
    final seatMap = repo.getSeatMap();
    final discount = ref.watch(promoDiscountProvider);

    final addonsTotal = addons.where((a) => a.isSelected).fold(0.0, (s, a) => s + a.price);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Booking Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Route summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightLilac.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('JKT', style: AppTypography.heading2),
                      Text('06:40', style: AppTypography.caption),
                    ],
                  ),
                  Column(
                    children: [
                      Text('1hr 50min', style: AppTypography.caption),
                      const Icon(Icons.flight_rounded, color: AppColors.teal),
                    ],
                  ),
                  Column(
                    children: [
                      Text('BDG', style: AppTypography.heading2),
                      Text('08:30', style: AppTypography.caption),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),

            const SizedBox(height: 24),
            PassengerForm(
              nameController: _nameController,
              emailController: _emailController,
              phoneController: _phoneController,
            ).animate().fadeIn(delay: 100.ms, duration: 300.ms),

            const SizedBox(height: 24),
            SeatSelection(
              seatMap: seatMap,
              selectedSeat: selectedSeat,
              onSeatSelected: (s) => ref.read(selectedSeatProvider.notifier).state = s,
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms),

            const SizedBox(height: 24),
            AddonsSection(
              addons: addons,
              onToggle: (id) => ref.read(addonsProvider.notifier).toggle(id),
            ).animate().fadeIn(delay: 300.ms, duration: 300.ms),

            const SizedBox(height: 24),
            PromoCodeField(
              controller: _promoController,
              isApplied: _promoApplied,
              onApply: () {
                if (_promoController.text.toUpperCase() == 'WELCOME30') {
                  ref.read(promoDiscountProvider.notifier).state = 24.3;
                  setState(() => _promoApplied = true);
                  ToastNotification.show(context, message: 'Promo applied! -\$24', type: ToastType.success);
                } else {
                  ToastNotification.show(context, message: 'Invalid promo code', type: ToastType.error);
                }
              },
            ).animate().fadeIn(delay: 400.ms, duration: 300.ms),

            const SizedBox(height: 24),
            PriceBreakdown(
              basePrice: 81,
              addonsTotal: addonsTotal,
              discount: discount,
              passengers: 1,
            ).animate().fadeIn(delay: 500.ms, duration: 300.ms),

            const SizedBox(height: 24),
            PillButton(
              label: 'Continue to Payment',
              onPressed: () => context.push('/payment'),
              width: double.infinity,
            ).animate().fadeIn(delay: 600.ms, duration: 300.ms),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 10: Commit**

```bash
git add -A
git commit -m "feat: add booking detail with passenger form, seat map, addons, promo, price"
```

---

### Task 15: Build Payment screen

**Files:**
- Create: `flyone/lib/features/payment/domain/models/payment_method.dart`
- Create: `flyone/lib/features/payment/data/payment_repository.dart`
- Create: `flyone/lib/features/payment/data/mock_payment_repository.dart`
- Create: `flyone/lib/features/payment/domain/payment_provider.dart`
- Create: `flyone/lib/features/payment/presentation/payment_screen.dart`
- Create: `flyone/lib/features/payment/presentation/widgets/payment_method_card.dart`
- Create: `flyone/lib/features/payment/presentation/widgets/add_card_form.dart`
- Create: `flyone/lib/features/payment/presentation/widgets/wallet_balance.dart`

- [ ] **Step 1: Create payment models, repository, provider, and screen**

`payment_method.dart`:
```dart
class PaymentMethod {
  final String id;
  final String type;
  final String name;
  final String lastFour;
  final String brand;
  final bool isDefault;

  const PaymentMethod({
    required this.id,
    required this.type,
    required this.name,
    required this.lastFour,
    required this.brand,
    this.isDefault = false,
  });
}
```

`payment_repository.dart`:
```dart
import '../../../core/utils/result.dart';

abstract class PaymentRepository {
  Future<Result<String>> processPayment(String methodId, double amount);
  double getWalletBalance();
}
```

`mock_payment_repository.dart`:
```dart
import '../../../core/utils/result.dart';
import 'payment_repository.dart';

class MockPaymentRepository implements PaymentRepository {
  @override
  Future<Result<String>> processPayment(String methodId, double amount) async {
    await Future.delayed(const Duration(seconds: 1));
    return const Success('TXN-FLY-2024-001');
  }

  @override
  double getWalletBalance() => 150.0;
}
```

`payment_provider.dart`:
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/payment_repository.dart';
import '../data/mock_payment_repository.dart';
import 'models/payment_method.dart';

final paymentRepositoryProvider = Provider<PaymentRepository>(
  (ref) => MockPaymentRepository(),
);

final paymentMethodsProvider = Provider<List<PaymentMethod>>((ref) => const [
  PaymentMethod(id: '1', type: 'card', name: 'Visa', lastFour: '4242', brand: 'Visa', isDefault: true),
  PaymentMethod(id: '2', type: 'card', name: 'Mastercard', lastFour: '8888', brand: 'Mastercard'),
  PaymentMethod(id: '3', type: 'card', name: 'AMEX', lastFour: '1234', brand: 'AMEX'),
]);

final selectedPaymentMethodProvider = StateProvider<String>((ref) => '1');

final walletBalanceProvider = Provider<double>((ref) {
  return ref.read(paymentRepositoryProvider).getWalletBalance();
});
```

- [ ] **Step 2: Create payment widgets**

`payment_method_card.dart`:
```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/payment_method.dart';

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({super.key, required this.method, required this.isSelected, required this.onTap});

  IconData get _brandIcon => switch (method.brand) {
    'Visa' => Icons.credit_card,
    'Mastercard' => Icons.credit_card,
    _ => Icons.credit_card,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightLilac.withValues(alpha: 0.3) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? AppColors.deepPurple : AppColors.divider),
        ),
        child: Row(
          children: [
            Icon(_brandIcon, color: AppColors.deepPurple, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(method.brand, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                  Text('•••• ${method.lastFour}', style: AppTypography.caption),
                ],
              ),
            ),
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onTap(),
              activeColor: AppColors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }
}
```

`wallet_balance.dart`:
```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class WalletBalance extends StatelessWidget {
  final double balance;

  const WalletBalance({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.deepPurple, Color(0xFF4A3F7A)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Flyone Wallet', style: AppTypography.bodySmall.copyWith(color: Colors.white70)),
                Text('\$${balance.toStringAsFixed(2)}', style: AppTypography.heading3.copyWith(color: Colors.white)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Top Up', style: AppTypography.buttonSmall.copyWith(color: AppColors.teal)),
          ),
        ],
      ),
    );
  }
}
```

`add_card_form.dart`:
```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AddCardForm extends StatelessWidget {
  const AddCardForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add New Card', style: AppTypography.heading3),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: 'Card Number', prefixIcon: Icon(Icons.credit_card))),
          const SizedBox(height: 12),
          Row(
            children: [
              const Expanded(child: TextField(decoration: InputDecoration(labelText: 'Expiry', hintText: 'MM/YY'))),
              const SizedBox(width: 12),
              const Expanded(child: TextField(decoration: InputDecoration(labelText: 'CVV'), obscureText: true)),
            ],
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Create payment_screen.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../core/widgets/toast_notification.dart';
import '../domain/payment_provider.dart';
import 'widgets/payment_method_card.dart';
import 'widgets/wallet_balance.dart';
import 'widgets/add_card_form.dart';

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methods = ref.watch(paymentMethodsProvider);
    final selected = ref.watch(selectedPaymentMethodProvider);
    final balance = ref.watch(walletBalanceProvider);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WalletBalance(balance: balance).animate().fadeIn(duration: 300.ms),
            const SizedBox(height: 24),
            Text('Payment Methods', style: AppTypography.heading3),
            const SizedBox(height: 12),
            ...methods.asMap().entries.map((entry) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: PaymentMethodCard(
                method: entry.value,
                isSelected: entry.value.id == selected,
                onTap: () => ref.read(selectedPaymentMethodProvider.notifier).state = entry.value.id,
              ).animate().fadeIn(delay: (100 * entry.key).ms, duration: 300.ms),
            )),
            const SizedBox(height: 16),
            const AddCardForm().animate().fadeIn(delay: 400.ms, duration: 300.ms),
            const SizedBox(height: 16),
            // BNPL option
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  const Icon(Icons.schedule_rounded, color: AppColors.teal),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Buy Now, Pay Later', style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                        Text('Split into 3 monthly payments', style: AppTypography.caption),
                      ],
                    ),
                  ),
                  Switch(value: false, onChanged: (_) {}, activeColor: AppColors.teal),
                ],
              ),
            ).animate().fadeIn(delay: 500.ms, duration: 300.ms),
            const SizedBox(height: 24),
            // Order summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.lightLilac.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _SummaryRow('Subtotal', '\$81'),
                  _SummaryRow('Add-ons', '\$25'),
                  _SummaryRow('Discount', '-\$24', isDiscount: true),
                  const Divider(color: AppColors.divider),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTypography.heading3),
                      Text('\$82', style: AppTypography.heading2.copyWith(color: AppColors.deepPurple)),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 600.ms, duration: 300.ms),
            const SizedBox(height: 24),
            PillButton(
              label: 'Pay \$82',
              onPressed: () {
                ToastNotification.show(context, message: 'Payment successful!', type: ToastType.success);
                context.push('/eticket');
              },
              width: double.infinity,
            ).animate().fadeIn(delay: 700.ms, duration: 300.ms),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isDiscount;

  const _SummaryRow(this.label, this.value, {this.isDiscount = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodySmall),
          Text(value, style: AppTypography.bodySmall.copyWith(
            color: isDiscount ? AppColors.success : null, fontWeight: FontWeight.w600,
          )),
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: Commit**

```bash
git add -A
git commit -m "feat: add payment screen with methods, wallet, BNPL, order summary"
```

---

## Phase 6: E-Ticket, Profile, Notifications, Chat, Tracking

### Task 16: Build E-Ticket screen

**Files:**
- Create: `flyone/lib/features/ticket/domain/models/ticket.dart`
- Create: `flyone/lib/features/ticket/data/mock_ticket_data.dart`
- Create: `flyone/lib/features/ticket/presentation/eticket_screen.dart`
- Create: `flyone/lib/features/ticket/presentation/widgets/ticket_qr_code.dart`
- Create: `flyone/lib/features/ticket/presentation/widgets/ticket_info_card.dart`
- Create: `flyone/lib/features/ticket/presentation/widgets/ticket_barcode.dart`

- [ ] **Step 1: Create ticket model and mock data**

`ticket.dart`:
```dart
class Ticket {
  final String id;
  final String pnr;
  final String tripType;
  final String carrierName;
  final String carrierLogo;
  final String departureCode;
  final String arrivalCode;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String date;
  final String gate;
  final String terminal;
  final String passengerName;
  final String seatNumber;
  final String travelClass;
  final String barcodeData;

  const Ticket({
    required this.id,
    required this.pnr,
    required this.tripType,
    required this.carrierName,
    required this.carrierLogo,
    required this.departureCode,
    required this.arrivalCode,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.date,
    required this.gate,
    required this.terminal,
    required this.passengerName,
    required this.seatNumber,
    required this.travelClass,
    required this.barcodeData,
  });
}
```

`mock_ticket_data.dart`:
```dart
import '../domain/models/ticket.dart';

class MockTicketData {
  static const ticket = Ticket(
    id: 'TKT-001',
    pnr: 'SHG2345',
    tripType: 'One Way',
    carrierName: 'Garuda Indonesia',
    carrierLogo: '✈️',
    departureCode: 'CGK',
    arrivalCode: 'BDG',
    departureTime: '06:40',
    arrivalTime: '08:30',
    duration: '1 hour 5',
    date: '23 February 2024',
    gate: 'G2',
    terminal: 'T3',
    passengerName: 'Alves Farhat',
    seatNumber: 'A3',
    travelClass: 'Business',
    barcodeData: 'ASF SHG2345',
  );
}
```

- [ ] **Step 2: Create ticket widgets**

`ticket_qr_code.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/theme/app_colors.dart';

class TicketQrCode extends StatelessWidget {
  final String data;

  const TicketQrCode({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: QrImageView(
          data: data,
          version: QrVersions.auto,
          size: 160,
          eyeStyle: const QrEyeStyle(color: AppColors.deepPurple, eyeShape: QrEyeShape.roundedOuter),
          dataModuleStyle: const QrDataModuleStyle(color: AppColors.deepPurple, dataModuleShape: QrDataModuleShape.roundedOutsideCorners),
        ),
      ),
    );
  }
}
```

`ticket_info_card.dart`:
```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/ticket.dart';

class TicketInfoCard extends StatelessWidget {
  final Ticket ticket;

  const TicketInfoCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))],
      ),
      child: Column(
        children: [
          // Trip type + carrier
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lightLilac.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(ticket.tripType, style: AppTypography.caption.copyWith(color: AppColors.deepPurple)),
              ),
              Text(ticket.carrierLogo, style: const TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: 20),
          // Route
          Row(
            children: [
              Expanded(child: _RouteInfo(code: ticket.departureCode, time: ticket.departureTime, label: 'From')),
              Column(
                children: [
                  Text(ticket.duration, style: AppTypography.caption),
                  const SizedBox(height: 4),
                  const Icon(Icons.flight_rounded, color: AppColors.teal),
                ],
              ),
              Expanded(child: _RouteInfo(code: ticket.arrivalCode, time: ticket.arrivalTime, label: 'To', isEnd: true)),
            ],
          ),
          const SizedBox(height: 20),
          // Gate + Terminal
          Row(
            children: [
              Expanded(child: _InfoBox(label: 'Gate', value: ticket.gate)),
              const SizedBox(width: 12),
              Expanded(child: _InfoBox(label: 'Terminal', value: ticket.terminal)),
              const SizedBox(width: 12),
              Expanded(child: _InfoBox(label: 'Seat', value: ticket.seatNumber)),
            ],
          ),
        ],
      ),
    );
  }
}

class _RouteInfo extends StatelessWidget {
  final String code;
  final String time;
  final String label;
  final bool isEnd;

  const _RouteInfo({required this.code, required this.time, required this.label, this.isEnd = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.caption),
        Text(code, style: AppTypography.heading1),
        Text(time, style: AppTypography.bodySmall),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.lightLilac.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(label, style: AppTypography.caption),
          const SizedBox(height: 4),
          Text(value, style: AppTypography.heading2),
        ],
      ),
    );
  }
}
```

`ticket_barcode.dart`:
```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class TicketBarcode extends StatelessWidget {
  final String data;

  const TicketBarcode({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Simulated barcode
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(30, (i) => Container(
            width: i % 3 == 0 ? 3 : 2,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            color: i % 5 == 0 ? Colors.transparent : AppColors.deepPurple,
          )),
        ),
        const SizedBox(height: 8),
        Text(data, style: AppTypography.caption.copyWith(letterSpacing: 2)),
      ],
    );
  }
}
```

- [ ] **Step 3: Create eticket_screen.dart**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/pill_button.dart';
import '../data/mock_ticket_data.dart';
import 'widgets/ticket_info_card.dart';
import 'widgets/ticket_qr_code.dart';
import 'widgets/ticket_barcode.dart';

class ETicketScreen extends StatelessWidget {
  const ETicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ticket = MockTicketData.ticket;

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        actions: [
          IconButton(icon: const Icon(Icons.share_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_horiz_rounded), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TicketInfoCard(ticket: ticket)
                .animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0, duration: 400.ms),
            const SizedBox(height: 24),
            // Passenger name
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Passenger Name', style: AppTypography.caption),
                  const SizedBox(height: 4),
                  Text(ticket.passengerName, style: AppTypography.heading3),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
            const SizedBox(height: 24),
            TicketQrCode(data: ticket.pnr)
                .animate().fadeIn(delay: 300.ms, duration: 400.ms)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), delay: 300.ms, duration: 400.ms),
            const SizedBox(height: 24),
            TicketBarcode(data: ticket.barcodeData)
                .animate().fadeIn(delay: 400.ms, duration: 300.ms),
            const SizedBox(height: 32),
            PillButton(
              label: 'Download Ticket',
              onPressed: () {},
              width: double.infinity,
              backgroundColor: AppColors.teal,
            ).animate().fadeIn(delay: 500.ms, duration: 300.ms),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Commit**

```bash
git add -A
git commit -m "feat: add e-ticket screen with QR code, barcode, passenger info"
```

---

### Task 17: Build Profile screen

**Files:**
- Create: `flyone/lib/features/profile/data/user_repository.dart`
- Create: `flyone/lib/features/profile/data/mock_user_repository.dart`
- Create: `flyone/lib/features/profile/domain/profile_provider.dart`
- Create: `flyone/lib/features/profile/presentation/profile_screen.dart`
- Create: `flyone/lib/features/profile/presentation/widgets/profile_header.dart`
- Create: `flyone/lib/features/profile/presentation/widgets/loyalty_tier_badge.dart`
- Create: `flyone/lib/features/profile/presentation/widgets/settings_list.dart`
- Create: `flyone/lib/features/loyalty/domain/models/loyalty_info.dart`
- Create: `flyone/lib/features/loyalty/data/loyalty_repository.dart`
- Create: `flyone/lib/features/loyalty/data/mock_loyalty_repository.dart`

- [ ] **Step 1: Create all profile/loyalty files**

*All file contents are provided in the plan — see spec for data models. Key structures:*

`loyalty_info.dart`:
```dart
class LoyaltyInfo {
  final int points;
  final String tier;
  final int nextTierPoints;
  final double progressPercent;

  const LoyaltyInfo({required this.points, required this.tier, required this.nextTierPoints, required this.progressPercent});
}
```

`user_repository.dart`:
```dart
abstract class UserRepository {
  Future<Map<String, String>> getUserProfile();
}
```

`mock_user_repository.dart`:
```dart
import 'user_repository.dart';

class MockUserRepository implements UserRepository {
  @override
  Future<Map<String, String>> getUserProfile() async {
    return {
      'name': 'Mejba Ahmed',
      'email': 'mejba@ramlit.com',
      'phone': '+62 812 3456 7890',
      'nationality': 'Indonesian',
      'passport': 'A12345678',
    };
  }
}
```

`loyalty_repository.dart`:
```dart
import '../domain/models/loyalty_info.dart';

abstract class LoyaltyRepository {
  LoyaltyInfo getLoyaltyInfo();
}
```

`mock_loyalty_repository.dart`:
```dart
import '../domain/models/loyalty_info.dart';
import 'loyalty_repository.dart';

class MockLoyaltyRepository implements LoyaltyRepository {
  @override
  LoyaltyInfo getLoyaltyInfo() => const LoyaltyInfo(
    points: 320,
    tier: 'Explorer',
    nextTierPoints: 1000,
    progressPercent: 0.32,
  );
}
```

`profile_provider.dart`:
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/user_repository.dart';
import '../data/mock_user_repository.dart';
import '../../loyalty/data/loyalty_repository.dart';
import '../../loyalty/data/mock_loyalty_repository.dart';
import '../../loyalty/domain/models/loyalty_info.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) => MockUserRepository());
final loyaltyRepositoryProvider = Provider<LoyaltyRepository>((ref) => MockLoyaltyRepository());

final userProfileProvider = FutureProvider<Map<String, String>>((ref) async {
  return ref.read(userRepositoryProvider).getUserProfile();
});

final loyaltyInfoProvider = Provider<LoyaltyInfo>((ref) {
  return ref.read(loyaltyRepositoryProvider).getLoyaltyInfo();
});
```

- [ ] **Step 2: Create profile widgets and screen**

`profile_header.dart`:
```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String email;

  const ProfileHeader({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.lightLilac,
              child: Text(name[0], style: AppTypography.heading1.copyWith(color: AppColors.deepPurple)),
            ),
            Positioned(
              bottom: 0, right: 0,
              child: Container(
                width: 32, height: 32,
                decoration: BoxDecoration(
                  color: AppColors.teal, shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(name, style: AppTypography.heading2),
        Text(email, style: AppTypography.bodySmall),
      ],
    );
  }
}
```

`loyalty_tier_badge.dart`:
```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../loyalty/domain/models/loyalty_info.dart';

class LoyaltyTierBadge extends StatelessWidget {
  final LoyaltyInfo info;

  const LoyaltyTierBadge({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.deepPurple, Color(0xFF4A3F7A)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.workspace_premium_rounded, color: AppColors.teal, size: 24),
              const SizedBox(width: 8),
              Text(info.tier, style: AppTypography.heading3.copyWith(color: Colors.white)),
              const Spacer(),
              Text('${info.points} pts', style: AppTypography.bodySmall.copyWith(color: AppColors.teal)),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: info.progressPercent,
              backgroundColor: Colors.white24,
              color: AppColors.teal,
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${info.nextTierPoints - info.points} points to Navigator',
            style: AppTypography.caption.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }
}
```

`settings_list.dart`:
```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Notifications', Icons.notifications_outlined),
      ('Language', Icons.language_rounded),
      ('Currency', Icons.attach_money_rounded),
      ('Privacy', Icons.lock_outline_rounded),
      ('Help & Support', Icons.help_outline_rounded),
      ('Logout', Icons.logout_rounded),
    ];

    return Column(
      children: items.map((item) => Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(item.$2, color: item.$1 == 'Logout' ? AppColors.error : AppColors.deepPurple),
          title: Text(item.$1, style: AppTypography.bodySmall.copyWith(
            color: item.$1 == 'Logout' ? AppColors.error : null,
          )),
          trailing: item.$1 != 'Logout'
              ? const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary)
              : null,
          onTap: () {},
        ),
      )).toList(),
    );
  }
}
```

`profile_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/profile_provider.dart';
import 'widgets/profile_header.dart';
import 'widgets/loyalty_tier_badge.dart';
import 'widgets/settings_list.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final loyalty = ref.watch(loyaltyInfoProvider);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(title: const Text('Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            profile.when(
              data: (data) => ProfileHeader(name: data['name']!, email: data['email']!)
                  .animate().fadeIn(duration: 300.ms),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Error'),
            ),
            const SizedBox(height: 24),
            LoyaltyTierBadge(info: loyalty).animate().fadeIn(delay: 200.ms, duration: 300.ms),
            const SizedBox(height: 24),
            // Personal info
            profile.when(
              data: (data) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Personal Info', style: AppTypography.heading3),
                        TextButton(onPressed: () {}, child: Text('Edit', style: AppTypography.bodySmall.copyWith(color: AppColors.teal))),
                      ],
                    ),
                    _InfoRow('Phone', data['phone']!),
                    _InfoRow('Nationality', data['nationality']!),
                    _InfoRow('Passport', data['passport']!),
                  ],
                ),
              ).animate().fadeIn(delay: 300.ms, duration: 300.ms),
              loading: () => const SizedBox(),
              error: (_, __) => const SizedBox(),
            ),
            const SizedBox(height: 24),
            const SettingsList().animate().fadeIn(delay: 400.ms, duration: 300.ms),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodySmall),
          Text(value, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add -A
git commit -m "feat: add profile screen with loyalty badge, personal info, settings"
```

---

### Task 18: Build Notifications screen

**Files:**
- Create: `flyone/lib/features/notifications/domain/models/app_notification.dart`
- Create: `flyone/lib/features/notifications/data/notification_repository.dart`
- Create: `flyone/lib/features/notifications/data/mock_notification_repository.dart`
- Create: `flyone/lib/features/notifications/domain/notification_provider.dart`
- Create: `flyone/lib/features/notifications/presentation/notifications_screen.dart`
- Create: `flyone/lib/features/notifications/presentation/widgets/notification_card.dart`

- [ ] **Step 1: Create notification model, repo, provider**

`app_notification.dart`:
```dart
enum NotificationCategory { booking, deal, system }

class AppNotification {
  final String id;
  final String title;
  final String description;
  final NotificationCategory category;
  final DateTime timestamp;
  final bool isRead;
  final IconType iconType;

  const AppNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.timestamp,
    this.isRead = false,
    required this.iconType,
  });
}

enum IconType { flight, train, promo, system, payment }
```

`notification_repository.dart`:
```dart
import '../../../core/utils/result.dart';
import '../domain/models/app_notification.dart';

abstract class NotificationRepository {
  Future<Result<List<AppNotification>>> getNotifications();
}
```

`mock_notification_repository.dart`:
```dart
import '../../../core/utils/result.dart';
import '../domain/models/app_notification.dart';
import 'notification_repository.dart';

class MockNotificationRepository implements NotificationRepository {
  @override
  Future<Result<List<AppNotification>>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Success([
      AppNotification(id: '1', title: 'Booking Confirmed', description: 'Your flight CGK→DPS has been confirmed', category: NotificationCategory.booking, timestamp: DateTime.now().subtract(const Duration(hours: 1)), iconType: IconType.flight),
      AppNotification(id: '2', title: 'Check-in Open', description: 'Online check-in is now available for your flight', category: NotificationCategory.booking, timestamp: DateTime.now().subtract(const Duration(hours: 3)), iconType: IconType.flight),
      AppNotification(id: '3', title: 'Flash Sale!', description: '50% off on all domestic flights this weekend', category: NotificationCategory.deal, timestamp: DateTime.now().subtract(const Duration(hours: 5)), iconType: IconType.promo),
      AppNotification(id: '4', title: 'Price Drop Alert', description: 'Jakarta to Bali fares dropped by 30%', category: NotificationCategory.deal, timestamp: DateTime.now().subtract(const Duration(hours: 8)), iconType: IconType.promo),
      AppNotification(id: '5', title: 'Payment Received', description: 'Payment of \$81 has been processed successfully', category: NotificationCategory.booking, timestamp: DateTime.now().subtract(const Duration(days: 1)), isRead: true, iconType: IconType.payment),
      AppNotification(id: '6', title: 'New Feature', description: 'AI Travel Assistant is now available! Try it out', category: NotificationCategory.system, timestamp: DateTime.now().subtract(const Duration(days: 2)), iconType: IconType.system),
      AppNotification(id: '7', title: 'App Update', description: 'Version 1.1 is available with bug fixes', category: NotificationCategory.system, timestamp: DateTime.now().subtract(const Duration(days: 3)), isRead: true, iconType: IconType.system),
      AppNotification(id: '8', title: 'Weekend Getaway', description: 'Exclusive deals for weekend trips from \$45', category: NotificationCategory.deal, timestamp: DateTime.now().subtract(const Duration(days: 1)), iconType: IconType.promo),
    ]);
  }
}
```

`notification_provider.dart`:
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/notification_repository.dart';
import '../data/mock_notification_repository.dart';
import 'models/app_notification.dart';

final notificationRepositoryProvider = Provider<NotificationRepository>(
  (ref) => MockNotificationRepository(),
);

final notificationsProvider = FutureProvider<List<AppNotification>>((ref) async {
  final repo = ref.read(notificationRepositoryProvider);
  final result = await repo.getNotifications();
  return switch (result) {
    Success(:final data) => data,
    Failure(:final message) => throw Exception(message),
  };
});
```

- [ ] **Step 2: Create notification_card.dart and notifications_screen.dart**

`notification_card.dart`:
```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/app_notification.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification notification;

  const NotificationCard({super.key, required this.notification});

  IconData get _icon => switch (notification.iconType) {
    IconType.flight => Icons.flight_rounded,
    IconType.train => Icons.train_rounded,
    IconType.promo => Icons.local_offer_rounded,
    IconType.system => Icons.info_rounded,
    IconType.payment => Icons.payment_rounded,
  };

  Color get _iconColor => switch (notification.category) {
    NotificationCategory.booking => AppColors.deepPurple,
    NotificationCategory.deal => AppColors.teal,
    NotificationCategory.system => AppColors.textSecondary,
  };

  String get _timeAgo {
    final diff = DateTime.now().difference(notification.timestamp);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: notification.isRead ? Colors.white : AppColors.lightLilac.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
        border: notification.isRead ? null : Border.all(color: AppColors.lightLilac.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: _iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_icon, color: _iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(notification.title, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600))),
                    Text(_timeAgo, style: AppTypography.caption),
                  ],
                ),
                const SizedBox(height: 4),
                Text(notification.description, style: AppTypography.caption, maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          if (!notification.isRead)
            Container(
              width: 8, height: 8,
              margin: const EdgeInsets.only(top: 6, left: 8),
              decoration: const BoxDecoration(color: AppColors.teal, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}
```

`notifications_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../domain/models/app_notification.dart';
import '../domain/notification_provider.dart';
import 'widgets/notification_card.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Notifications'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.deepPurple,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.deepPurple,
          tabs: const [Tab(text: 'Bookings'), Tab(text: 'Deals'), Tab(text: 'System')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTab(notifications, NotificationCategory.booking),
          _buildTab(notifications, NotificationCategory.deal),
          _buildTab(notifications, NotificationCategory.system),
        ],
      ),
    );
  }

  Widget _buildTab(AsyncValue<List<AppNotification>> notifications, NotificationCategory category) {
    return notifications.when(
      data: (data) {
        final filtered = data.where((n) => n.category == category).toList();
        if (filtered.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.notifications_off_rounded, size: 60, color: AppColors.lightLilac),
                const SizedBox(height: 12),
                Text('No notifications yet', style: AppTypography.bodySmall),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: filtered.length,
          itemBuilder: (context, index) => NotificationCard(notification: filtered[index])
              .animate().fadeIn(delay: (80 * index).ms, duration: 300.ms),
        );
      },
      loading: () => ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 3,
        itemBuilder: (_, __) => const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: SkeletonCard(height: 80),
        ),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add -A
git commit -m "feat: add notifications screen with tabbed categories"
```

---

### Task 19: Build AI Chat screen

**Files:**
- Create: `flyone/lib/features/chat/domain/models/chat_message.dart`
- Create: `flyone/lib/features/chat/data/chat_repository.dart`
- Create: `flyone/lib/features/chat/data/mock_chat_repository.dart`
- Create: `flyone/lib/features/chat/domain/chat_provider.dart`
- Create: `flyone/lib/features/chat/presentation/chat_screen.dart`
- Create: `flyone/lib/features/chat/presentation/widgets/chat_bubble.dart`
- Create: `flyone/lib/features/chat/presentation/widgets/quick_reply_chips.dart`
- Create: `flyone/lib/features/chat/presentation/widgets/typing_indicator.dart`

- [ ] **Step 1: Create chat model, repo, provider**

`chat_message.dart`:
```dart
class ChatMessage {
  final String id;
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final List<String>? quickReplies;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.quickReplies,
  });
}
```

`chat_repository.dart`:
```dart
import '../../../core/utils/result.dart';
import '../domain/models/chat_message.dart';

abstract class ChatRepository {
  Future<Result<ChatMessage>> sendMessage(String message);
}
```

`mock_chat_repository.dart`:
```dart
import '../../../core/utils/result.dart';
import '../domain/models/chat_message.dart';
import 'chat_repository.dart';

class MockChatRepository implements ChatRepository {
  final _responses = {
    'default': ChatMessage(
      id: 'ai-1', text: 'I can help you find the best travel options! Try asking me about flights, trains, or destinations.', isUser: false, timestamp: DateTime.now(),
      quickReplies: ['Find flights to Bali', 'Train to Bandung', 'Best deals this week'],
    ),
    'bali': ChatMessage(
      id: 'ai-2', text: 'Great choice! I found 12 flights to Bali starting from \$120. The cheapest option is Lion Air departing at 14:30. Would you like me to search for specific dates?', isUser: false, timestamp: DateTime.now(),
      quickReplies: ['Show cheapest', 'This weekend', 'Next month'],
    ),
    'bandung': ChatMessage(
      id: 'ai-3', text: 'For Jakarta to Bandung, I recommend Whoosh high-speed train — it takes only 45 minutes! Prices start at \$15. The next departure is at 10:00.', isUser: false, timestamp: DateTime.now(),
      quickReplies: ['Book now', 'Show all options', 'Different date'],
    ),
    'deals': ChatMessage(
      id: 'ai-4', text: 'Here are this week\'s best deals:\n\n🔥 Jakarta→Bali from \$89 (40% off)\n🔥 Jakarta→Singapore from \$120\n🔥 Weekend getaway packages from \$45\n\nWant me to book any of these?', isUser: false, timestamp: DateTime.now(),
      quickReplies: ['Book Bali deal', 'More deals', 'Set price alert'],
    ),
  };

  @override
  Future<Result<ChatMessage>> sendMessage(String message) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final lower = message.toLowerCase();
    if (lower.contains('bali')) return Success(_responses['bali']!);
    if (lower.contains('bandung') || lower.contains('train')) return Success(_responses['bandung']!);
    if (lower.contains('deal') || lower.contains('cheap') || lower.contains('best')) return Success(_responses['deals']!);
    return Success(_responses['default']!);
  }
}
```

`chat_provider.dart`:
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/chat_repository.dart';
import '../data/mock_chat_repository.dart';
import 'models/chat_message.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) => MockChatRepository());

final chatMessagesProvider = StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
  (ref) => ChatNotifier(ref.read(chatRepositoryProvider)),
);

final isTypingProvider = StateProvider<bool>((ref) => false);

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  final ChatRepository _repo;

  ChatNotifier(this._repo) : super([
    ChatMessage(
      id: 'welcome',
      text: 'Hi! I\'m your AI travel assistant. How can I help you today? ✈️',
      isUser: false,
      timestamp: DateTime.now(),
      quickReplies: ['Find flights to Bali', 'Train to Bandung', 'Best deals this week'],
    ),
  ]);

  Future<void> send(String message, StateController<bool> typingController) async {
    state = [...state, ChatMessage(id: 'user-${state.length}', text: message, isUser: true, timestamp: DateTime.now())];
    typingController.state = true;
    final result = await _repo.sendMessage(message);
    typingController.state = false;
    if (result case Success(:final data)) {
      state = [...state, data];
    }
  }
}
```

- [ ] **Step 2: Create chat widgets and screen**

`chat_bubble.dart`:
```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: message.isUser ? AppColors.deepPurple : AppColors.lightLilac.withValues(alpha: 0.4),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message.isUser ? 16 : 4),
            bottomRight: Radius.circular(message.isUser ? 4 : 16),
          ),
        ),
        child: Text(
          message.text,
          style: AppTypography.bodySmall.copyWith(
            color: message.isUser ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
```

`quick_reply_chips.dart`:
```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class QuickReplyChips extends StatelessWidget {
  final List<String> replies;
  final ValueChanged<String> onTap;

  const QuickReplyChips({super.key, required this.replies, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: replies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onTap(replies[index]),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.teal),
            ),
            child: Text(replies[index], style: AppTypography.caption.copyWith(color: AppColors.teal, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }
}
```

`typing_indicator.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.lightLilac.withValues(alpha: 0.4),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (i) => Container(
            width: 8, height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(color: AppColors.deepPurple.withValues(alpha: 0.5), shape: BoxShape.circle),
          ).animate(onPlay: (c) => c.repeat())
              .fadeIn(delay: (200 * i).ms, duration: 400.ms)
              .then()
              .fadeOut(duration: 400.ms)),
        ),
      ),
    );
  }
}
```

`chat_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/chat_provider.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/quick_reply_chips.dart';
import 'widgets/typing_indicator.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  void _send(String text) {
    if (text.trim().isEmpty) return;
    _controller.clear();
    ref.read(chatMessagesProvider.notifier).send(text, ref.read(isTypingProvider.notifier));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessagesProvider);
    final isTyping = ref.watch(isTypingProvider);

    // Auto-scroll on new messages
    ref.listen(chatMessagesProvider, (_, __) => _scrollToBottom());

    final lastAiMessage = messages.where((m) => !m.isUser).lastOrNull;

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.auto_awesome, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Text('AI Assistant', style: AppTypography.heading3),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              itemCount: messages.length + (isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == messages.length && isTyping) return const TypingIndicator();
                return ChatBubble(message: messages[index])
                    .animate().fadeIn(duration: 200.ms).slideY(begin: 0.1, end: 0, duration: 200.ms);
              },
            ),
          ),
          // Quick replies
          if (lastAiMessage?.quickReplies != null && !isTyping)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: QuickReplyChips(
                replies: lastAiMessage!.quickReplies!,
                onTap: _send,
              ),
            ),
          // Input bar
          Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -2))],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Ask me anything about travel...',
                      hintStyle: AppTypography.bodySmall,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      filled: true,
                      fillColor: AppColors.softWhite,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onSubmitted: _send,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => _send(_controller.text),
                  child: Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(color: AppColors.deepPurple, borderRadius: BorderRadius.circular(12)),
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: Commit**

```bash
git add -A
git commit -m "feat: add AI chat assistant with bubbles, quick replies, typing indicator"
```

---

### Task 20: Build Live Tracking screen

**Files:**
- Create: `flyone/lib/features/tracking/data/tracking_repository.dart`
- Create: `flyone/lib/features/tracking/data/mock_tracking_repository.dart`
- Create: `flyone/lib/features/tracking/domain/tracking_provider.dart`
- Create: `flyone/lib/features/tracking/presentation/tracking_screen.dart`

- [ ] **Step 1: Create tracking files**

`tracking_repository.dart`:
```dart
abstract class TrackingRepository {
  Stream<Map<String, dynamic>> getVehiclePosition(String bookingId);
}
```

`mock_tracking_repository.dart`:
```dart
import 'tracking_repository.dart';

class MockTrackingRepository implements TrackingRepository {
  @override
  Stream<Map<String, dynamic>> getVehiclePosition(String bookingId) async* {
    final stops = ['Jakarta (CGK)', 'Karawang', 'Cikampek', 'Purwakarta', 'Bandung (BDG)'];
    for (int i = 0; i < stops.length; i++) {
      await Future.delayed(const Duration(seconds: 3));
      yield {
        'currentStop': stops[i],
        'progress': (i + 1) / stops.length,
        'eta': '${(stops.length - i - 1) * 25} min',
        'speed': '120 km/h',
      };
    }
  }
}
```

`tracking_provider.dart`:
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/tracking_repository.dart';
import '../data/mock_tracking_repository.dart';

final trackingRepositoryProvider = Provider<TrackingRepository>(
  (ref) => MockTrackingRepository(),
);

final trackingStreamProvider = StreamProvider.family<Map<String, dynamic>, String>((ref, bookingId) {
  return ref.read(trackingRepositoryProvider).getVehiclePosition(bookingId);
});
```

`tracking_screen.dart`:
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/tracking_provider.dart';

class TrackingScreen extends ConsumerWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracking = ref.watch(trackingStreamProvider('booking-1'));

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Live Tracking'),
      ),
      body: Column(
        children: [
          // Map placeholder
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.lightLilac.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.lightLilac),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.map_rounded, size: 60, color: AppColors.teal.withValues(alpha: 0.5)),
                    const SizedBox(height: 8),
                    Text('Live Map View', style: AppTypography.bodySmall),
                    Text('Map integration coming soon', style: AppTypography.caption),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 400.ms),
          ),
          // Vehicle info
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, -4))],
              ),
              child: tracking.when(
                data: (data) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 48, height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.teal.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.train_rounded, color: AppColors.teal),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Whoosh High-Speed', style: AppTypography.heading3),
                              Text('Speed: ${data['speed']}', style: AppTypography.caption),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.teal.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text('ETA: ${data['eta']}', style: AppTypography.bodySmall.copyWith(color: AppColors.teal, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Current Location', style: AppTypography.bodySmall),
                    const SizedBox(height: 4),
                    Text(data['currentStop'] as String, style: AppTypography.heading3),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: data['progress'] as double,
                        backgroundColor: AppColors.lightLilac.withValues(alpha: 0.3),
                        color: AppColors.teal,
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Jakarta (CGK)', style: AppTypography.caption),
                        Text('Bandung (BDG)', style: AppTypography.caption),
                      ],
                    ),
                  ],
                ).animate().fadeIn(duration: 300.ms),
                loading: () => const Center(child: CircularProgressIndicator(color: AppColors.teal)),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Commit**

```bash
git add -A
git commit -m "feat: add live tracking screen with vehicle info and progress"
```

---

## Phase 7: Final Integration

### Task 21: Add missing imports and fix Result pattern imports

- [ ] **Step 1: Ensure all providers import Result correctly**

Add this import to `search_provider.dart` and `notification_provider.dart`:
```dart
import '../../../core/utils/result.dart';
```

- [ ] **Step 2: Verify all feature screens are exported and imported in router**

Review `app_router.dart` to ensure all 12 screen imports resolve correctly.

- [ ] **Step 3: Run flutter analyze and fix issues**

Run:
```bash
cd /Users/mejba/AndroidStudioProjects/flyone-app/flyone
flutter analyze
```

Fix any warnings or errors.

- [ ] **Step 4: Run the app**

Run:
```bash
flutter run
```

Verify:
- Splash → Onboarding → Home flow works
- Bottom nav switches between tabs
- Search → Results → Booking → Payment → E-Ticket flow works
- Profile, Notifications, Chat, Tracking screens load
- Animations are smooth

- [ ] **Step 5: Final commit**

```bash
git add -A
git commit -m "feat: complete Flyone Flutter app with all 12 screens and navigation"
```
