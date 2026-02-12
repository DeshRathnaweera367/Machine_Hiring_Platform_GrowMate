import '../models/booking_model.dart';
import 'machine_data.dart';

final List<Booking> bookings = [
  Booking(
    id: 'b1',
    machine: machines[0],  // Rice Harvester 1000
    userId: 'u1',
    date: DateTime(2026, 2, 15),
    hours: 4,
  ),
  Booking(
    id: 'b2',
    machine: machines[5],  // Corn Harvester 1000
    userId: 'u2',
    date: DateTime(2026, 2, 16),
    hours: 6,
  ),
  Booking(
    id: 'b3',
    machine: machines[10], // Universal Harvester 1
    userId: 'u3',
    date: DateTime(2026, 2, 18),
    hours: 5,
  ),
  Booking(
    id: 'b4',
    machine: machines[2],  // Mini Rice Combine
    userId: 'u4',
    date: DateTime(2026, 2, 19),
    hours: 3,
  ),
  Booking(
    id: 'b5',
    machine: machines[7],  // Corn Harvester 2000
    userId: 'u5',
    date: DateTime(2026, 2, 20),
    hours: 8,
  ),
];