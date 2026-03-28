import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_constants.dart';
import '../../../core/widgets/pill_button.dart';
import '../data/mock_ticket_data.dart';
import 'widgets/ticket_info_card.dart';
import 'widgets/ticket_qr_code.dart';
import 'widgets/ticket_barcode.dart';

class ETicketScreen extends StatelessWidget {
  const ETicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ticket = MockTicketData.ticket;

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
                    Expanded(
                      child: Text('E-Ticket', style: AppTypography.heading1.copyWith(color: Colors.white)),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                        child: const Icon(Icons.share_rounded, size: 20, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                        ),
                        child: const Icon(Icons.more_horiz_rounded, size: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Main ticket card with notch effect
            _TicketCard(
              child: Column(
                children: [
                  TicketInfoCard(ticket: ticket)
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.1, end: 0, duration: 400.ms),
                  const SizedBox(height: 4),
                  // Dashed tear line
                  const _TicketTearLine(),
                  const SizedBox(height: 12),
                  // Passenger name section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Passenger Name', style: AppTypography.caption),
                              const SizedBox(height: 2),
                              Text(ticket.passengerName, style: AppTypography.heading3),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Travel Class', style: AppTypography.caption),
                            const SizedBox(height: 2),
                            Text(ticket.travelClass, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
                  const SizedBox(height: 12),
                  // Dashed tear line before QR
                  const _TicketTearLine(),
                  const SizedBox(height: 16),
                  TicketQrCode(data: ticket.pnr)
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 400.ms)
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1, 1),
                        delay: 300.ms,
                        duration: 400.ms,
                      ),
                  const SizedBox(height: 16),
                  // Dashed tear line before barcode
                  const _TicketTearLine(),
                  const SizedBox(height: 16),
                  TicketBarcode(data: ticket.barcodeData)
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 300.ms),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 32),
            PillButton(
              label: 'Download Ticket',
              icon: Icons.download_rounded,
              isOutlined: true,
              onPressed: () {},
              width: double.infinity,
            ).animate().fadeIn(delay: 500.ms, duration: 300.ms),
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

/// Ticket card with notch cutouts on left and right sides
class _TicketCard extends StatelessWidget {
  final Widget child;

  const _TicketCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TicketNotchPainter(),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          boxShadow: AppConstants.shadowSubtle,
        ),
        child: child,
      ),
    );
  }
}

class _TicketNotchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.softWhite
      ..style = PaintingStyle.fill;

    const notchRadius = 12.0;
    // Position the notches roughly where the tear lines are (about 55% from top)
    final notchY = size.height * 0.55;

    // Left notch
    canvas.drawCircle(Offset(0, notchY), notchRadius, paint);
    // Right notch
    canvas.drawCircle(Offset(size.width, notchY), notchRadius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TicketTearLine extends StatelessWidget {
  const _TicketTearLine();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 8.0;
        const dashSpace = 5.0;
        final count = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          children: List.generate(
            count,
            (_) => Container(
              width: dashWidth,
              height: 1.5,
              margin: const EdgeInsets.only(right: dashSpace),
              color: AppColors.divider,
            ),
          ),
        );
      },
    );
  }
}

