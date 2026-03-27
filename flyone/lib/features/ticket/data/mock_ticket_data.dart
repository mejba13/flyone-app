import '../domain/models/ticket.dart';

class MockTicketData {
  static const ticket = Ticket(
    id: 'TKT-001',
    pnr: 'SHG2345',
    tripType: 'One Way',
    carrierName: 'Garuda Indonesia',
    carrierLogo: '✈️',
    departureCode: 'CGK',
    arrivalCode: 'BDG',
    departureTime: '06:40',
    arrivalTime: '08:30',
    duration: '1 hour 5',
    date: '23 February 2024',
    gate: 'G2',
    terminal: 'T3',
    passengerName: 'Alves Farhat',
    seatNumber: 'A3',
    travelClass: 'Business',
    barcodeData: 'ASF SHG2345',
  );
}
