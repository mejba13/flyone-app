import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';

class ProfileHeader extends StatefulWidget {
  final String name;
  final String email;

  const ProfileHeader({super.key, required this.name, required this.email});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  bool _cameraPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Background shape: large surfaceVariant circle
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                color: AppColors.surfaceVariant,
                shape: BoxShape.circle,
              ),
            ),
            // Gradient ring around avatar
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.lightLilac, AppColors.teal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: CircleAvatar(
                  backgroundColor: AppColors.lightLilac,
                  child: Text(
                    widget.name[0],
                    style: AppTypography.heading1.copyWith(color: AppColors.deepPurple),
                  ),
                ),
              ),
            ),
            // Camera icon with press animation
            Positioned(
              bottom: 4,
              right: 4,
              child: GestureDetector(
                onTapDown: (_) => setState(() => _cameraPressed = true),
                onTapUp: (_) => setState(() => _cameraPressed = false),
                onTapCancel: () => setState(() => _cameraPressed = false),
                onTap: () {},
                child: AnimatedScale(
                  scale: _cameraPressed ? 0.85 : 1.0,
                  duration: const Duration(milliseconds: 120),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.teal,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(widget.name, style: AppTypography.heading2),
        Text(widget.email, style: AppTypography.bodySmall),
        const SizedBox(height: 4),
        Text(
          'Member since 2023',
          style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
