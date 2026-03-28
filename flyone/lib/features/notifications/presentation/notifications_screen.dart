import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_constants.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../domain/models/app_notification.dart';
import '../domain/notification_provider.dart';
import 'widgets/notification_card.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _unreadCount(List<AppNotification> notifications, NotificationCategory category) {
    return notifications.where((n) => n.category == category && !n.isRead).length;
  }

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

  TabBar _buildTabBar(List<AppNotification>? data) {
    if (data != null) {
      return TabBar(
        controller: _tabController,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorColor: Colors.white,
        tabs: [
          _tabWithBadge('Bookings', _unreadCount(data, NotificationCategory.booking)),
          _tabWithBadge('Deals', _unreadCount(data, NotificationCategory.deal)),
          _tabWithBadge('System', _unreadCount(data, NotificationCategory.system)),
        ],
      );
    }
    return TabBar(
      controller: _tabController,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorColor: Colors.white,
      tabs: const [
        Tab(text: 'Bookings'),
        Tab(text: 'Deals'),
        Tab(text: 'System'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.deepPurple, Color(0xFF3D3470)],
              ),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Column(
                  children: [
                    // Title row
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                              ),
                            ),
                            child: const Icon(Icons.arrow_back, size: 20, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Notifications',
                          style: AppTypography.heading1.copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Mark all read',
                            style: AppTypography.caption.copyWith(color: AppColors.teal),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppConstants.spaceLG),
                    // Tab bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.15),
                        ),
                      ),
                      child: notifications.maybeWhen(
                        data: (data) => _buildTabBar(data),
                        orElse: () => _buildTabBar(null),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.03, end: 0, duration: 500.ms, curve: Curves.easeOut),
          // TabBarView below
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTab(notifications, NotificationCategory.booking),
                _buildTab(notifications, NotificationCategory.deal),
                _buildTab(notifications, NotificationCategory.system),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    AsyncValue<List<AppNotification>> notifications,
    NotificationCategory category,
  ) {
    return notifications.when(
      data: (data) {
        final filtered = data.where((n) => n.category == category).toList();
        if (filtered.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.notifications_off_rounded,
                    size: 40,
                    color: AppColors.lightLilac,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'No notifications yet',
                  style: AppTypography.heading3.copyWith(color: AppColors.textPrimary),
                ),
                const SizedBox(height: 8),
                Text(
                  "You're all caught up!\nWe'll notify you when something new arrives.",
                  style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.radiusSmall)),
                    padding: const EdgeInsets.symmetric(horizontal: AppConstants.spaceXXL, vertical: AppConstants.spaceMD),
                  ),
                  child: const Text('Explore Deals'),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: filtered.length,
          itemBuilder: (context, index) => NotificationCard(notification: filtered[index])
              .animate()
              .fadeIn(delay: (80 * index).ms, duration: 300.ms),
        );
      },
      loading: () => ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 3,
        itemBuilder: (_, __) => const Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: SkeletonCard(height: 80),
        ),
      ),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}
