import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_constants.dart';
import '../../../core/utils/transport_icon.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../domain/models/booking_summary.dart';
import '../domain/bookings_provider.dart';

class BookingsScreen extends ConsumerStatefulWidget {
  const BookingsScreen({super.key});

  @override
  ConsumerState<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends ConsumerState<BookingsScreen>
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

  @override
  Widget build(BuildContext context) {
    final bookings = ref.watch(bookingsProvider);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Gradient Header ──────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.deepPurple,
                  Color(0xFF3D3470),
                ],
              ),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(28),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('My Bookings', style: AppTypography.heading1.copyWith(color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(
                      'Manage your trips and travel history',
                      style: AppTypography.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.7)),
                    ),
                    const SizedBox(height: AppConstants.spaceLG),
                    // Tab bar inside header
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        labelColor: AppColors.deepPurple,
                        unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
                        labelStyle: AppTypography.overline.copyWith(fontWeight: FontWeight.w600),
                        unselectedLabelStyle: AppTypography.overline,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerHeight: 0,
                        tabs: const [
                          Tab(text: 'Upcoming'),
                          Tab(text: 'Completed'),
                          Tab(text: 'Cancelled'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.03, end: 0, duration: 500.ms, curve: Curves.easeOut),

          const SizedBox(height: AppConstants.spaceLG),
          // Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildBookingsList(bookings, BookingStatus.upcoming),
                _buildBookingsList(bookings, BookingStatus.completed),
                _buildBookingsList(bookings, BookingStatus.cancelled),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList(
    AsyncValue<List<BookingSummary>> bookings,
    BookingStatus status,
  ) {
    return bookings.when(
      data: (data) {
        final filtered = data.where((b) => b.status == status).toList();
        if (filtered.isEmpty) return _buildEmptyState(status);
        return ListView.builder(
          padding: EdgeInsets.fromLTRB(20, 0, 20, AppConstants.bottomNavClearance),
          itemCount: filtered.length,
          itemBuilder: (context, index) => _BookingCard(
            booking: filtered[index],
            onTap: () => context.push('/eticket'),
          )
              .animate()
              .fadeIn(delay: (80 * index).ms, duration: 300.ms)
              .slideY(begin: 0.05, end: 0, delay: (80 * index).ms, duration: 300.ms),
        );
      },
      loading: () => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 3,
        itemBuilder: (_, __) => const Padding(
          padding: EdgeInsets.only(bottom: 12),
          child: SkeletonCard(height: 160),
        ),
      ),
      error: (e, _) => Center(child: Text('Error: $e', style: AppTypography.bodySmall)),
    );
  }

  Widget _buildEmptyState(BookingStatus status) {
    final (icon, message) = switch (status) {
      BookingStatus.upcoming => (Icons.flight_takeoff_rounded, 'No upcoming trips'),
      BookingStatus.completed => (Icons.check_circle_outline_rounded, 'No completed trips yet'),
      BookingStatus.cancelled => (Icons.cancel_outlined, 'No cancelled bookings'),
    };

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            ),
            child: Icon(icon, size: 32, color: AppColors.lightLilac),
          ),
          const SizedBox(height: AppConstants.spaceLG),
          Text(message, style: AppTypography.heading3),
          const SizedBox(height: AppConstants.spaceSM),
          Text(
            'Your bookings will appear here',
            style: AppTypography.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _BookingCard extends StatefulWidget {
  final BookingSummary booking;
  final VoidCallback onTap;

  const _BookingCard({required this.booking, required this.onTap});

  @override
  State<_BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<_BookingCard> {
  bool _pressed = false;

  Color get _statusColor => switch (widget.booking.status) {
        BookingStatus.upcoming => AppColors.teal,
        BookingStatus.completed => AppColors.success,
        BookingStatus.cancelled => AppColors.error,
      };

  String get _statusLabel => switch (widget.booking.status) {
        BookingStatus.upcoming => 'UPCOMING',
        BookingStatus.completed => 'COMPLETED',
        BookingStatus.cancelled => 'CANCELLED',
      };

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
        scale: _pressed ? AppConstants.pressScale : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          margin: const EdgeInsets.only(bottom: AppConstants.spaceMD),
          padding: const EdgeInsets.all(AppConstants.spaceLG),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
            boxShadow: AppConstants.shadowSubtle,
          ),
          child: Column(
            children: [
              // Header: carrier + status
              Row(
                children: [
                  TransportIcon(
                    mode: widget.booking.transportMode,
                    size: 16,
                    color: AppColors.deepPurple,
                  ),
                  const SizedBox(width: AppConstants.spaceSM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.booking.carrierName,
                          style: AppTypography.overline.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${widget.booking.travelClass}  ·  ${widget.booking.date}',
                          style: AppTypography.caption,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spaceSM,
                      vertical: AppConstants.spaceXS,
                    ),
                    decoration: BoxDecoration(
                      color: _statusColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                    ),
                    child: Text(
                      _statusLabel,
                      style: AppTypography.label.copyWith(
                        color: _statusColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spaceLG),
              // Route row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.booking.departureCode, style: AppTypography.routeCode.copyWith(fontSize: 20)),
                        const SizedBox(height: 2),
                        Text(widget.booking.departureTime, style: AppTypography.caption),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(widget.booking.duration, style: AppTypography.caption.copyWith(fontWeight: FontWeight.w500)),
                        const SizedBox(height: AppConstants.spaceXS),
                        Row(
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.deepPurple,
                                shape: BoxShape.circle,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: AppColors.divider,
                              ),
                            ),
                            Icon(
                              TransportIcon.getIcon(widget.booking.transportMode),
                              size: 14,
                              color: AppColors.teal,
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: AppColors.divider,
                              ),
                            ),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: AppColors.teal,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(widget.booking.arrivalCode, style: AppTypography.routeCode.copyWith(fontSize: 20)),
                        const SizedBox(height: 2),
                        Text(widget.booking.arrivalTime, style: AppTypography.caption),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.spaceLG),
              // Footer: PNR + price
              Container(
                padding: const EdgeInsets.all(AppConstants.spaceMD),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.confirmation_number_outlined, size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text('PNR', style: AppTypography.label.copyWith(color: AppColors.textSecondary)),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.booking.pnr,
                          style: AppTypography.overline.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${widget.booking.currency}${widget.booking.price.toInt()}',
                      style: AppTypography.price.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.spaceMD),
              // Tap to view
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('View ticket', style: AppTypography.caption.copyWith(color: AppColors.teal, fontWeight: FontWeight.w500)),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward_ios_rounded, size: 10, color: AppColors.teal),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
