import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../domain/profile_provider.dart';
import 'widgets/profile_header.dart';
import 'widgets/loyalty_tier_badge.dart';
import 'widgets/settings_list.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(userProfileProvider);
    final loyalty = ref.watch(loyaltyInfoProvider);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      appBar: AppBar(title: const Text('Profile')),
      body: Stack(
        children: [
          // Header background shape: large lilac circle at 10% opacity
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                color: AppColors.lightLilac.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: -40,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.teal.withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                profile.when(
                  data: (data) => ProfileHeader(name: data['name']!, email: data['email']!)
                      .animate()
                      .fadeIn(duration: 300.ms),
                  loading: () => const CircularProgressIndicator(),
                  error: (_, __) => const Text('Error'),
                ),
                const SizedBox(height: 24),
                LoyaltyTierBadge(info: loyalty)
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 300.ms),
                const SizedBox(height: 24),
                // Personal info card with icons
                profile.when(
                  data: (data) => Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColor,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Personal Info', style: AppTypography.heading3),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Edit',
                                style: AppTypography.bodySmall.copyWith(color: AppColors.teal),
                              ),
                            ),
                          ],
                        ),
                        _InfoRow(
                          label: 'Phone',
                          value: data['phone']!,
                          icon: Icons.phone_rounded,
                        ),
                        _InfoRow(
                          label: 'Nationality',
                          value: data['nationality']!,
                          icon: Icons.flag_rounded,
                        ),
                        _InfoRow(
                          label: 'Passport',
                          value: data['passport']!,
                          icon: Icons.badge_rounded,
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 300.ms, duration: 300.ms),
                  loading: () => const SizedBox(),
                  error: (_, __) => const SizedBox(),
                ),
                const SizedBox(height: 24),
                const SettingsList().animate().fadeIn(delay: 400.ms, duration: 300.ms),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoRow({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.deepPurple, size: 16),
          ),
          const SizedBox(width: 10),
          Text(label, style: AppTypography.bodySmall),
          const Spacer(),
          Text(
            value,
            style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
