import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_constants.dart';
import '../../../../core/utils/transport_icon.dart';
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
      width: 280,
      padding: const EdgeInsets.all(AppConstants.spaceLG),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        boxShadow: AppConstants.shadowSubtle,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TransportIcon(
                mode: schedule.transportMode,
                size: 18,
                color: AppColors.deepPurple,
              ),
              const SizedBox(width: AppConstants.spaceSM),
              Expanded(
                child: Text(
                  schedule.carrierName,
                  style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                schedule.date,
                style: AppTypography.caption.copyWith(color: AppColors.teal),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spaceLG),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(schedule.departureCode, style: AppTypography.heading3),
                  Text(schedule.departureTime, style: AppTypography.caption),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(schedule.duration, style: AppTypography.caption),
                    const SizedBox(height: AppConstants.spaceXS),
                    _DashedLine(),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(schedule.arrivalCode, style: AppTypography.heading3),
                  Text(schedule.arrivalTime, style: AppTypography.caption),
                ],
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: PillButton(
              label: 'See Details',
              isSmall: true,
              isOutlined: true,
              onPressed: onTap,
            ),
          ),
        ],
      ),
    );
  }
}

class _DashedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        const dashWidth = 4.0;
        const dashSpace = 3.0;
        final count = (width / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            count,
            (_) => Container(
              width: dashWidth,
              height: 1,
              color: AppColors.divider,
            ),
          ),
        );
      },
    );
  }
}
