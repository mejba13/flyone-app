import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
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
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor.withValues(alpha: 0.18),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              // Image
              CachedNetworkImage(
                imageUrl: destination.imageUrl,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
                placeholder: (_, __) => const SkeletonLoader(height: 140),
                errorWidget: (_, __, ___) => Container(
                  height: 140,
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

              // Bottom gradient overlay — covers bottom 40%
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 80,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.75),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Bookmark icon top-right
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.25),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.bookmark_border_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),

              // Name and price
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      const SizedBox(width: 4),
                      Text(
                        destination.price,
                        style: AppTypography.caption.copyWith(color: AppColors.teal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
