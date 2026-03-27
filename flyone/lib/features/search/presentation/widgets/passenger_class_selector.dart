import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class PassengerClassSelector extends StatelessWidget {
  final int passengers;
  final String travelClass;
  final ValueChanged<int> onPassengersChanged;
  final ValueChanged<String> onClassChanged;

  const PassengerClassSelector({
    super.key,
    required this.passengers,
    required this.travelClass,
    required this.onPassengersChanged,
    required this.onClassChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPicker(context),
      child: Row(
        children: [
          const Icon(Icons.person_rounded, size: 18, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Passenger', style: AppTypography.caption),
              Text(
                '$passengers Passenger${passengers > 1 ? 's' : ''}, $travelClass',
                style: AppTypography.body.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPicker(BuildContext context) {
    int tempPassengers = passengers;
    String tempClass = travelClass;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Passengers & Class', style: AppTypography.heading3),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Passengers', style: AppTypography.body),
                  Row(
                    children: [
                      IconButton(
                        onPressed: tempPassengers > 1
                            ? () => setModalState(() => tempPassengers--)
                            : null,
                        icon: const Icon(Icons.remove_circle_outline),
                        color: AppColors.deepPurple,
                      ),
                      Text('$tempPassengers', style: AppTypography.heading3),
                      IconButton(
                        onPressed: tempPassengers < 9
                            ? () => setModalState(() => tempPassengers++)
                            : null,
                        icon: const Icon(Icons.add_circle_outline),
                        color: AppColors.deepPurple,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('Class', style: AppTypography.body),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: ['Economy', 'Business', 'First'].map((c) {
                  final isSelected = c == tempClass;
                  return ChoiceChip(
                    label: Text(c),
                    selected: isSelected,
                    selectedColor: AppColors.lightLilac,
                    labelStyle: TextStyle(
                      color: isSelected ? AppColors.deepPurple : AppColors.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                    onSelected: (_) => setModalState(() => tempClass = c),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onPassengersChanged(tempPassengers);
                    onClassChanged(tempClass);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepPurple,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  child: Text('Confirm', style: AppTypography.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
