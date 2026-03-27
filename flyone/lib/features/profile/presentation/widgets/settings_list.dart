import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    final preferenceItems = [
      ('Notifications', Icons.notifications_outlined),
      ('Language', Icons.language_rounded),
      ('Currency', Icons.attach_money_rounded),
    ];

    final accountItems = [
      ('Privacy', Icons.lock_outline_rounded),
      ('Help & Support', Icons.help_outline_rounded),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preferences group
        _CategoryHeader(label: 'Preferences'),
        const SizedBox(height: 8),
        ...preferenceItems.map((item) => _SettingsItem(title: item.$1, icon: item.$2)),
        const SizedBox(height: 16),
        // Account group
        _CategoryHeader(label: 'Account'),
        const SizedBox(height: 8),
        ...accountItems.map((item) => _SettingsItem(title: item.$1, icon: item.$2)),
        // Logout with extra spacing
        const SizedBox(height: 24),
        _SettingsItem(title: 'Logout', icon: Icons.logout_rounded, isLogout: true),
        const SizedBox(height: 24),
        // Version number at the bottom
        Center(
          child: Text(
            'Version 1.0.0',
            style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  final String label;

  const _CategoryHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.caption.copyWith(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
        ),
      ),
    );
  }
}

class _SettingsItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isLogout;

  const _SettingsItem({
    required this.title,
    required this.icon,
    this.isLogout = false,
  });

  @override
  State<_SettingsItem> createState() => _SettingsItemState();
}

class _SettingsItemState extends State<_SettingsItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isLogout ? AppColors.error : AppColors.deepPurple;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: _pressed ? AppColors.surfaceVariant : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(widget.icon, color: color),
          title: Text(
            widget.title,
            style: AppTypography.bodySmall.copyWith(
              color: widget.isLogout ? AppColors.error : null,
            ),
          ),
          trailing: widget.isLogout
              ? null
              : const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
