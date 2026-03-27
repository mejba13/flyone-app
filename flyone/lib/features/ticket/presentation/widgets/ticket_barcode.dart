import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class TicketBarcode extends StatelessWidget {
  final String data;

  const TicketBarcode({super.key, required this.data});

  // Generate a deterministic barcode pattern from the data string
  List<_Bar> _generateBars(String input) {
    // Use the character codes to drive width variation
    final bars = <_Bar>[];
    // Build a longer pattern sequence from input characters
    final seed = input.codeUnits;
    const totalBars = 60;
    for (int i = 0; i < totalBars; i++) {
      final charCode = seed[i % seed.length];
      final bitPos = i % 7;
      final isBlack = ((charCode >> bitPos) & 1) == 1;

      // Vary widths: narrow (1), medium (2), wide (3) based on position
      double width;
      if (i % 11 == 0) {
        width = 4.0; // guard bar
      } else if ((charCode + i) % 5 == 0) {
        width = 3.0;
      } else if ((charCode + i) % 3 == 0) {
        width = 2.0;
      } else {
        width = 1.5;
      }
      bars.add(_Bar(isBlack: isBlack, width: width));
    }
    return bars;
  }

  @override
  Widget build(BuildContext context) {
    final bars = _generateBars(data);

    return Column(
      children: [
        // Barcode strips
        SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: bars.map((bar) => Container(
              width: bar.width,
              margin: const EdgeInsets.symmetric(horizontal: 0.5),
              color: bar.isBlack ? AppColors.deepPurple : Colors.transparent,
            )).toList(),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          data,
          style: AppTypography.caption.copyWith(letterSpacing: 2.5),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.qr_code_scanner_rounded, size: 14, color: AppColors.teal),
            const SizedBox(width: 5),
            Text(
              'Scan for boarding',
              style: AppTypography.label.copyWith(
                color: AppColors.teal,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Bar {
  final bool isBlack;
  final double width;

  const _Bar({required this.isBlack, required this.width});
}
