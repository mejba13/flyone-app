import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/transport_icon.dart';
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

class _SearchScreenState extends ConsumerState<SearchScreen>
    with TickerProviderStateMixin {
  bool _isRoundTrip = false;
  String _from = 'Jakarta';
  String _to = 'Bandung';
  String _fromCode = 'JKT';
  String _toCode = 'BDG';
  DateTime _date = DateTime.now().add(const Duration(days: 7));
  int _passengers = 1;
  String _travelClass = 'Business';

  // Swap button rotation animation
  late final AnimationController _swapController;
  late final Animation<double> _swapRotation;

  // Back button scale animation
  bool _backPressed = false;

  @override
  void initState() {
    super.initState();
    _swapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _swapRotation = Tween<double>(begin: 0, end: math.pi).animate(
      CurvedAnimation(parent: _swapController, curve: Curves.easeInOutBack),
    );
  }

  @override
  void dispose() {
    _swapController.dispose();
    super.dispose();
  }

  void _swapLocations() {
    // Trigger rotation then swap
    _swapController.forward(from: 0).then((_) {
      setState(() {
        final tempName = _from;
        final tempCode = _fromCode;
        _from = _to;
        _fromCode = _toCode;
        _to = tempName;
        _toCode = tempCode;
      });
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
            // Header with elaborate illustration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
              decoration: const BoxDecoration(
                color: Color(0xFFF0EDFF),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  // Back button + grid icon row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back button with scale press state
                      GestureDetector(
                        onTapDown: (_) => setState(() => _backPressed = true),
                        onTapUp: (_) {
                          setState(() => _backPressed = false);
                          context.go('/home');
                        },
                        onTapCancel: () => setState(() => _backPressed = false),
                        child: AnimatedScale(
                          scale: _backPressed ? 0.88 : 1.0,
                          duration: const Duration(milliseconds: 120),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.shadowColor,
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.arrow_back,
                                size: 20, color: AppColors.deepPurple),
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadowColor,
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.grid_view_rounded,
                            size: 20, color: AppColors.deepPurple),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Elaborate illustration with Stack of overlapping shapes
                  SizedBox(
                    width: 220,
                    height: 130,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // Large background circle — lilac
                        Positioned(
                          left: -10,
                          top: 10,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightLilac.withValues(alpha: 0.35),
                            ),
                          ),
                        ),
                        // Medium teal circle — right side
                        Positioned(
                          right: -8,
                          bottom: 0,
                          child: Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.teal.withValues(alpha: 0.22),
                            ),
                          ),
                        ),
                        // Small accent rounded rect — top right
                        Positioned(
                          right: 20,
                          top: 4,
                          child: Container(
                            width: 48,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppColors.deepPurple.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                        // Small lilac pill — bottom left
                        Positioned(
                          left: 8,
                          bottom: 8,
                          child: Container(
                            width: 56,
                            height: 20,
                            decoration: BoxDecoration(
                              color: AppColors.teal.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        // Center card housing the transport icon
                        Container(
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.lightLilac.withValues(alpha: 0.6),
                                blurRadius: 20,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Icon(
                              TransportIcon.getIcon('train'),
                              size: 44,
                              color: AppColors.teal,
                            ),
                          ),
                        ),
                        // Small dot accent — top left
                        Positioned(
                          left: 30,
                          top: 2,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.teal.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                        // Small dot accent — bottom right
                        Positioned(
                          right: 30,
                          bottom: 6,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.lightLilac.withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),
                  Text(
                    'Find Your\nBest Trip',
                    style: AppTypography.heading2,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),

            // Search form card
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lightLilac.withValues(alpha: 0.45),
                      blurRadius: 24,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                    const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    TripTypeToggle(
                      isRoundTrip: _isRoundTrip,
                      onChanged: (v) => setState(() => _isRoundTrip = v),
                    ),
                    const SizedBox(height: 24),
                    LocationSelector(
                      from: _from,
                      to: _to,
                      onSwap: _swapLocations,
                      swapRotation: _swapRotation,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: AppColors.divider),
                    ),
                    DatePickerField(
                      selectedDate: _date,
                      onDateChanged: (d) => setState(() => _date = d),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: AppColors.divider),
                    ),
                    PassengerClassSelector(
                      passengers: _passengers,
                      travelClass: _travelClass,
                      onPassengersChanged: (v) =>
                          setState(() => _passengers = v),
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
              ),
            )
                .animate()
                .fadeIn(delay: 200.ms, duration: 400.ms)
                .slideY(begin: 0.1, end: 0, delay: 200.ms, duration: 400.ms),

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
