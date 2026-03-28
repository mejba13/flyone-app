import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_constants.dart';
import '../domain/profile_provider.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Gradient Profile Header ──────────────
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.deepPurple,
                    Color(0xFF3D3470),
                  ],
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
                  child: Column(
                    children: [
                      // Title row
                      Row(
                        children: [
                          Text('Profile', style: AppTypography.heading1.copyWith(color: Colors.white)),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                              ),
                              child: const Icon(Icons.settings_rounded, color: Colors.white, size: 20),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Profile info inline
                      profile.when(
                        data: (data) => Row(
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2.5),
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  'https://randomuser.me/api/portraits/men/32.jpg',
                                  width: 72,
                                  height: 72,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: AppColors.teal.withValues(alpha: 0.3),
                                    child: Center(
                                      child: Text(
                                        data['name']!.split(' ').map((n) => n[0]).take(2).join(),
                                        style: AppTypography.heading2.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['name']!, style: AppTypography.heading2.copyWith(color: Colors.white)),
                                  const SizedBox(height: 4),
                                  Text(data['email']!, style: AppTypography.bodySmall.copyWith(color: Colors.white.withValues(alpha: 0.7))),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.teal.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                                      border: Border.all(color: AppColors.teal.withValues(alpha: 0.4)),
                                    ),
                                    child: Text(
                                      'Gold Member',
                                      style: AppTypography.label.copyWith(color: AppColors.teal),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ).animate().fadeIn(duration: 400.ms),
                        loading: () => const CircularProgressIndicator(color: Colors.white),
                        error: (_, __) => const SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.03, end: 0, duration: 500.ms, curve: Curves.easeOut),

            // ── Content below header ──────────────
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  LoyaltyTierBadge(info: loyalty)
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 300.ms),
                  const SizedBox(height: 24),
                  // Personal info card
                  profile.when(
                    data: (data) => Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                        boxShadow: AppConstants.shadowSubtle,
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
                  const SizedBox(height: AppConstants.bottomNavClearance),
                ],
              ),
            ),
          ],
        ),
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
      padding: const EdgeInsets.only(bottom: AppConstants.spaceMD),
      child: SizedBox(
        height: 56,
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
              ),
              child: Icon(icon, color: AppColors.deepPurple, size: 18),
            ),
            const SizedBox(width: AppConstants.spaceMD),
            Text(label, style: AppTypography.bodySmall),
            const Spacer(),
            Text(
              value,
              style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
