import '../../../core/utils/result.dart';
import '../domain/models/search_result.dart';
import '../domain/models/search_query.dart';

abstract class SearchRepository {
  Future<Result<List<SearchResult>>> search(SearchQuery query);
}
