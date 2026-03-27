import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class SeatSelection extends StatelessWidget {
  final List<List<int>> seatMap;
  final String? selectedSeat;
  final ValueChanged<String> onSeatSelected;

  const SeatSelection({
    super.key,
    required this.seatMap,
    this.selectedSeat,
    required this.onSeatSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Legend(color: AppColors.surfaceVariant, label: 'Available'),
            _Legend(color: AppColors.textSecondary.withValues(alpha: 0.3), label: 'Occupied'),
            _Legend(color: AppColors.teal.withValues(alpha: 0.3), label: 'Premium'),
            _Legend(color: AppColors.deepPurple, label: 'Selected'),
          ],
        ),
        const SizedBox(height: 20),
        // Column number header
        _ColumnHeader(),
        const SizedBox(height: 8),
        // Seat grid with row labels
        ...List.generate(seatMap.length, (row) {
          final rowLabel = String.fromCharCode(65 + row);
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Row label
                SizedBox(
                  width: 22,
                  child: Text(
                    rowLabel,
                    textAlign: TextAlign.center,
                    style: AppTypography.caption.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                // Left 3 seats
                ...List.generate(3, (col) => _SeatWidget(
                  seatId: '$rowLabel${col + 1}',
                  status: seatMap[row][col],
                  isSelected: selectedSeat == '$rowLabel${col + 1}',
                  onTap: seatMap[row][col] != 1
                      ? () => onSeatSelected('$rowLabel${col + 1}')
                      : null,
                )),
                // Aisle label
                Container(
                  width: 36,
                  alignment: Alignment.center,
                  child: Text(
                    'AISLE',
                    style: TextStyle(
                      fontSize: 7,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary.withValues(alpha: 0.6),
                      letterSpacing: 1,
                    ),
                  ),
                ),
                // Right 3 seats
                ...List.generate(3, (col) => _SeatWidget(
                  seatId: '$rowLabel${col + 4}',
                  status: seatMap[row][col + 3],
                  isSelected: selectedSeat == '$rowLabel${col + 4}',
                  onTap: seatMap[row][col + 3] != 1
                      ? () => onSeatSelected('$rowLabel${col + 4}')
                      : null,
                )),
                const SizedBox(width: 26),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _ColumnHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 26),
        ...List.generate(3, (col) => SizedBox(
          width: 42,
          child: Center(
            child: Text(
              '${col + 1}',
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
        )),
        const SizedBox(width: 36),
        ...List.generate(3, (col) => SizedBox(
          width: 42,
          child: Center(
            child: Text(
              '${col + 4}',
              style: AppTypography.caption.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
        )),
      ],
    );
  }
}

class _SeatWidget extends StatefulWidget {
  final String seatId;
  final int status;
  final bool isSelected;
  final VoidCallback? onTap;

  const _SeatWidget({
    required this.seatId,
    required this.status,
    required this.isSelected,
    this.onTap,
  });

  @override
  State<_SeatWidget> createState() => _SeatWidgetState();
}

class _SeatWidgetState extends State<_SeatWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.18), weight: 40),
      TweenSequenceItem(tween: Tween(begin: 1.18, end: 0.95), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.95, end: 1.0), weight: 30),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void didUpdateWidget(_SeatWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected && !oldWidget.isSelected) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _color {
    if (widget.isSelected) return AppColors.deepPurple;
    return switch (widget.status) {
      0 => AppColors.surfaceVariant,
      1 => AppColors.textSecondary.withValues(alpha: 0.3),
      2 => AppColors.teal.withValues(alpha: 0.3),
      _ => AppColors.surfaceVariant,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Container(
          width: 36,
          height: 36,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: AppColors.deepPurple.withValues(alpha: 0.35),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              widget.seatId,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: widget.isSelected ? Colors.white : AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String label;

  const _Legend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}
