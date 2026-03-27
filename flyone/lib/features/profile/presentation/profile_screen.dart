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
      body: SingleChildScrollView(
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
            // Personal info
            profile.when(
              data: (data) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
                    _InfoRow('Phone', data['phone']!),
                    _InfoRow('Nationality', data['nationality']!),
                    _InfoRow('Passport', data['passport']!),
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
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTypography.bodySmall),
          Text(
            value,
            style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
