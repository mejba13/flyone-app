import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/models/ticket.dart';

class TicketInfoCard extends StatelessWidget {
  final Ticket ticket;

  const TicketInfoCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Trip type + carrier
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.lightLilac.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  ticket.tripType,
                  style: AppTypography.caption.copyWith(color: AppColors.deepPurple),
                ),
              ),
              Text(ticket.carrierLogo, style: const TextStyle(fontSize: 24)),
            ],
          ),
          const SizedBox(height: 20),
          // Route
          Row(
            children: [
              Expanded(
                child: _RouteInfo(
                  code: ticket.departureCode,
                  time: ticket.departureTime,
                  label: 'From',
                ),
              ),
              Column(
                children: [
                  Text(ticket.duration, style: AppTypography.caption),
                  const SizedBox(height: 4),
                  const Icon(Icons.flight_rounded, color: AppColors.teal),
                ],
              ),
              Expanded(
                child: _RouteInfo(
                  code: ticket.arrivalCode,
                  time: ticket.arrivalTime,
                  label: 'To',
                  isEnd: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Gate + Terminal + Seat
          Row(
            children: [
              Expanded(child: _InfoBox(label: 'Gate', value: ticket.gate)),
              const SizedBox(width: 12),
              Expanded(child: _InfoBox(label: 'Terminal', value: ticket.terminal)),
              const SizedBox(width: 12),
              Expanded(child: _InfoBox(label: 'Seat', value: ticket.seatNumber)),
            ],
          ),
        ],
      ),
    );
  }
}

class _RouteInfo extends StatelessWidget {
  final String code;
  final String time;
  final String label;
  final bool isEnd;

  const _RouteInfo({
    required this.code,
    required this.time,
    required this.label,
    this.isEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.caption),
        Text(code, style: AppTypography.heading1),
        Text(time, style: AppTypography.bodySmall),
      ],
    );
  }
}

class _InfoBox extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.lightLilac.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(label, style: AppTypography.caption),
          const SizedBox(height: 4),
          Text(value, style: AppTypography.heading2),
        ],
      ),
    );
  }
}
