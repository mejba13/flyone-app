import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.share_rounded), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_horiz_rounded), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TicketInfoCard(ticket: ticket)
                .animate()
                .fadeIn(duration: 400.ms)
                .slideY(begin: 0.1, end: 0, duration: 400.ms),
            const SizedBox(height: 24),
            // Passenger name
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Passenger Name', style: AppTypography.caption),
                  const SizedBox(height: 4),
                  Text(ticket.passengerName, style: AppTypography.heading3),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms, duration: 300.ms),
            const SizedBox(height: 24),
            TicketQrCode(data: ticket.pnr)
                .animate()
                .fadeIn(delay: 300.ms, duration: 400.ms)
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  delay: 300.ms,
                  duration: 400.ms,
                ),
            const SizedBox(height: 24),
            TicketBarcode(data: ticket.barcodeData)
                .animate()
                .fadeIn(delay: 400.ms, duration: 300.ms),
            const SizedBox(height: 32),
            PillButton(
              label: 'Download Ticket',
              onPressed: () {},
              width: double.infinity,
              backgroundColor: AppColors.teal,
            ).animate().fadeIn(delay: 500.ms, duration: 300.ms),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
