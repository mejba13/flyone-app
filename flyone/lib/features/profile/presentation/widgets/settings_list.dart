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
      children: items
          .map(
            (item) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(
                  item.$2,
                  color: item.$1 == 'Logout' ? AppColors.error : AppColors.deepPurple,
                ),
                title: Text(
                  item.$1,
                  style: AppTypography.bodySmall.copyWith(
                    color: item.$1 == 'Logout' ? AppColors.error : null,
                  ),
                ),
                trailing: item.$1 != 'Logout'
                    ? const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary)
                    : null,
                onTap: () {},
              ),
            ),
          )
          .toList(),
    );
  }
}
