import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_constants.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/tracking_provider.dart';

class TrackingScreen extends ConsumerWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracking = ref.watch(trackingStreamProvider('booking-1'));

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Live Tracking'),
      ),
      body: Column(
        children: [
          // Enhanced map placeholder with grid pattern and route visualization
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                color: AppColors.lightLilac.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.lightLilac),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    // Grid pattern background
                    CustomPaint(
                      painter: _GridPainter(),
                      child: const SizedBox.expand(),
                    ),
                    // Route visualization (dotted line A to B)
                    CustomPaint(
                      painter: _RoutePainter(),
                      child: const SizedBox.expand(),
                    ),
                    // Center content
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.teal.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.map_rounded,
                              size: 30,
                              color: AppColors.teal.withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Live Map View', style: AppTypography.bodySmall),
                          Text(
                            'Map integration coming soon',
                            style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 400.ms),
          ),
          // Vehicle info panel
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: AppConstants.shadowSubtle,
              ),
              child: tracking.when(
                data: (data) => SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: AppColors.divider,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      // Vehicle info row
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.teal.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.train_rounded, color: AppColors.teal),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Whoosh High-Speed', style: AppTypography.heading3),
                                Text(
                                  'Speed: ${data['speed']}',
                                  style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                                ),
                              ],
                            ),
                          ),
                          // ETA badge with gradient
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.teal, Color(0xFF4DB8B8)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'ETA: ${data['eta']}',
                              style: AppTypography.bodySmall.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Divider between vehicle info and route progress
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Divider(color: AppColors.divider, height: 1),
                      ),
                      Text(
                        'Current Location',
                        style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 2),
                      Text(data['currentStop'] as String, style: AppTypography.heading3),
                      const SizedBox(height: 12),
                      // Progress bar with stop indicators
                      _RouteProgress(progress: data['progress'] as double),
                      const SizedBox(height: 12),
                      // Quick action row: Share location & Contact driver
                      Row(
                        children: [
                          Expanded(
                            child: _QuickActionButton(
                              icon: Icons.share_location_rounded,
                              label: 'Share Location',
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _QuickActionButton(
                              icon: Icons.headset_mic_rounded,
                              label: 'Contact Driver',
                              onTap: () {},
                              filled: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ).animate().fadeIn(duration: 300.ms),
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.teal),
                ),
                error: (e, _) => Center(child: Text('Error: $e')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RouteProgress extends StatelessWidget {
  final double progress;

  const _RouteProgress({required this.progress});

  @override
  Widget build(BuildContext context) {
    const stops = ['Jakarta (CGK)', 'Karawang', 'Purwakarta', 'Bandung (BDG)'];
    const stopPositions = [0.0, 0.33, 0.66, 1.0];

    return Column(
      children: [
        // Progress bar with labeled stop dots
        SizedBox(
          height: 36,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Track
              Positioned(
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.lightLilac.withValues(alpha: 0.3),
                    color: AppColors.teal,
                    minHeight: 8,
                  ),
                ),
              ),
              // Stop dots
              ...List.generate(stops.length, (i) {
                return Align(
                  alignment: Alignment(stopPositions[i] * 2 - 1, 0),
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: progress >= stopPositions[i] ? AppColors.teal : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.teal,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 6),
        // Stop labels
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: stops
              .map(
                (s) => Flexible(
                  child: Text(
                    s,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 9,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool filled;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: filled ? AppColors.deepPurple : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: filled ? Colors.white : AppColors.deepPurple,
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTypography.caption.copyWith(
                color: filled ? Colors.white : AppColors.deepPurple,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Grid pattern painter for map placeholder
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.lightLilac.withValues(alpha: 0.15)
      ..strokeWidth = 0.8;

    const spacing = 28.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Route visualization painter (dotted line from A to B with vehicle dot)
class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint dashPaint = Paint()
      ..color = AppColors.teal.withValues(alpha: 0.6)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final Paint dotPaint = Paint()
      ..color = AppColors.teal
      ..style = PaintingStyle.fill;

    final Paint endPaint = Paint()
      ..color = AppColors.deepPurple
      ..style = PaintingStyle.fill;

    // Route: from bottom-left to top-right with a slight curve
    final start = Offset(size.width * 0.15, size.height * 0.75);
    final end = Offset(size.width * 0.85, size.height * 0.25);
    final midCtrl = Offset(size.width * 0.5, size.height * 0.35);

    // Draw dashed curved route
    final path = Path()..moveTo(start.dx, start.dy);
    path.quadraticBezierTo(midCtrl.dx, midCtrl.dy, end.dx, end.dy);

    final dashPath = _dashPath(path, dashLength: 8, gapLength: 5);
    canvas.drawPath(dashPath, dashPaint);

    // Start point (A)
    canvas.drawCircle(start, 6, endPaint);
    canvas.drawCircle(start, 4, Paint()..color = Colors.white);

    // End point (B)
    canvas.drawCircle(end, 6, endPaint);
    canvas.drawCircle(end, 4, Paint()..color = Colors.white);

    // Vehicle dot along the route (~40%)
    final vehiclePos = _getPointOnQuadratic(start, midCtrl, end, 0.4);
    canvas.drawCircle(vehiclePos, 8, dotPaint);
    canvas.drawCircle(vehiclePos, 5, Paint()..color = Colors.white);
  }

  Offset _getPointOnQuadratic(Offset p0, Offset p1, Offset p2, double t) {
    final x = (1 - t) * (1 - t) * p0.dx + 2 * (1 - t) * t * p1.dx + t * t * p2.dx;
    final y = (1 - t) * (1 - t) * p0.dy + 2 * (1 - t) * t * p1.dy + t * t * p2.dy;
    return Offset(x, y);
  }

  Path _dashPath(Path source, {required double dashLength, required double gapLength}) {
    final dashPath = Path();
    final metrics = source.computeMetrics();
    for (final metric in metrics) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final len = draw ? dashLength : gapLength;
        if (draw) {
          dashPath.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
      }
    }
    return dashPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
