import '../../../core/utils/result.dart';
import '../domain/models/app_notification.dart';
import 'notification_repository.dart';

class MockNotificationRepository implements NotificationRepository {
  @override
  Future<Result<List<AppNotification>>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return Success([
      AppNotification(
        id: '1',
        title: 'Booking Confirmed',
        description: 'Your flight CGK→DPS has been confirmed',
        category: NotificationCategory.booking,
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        iconType: NotificationIconType.flight,
      ),
      AppNotification(
        id: '2',
        title: 'Check-in Open',
        description: 'Online check-in is now available for your flight',
        category: NotificationCategory.booking,
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        iconType: NotificationIconType.flight,
      ),
      AppNotification(
        id: '3',
        title: 'Flash Sale!',
        description: '50% off on all domestic flights this weekend',
        category: NotificationCategory.deal,
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        iconType: NotificationIconType.promo,
      ),
      AppNotification(
        id: '4',
        title: 'Price Drop Alert',
        description: 'Jakarta to Bali fares dropped by 30%',
        category: NotificationCategory.deal,
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        iconType: NotificationIconType.promo,
      ),
      AppNotification(
        id: '5',
        title: 'Payment Received',
        description: 'Payment of \$81 has been processed successfully',
        category: NotificationCategory.booking,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
        iconType: NotificationIconType.payment,
      ),
      AppNotification(
        id: '6',
        title: 'New Feature',
        description: 'AI Travel Assistant is now available! Try it out',
        category: NotificationCategory.system,
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        iconType: NotificationIconType.system,
      ),
      AppNotification(
        id: '7',
        title: 'App Update',
        description: 'Version 1.1 is available with bug fixes',
        category: NotificationCategory.system,
        timestamp: DateTime.now().subtract(const Duration(days: 3)),
        isRead: true,
        iconType: NotificationIconType.system,
      ),
      AppNotification(
        id: '8',
        title: 'Weekend Getaway',
        description: 'Exclusive deals for weekend trips from \$45',
        category: NotificationCategory.deal,
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        iconType: NotificationIconType.promo,
      ),
    ]);
  }
}
