# Flyone Premium Minimalist Redesign — Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Transform the Flyone Flutter app's UI from its current state to a premium minimalist "Soft Depth" aesthetic with standardized design tokens, cleaner components, and refined screens.

**Architecture:** Foundation-first approach — create design token constants, update theme files, then update core widgets, then update each screen. Each task produces a working app (no broken intermediate states). All changes are in `flyone/lib/`.

**Tech Stack:** Flutter 3.7+, Dart, flutter_riverpod, go_router, flutter_animate, google_fonts, shimmer

---

### Task 1: Create Design Token Constants

**Files:**
- Create: `flyone/lib/core/theme/app_constants.dart`

- [ ] **Step 1: Create the constants file with all design tokens**

```dart
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
```

- [ ] **Step 2: Verify the file compiles**

Run: `cd flyone && flutter analyze lib/core/theme/app_constants.dart`
Expected: No issues found

- [ ] **Step 3: Commit**

```bash
git add flyone/lib/core/theme/app_constants.dart
git commit -m "feat: add design token constants (radii, spacing, shadows, animation)"
```

---

### Task 2: Update Theme Foundation (Colors, Typography, Theme)

**Files:**
- Modify: `flyone/lib/core/theme/app_colors.dart`
- Modify: `flyone/lib/core/theme/app_typography.dart`
- Modify: `flyone/lib/core/theme/app_theme.dart`

- [ ] **Step 1: Update AppColors — shimmer colors and gradient direction**

In `app_colors.dart`, change:

```dart
  static const Color shimmerBase = Color(0xFFE8E5F0);
  static const Color shimmerHighlight = Color(0xFFF3F0FA);
```
to:
```dart
  static const Color shimmerBase = Color(0xFFEFECF5);
  static const Color shimmerHighlight = Color(0xFFF8F6FC);
```

Change `primaryGradient` from diagonal to vertical:
```dart
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [lightLilac, softWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
```

Change `accentGradient` to be more subtle:
```dart
  static const LinearGradient accentGradient = LinearGradient(
    colors: [teal, Color(0xB35BCFCF)], // teal at 0.7 opacity
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
```

- [ ] **Step 2: Update AppTypography — sizes and letter-spacing**

Replace the entire `app_typography.dart` with:

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextStyle get heading1 => GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      );

  static TextStyle get heading2 => GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
      );

  static TextStyle get heading3 => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      );

  static TextStyle get body => GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
      );

  static TextStyle get caption => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        letterSpacing: 0.2,
      );

  static TextStyle get button => GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  static TextStyle get buttonSmall => GoogleFonts.poppins(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      );

  static TextStyle get label => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondary,
        letterSpacing: 0.8,
      );
}
```

- [ ] **Step 3: Update AppTheme — use standardized radii**

In `app_theme.dart`, change the card theme's `BorderRadius.circular(16)` — this is already 16 so no change needed. Update `inputDecorationTheme` border radius from 12 to use `AppConstants.radiusSmall`:

Add import at top:
```dart
import 'app_constants.dart';
```

Change all `BorderRadius.circular(12)` in `inputDecorationTheme` to `BorderRadius.circular(AppConstants.radiusSmall)`.

- [ ] **Step 4: Verify the app compiles**

Run: `cd flyone && flutter analyze`
Expected: No issues found (or only pre-existing warnings)

- [ ] **Step 5: Commit**

```bash
git add flyone/lib/core/theme/
git commit -m "feat: update theme foundation — typography sizes, softer shimmer, vertical gradient"
```

---

### Task 3: Redesign Core Widgets (AppCard, PillButton, SkeletonLoader, SectionHeader, Toast)

**Files:**
- Modify: `flyone/lib/core/widgets/app_card.dart`
- Modify: `flyone/lib/core/widgets/pill_button.dart`
- Modify: `flyone/lib/core/widgets/skeleton_loader.dart`
- Modify: `flyone/lib/core/widgets/section_header.dart`
- Modify: `flyone/lib/core/widgets/toast_notification.dart`

- [ ] **Step 1: Redesign AppCard — single subtle shadow, 0.96 press scale**

Replace `app_card.dart` with:

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_constants.dart';

class AppCard extends StatefulWidget {
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
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: AppConstants.pressScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (widget.onTap != null) _controller.forward();
  }

  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: widget.padding ?? const EdgeInsets.all(AppConstants.spaceLG),
          decoration: BoxDecoration(
            color: widget.color ?? AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            boxShadow: AppConstants.shadowSubtle,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Redesign PillButton — solid fills, 0.96 scale, 48/36 heights**

Replace `pill_button.dart` with:

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_constants.dart';

class PillButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final bool isSmall;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final LinearGradient? gradient;

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
    this.gradient,
  });

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: AppConstants.pressScale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) {
    if (widget.onPressed != null) _controller.forward();
  }

  void _onTapUp(TapUpDetails _) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.backgroundColor ?? AppColors.deepPurple;
    final fgColor = widget.textColor ?? Colors.white;
    final height = widget.isSmall ? AppConstants.buttonHeightSmall : AppConstants.buttonHeight;
    final horizontalPad = widget.isSmall ? 16.0 : 24.0;

    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SizedBox(
          width: widget.width,
          height: height,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: horizontalPad),
            decoration: BoxDecoration(
              color: widget.isOutlined ? Colors.transparent : (widget.gradient != null ? null : bgColor),
              gradient: widget.isOutlined ? null : widget.gradient,
              borderRadius: BorderRadius.circular(height / 2),
              border: widget.isOutlined
                  ? Border.all(color: bgColor, width: 1)
                  : null,
              boxShadow: widget.isOutlined ? null : AppConstants.shadowSubtle,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon,
                      size: widget.isSmall ? 16 : 18,
                      color: widget.isOutlined ? bgColor : fgColor),
                  const SizedBox(width: AppConstants.spaceSM),
                ],
                Text(
                  widget.label,
                  style: (widget.isSmall
                          ? AppTypography.buttonSmall
                          : AppTypography.button)
                      .copyWith(color: widget.isOutlined ? bgColor : fgColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Update SkeletonLoader — shimmer colors now come from updated AppColors**

No code change needed — `SkeletonLoader` already uses `AppColors.shimmerBase` and `AppColors.shimmerHighlight` which were updated in Task 2. Verify it still compiles.

- [ ] **Step 4: Update SectionHeader — label style for action text**

Replace `section_header.dart` with:

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_constants.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceXL),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTypography.heading3),
          if (onViewAll != null)
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                'VIEW ALL',
                style: AppTypography.label.copyWith(
                  color: AppColors.teal,
                  letterSpacing: 0.8,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 5: Update ToastNotification — 16px radius, subtle shadow**

In `toast_notification.dart`, change `BorderRadius.circular(12)` to `BorderRadius.circular(AppConstants.radiusMedium)` and replace the boxShadow with `AppConstants.shadowSubtle`. Add import for `app_constants.dart`:

Add at top:
```dart
import '../theme/app_constants.dart';
```

Replace the decoration in `_ToastWidgetState.build`:
```dart
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            boxShadow: AppConstants.shadowSubtle,
            border: Border.all(color: _color.withValues(alpha: 0.2)),
          ),
```

Change icon size from `22` to `18`:
```dart
              Icon(_icon, color: _color, size: 18),
```

- [ ] **Step 6: Verify the app compiles**

Run: `cd flyone && flutter analyze`
Expected: No issues found

- [ ] **Step 7: Commit**

```bash
git add flyone/lib/core/widgets/
git commit -m "feat: redesign core widgets — subtle shadows, 0.96 press, refined buttons"
```

---

### Task 4: Redesign Bottom Nav & Shell Screen

**Files:**
- Modify: `flyone/lib/core/widgets/app_bottom_nav.dart`
- Modify: `flyone/lib/core/router/shell_screen.dart`

- [ ] **Step 1: Redesign AppBottomNav — floating bar with morphing pill indicator**

Replace `app_bottom_nav.dart` with:

```dart
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../theme/app_constants.dart';

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
      margin: const EdgeInsets.fromLTRB(
        AppConstants.spaceLG,
        0,
        AppConstants.spaceLG,
        AppConstants.spaceMD,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spaceSM,
        vertical: AppConstants.spaceSM,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        boxShadow: AppConstants.shadowElevated,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: Icons.home_rounded,
              activeIcon: Icons.home_filled,
              label: 'Home',
              isActive: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            _NavItem(
              icon: Icons.search_rounded,
              activeIcon: Icons.search_rounded,
              label: 'Search',
              isActive: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            _NavItem(
              icon: Icons.calendar_today_rounded,
              activeIcon: Icons.calendar_today_rounded,
              label: 'Bookings',
              isActive: currentIndex == 2,
              onTap: () => onTap(2),
            ),
            _NavItem(
              icon: Icons.person_rounded,
              activeIcon: Icons.person_rounded,
              label: 'Profile',
              isActive: currentIndex == 3,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
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
        duration: AppConstants.animNormal,
        curve: AppConstants.animSpring,
        constraints: const BoxConstraints(minHeight: 44, minWidth: 44),
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? AppConstants.spaceLG : AppConstants.spaceMD,
          vertical: AppConstants.spaceSM,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.lightLilac.withValues(alpha: AppConstants.opacityLight)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppColors.deepPurple : AppColors.textSecondary,
              size: 22,
            ),
            if (isActive) ...[
              const SizedBox(width: AppConstants.spaceSM),
              Text(
                label,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.deepPurple,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Update ShellScreen — use body with Stack for floating nav**

Replace `shell_screen.dart` with:

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
      extendBody: true,
      bottomNavigationBar: AppBottomNav(
        currentIndex: currentIndex,
        onTap: onNavigate,
      ),
    );
  }
}
```

- [ ] **Step 3: Verify the app compiles and bottom nav renders**

Run: `cd flyone && flutter analyze`
Expected: No issues found

- [ ] **Step 4: Commit**

```bash
git add flyone/lib/core/widgets/app_bottom_nav.dart flyone/lib/core/router/shell_screen.dart
git commit -m "feat: redesign bottom nav — floating bar with morphing pill indicator"
```

---

### Task 5: Redesign Home Screen

**Files:**
- Modify: `flyone/lib/features/home/presentation/home_screen.dart`
- Modify: `flyone/lib/features/home/presentation/widgets/points_badge.dart`
- Modify: `flyone/lib/features/home/presentation/widgets/category_icons.dart`
- Modify: `flyone/lib/features/home/presentation/widgets/upcoming_schedule_card.dart`
- Modify: `flyone/lib/features/home/presentation/widgets/destination_card.dart`
- Modify: `flyone/lib/features/home/presentation/widgets/voucher_carousel.dart`

- [ ] **Step 1: Update HomeScreen — remove points badge from header, update FAB, add bottom padding for floating nav**

In `home_screen.dart`:

Remove the `PointsBadge` import and the points badge from the top bar. Replace the top bar section (lines 48-82) with a greeting + avatar header:

```dart
                // Top Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      // Avatar
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.lightLilac,
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                        child: const Icon(Icons.person_rounded, color: AppColors.deepPurple, size: 22),
                      ),
                      const SizedBox(width: AppConstants.spaceMD),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_greeting()}, Mejba',
                              style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                            ),
                            Text('Travel Made Effortless', style: AppTypography.heading3),
                          ],
                        ),
                      ),
                      _TopIconButton(
                        icon: Icons.search_rounded,
                        onTap: () => context.go('/search'),
                      ),
                      const SizedBox(width: AppConstants.spaceSM),
                      Stack(
                        children: [
                          _TopIconButton(
                            icon: Icons.notifications_outlined,
                            onTap: () => context.push('/notifications'),
                          ),
                          Positioned(
                            top: 7,
                            right: 7,
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: AppConstants.animNormal),
```

Remove the separate greeting/hero text section (lines 84-103) since it's now in the top bar.

Update the FAB to teal, 52px:
```dart
      floatingActionButton: SizedBox(
        width: 52,
        height: 52,
        child: FloatingActionButton(
          onPressed: () => context.push('/chat'),
          backgroundColor: AppColors.teal,
          elevation: 2,
          child: const Icon(Icons.chat_rounded, color: Colors.white, size: 22),
        ),
      ),
```

Change all stagger animation delays from `100.ms` to `80.ms` intervals. Add `const SizedBox(height: 80)` at the end of the Column children (before closing `],`) to add padding for the floating bottom nav.

Update `_TopIconButton` shadow to use `AppConstants.shadowSubtle`:
```dart
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
            boxShadow: AppConstants.shadowSubtle,
          ),
```

Add import at top of file:
```dart
import '../../../core/theme/app_constants.dart';
```

Remove the `import 'widgets/points_badge.dart';` line. Remove `final points = ref.watch(userPointsProvider);`.

- [ ] **Step 2: Update CategoryIcons — 52px circles, surfaceVariant fill, remove colored shadows**

In `category_icons.dart`, update `_CategoryItem.build` to use 52px circles with `surfaceVariant` fill and no colored shadows:

Add import:
```dart
import '../../../../core/theme/app_constants.dart';
```

Replace the icon container (the `Container` with width 60, height 60):
```dart
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                    ),
                    child: Icon(widget.icon, color: AppColors.deepPurple, size: 24),
                  ),
```

Update press scale from `0.95` to `AppConstants.pressScale`:
```dart
    _scale = Tween<double>(begin: 1.0, end: AppConstants.pressScale).animate(
```

Change badge text style to use `AppTypography.label`:
```dart
                        child: Text(
                          widget.badge!,
                          style: AppTypography.label.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
```

Remove the badge boxShadow (the colored teal shadow).

- [ ] **Step 3: Redesign UpcomingScheduleCard — single shadow, fix overflow, ghost "See Details"**

Replace `upcoming_schedule_card.dart` with:

```dart
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_constants.dart';
import '../../../../core/utils/transport_icon.dart';
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
      width: 280,
      padding: const EdgeInsets.all(AppConstants.spaceLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        boxShadow: AppConstants.shadowSubtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              TransportIcon(
                mode: schedule.transportMode,
                size: 18,
                color: AppColors.deepPurple,
              ),
              const SizedBox(width: AppConstants.spaceSM),
              Expanded(
                child: Text(
                  schedule.carrierName,
                  style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                schedule.date,
                style: AppTypography.caption.copyWith(color: AppColors.teal),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spaceLG),
          // Route row
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(schedule.departureCode, style: AppTypography.heading3),
                  Text(schedule.departureTime, style: AppTypography.caption),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(schedule.duration, style: AppTypography.caption),
                    const SizedBox(height: AppConstants.spaceXS),
                    _DashedLine(),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(schedule.arrivalCode, style: AppTypography.heading3),
                  Text(schedule.arrivalTime, style: AppTypography.caption),
                ],
              ),
            ],
          ),
          const Spacer(),
          // Footer — ghost button
          SizedBox(
            width: double.infinity,
            child: PillButton(
              label: 'See Details',
              isSmall: true,
              isOutlined: true,
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        const dashWidth = 4.0;
        const dashSpace = 3.0;
        final count = (width / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            count,
            (_) => Container(
              width: dashWidth,
              height: 1,
              color: AppColors.divider,
            ),
          ),
        );
      },
    );
  }
}
```

- [ ] **Step 4: Redesign DestinationCard — taller aspect ratio, remove bookmark, price pill**

Replace `destination_card.dart` with:

```dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_constants.dart';
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
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          boxShadow: AppConstants.shadowSubtle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: destination.imageUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => const SkeletonLoader(height: 180),
                errorWidget: (_, __, ___) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.lightLilac, AppColors.surfaceVariant],
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.image_rounded, color: AppColors.deepPurple, size: 32),
                  ),
                ),
              ),
              // Bottom 40% gradient overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.70),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // Name and price pill
              Positioned(
                bottom: AppConstants.spaceMD,
                left: AppConstants.spaceMD,
                right: AppConstants.spaceMD,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        destination.name,
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spaceSM,
                        vertical: AppConstants.spaceXS,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.20),
                        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                      ),
                      child: Text(
                        destination.price,
                        style: AppTypography.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
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

Also update the `childAspectRatio` in `home_screen.dart` from `1.3` to `0.85` (taller cards):
```dart
                        childAspectRatio: 0.85,
```

- [ ] **Step 5: Redesign VoucherCarousel — remove decorative circles, cleaner layout**

In `voucher_carousel.dart`:

Add import:
```dart
import '../../../../core/theme/app_constants.dart';
```

In the carousel item builder, remove the two `_DecorativeCircle` `Positioned` widgets (lines 81-90). Update the card decoration to use `AppConstants`:

```dart
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                    boxShadow: AppConstants.shadowSubtle,
                  ),
```

Update dot indicators width from `18` to `20` and height from `6` to `5`:
```dart
                width: isActive ? 20 : 5,
                height: 5,
```

Remove the `_DecorativeCircle` class entirely (lines 205-221).

- [ ] **Step 6: Verify the app compiles**

Run: `cd flyone && flutter analyze`
Expected: No issues found

- [ ] **Step 7: Commit**

```bash
git add flyone/lib/features/home/
git commit -m "feat: redesign home screen — cleaner header, subtle shadows, taller cards"
```

---

### Task 6: Redesign Search & Search Results Screens

**Files:**
- Modify: `flyone/lib/features/search/presentation/search_screen.dart`
- Modify: `flyone/lib/features/search/presentation/search_results_screen.dart`
- Modify: `flyone/lib/features/search/presentation/widgets/route_card.dart`
- Modify: `flyone/lib/features/search/presentation/widgets/filter_sort_bar.dart`

- [ ] **Step 1: Simplify SearchScreen header illustration and form card shadows**

In `search_screen.dart`:

Add import:
```dart
import '../../../core/theme/app_constants.dart';
```

Replace `Color(0xFFF0EDFF)` with `AppColors.surfaceVariant`.

Simplify the illustration Stack (lines 167-277) to just 2-3 shapes:
```dart
                  SizedBox(
                    width: 200,
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Large background circle
                        Positioned(
                          left: 0,
                          top: 10,
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightLilac.withValues(alpha: 0.25),
                            ),
                          ),
                        ),
                        // Small teal circle
                        Positioned(
                          right: 10,
                          bottom: 5,
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.teal.withValues(alpha: 0.15),
                            ),
                          ),
                        ),
                        // Center icon card
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                            boxShadow: AppConstants.shadowSubtle,
                          ),
                          child: Center(
                            child: Icon(
                              TransportIcon.getIcon('train'),
                              size: 40,
                              color: AppColors.teal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
```

Replace the form card decoration (lines 297-309) with single subtle shadow:
```dart
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
                  boxShadow: AppConstants.shadowSubtle,
                ),
```

Increase form card internal padding from 20 to 24:
```dart
                padding: const EdgeInsets.all(AppConstants.spaceXXL),
```

The search PillButton is already full-width with deep purple — no change needed.

- [ ] **Step 2: Update FilterSortBar — 12px radius, ghost style**

In `filter_sort_bar.dart`:

Add import:
```dart
import '../../../../core/theme/app_constants.dart';
```

Change `BorderRadius.circular(20)` to `BorderRadius.circular(AppConstants.radiusSmall)`.

Remove the active boxShadow (the deep purple shadow). Keep the fill/border logic as-is (it already does deep purple fill for active, white + border for inactive).

- [ ] **Step 3: Redesign RouteCard — remove left stripe, subtle shadow, regular price text**

In `route_card.dart`:

Add import:
```dart
import '../../../../core/theme/app_constants.dart';
```

Replace the card Container decoration to remove the gradient stripe:
```dart
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            boxShadow: AppConstants.shadowSubtle,
          ),
```

Remove the `IntrinsicHeight` + `Row` wrapper with the gradient stripe `Container(width: 4, ...)`. The content should be directly inside the `ClipRRect`:
```dart
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.spaceLG),
              child: Column(
                // ... existing column children unchanged
              ),
            ),
          ),
```

Replace the gradient price tag with plain text:
```dart
                              Text(
                                '${widget.result.currency} ${widget.result.pricePerPax.toInt()}/pax',
                                style: AppTypography.heading3.copyWith(
                                  color: AppColors.deepPurple,
                                ),
                              ),
```

Update press scale from `0.98` to `AppConstants.pressScale`.

- [ ] **Step 4: Verify the app compiles**

Run: `cd flyone && flutter analyze`
Expected: No issues found

- [ ] **Step 5: Commit**

```bash
git add flyone/lib/features/search/
git commit -m "feat: redesign search screens — simplified illustration, subtle shadows, cleaner cards"
```

---

### Task 7: Redesign Booking Detail & Payment Screens

**Files:**
- Modify: `flyone/lib/features/booking/presentation/booking_detail_screen.dart`
- Modify: `flyone/lib/features/payment/presentation/payment_screen.dart`
- Modify: `flyone/lib/features/payment/presentation/widgets/wallet_balance.dart`
- Modify: `flyone/lib/features/payment/presentation/widgets/payment_method_card.dart`

- [ ] **Step 1: Update BookingDetailScreen — softer gradient, spacing replaces dividers**

In `booking_detail_screen.dart`:

Add import:
```dart
import '../../../core/theme/app_constants.dart';
```

Soften the route summary gradient by reducing alpha:
```dart
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.lightLilac.withValues(alpha: 0.7),
                    AppColors.surfaceVariant.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                boxShadow: AppConstants.shadowSubtle,
              ),
```

Replace all `_SectionDivider(label: ...)` usages with a simpler label:
```dart
            Text('Passenger Details', style: AppTypography.label.copyWith(
              color: AppColors.onSurfaceVariant,
              letterSpacing: 0.8,
            )),
```

Repeat for all section labels ('Seat Selection', 'Add-ons', 'Promo Code', 'Price Summary').

Remove the `_SectionDivider` class entirely. Change the spacing between sections from `28` to `AppConstants.spaceXXL`.

Update all stagger delays from `100.ms` intervals to `80.ms` intervals.

- [ ] **Step 2: Update PaymentScreen — remove decorative circles from wallet, simplify payment cards**

In `wallet_balance.dart`:

Add import:
```dart
import '../../../../core/theme/app_constants.dart';
```

Remove the three `_DecorativeCircle` Positioned widgets (lines 34-48). Remove the `_DecorativeCircle` class (lines 110-130). Update the card border radius to `AppConstants.radiusMedium`.

In `payment_method_card.dart`:

Add import:
```dart
import '../../../../core/theme/app_constants.dart';
```

Remove the brand-specific `_brandColor` getter. Use `AppColors.deepPurple` for all brand colors. Simplify the card — remove colored background on selection:

```dart
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          border: Border.all(
            color: isSelected ? AppColors.deepPurple : AppColors.divider,
            width: isSelected ? 1.5 : 1,
          ),
        ),
```

Update icon container to use `AppColors.surfaceVariant`:
```dart
            Container(
              width: 44,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
              ),
              child: Icon(_brandIcon, color: AppColors.deepPurple, size: 20),
            ),
```

Update `_CustomRadio` to use `AppColors.deepPurple` instead of variable color.

In `payment_screen.dart`:

Add import:
```dart
import '../../../core/theme/app_constants.dart';
```

Update the order summary decoration:
```dart
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                boxShadow: AppConstants.shadowSubtle,
              ),
```

Remove the gradient from order summary. Update the total row to use `heading2`:
```dart
                      Text('\$${total.toStringAsFixed(0)}', style: AppTypography.heading2.copyWith(color: AppColors.deepPurple)),
```

- [ ] **Step 3: Verify the app compiles**

Run: `cd flyone && flutter analyze`
Expected: No issues found

- [ ] **Step 4: Commit**

```bash
git add flyone/lib/features/booking/ flyone/lib/features/payment/
git commit -m "feat: redesign booking & payment — softer gradients, cleaner cards, no decorative circles"
```

---

### Task 8: Redesign E-Ticket, Profile, Notifications Screens

**Files:**
- Modify: `flyone/lib/features/ticket/presentation/eticket_screen.dart`
- Modify: `flyone/lib/features/profile/presentation/profile_screen.dart`
- Modify: `flyone/lib/features/notifications/presentation/notifications_screen.dart`

- [ ] **Step 1: Update ETicketScreen — refine notch, ghost download button**

In `eticket_screen.dart`:

Add import:
```dart
import '../../../core/theme/app_constants.dart';
```

Change notch radius from `14.0` to `12.0` in `_TicketNotchPainter`.

Update `_TicketCard` decoration:
```dart
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          boxShadow: AppConstants.shadowSubtle,
        ),
```

Replace `_GradientDownloadButton` with a ghost PillButton:
```dart
            PillButton(
              label: 'Download Ticket',
              icon: Icons.download_rounded,
              isOutlined: true,
              onPressed: () {},
              width: double.infinity,
            )
```

Remove the `_GradientDownloadButton` class.

- [ ] **Step 2: Update ProfileScreen — remove decorative circles, cleaner info rows**

In `profile_screen.dart`:

Add import:
```dart
import '../../../core/theme/app_constants.dart';
```

Remove both `Positioned` decorative circle containers (lines 26-48).

Update the personal info card decoration:
```dart
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                      boxShadow: AppConstants.shadowSubtle,
                    ),
```

Update `_InfoRow` — increase row height to 56px, use `AppConstants.radiusSmall` for icon container:
```dart
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.spaceMD),
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
              ),
              child: Icon(icon, color: AppColors.deepPurple, size: 18),
            ),
            const SizedBox(width: AppConstants.spaceMD),
            Text(label, style: AppTypography.bodySmall),
            const Spacer(),
            Text(
              value,
              style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
```

- [ ] **Step 3: Update NotificationsScreen — custom pill tabs, teal dot for unread**

In `notifications_screen.dart`:

Add import:
```dart
import '../../../core/theme/app_constants.dart';
```

Replace the `_tabWithBadge` method — use small teal dot instead of number badge:
```dart
  Widget _tabWithBadge(String label, int count) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (count > 0) ...[
            const SizedBox(width: AppConstants.spaceSM),
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.teal,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
```

Update empty state — use `AppConstants.radiusMedium` for the "Explore Deals" button:
```dart
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusSmall)),
                      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceXXL, vertical: AppConstants.spaceMD),
                    ),
```

- [ ] **Step 4: Verify the app compiles**

Run: `cd flyone && flutter analyze`
Expected: No issues found

- [ ] **Step 5: Commit**

```bash
git add flyone/lib/features/ticket/ flyone/lib/features/profile/ flyone/lib/features/notifications/
git commit -m "feat: redesign ticket, profile, notifications — ghost buttons, cleaner layout, dot badges"
```

---

### Task 9: Redesign Chat & Tracking Screens

**Files:**
- Modify: `flyone/lib/features/chat/presentation/chat_screen.dart`
- Modify: `flyone/lib/features/chat/presentation/widgets/chat_bubble.dart`
- Modify: `flyone/lib/features/tracking/presentation/tracking_screen.dart`

- [ ] **Step 1: Update ChatBubble — solid purple (no gradient), 16px radius with 4px corner**

In `chat_bubble.dart`:

Add import:
```dart
import '../../../../core/theme/app_constants.dart';
```

Replace the bubble decoration:
```dart
                decoration: BoxDecoration(
                  color: isUser ? AppColors.deepPurple : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(AppConstants.radiusMedium),
                    topRight: const Radius.circular(AppConstants.radiusMedium),
                    bottomLeft: Radius.circular(isUser ? AppConstants.radiusMedium : 4),
                    bottomRight: Radius.circular(isUser ? 4 : AppConstants.radiusMedium),
                  ),
                ),
```

Remove the `gradient:` and `color:` null toggle — just use `color:` only.

- [ ] **Step 2: Update ChatScreen input bar — floating with rounded corners, teal send button**

In `chat_screen.dart`:

Add import:
```dart
import '../../../core/theme/app_constants.dart';
```

Replace the input bar Container decoration:
```dart
          Container(
            margin: const EdgeInsets.fromLTRB(
              AppConstants.spaceLG, 0, AppConstants.spaceLG, AppConstants.spaceMD,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.spaceMD,
              vertical: AppConstants.spaceSM,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
              boxShadow: AppConstants.shadowSubtle,
            ),
```

Change the send button to teal circle:
```dart
                GestureDetector(
                  onTap: () => _send(_controller.text),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.teal,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                  ),
                ),
```

Update `_SuggestedPromptCard` shadow to `AppConstants.shadowSubtle` and border radius to `AppConstants.radiusMedium`.

- [ ] **Step 3: Update TrackingScreen — softer grid, 24px panel radius**

In `tracking_screen.dart`:

Add import:
```dart
import '../../../core/theme/app_constants.dart';
```

In `_GridPainter.paint`, reduce alpha from `0.3` to `0.15`:
```dart
      ..color = AppColors.lightLilac.withValues(alpha: 0.15)
```

Update the bottom panel decoration:
```dart
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(AppConstants.radiusLarge)),
                boxShadow: AppConstants.shadowSubtle,
              ),
```

Add a drag handle at the top of the panel content:
```dart
                      // Drag handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: AppConstants.spaceLG),
                          decoration: BoxDecoration(
                            color: AppColors.divider,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
```

- [ ] **Step 4: Verify the app compiles**

Run: `cd flyone && flutter analyze`
Expected: No issues found

- [ ] **Step 5: Commit**

```bash
git add flyone/lib/features/chat/ flyone/lib/features/tracking/
git commit -m "feat: redesign chat & tracking — solid bubbles, floating input, softer map grid"
```

---

### Task 10: Redesign Splash & Onboarding Screens

**Files:**
- Modify: `flyone/lib/features/splash/presentation/splash_screen.dart`
- Modify: `flyone/lib/features/onboarding/presentation/onboarding_screen.dart`

- [ ] **Step 1: Update SplashScreen — use standardized tokens**

In `splash_screen.dart`:

Add import:
```dart
import '../../../core/theme/app_constants.dart';
```

Replace the logo container shadows with `AppConstants.shadowElevated`:
```dart
                  boxShadow: AppConstants.shadowElevated,
```

Remove the dual shadow (lines 52-64) and replace with just the one above.

Update border radius from `28` to `AppConstants.radiusLarge`.

- [ ] **Step 2: Update OnboardingScreen — reduce decorative blobs, use tokens**

In `onboarding_screen.dart`:

Add import:
```dart
import '../../../core/theme/app_constants.dart';
```

Reduce the 4 background blobs to 2. Remove the bottom-left and bottom-right blobs (lines 109-132). Keep only the top-left and top-right ones.

Lower the opacity of remaining blobs — change `0.18` to `0.12` and `0.10` to `0.08`.

Update the page indicator dot width from `24` to `20`, remove the active boxShadow.

- [ ] **Step 3: Verify the app compiles**

Run: `cd flyone && flutter analyze`
Expected: No issues found

- [ ] **Step 4: Commit**

```bash
git add flyone/lib/features/splash/ flyone/lib/features/onboarding/
git commit -m "feat: redesign splash & onboarding — cleaner, fewer decorative elements"
```

---

### Task 11: Final Verification & Cleanup

**Files:**
- All modified files

- [ ] **Step 1: Run full analysis**

Run: `cd flyone && flutter analyze`
Expected: No issues found

- [ ] **Step 2: Run tests**

Run: `cd flyone && flutter test`
Expected: All tests pass

- [ ] **Step 3: Run the app on emulator to visual check**

Run: `cd flyone && flutter run`
Expected: App launches, all screens render correctly with new design

- [ ] **Step 4: Final commit if any cleanup needed**

```bash
git add -A
git commit -m "chore: final cleanup for premium minimalist redesign"
```
