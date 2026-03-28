import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_constants.dart';
import '../../../core/utils/transport_icon.dart';
import '../../../core/widgets/skeleton_loader.dart';
import '../domain/search_provider.dart';
import 'widgets/route_card.dart';
import 'widgets/filter_sort_bar.dart';

class SearchResultsScreen extends ConsumerStatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  ConsumerState<SearchResultsScreen> createState() =>
      _SearchResultsScreenState();
}

class _SearchResultsScreenState extends ConsumerState<SearchResultsScreen>
    with SingleTickerProviderStateMixin {
  String _selectedFilter = 'Best';

  // Controller to animate the list when filter changes
  late final AnimationController _listController;

  @override
  void initState() {
    super.initState();
    _listController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  void _changeFilter(String filter) async {
    // Fade list out, update state, fade back in
    await _listController.animateTo(0.0,
        duration: const Duration(milliseconds: 150), curve: Curves.easeOut);
    if (!mounted) return;
    setState(() => _selectedFilter = filter);
    _listController.animateTo(1.0,
        duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
  }

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
                    child: const Icon(Icons.arrow_back,
                        color: AppColors.deepPurple),
                  ),
                  const Spacer(),
                  const Icon(Icons.share_rounded,
                      color: AppColors.deepPurple, size: 22),
                  const SizedBox(width: 16),
                  const Icon(Icons.more_horiz_rounded,
                      color: AppColors.deepPurple, size: 22),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text('Search Results', style: AppTypography.heading1),
            ),

            if (query != null) ...[
              const SizedBox(height: 6),
              // Results count badge + summary row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: results.when(
                  data: (data) => Row(
                    children: [
                      // Gradient results count badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              AppColors.teal,
                              Color(0xFF4DB8B8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${data.length} results',
                          style: AppTypography.caption.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'from ${query.from} to ${query.to}',
                        style: AppTypography.bodySmall,
                      ),
                    ],
                  ),
                  loading: () =>
                      Text('Searching...', style: AppTypography.bodySmall),
                  error: (_, __) =>
                      Text('Error', style: AppTypography.bodySmall),
                ),
              ),
              const SizedBox(height: 12),

              // Route summary pill — uses TransportIcon instead of emoji
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.lightLilac.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        query.from,
                        style: AppTypography.bodySmall
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          TransportIcon.getIcon('flight'),
                          size: 16,
                          color: AppColors.teal,
                        ),
                      ),
                      Text(
                        query.to,
                        style: AppTypography.bodySmall
                            .copyWith(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 16),

            FilterSortBar(
              selectedFilter: _selectedFilter,
              onFilterChanged: _changeFilter,
            ),
            const SizedBox(height: 12),

            // Results list — fades on filter change
            Expanded(
              child: results.when(
                data: (data) => AnimatedBuilder(
                  animation: _listController,
                  builder: (context, child) => Opacity(
                    opacity: _listController.value,
                    child: child,
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: AppConstants.bottomNavClearance),
                    itemCount: data.length,
                    itemBuilder: (context, index) => RouteCard(
                      result: data[index],
                      isFavorite: favorites.contains(data[index].id),
                      onFavoriteTap: () => ref
                          .read(favoritesProvider.notifier)
                          .toggle(data[index].id),
                      onBookmarkTap: () {},
                      onTap: () {
                        ref.read(selectedResultProvider.notifier).state = data[index];
                        context.push('/booking-detail');
                      },
                    )
                        .animate()
                        .fadeIn(
                            delay: (80 * index).ms, duration: 300.ms)
                        .slideY(
                            begin: 0.1,
                            end: 0,
                            delay: (80 * index).ms,
                            duration: 300.ms),
                  ),
                ),
                loading: () => ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 4,
                  itemBuilder: (_, __) => const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: SkeletonCard(height: 160),
                  ),
                ),
                error: (e, _) => Center(
                    child:
                        Text('Error: $e', style: AppTypography.bodySmall)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
