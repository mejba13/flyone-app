import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/theme/app_constants.dart';
import '../../../../core/widgets/skeleton_loader.dart';
import '../../domain/models/destination.dart';

class DestinationCard extends StatelessWidget {
  final Destination destination;
  final VoidCallback? onTap;

  const DestinationCard({super.key, required this.destination, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          boxShadow: AppConstants.shadowSubtle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: destination.imageUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => const SkeletonLoader(height: 180),
                errorWidget: (_, __, ___) => Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.lightLilac, AppColors.surfaceVariant],
                    ),
                  ),
                  child: const Center(
                    child: Icon(Icons.image_rounded, color: AppColors.deepPurple, size: 32),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.70),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: AppConstants.spaceMD,
                left: AppConstants.spaceMD,
                right: AppConstants.spaceMD,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        destination.name,
                        style: AppTypography.bodySmall.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.spaceSM,
                        vertical: AppConstants.spaceXS,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.20),
                        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
                      ),
                      child: Text(
                        destination.price,
                        style: AppTypography.caption.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
