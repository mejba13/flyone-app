import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/pill_button.dart';
import 'widgets/onboarding_page.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  final _pages = const [
    OnboardingPage(
      title: 'Travel Made\nEffortless',
      description:
          'Book flights, trains, buses and boats all in one place. Your journey starts here.',
      icon: Icons.public_rounded,
      iconColor: AppColors.deepPurple,
      orbitIcons: [
        Icons.flight_takeoff_rounded,
        Icons.directions_bus_rounded,
        Icons.directions_boat_rounded,
      ],
    ),
    OnboardingPage(
      title: 'AI-Powered\nPlanning',
      description:
          'Smart recommendations, price predictions, and route optimization powered by AI.',
      icon: Icons.auto_awesome_rounded,
      iconColor: AppColors.teal,
      orbitIcons: [
        Icons.insights_rounded,
        Icons.route_rounded,
        Icons.savings_rounded,
      ],
    ),
    OnboardingPage(
      title: 'Digital Tickets\n& Tracking',
      description:
          'E-tickets with QR codes, real-time tracking, and instant notifications.',
      icon: Icons.qr_code_scanner_rounded,
      iconColor: AppColors.deepPurple,
      orbitIcons: [
        Icons.notifications_active_rounded,
        Icons.location_on_rounded,
        Icons.confirmation_num_rounded,
      ],
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/home');
    }
  }

  bool get _isLastPage => _currentPage == _pages.length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: Stack(
        children: [
          // ── Background floating blobs ──────────────────────────────────
          Positioned(
            top: -60,
            left: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightLilac.withValues(alpha: 0.18),
              ),
            ),
          ),
          Positioned(
            top: 80,
            right: -50,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.teal.withValues(alpha: 0.10),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: -30,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.teal.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.lightLilac.withValues(alpha: 0.12),
              ),
            ),
          ),

          // ── Main content ───────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // Skip button — 44x44 touch target
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, right: 8),
                    child: SizedBox(
                      width: 44,
                      height: 44,
                      child: GestureDetector(
                        onTap: () => context.go('/home'),
                        behavior: HitTestBehavior.opaque,
                        child: Center(
                          child: Text(
                            'Skip',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.teal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Page content with AnimatedSwitcher crossfade
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    children: _pages,
                  ),
                ),

                // Dots + CTA
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                  child: Column(
                    children: [
                      // Page indicator dots with active glow
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _pages.length,
                          (i) {
                            final isActive = _currentPage == i;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: isActive ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isActive
                                    ? AppColors.deepPurple
                                    : AppColors.lightLilac,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: isActive
                                    ? [
                                        BoxShadow(
                                          color: AppColors.deepPurple
                                              .withValues(alpha: 0.40),
                                          blurRadius: 8,
                                          spreadRadius: 1,
                                          offset: const Offset(0, 2),
                                        ),
                                      ]
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Get Started (gradient) on last page, Next (solid purple) otherwise
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: _isLastPage
                            ? PillButton(
                                key: const ValueKey('get_started'),
                                label: 'Get Started',
                                onPressed: _next,
                                width: double.infinity,
                                gradient: AppColors.primaryGradient,
                              )
                            : PillButton(
                                key: const ValueKey('next'),
                                label: 'Next',
                                onPressed: _next,
                                width: double.infinity,
                              ),
                      ).animate().fadeIn(duration: 300.ms),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
