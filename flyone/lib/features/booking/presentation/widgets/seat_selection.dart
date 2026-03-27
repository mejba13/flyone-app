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
        Text('Select Seat', style: AppTypography.heading3),
        const SizedBox(height: 12),
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Legend(color: AppColors.lightLilac.withValues(alpha: 0.5), label: 'Available'),
            _Legend(color: AppColors.textSecondary.withValues(alpha: 0.3), label: 'Occupied'),
            _Legend(color: AppColors.teal.withValues(alpha: 0.3), label: 'Premium'),
            _Legend(color: AppColors.deepPurple, label: 'Selected'),
          ],
        ),
        const SizedBox(height: 16),
        // Seat grid
        Center(
          child: Column(
            children: List.generate(seatMap.length, (row) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(3, (col) => _SeatWidget(
                      seatId: '${String.fromCharCode(65 + row)}${col + 1}',
                      status: seatMap[row][col],
                      isSelected: selectedSeat == '${String.fromCharCode(65 + row)}${col + 1}',
                      onTap: seatMap[row][col] != 1
                          ? () => onSeatSelected('${String.fromCharCode(65 + row)}${col + 1}')
                          : null,
                    )),
                    const SizedBox(width: 24),
                    ...List.generate(3, (col) => _SeatWidget(
                      seatId: '${String.fromCharCode(65 + row)}${col + 4}',
                      status: seatMap[row][col + 3],
                      isSelected: selectedSeat == '${String.fromCharCode(65 + row)}${col + 4}',
                      onTap: seatMap[row][col + 3] != 1
                          ? () => onSeatSelected('${String.fromCharCode(65 + row)}${col + 4}')
                          : null,
                    )),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _SeatWidget extends StatelessWidget {
  final String seatId;
  final int status;
  final bool isSelected;
  final VoidCallback? onTap;

  const _SeatWidget({required this.seatId, required this.status, required this.isSelected, this.onTap});

  Color get _color {
    if (isSelected) return AppColors.deepPurple;
    return switch (status) {
      0 => AppColors.lightLilac.withValues(alpha: 0.5),
      1 => AppColors.textSecondary.withValues(alpha: 0.3),
      2 => AppColors.teal.withValues(alpha: 0.3),
      _ => AppColors.lightLilac,
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36, height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            seatId,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : AppColors.textPrimary,
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
        Container(width: 14, height: 14, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 4),
        Text(label, style: AppTypography.caption),
      ],
    );
  }
}
