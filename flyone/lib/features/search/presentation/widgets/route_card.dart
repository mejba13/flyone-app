import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/rating_stars.dart';
import '../../domain/models/search_result.dart';

class RouteCard extends StatelessWidget {
  final SearchResult result;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;
  final VoidCallback onBookmarkTap;
  final VoidCallback onTap;

  const RouteCard({
    super.key,
    required this.result,
    required this.isFavorite,
    required this.onFavoriteTap,
    required this.onBookmarkTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            // Carrier row
            Row(
              children: [
                Text(result.carrierLogo, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(result.travelClass, style: AppTypography.caption),
                      Text(result.carrierName, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onFavoriteTap,
                  child: Icon(
                    isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: isFavorite ? AppColors.error : AppColors.textSecondary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: onBookmarkTap,
                  child: const Icon(Icons.bookmark_border_rounded, color: AppColors.textSecondary, size: 22),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Route row
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(result.departureCode, style: AppTypography.heading3),
                    Text(result.departureTime, style: AppTypography.caption),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(result.duration, style: AppTypography.caption),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Expanded(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(height: 1.5, color: AppColors.divider),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(width: 6, height: 6,
                                      decoration: const BoxDecoration(color: AppColors.deepPurple, shape: BoxShape.circle)),
                                    Icon(
                                      result.transportMode == 'flight'
                                          ? Icons.flight_rounded
                                          : result.transportMode == 'train'
                                              ? Icons.train_rounded
                                              : result.transportMode == 'boat'
                                                  ? Icons.sailing_rounded
                                                  : Icons.directions_bus_rounded,
                                      size: 16,
                                      color: AppColors.teal,
                                    ),
                                    Container(width: 6, height: 6,
                                      decoration: const BoxDecoration(color: AppColors.teal, shape: BoxShape.circle)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(result.arrivalCode, style: AppTypography.heading3),
                    Text(result.arrivalTime, style: AppTypography.caption),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Footer row
            Row(
              children: [
                RatingStars(rating: result.rating),
                const SizedBox(width: 12),
                if (result.canReschedule)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.teal.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Ability to reschedule',
                      style: AppTypography.caption.copyWith(color: AppColors.teal, fontWeight: FontWeight.w500),
                    ),
                  ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.deepPurple,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${result.currency} ${result.pricePerPax.toInt()}/pax',
                    style: AppTypography.buttonSmall.copyWith(fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
