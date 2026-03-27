import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class AddCardForm extends StatelessWidget {
  const AddCardForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add New Card', style: AppTypography.heading3),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: 'Card Number', prefixIcon: Icon(Icons.credit_card))),
          const SizedBox(height: 12),
          Row(
            children: const [
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'Expiry', hintText: 'MM/YY'))),
              SizedBox(width: 12),
              Expanded(child: TextField(decoration: InputDecoration(labelText: 'CVV'), obscureText: true)),
            ],
          ),
        ],
      ),
    );
  }
}
