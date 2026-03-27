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
      description: 'Book flights, trains, buses and boats all in one place. Your journey starts here.',
      icon: Icons.public_rounded,
      iconColor: AppColors.deepPurple,
    ),
    OnboardingPage(
      title: 'AI-Powered\nPlanning',
      description: 'Smart recommendations, price predictions, and route optimization powered by AI.',
      icon: Icons.auto_awesome_rounded,
      iconColor: AppColors.teal,
    ),
    OnboardingPage(
      title: 'Digital Tickets\n& Tracking',
      description: 'E-tickets with QR codes, real-time tracking, and instant notifications.',
      icon: Icons.qr_code_scanner_rounded,
      iconColor: AppColors.deepPurple,
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: GestureDetector(
                  onTap: () => context.go('/home'),
                  child: Text('Skip', style: AppTypography.bodySmall.copyWith(color: AppColors.teal)),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: _pages,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == i ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == i ? AppColors.deepPurple : AppColors.lightLilac,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  PillButton(
                    label: _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                    onPressed: _next,
                    width: double.infinity,
                  ).animate().fadeIn(duration: 300.ms),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
