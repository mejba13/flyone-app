import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/result.dart';
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
