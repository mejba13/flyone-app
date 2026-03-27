import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class WalletBalance extends StatelessWidget {
  final double balance;

  const WalletBalance({super.key, required this.balance});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.deepPurple, Color(0xFF4A3F7A)]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Flyone Wallet', style: AppTypography.bodySmall.copyWith(color: Colors.white70)),
                Text('\$${balance.toStringAsFixed(2)}', style: AppTypography.heading3.copyWith(color: Colors.white)),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Top Up', style: AppTypography.buttonSmall.copyWith(color: AppColors.teal)),
          ),
        ],
      ),
    );
  }
}
