import '../../../core/utils/result.dart';
import '../domain/models/search_query.dart';
import '../domain/models/search_result.dart';
import 'search_repository.dart';

class MockSearchRepository implements SearchRepository {
  @override
  Future<Result<List<SearchResult>>> search(SearchQuery query) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return Success([
      SearchResult(
        id: '1', carrierName: 'Whoosh', carrierLogo: '🚄',
        travelClass: 'Business', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '06:40', arrivalTime: '07:30', duration: '1hr 50min',
        rating: 4.6, pricePerPax: 81, transportMode: 'train',
      ),
      SearchResult(
        id: '2', carrierName: 'KAI', carrierLogo: '🚄',
        travelClass: 'Economy', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '13:10', arrivalTime: '16:12', duration: '3hr 2min',
        rating: 4.4, pricePerPax: 89, transportMode: 'train',
      ),
      SearchResult(
        id: '3', carrierName: 'Whoosh', carrierLogo: '🚄',
        travelClass: 'Business', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '09:00', arrivalTime: '09:55', duration: '1hr 30min',
        rating: 4.7, pricePerPax: 95, transportMode: 'train',
      ),
      SearchResult(
        id: '4', carrierName: 'Garuda Indonesia', carrierLogo: '✈️',
        travelClass: 'Economy', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '07:15', arrivalTime: '08:25', duration: '1hr 10min',
        rating: 4.5, pricePerPax: 120, transportMode: 'flight',
      ),
      SearchResult(
        id: '5', carrierName: 'Lion Air', carrierLogo: '✈️',
        travelClass: 'Economy', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '14:30', arrivalTime: '15:35', duration: '1hr 5min',
        rating: 4.1, pricePerPax: 75, transportMode: 'flight',
      ),
      SearchResult(
        id: '6', carrierName: 'Pelni Ferry', carrierLogo: '⛴️',
        travelClass: 'Economy', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '08:00', arrivalTime: '14:00', duration: '6hr',
        rating: 3.9, pricePerPax: 45, canReschedule: false, transportMode: 'boat',
      ),
      SearchResult(
        id: '7', carrierName: 'TransJava Bus', carrierLogo: '🚌',
        travelClass: 'Economy', departureCode: query.fromCode, arrivalCode: query.toCode,
        departureTime: '22:00', arrivalTime: '06:00', duration: '8hr',
        rating: 4.0, pricePerPax: 35, transportMode: 'bus',
      ),
    ]);
  }
}
