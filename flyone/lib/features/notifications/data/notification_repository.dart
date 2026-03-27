import '../../../core/utils/result.dart';
import '../domain/models/app_notification.dart';

abstract class NotificationRepository {
  Future<Result<List<AppNotification>>> getNotifications();
}
