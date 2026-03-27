import 'package:flutter/material.dart';
import 'dart:async';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/voucher.dart';

class VoucherCarousel extends StatefulWidget {
  final List<Voucher> vouchers;

  const VoucherCarousel({super.key, required this.vouchers});

  @override
  State<VoucherCarousel> createState() => _VoucherCarouselState();
}

class _VoucherCarouselState extends State<VoucherCarousel> {
  late final PageController _controller;
  Timer? _autoScrollTimer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.85);
    if (widget.vouchers.length > 1) {
      _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
        if (!mounted || widget.vouchers.isEmpty) return;
        _currentPage = (_currentPage + 1) % widget.vouchers.length;
        _controller.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Color _parseColor(String hex) {
    return Color(int.parse('FF$hex', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.vouchers.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        SizedBox(
          height: 148,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.vouchers.length,
            onPageChanged: (i) => setState(() => _currentPage = i),
            itemBuilder: (context, index) {
              final voucher = widget.vouchers[index];
              final bgColor = _parseColor(voucher.bgColorHex);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Container(
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: bgColor.withValues(alpha: 0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Stack(
                    children: [
                      // Decorative shape on the right
                      Positioned(
                        right: -20,
                        top: -20,
                        child: _DecorativeCircle(color: Colors.white.withValues(alpha: 0.12), size: 110),
                      ),
                      Positioned(
                        right: 40,
                        bottom: -30,
                        child: _DecorativeCircle(color: Colors.white.withValues(alpha: 0.08), size: 80),
                      ),
                      // Dashed separator line (vertical)
                      Positioned(
                        right: 90,
                        top: 16,
                        bottom: 16,
                        child: _DashedVerticalDivider(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            // Text content
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.3),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      voucher.title,
                                      style: AppTypography.caption.copyWith(
                                        color: AppColors.deepPurple,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    voucher.subtitle,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.deepPurple,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    voucher.discount,
                                    style: AppTypography.heading1.copyWith(
                                      color: AppColors.deepPurple,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Right icon area
                            SizedBox(
                              width: 72,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.35),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.local_offer_rounded,
                                      size: 28,
                                      color: AppColors.deepPurple,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Use now',
                                    style: AppTypography.caption.copyWith(
                                      color: AppColors.deepPurple.withValues(alpha: 0.7),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Dot indicators
        const SizedBox(height: 10),
        if (widget.vouchers.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.vouchers.length, (index) {
              final isActive = index == _currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 18 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.deepPurple : AppColors.lightLilac,
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }),
          ),
      ],
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  final Color color;
  final double size;
  const _DecorativeCircle({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

class _DashedVerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        const dashHeight = 5.0;
        const dashSpace = 4.0;
        final count = (height / (dashHeight + dashSpace)).floor();
        return Column(
          children: List.generate(
            count,
            (_) => Padding(
              padding: const EdgeInsets.only(bottom: dashSpace),
              child: Container(
                width: 1,
                height: dashHeight,
                color: AppColors.deepPurple.withValues(alpha: 0.2),
              ),
            ),
          ),
        );
      },
    );
  }
}
