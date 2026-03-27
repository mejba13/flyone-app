enum NotificationCategory { booking, deal, system }

class AppNotification {
  final String id;
  final String title;
  final String description;
  final NotificationCategory category;
  final DateTime timestamp;
  final bool isRead;
  final NotificationIconType iconType;

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

enum NotificationIconType { flight, train, promo, system, payment }
