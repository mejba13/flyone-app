import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/app_notification.dart';

class NotificationCard extends StatelessWidget {
  final AppNotification notification;

  const NotificationCard({super.key, required this.notification});

  IconData get _icon => switch (notification.iconType) {
    NotificationIconType.flight => Icons.flight_rounded,
    NotificationIconType.train => Icons.train_rounded,
    NotificationIconType.promo => Icons.local_offer_rounded,
    NotificationIconType.system => Icons.info_rounded,
    NotificationIconType.payment => Icons.payment_rounded,
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
            width: 40,
            height: 40,
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
                    Expanded(
                      child: Text(
                        notification.title,
                        style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(_timeAgo, style: AppTypography.caption),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification.description,
                  style: AppTypography.caption,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (!notification.isRead)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(top: 6, left: 8),
              decoration: const BoxDecoration(color: AppColors.teal, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}
