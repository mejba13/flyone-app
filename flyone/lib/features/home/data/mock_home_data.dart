import '../domain/models/schedule.dart';
import '../domain/models/destination.dart';
import '../domain/models/voucher.dart';

class MockHomeData {
  static const schedules = [
    Schedule(
      id: '1',
      carrierName: 'Garuda Airline',
      carrierLogo: '✈️',
      tripType: 'One Way',
      departureCode: 'CGK',
      arrivalCode: 'DPS',
      departureTime: '06:40',
      arrivalTime: '09:25',
      duration: '3hr 55min',
      date: '3 Feb 2024',
      travelClass: 'Business',
      baggage: '5 kg',
      transportMode: 'flight',
    ),
    Schedule(
      id: '2',
      carrierName: 'Whoosh',
      carrierLogo: '🚄',
      tripType: 'One-way',
      departureCode: 'HLM',
      arrivalCode: 'BDG',
      departureTime: '12:30',
      arrivalTime: '14:15',
      duration: '1hr 45min',
      date: '5 Feb 2024',
      travelClass: 'Business',
      baggage: '10 kg',
      transportMode: 'train',
    ),
    Schedule(
      id: '3',
      carrierName: 'Lion Air',
      carrierLogo: '✈️',
      tripType: 'Round Trip',
      departureCode: 'CGK',
      arrivalCode: 'SUB',
      departureTime: '08:00',
      arrivalTime: '09:30',
      duration: '1hr 30min',
      date: '10 Feb 2024',
      travelClass: 'Economy',
      baggage: '20 kg',
      transportMode: 'flight',
    ),
  ];

  static const destinations = [
    Destination(id: '1', name: 'Bali', imageUrl: 'https://images.unsplash.com/photo-1537996194471-e657df975ab4?w=400', price: '\$120'),
    Destination(id: '2', name: 'Tokyo', imageUrl: 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=400', price: '\$350'),
    Destination(id: '3', name: 'Paris', imageUrl: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?w=400', price: '\$420'),
    Destination(id: '4', name: 'Sydney', imageUrl: 'https://images.unsplash.com/photo-1506973035872-a4ec16b8e8d9?w=400', price: '\$380'),
    Destination(id: '5', name: 'Dubai', imageUrl: 'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?w=400', price: '\$280'),
    Destination(id: '6', name: 'Bangkok', imageUrl: 'https://images.unsplash.com/photo-1508009603885-50cf7c579365?w=400', price: '\$95'),
  ];

  static const vouchers = [
    Voucher(id: '1', title: 'New member', subtitle: 'Special discount', discount: '30%', code: 'WELCOME30', bgColorHex: 'D6CCFF'),
    Voucher(id: '2', title: 'Exclusive Deal', subtitle: 'Buy 1 Get 1', discount: 'BOGO', code: 'BOGO2024', bgColorHex: '5BCFCF'),
    Voucher(id: '3', title: 'Weekend Sale', subtitle: 'Limited time', discount: '20%', code: 'WEEKEND20', bgColorHex: 'D6CCFF'),
  ];

  static const int userPoints = 320;
  static const String userName = 'Mejba';
}
