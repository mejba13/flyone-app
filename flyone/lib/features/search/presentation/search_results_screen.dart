import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../domain/search_provider.dart';
import 'widgets/route_card.dart';
import 'widgets/filter_sort_bar.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  ConsumerState<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen> {
  String _selectedFilter = 'Best';

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);
    final results = ref.watch(searchResultsProvider);
    final favorites = ref.watch(favoritesProvider);

    return Scaffold(
      backgroundColor: AppColors.softWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back, color: AppColors.deepPurple),
                  ),
                  const Spacer(),
                  const Icon(Icons.share_rounded, color: AppColors.deepPurple, size: 22),
                  const SizedBox(width: 16),
                  const Icon(Icons.more_horiz_rounded, color: AppColors.deepPurple, size: 22),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Search Results', style: AppTypography.heading1),
            ),
            if (query != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: results.when(
                  data: (data) => RichText(
                    text: TextSpan(
                      style: AppTypography.bodySmall,
                      children: [
                        const TextSpan(text: 'There are '),
                        TextSpan(
                          text: '${data.length} search results',
                          style: AppTypography.bodySmall.copyWith(color: AppColors.teal, fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: ' from\n${query.from} to ${query.to}'),
                      ],
                    ),
                  ),
                  loading: () => Text('Searching...', style: AppTypography.bodySmall),
                  error: (_, __) => Text('Error', style: AppTypography.bodySmall),
                ),
              ),
              const SizedBox(height: 12),
              // Route summary
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.lightLilac.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(query.from, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(Icons.swap_horiz_rounded, size: 18, color: AppColors.teal),
                      ),
                      Text(query.to, style: AppTypography.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),
            FilterSortBar(
              selectedFilter: _selectedFilter,
              onFilterChanged: (f) => setState(() => _selectedFilter = f),
            ),
            const SizedBox(height: 12),
            // Results list
            Expanded(
              child: results.when(
                data: (data) => ListView.builder(
                  padding: const EdgeInsets.only(bottom: 20),
                  itemCount: data.length,
                  itemBuilder: (context, index) => RouteCard(
                    result: data[index],
                    isFavorite: favorites.contains(data[index].id),
                    onFavoriteTap: () => ref.read(favoritesProvider.notifier).toggle(data[index].id),
                    onBookmarkTap: () {},
                    onTap: () => context.push('/booking-detail'),
                  ).animate().fadeIn(delay: (80 * index).ms, duration: 300.ms)
                      .slideY(begin: 0.1, end: 0, delay: (80 * index).ms, duration: 300.ms),
                ),
                loading: () => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 4,
                  itemBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: SkeletonCard(height: 160),
                  ),
                ),
                error: (e, _) => Center(child: Text('Error: $e', style: AppTypography.bodySmall)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
