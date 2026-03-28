import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_constants.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../core/widgets/toast_notification.dart';
import '../domain/booking_provider.dart';
import '../../search/domain/search_provider.dart';
import 'widgets/passenger_form.dart';
import 'widgets/seat_selection.dart';
import 'widgets/addons_section.dart';
import 'widgets/promo_code_field.dart';
import 'widgets/price_breakdown.dart';

class BookingDetailScreen extends ConsumerStatefulWidget {
  const BookingDetailScreen({super.key});

  @override
  ConsumerState<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends ConsumerState<BookingDetailScreen> {
  final _nameController = TextEditingController(text: 'Mejba Ahmed');
  final _emailController = TextEditingController(text: 'mejba@email.com');
  final _phoneController = TextEditingController(text: '+62 812 3456 7890');
  final _promoController = TextEditingController();
  bool _promoApplied = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addons = ref.watch(addonsProvider);
    final selectedSeat = ref.watch(selectedSeatProvider);
    final repo = ref.read(bookingRepositoryProvider);
    final seatMap = repo.getSeatMap();
    final discount = ref.watch(promoDiscountProvider);
    final selectedRoute = ref.watch(selectedResultProvider);

    final addonsTotal = addons.where((a) => a.isSelected).fold(0.0, (s, a) => s + a.price);

    final departureCode = selectedRoute?.departureCode ?? 'JKT';
    final arrivalCode = selectedRoute?.arrivalCode ?? 'BDG';
    final departureTime = selectedRoute?.departureTime ?? '06:40';
    final arrivalTime = selectedRoute?.arrivalTime ?? '08:30';
    final routeDuration = selectedRoute?.duration ?? '1hr 50min';
    final basePrice = selectedRoute?.pricePerPax ?? 81.0;

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: Column(
        children: [
          // ── Gradient Header ──────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.deepPurple, Color(0xFF3D3470)],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                        child: const Icon(Icons.arrow_back, size: 20, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text('Booking Details', style: AppTypography.heading1.copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Route summary — softened gradient card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.lightLilac.withValues(alpha: 0.7),
                    AppColors.surfaceVariant.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                boxShadow: AppConstants.shadowSubtle,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(departureCode, style: AppTypography.routeCode),
                      const SizedBox(height: 2),
                      Text(departureTime, style: AppTypography.caption),
                    ],
                  ),
                  Column(
                    children: [
                      Text(routeDuration, style: AppTypography.caption.copyWith(fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.7),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.flight_rounded, color: AppColors.teal, size: 22),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(arrivalCode, style: AppTypography.routeCode),
                      const SizedBox(height: 2),
                      Text(arrivalTime, style: AppTypography.caption),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),

            const SizedBox(height: AppConstants.spaceXXL),
            const _SectionLabel('PASSENGER DETAILS'),
            const SizedBox(height: AppConstants.spaceLG),
            PassengerForm(
              nameController: _nameController,
              emailController: _emailController,
              phoneController: _phoneController,
            ).animate().fadeIn(delay: (80 * 1).ms, duration: 300.ms),

            const SizedBox(height: AppConstants.spaceXXL),
            const _SectionLabel('SEAT SELECTION'),
            const SizedBox(height: AppConstants.spaceLG),
            SeatSelection(
              seatMap: seatMap,
              selectedSeat: selectedSeat,
              onSeatSelected: (s) => ref.read(selectedSeatProvider.notifier).state = s,
            ).animate().fadeIn(delay: (80 * 2).ms, duration: 300.ms),

            const SizedBox(height: AppConstants.spaceXXL),
            const _SectionLabel('ADD-ONS'),
            const SizedBox(height: AppConstants.spaceLG),
            AddonsSection(
              addons: addons,
              onToggle: (id) => ref.read(addonsProvider.notifier).toggle(id),
            ).animate().fadeIn(delay: (80 * 3).ms, duration: 300.ms),

            const SizedBox(height: AppConstants.spaceXXL),
            const _SectionLabel('PROMO CODE'),
            const SizedBox(height: AppConstants.spaceLG),
            PromoCodeField(
              controller: _promoController,
              isApplied: _promoApplied,
              onApply: () {
                if (_promoController.text.toUpperCase() == 'WELCOME30') {
                  ref.read(promoDiscountProvider.notifier).state = 24.3;
                  setState(() => _promoApplied = true);
                  ToastNotification.show(context, message: 'Promo applied! -\$24', type: ToastType.success);
                } else {
                  ToastNotification.show(context, message: 'Invalid promo code', type: ToastType.error);
                }
              },
            ).animate().fadeIn(delay: (80 * 4).ms, duration: 300.ms),

            const SizedBox(height: AppConstants.spaceXXL),
            const _SectionLabel('PRICE SUMMARY'),
            const SizedBox(height: AppConstants.spaceLG),
            PriceBreakdown(
              basePrice: basePrice,
              addonsTotal: addonsTotal,
              discount: discount,
              passengers: 1,
            ).animate().fadeIn(delay: (80 * 5).ms, duration: 300.ms),

            const SizedBox(height: AppConstants.spaceXXL),
            PillButton(
              label: 'Continue to Payment',
              onPressed: () => context.push('/payment'),
              width: double.infinity,
            ).animate().fadeIn(delay: (80 * 6).ms, duration: 300.ms),
            const SizedBox(height: AppConstants.bottomNavClearance),
          ],
        ),
      ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String title;
  const _SectionLabel(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(title, style: AppTypography.label.copyWith(
        color: AppColors.textSecondary,
      )),
    );
  }
}
