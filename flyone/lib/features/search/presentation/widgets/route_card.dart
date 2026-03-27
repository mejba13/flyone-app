import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/transport_icon.dart';
import '../../../../core/widgets/rating_stars.dart';
import '../../domain/models/search_result.dart';

class RouteCard extends StatefulWidget {
  final SearchResult result;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onBookmarkTap;
  final VoidCallback onTap;

  const RouteCard({
    super.key,
    required this.result,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onBookmarkTap,
    required this.onTap,
  });

  @override
  State<RouteCard> createState() => _RouteCardState();
}

class _RouteCardState extends State<RouteCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Teal left border stripe
                  Container(
                    width: 4,
                    decoration: const BoxDecoration(
                      gradient: AppColors.accentGradient,
                    ),
                  ),
                  // Card content
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          // Carrier row
                          Row(
                            children: [
                              // TransportIcon widget instead of emoji
                              TransportIcon(
                                mode: widget.result.transportMode,
                                size: 20,
                                color: AppColors.teal,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.result.travelClass,
                                        style: AppTypography.caption),
                                    Text(
                                      widget.result.carrierName,
                                      style: AppTypography.bodySmall.copyWith(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.onFavoriteTap,
                                child: Icon(
                                  widget.isFavorite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,
                                  color: widget.isFavorite
                                      ? AppColors.error
                                      : AppColors.textSecondary,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: widget.onBookmarkTap,
                                child: const Icon(
                                    Icons.bookmark_border_rounded,
                                    color: AppColors.textSecondary,
                                    size: 22),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Route row with dashed line
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.result.departureCode,
                                      style: AppTypography.heading3),
                                  Text(widget.result.departureTime,
                                      style: AppTypography.caption),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(widget.result.duration,
                                        style: AppTypography.caption),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              // Dashed route line
                                              _DashedRouteLine(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: 7,
                                                    height: 7,
                                                    decoration: const BoxDecoration(
                                                      color:
                                                          AppColors.deepPurple,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Icon(
                                                    TransportIcon.getIcon(
                                                        widget.result
                                                            .transportMode),
                                                    size: 16,
                                                    color: AppColors.teal,
                                                  ),
                                                  Container(
                                                    width: 7,
                                                    height: 7,
                                                    decoration: const BoxDecoration(
                                                      color: AppColors.teal,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(widget.result.arrivalCode,
                                      style: AppTypography.heading3),
                                  Text(widget.result.arrivalTime,
                                      style: AppTypography.caption),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Footer row
                          Row(
                            children: [
                              RatingStars(rating: widget.result.rating),
                              const SizedBox(width: 10),
                              if (widget.result.canReschedule)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.teal.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.check_circle_outline,
                                          size: 12,
                                          color: AppColors.teal),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Reschedule',
                                        style: AppTypography.caption.copyWith(
                                          color: AppColors.teal,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              const Spacer(),
                              // Price tag with gradient background
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.deepPurple,
                                      Color(0xFF4A3F7A),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '${widget.result.currency} ${widget.result.pricePerPax.toInt()}/pax',
                                  style: AppTypography.buttonSmall
                                      .copyWith(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Dashed horizontal line for the route connector
class _DashedRouteLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, 1.5),
          painter: _DashedRouteLinePainter(),
        );
      },
    );
  }
}

class _DashedRouteLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    final paint = Paint()
      ..color = AppColors.divider
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
          Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2),
          paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
