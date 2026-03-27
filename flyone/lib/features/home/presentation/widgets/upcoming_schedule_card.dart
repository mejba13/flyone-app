import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
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
      width: 260,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightLilac.withValues(alpha: 0.5),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // Subtle gradient overlay at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 48,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.lightLilac.withValues(alpha: 0.05),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header row
                  Row(
                    children: [
                      TransportIcon(
                        mode: schedule.transportMode,
                        size: 20,
                        color: AppColors.deepPurple,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(schedule.tripType, style: AppTypography.caption),
                                Text(
                                  schedule.date,
                                  style: AppTypography.caption.copyWith(color: AppColors.teal),
                                ),
                              ],
                            ),
                            Text(
                              schedule.carrierName,
                              style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Route row with dotted line
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
                                Expanded(
                                  child: _DashedLine(),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: Icon(
                                    TransportIcon.getIcon(schedule.transportMode),
                                    size: 14,
                                    color: AppColors.teal,
                                  ),
                                ),
                                Expanded(
                                  child: _DashedLine(reverse: true),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _RoutePoint(
                        code: schedule.arrivalCode,
                        time: schedule.arrivalTime,
                        isArrival: true,
                      ),
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
                          Text(
                            schedule.baggage,
                            style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Type', style: AppTypography.caption),
                          Text(
                            schedule.travelClass,
                            style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      _PressableSeeDetails(onTap: onTap),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashedLine extends StatelessWidget {
  final bool reverse;
  const _DashedLine({this.reverse = false});

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

class _PressableSeeDetails extends StatefulWidget {
  final VoidCallback? onTap;
  const _PressableSeeDetails({this.onTap});

  @override
  State<_PressableSeeDetails> createState() => _PressableSeeDetailsState();
}

class _PressableSeeDetailsState extends State<_PressableSeeDetails> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: PillButton(
          label: 'See Details',
          isSmall: true,
          isOutlined: true,
          onPressed: widget.onTap,
        ),
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
