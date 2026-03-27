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

  // Gradient backgrounds matching category
  List<Color> get _iconGradient => switch (notification.category) {
    NotificationCategory.booking => [AppColors.deepPurple, const Color(0xFF4A3F7A)],
    NotificationCategory.deal => [AppColors.teal, const Color(0xFF4DB8B8)],
    NotificationCategory.system => [AppColors.textSecondary, const Color(0xFFB0B0C0)],
  };

  String get _timeAgo {
    final diff = DateTime.now().difference(notification.timestamp);
    if (diff.inMinutes < 5) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} min';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: notification.isRead ? Colors.white : AppColors.lightLilac.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(
            color: notification.isRead ? Colors.transparent : AppColors.teal,
            width: 2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gradient icon container
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _iconGradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(_icon, color: Colors.white, size: 20),
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
          ),
          // Swipe-to-dismiss hint: subtle chevron on right edge
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Center(
              child: Opacity(
                opacity: 0.18,
                child: const Icon(
                  Icons.chevron_left_rounded,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
