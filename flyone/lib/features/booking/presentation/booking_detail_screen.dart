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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Booking Details'),
      ),
      body: SingleChildScrollView(
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
                      Text(departureCode, style: AppTypography.heading1),
                      Text(departureTime, style: AppTypography.caption),
                    ],
                  ),
                  Column(
                    children: [
                      Text(routeDuration, style: AppTypography.caption),
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
                      Text(arrivalCode, style: AppTypography.heading1),
                      Text(arrivalTime, style: AppTypography.caption),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),

            const SizedBox(height: AppConstants.spaceXXL),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('PASSENGER DETAILS', style: AppTypography.label.copyWith(
                color: AppColors.textSecondary,
              )),
            ),
            const SizedBox(height: AppConstants.spaceLG),
            PassengerForm(
              nameController: _nameController,
              emailController: _emailController,
              phoneController: _phoneController,
            ).animate().fadeIn(delay: 80.ms, duration: 300.ms),

            const SizedBox(height: AppConstants.spaceXXL),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('SEAT SELECTION', style: AppTypography.label.copyWith(
                color: AppColors.textSecondary,
              )),
            ),
            const SizedBox(height: AppConstants.spaceLG),
            SeatSelection(
              seatMap: seatMap,
              selectedSeat: selectedSeat,
              onSeatSelected: (s) => ref.read(selectedSeatProvider.notifier).state = s,
            ).animate().fadeIn(delay: 80.ms, duration: 300.ms),

            const SizedBox(height: AppConstants.spaceXXL),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('ADD-ONS', style: AppTypography.label.copyWith(
                color: AppColors.textSecondary,
              )),
            ),
            const SizedBox(height: AppConstants.spaceLG),
            AddonsSection(
              addons: addons,
              onToggle: (id) => ref.read(addonsProvider.notifier).toggle(id),
            ).animate().fadeIn(delay: 80.ms, duration: 300.ms),

            const SizedBox(height: AppConstants.spaceXXL),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('PROMO CODE', style: AppTypography.label.copyWith(
                color: AppColors.textSecondary,
              )),
            ),
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
            ).animate().fadeIn(delay: 80.ms, duration: 300.ms),

            const SizedBox(height: AppConstants.spaceXXL),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('PRICE SUMMARY', style: AppTypography.label.copyWith(
                color: AppColors.textSecondary,
              )),
            ),
            const SizedBox(height: AppConstants.spaceLG),
            PriceBreakdown(
              basePrice: basePrice,
              addonsTotal: addonsTotal,
              discount: discount,
              passengers: 1,
            ).animate().fadeIn(delay: 80.ms, duration: 300.ms),

            const SizedBox(height: AppConstants.spaceXXL),
            PillButton(
              label: 'Continue to Payment',
              onPressed: () => context.push('/payment'),
              width: double.infinity,
            ).animate().fadeIn(delay: 80.ms, duration: 300.ms),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
