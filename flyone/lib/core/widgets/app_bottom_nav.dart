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
                style: AppTypography.overline.copyWith(
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
