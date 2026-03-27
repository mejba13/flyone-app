import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../core/widgets/toast_notification.dart';
import '../domain/booking_provider.dart';
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

    final addonsTotal = addons.where((a) => a.isSelected).fold(0.0, (s, a) => s + a.price);

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
            // Route summary — gradient card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.lightLilac, AppColors.surfaceVariant],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 16,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('JKT', style: AppTypography.heading1),
                      Text('06:40', style: AppTypography.caption),
                    ],
                  ),
                  Column(
                    children: [
                      Text('1hr 50min', style: AppTypography.caption),
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
                      Text('BDG', style: AppTypography.heading1),
                      Text('08:30', style: AppTypography.caption),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 300.ms),

            const SizedBox(height: 28),
            _SectionDivider(label: 'Passenger Details'),
            const SizedBox(height: 12),
            PassengerForm(
              nameController: _nameController,
              emailController: _emailController,
              phoneController: _phoneController,
            ).animate().fadeIn(delay: 100.ms, duration: 300.ms),

            const SizedBox(height: 28),
            _SectionDivider(label: 'Seat Selection'),
            const SizedBox(height: 12),
            SeatSelection(
              seatMap: seatMap,
              selectedSeat: selectedSeat,
              onSeatSelected: (s) => ref.read(selectedSeatProvider.notifier).state = s,
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms),

            const SizedBox(height: 28),
            _SectionDivider(label: 'Add-ons'),
            const SizedBox(height: 12),
            AddonsSection(
              addons: addons,
              onToggle: (id) => ref.read(addonsProvider.notifier).toggle(id),
            ).animate().fadeIn(delay: 300.ms, duration: 300.ms),

            const SizedBox(height: 28),
            _SectionDivider(label: 'Promo Code'),
            const SizedBox(height: 12),
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
            ).animate().fadeIn(delay: 400.ms, duration: 300.ms),

            const SizedBox(height: 28),
            _SectionDivider(label: 'Price Summary'),
            const SizedBox(height: 12),
            PriceBreakdown(
              basePrice: 81,
              addonsTotal: addonsTotal,
              discount: discount,
              passengers: 1,
            ).animate().fadeIn(delay: 500.ms, duration: 300.ms),

            const SizedBox(height: 24),
            PillButton(
              label: 'Continue to Payment',
              onPressed: () => context.push('/payment'),
              width: double.infinity,
            ).animate().fadeIn(delay: 600.ms, duration: 300.ms),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  final String label;

  const _SectionDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.divider,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: AppTypography.caption.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceVariant,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.divider,
          ),
        ),
      ],
    );
  }
}
