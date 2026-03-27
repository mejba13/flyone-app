import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/pill_button.dart';
import '../../../core/widgets/section_header.dart';
import '../domain/models/search_query.dart';
import '../domain/search_provider.dart';
import '../../home/domain/home_provider.dart';
import '../../home/presentation/widgets/voucher_carousel.dart';
import 'widgets/trip_type_toggle.dart';
import 'widgets/location_selector.dart';
import 'widgets/date_picker_field.dart';
import 'widgets/passenger_class_selector.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  bool _isRoundTrip = false;
  String _from = 'Jakarta';
  String _to = 'Bandung';
  String _fromCode = 'JKT';
  String _toCode = 'BDG';
  DateTime _date = DateTime.now().add(const Duration(days: 7));
  int _passengers = 1;
  String _travelClass = 'Business';

  void _swapLocations() {
    setState(() {
      final tempName = _from;
      final tempCode = _fromCode;
      _from = _to;
      _fromCode = _toCode;
      _to = tempName;
      _toCode = tempCode;
    });
  }

  void _search() {
    ref.read(searchQueryProvider.notifier).state = SearchQuery(
      from: _from,
      to: _to,
      fromCode: _fromCode,
      toCode: _toCode,
      date: _date,
      passengers: _passengers,
      travelClass: _travelClass,
      isRoundTrip: _isRoundTrip,
    );
    context.push('/search-results');
  }

  @override
  Widget build(BuildContext context) {
    final vouchers = ref.watch(vouchersProvider);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with illustration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
              decoration: BoxDecoration(
                color: AppColors.lightLilac.withValues(alpha: 0.3),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  // Back button + grid icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => context.go('/home'),
                        child: Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.arrow_back, size: 20, color: AppColors.deepPurple),
                        ),
                      ),
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.grid_view_rounded, size: 20, color: AppColors.deepPurple),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Illustration placeholder
                  Container(
                    width: 200, height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.teal.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.train_rounded, size: 60, color: AppColors.teal),
                  ),
                  const SizedBox(height: 16),
                  Text('Find Your\nBest Trip',
                    style: AppTypography.heading1,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),

            // Search form
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4)),
                  ],
                ),
                child: Column(
                  children: [
                    TripTypeToggle(isRoundTrip: _isRoundTrip, onChanged: (v) => setState(() => _isRoundTrip = v)),
                    const SizedBox(height: 24),
                    LocationSelector(from: _from, to: _to, onSwap: _swapLocations),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: AppColors.divider),
                    ),
                    DatePickerField(selectedDate: _date, onDateChanged: (d) => setState(() => _date = d)),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: AppColors.divider),
                    ),
                    PassengerClassSelector(
                      passengers: _passengers,
                      travelClass: _travelClass,
                      onPassengersChanged: (v) => setState(() => _passengers = v),
                      onClassChanged: (v) => setState(() => _travelClass = v),
                    ),
                    const SizedBox(height: 24),
                    PillButton(
                      label: 'Search',
                      onPressed: _search,
                      width: double.infinity,
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0, delay: 200.ms, duration: 400.ms),
            ),

            // Vouchers section
            SectionHeader(title: 'Vouchers', onViewAll: () {}),
            const SizedBox(height: 12),
            VoucherCarousel(vouchers: vouchers),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
