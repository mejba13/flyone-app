import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/pill_button.dart';
import '../../domain/models/schedule.dart';

class UpcomingScheduleCard extends StatelessWidget {
  final Schedule schedule;
  final VoidCallback? onTap;

  const UpcomingScheduleCard({
    super.key,
    required this.schedule,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              Text(schedule.carrierLogo, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(schedule.tripType, style: AppTypography.caption),
                        Text(schedule.date, style: AppTypography.caption.copyWith(color: AppColors.teal)),
                      ],
                    ),
                    Text(schedule.carrierName, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Route row
          Row(
            children: [
              _RoutePoint(code: schedule.departureCode, time: schedule.departureTime),
              Expanded(
                child: Column(
                  children: [
                    Text(schedule.duration, style: AppTypography.caption),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(child: Container(height: 1, color: AppColors.divider)),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(Icons.flight_rounded, size: 14, color: AppColors.teal),
                        ),
                        Expanded(child: Container(height: 1, color: AppColors.divider)),
                      ],
                    ),
                  ],
                ),
              ),
              _RoutePoint(code: schedule.arrivalCode, time: schedule.arrivalTime, isArrival: true),
            ],
          ),
          const SizedBox(height: 12),
          // Footer
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Baggage', style: AppTypography.caption),
                  Text(schedule.baggage, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Type', style: AppTypography.caption),
                  Text(schedule.travelClass, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
              PillButton(
                label: 'See Details',
                isSmall: true,
                isOutlined: true,
                onPressed: onTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RoutePoint extends StatelessWidget {
  final String code;
  final String time;
  final bool isArrival;

  const _RoutePoint({required this.code, required this.time, this.isArrival = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isArrival ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(code, style: AppTypography.heading3),
        Text(time, style: AppTypography.caption),
      ],
    );
  }
}
