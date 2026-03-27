import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/theme/app_colors.dart';

class TicketQrCode extends StatelessWidget {
  final String data;

  const TicketQrCode({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: QrImageView(
          data: data,
          version: QrVersions.auto,
          size: 160,
          eyeStyle: const QrEyeStyle(
            color: AppColors.deepPurple,
            eyeShape: QrEyeShape.circle,
          ),
          dataModuleStyle: const QrDataModuleStyle(
            color: AppColors.deepPurple,
            dataModuleShape: QrDataModuleShape.circle,
          ),
        ),
      ),
    );
  }
}
