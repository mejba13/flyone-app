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
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      _currentPage = (_currentPage + 1) % widget.vouchers.length;
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
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
    return SizedBox(
      height: 140,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.vouchers.length,
        onPageChanged: (i) => setState(() => _currentPage = i),
        itemBuilder: (context, index) {
          final voucher = widget.vouchers[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Container(
              decoration: BoxDecoration(
                color: _parseColor(voucher.bgColorHex),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          voucher.title,
                          style: AppTypography.caption.copyWith(color: AppColors.deepPurple),
                        ),
                        Text(
                          voucher.subtitle,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.deepPurple,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          voucher.discount,
                          style: AppTypography.heading1.copyWith(color: AppColors.deepPurple),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.local_offer_rounded, size: 36, color: AppColors.deepPurple),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
