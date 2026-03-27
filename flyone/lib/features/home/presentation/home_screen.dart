import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../domain/home_provider.dart';
import 'widgets/points_badge.dart';
import 'widgets/category_icons.dart';
import 'widgets/upcoming_schedule_card.dart';
import 'widgets/destination_card.dart';
import 'widgets/voucher_carousel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedules = ref.watch(schedulesProvider);
    final destinations = ref.watch(destinationsProvider);
    final vouchers = ref.watch(vouchersProvider);
    final points = ref.watch(userPointsProvider);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.deepPurple,
          onRefresh: () async {
            ref.invalidate(schedulesProvider);
            ref.invalidate(destinationsProvider);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Row(
                    children: [
                      PointsBadge(points: points),
                      const Spacer(),
                      _TopIconButton(
                        icon: Icons.search_rounded,
                        onTap: () => context.go('/search'),
                      ),
                      const SizedBox(width: 10),
                      Stack(
                        children: [
                          _TopIconButton(
                            icon: Icons.notifications_outlined,
                            onTap: () => context.push('/notifications'),
                          ),
                          Positioned(
                            top: 7,
                            right: 7,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 1.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 300.ms),

                const SizedBox(height: 20),

                // Greeting + Hero text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_greeting()}, Mejba',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Travel Made\nEffortless', style: AppTypography.heading1),
                    ],
                  ),
                ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.1, end: 0, duration: 400.ms),

                const SizedBox(height: 24),

                // Category icons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CategoryIcons(
                    onCategoryTap: (mode) => context.go('/search'),
                  ),
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

                const SizedBox(height: 28),

                // Upcoming Schedules
                SectionHeader(title: 'Upcoming Schedules', onViewAll: () {}),
                const SizedBox(height: 12),
                schedules.when(
                  data: (data) => SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: data.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) => UpcomingScheduleCard(
                        schedule: data[index],
                        onTap: () => context.push('/eticket'),
                      ).animate().fadeIn(delay: (100 * index).ms, duration: 300.ms)
                          .slideX(begin: 0.2, end: 0, delay: (100 * index).ms, duration: 300.ms),
                    ),
                  ),
                  loading: () => SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: 2,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (_, __) => const SizedBox(
                        width: 260,
                        child: SkeletonCard(height: 200),
                      ),
                    ),
                  ),
                  error: (e, _) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Error loading schedules', style: AppTypography.bodySmall),
                  ),
                ),

                const SizedBox(height: 28),

                // Recommendations
                SectionHeader(title: 'Recommendations', onViewAll: () {}),
                const SizedBox(height: 12),
                destinations.when(
                  data: (data) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.3,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) => DestinationCard(destination: data[index])
                          .animate()
                          .fadeIn(delay: (100 * index).ms, duration: 300.ms)
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            end: const Offset(1, 1),
                            delay: (100 * index).ms,
                            duration: 300.ms,
                          ),
                    ),
                  ),
                  loading: () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.3,
                      ),
                      itemCount: 4,
                      itemBuilder: (_, __) => const SkeletonCard(height: 140),
                    ),
                  ),
                  error: (e, _) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Error loading destinations', style: AppTypography.bodySmall),
                  ),
                ),

                const SizedBox(height: 28),

                // Vouchers
                SectionHeader(title: 'Vouchers', onViewAll: () {}),
                const SizedBox(height: 12),
                VoucherCarousel(vouchers: vouchers)
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 400.ms),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/chat'),
        backgroundColor: AppColors.deepPurple,
        child: const Icon(Icons.chat_rounded, color: Colors.white),
      ),
    );
  }
}

class _TopIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _TopIconButton({required this.icon, required this.onTap});

  @override
  State<_TopIconButton> createState() => _TopIconButtonState();
}

class _TopIconButtonState extends State<_TopIconButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 1)),
            ],
          ),
          child: Icon(widget.icon, color: AppColors.deepPurple, size: 20),
        ),
      ),
    );
  }
}
