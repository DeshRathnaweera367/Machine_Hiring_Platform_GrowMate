import '../models/booking_model.dart';
import '../data/machine_data.dart';

final List<Booking> bookings = [
  Booking(
    id: 'B001',
    machine: machines[0], // always assign a Machine object
    bookingDate: DateTime.now().subtract(const Duration(days: 3)),
    startDate: DateTime.now().add(const Duration(days: 1)),
    endDate: DateTime.now().add(const Duration(days: 3)),
    totalDays: 3,
    totalPrice: machines[0].pricePerDay.toDouble() * 3, // totalPrice as double
    status: 'pending',
  ),
  Booking(
    id: 'B002',
    machine: machines[1],
    bookingDate: DateTime.now().subtract(const Duration(days: 7)),
    startDate: DateTime.now().subtract(const Duration(days: 5)),
    endDate: DateTime.now().subtract(const Duration(days: 2)),
    totalDays: 3,
    totalPrice: machines[1].pricePerDay.toDouble() * 3,
    status: 'completed',
  ),
];