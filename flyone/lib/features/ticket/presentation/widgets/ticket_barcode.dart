import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class TicketBarcode extends StatelessWidget {
  final String data;

  const TicketBarcode({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Simulated barcode
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            30,
            (i) => Container(
              width: i % 3 == 0 ? 3 : 2,
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              color: i % 5 == 0 ? Colors.transparent : AppColors.deepPurple,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(data, style: AppTypography.caption.copyWith(letterSpacing: 2)),
      ],
    );
  }
}
