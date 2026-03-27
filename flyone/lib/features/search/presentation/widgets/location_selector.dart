import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class LocationSelector extends StatelessWidget {
  final String from;
  final String to;
  final VoidCallback onSwap;
  final VoidCallback? onFromTap;
  final VoidCallback? onToTap;
  // Optional rotation animation passed in from parent (swap button)
  final Animation<double>? swapRotation;

  const LocationSelector({
    super.key,
    required this.from,
    required this.to,
    required this.onSwap,
    this.onFromTap,
    this.onToTap,
    this.swapRotation,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _LocationField(
                label: 'From',
                value: from,
                isFrom: true,
                onTap: onFromTap,
              ),
              // Dashed separator between From and To
              Padding(
                padding: const EdgeInsets.only(left: 9, top: 8, bottom: 8),
                child: _DashedLine(),
              ),
              _LocationField(
                label: 'To',
                value: to,
                isFrom: false,
                onTap: onToTap,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Swap button with rotation animation
        GestureDetector(
          onTap: onSwap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.teal,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.teal.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: swapRotation != null
                ? AnimatedBuilder(
                    animation: swapRotation!,
                    builder: (context, child) => Transform.rotate(
                      angle: swapRotation!.value,
                      child: child,
                    ),
                    child: const Icon(Icons.swap_vert_rounded,
                        color: Colors.white, size: 22),
                  )
                : const Icon(Icons.swap_vert_rounded,
                    color: Colors.white, size: 22),
          ),
        ),
      ],
    );
  }
}

/// A short vertical dashed line drawn with a CustomPainter
class _DashedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(2, 20),
      painter: _DashedLinePainter(),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashHeight = 4.0;
    const dashSpace = 3.0;
    final paint = Paint()
      ..color = AppColors.divider
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LocationField extends StatefulWidget {
  final String label;
  final String value;
  final bool isFrom;
  final VoidCallback? onTap;

  const _LocationField({
    required this.label,
    required this.value,
    required this.isFrom,
    this.onTap,
  });

  @override
  State<_LocationField> createState() => _LocationFieldState();
}

class _LocationFieldState extends State<_LocationField> {
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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: _pressed
              ? AppColors.surfaceVariant.withValues(alpha: 0.6)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Visually distinct icon: colored dot for From, filled pin for To
            widget.isFrom
                ? Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.teal,
                    ),
                  )
                : const Icon(
                    Icons.location_on_rounded,
                    size: 16,
                    color: AppColors.deepPurple,
                  ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.label, style: AppTypography.caption),
                Text(
                  widget.value,
                  style: AppTypography.body
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
