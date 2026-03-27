import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/result.dart';
import '../data/search_repository.dart';
import '../data/mock_search_repository.dart';
import 'models/search_query.dart';
import 'models/search_result.dart';

final searchRepositoryProvider = Provider<SearchRepository>(
  (ref) => MockSearchRepository(),
);

final searchQueryProvider = StateProvider<SearchQuery?>((ref) => null);

final searchResultsProvider = FutureProvider<List<SearchResult>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query == null) return [];
  final repo = ref.read(searchRepositoryProvider);
  final result = await repo.search(query);
  return switch (result) {
    Success(:final data) => data,
    Failure(:final message) => throw Exception(message),
  };
});

final favoritesProvider = StateNotifierProvider<FavoritesNotifier, Set<String>>(
  (ref) => FavoritesNotifier(),
);

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier() : super({});

  void toggle(String id) {
    if (state.contains(id)) {
      state = {...state}..remove(id);
    } else {
      state = {...state, id};
    }
  }
}
