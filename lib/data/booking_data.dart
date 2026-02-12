import '../models/booking_model.dart';
import '../data/machine_data.dart';

final List<Booking> bookings = [
  // =========================
  // Sample Bookings
  // =========================
  Booking(
    id: 'B001',
    machine: machines[0], // Rice Harvester 1000
    bookingDate: DateTime.now().subtract(const Duration(days: 3)),
    startDate: DateTime.now().add(const Duration(days: 1)),
    endDate: DateTime.now().add(const Duration(days: 3)),
    totalDays: 3,
    totalPrice: machines[0].pricePerDay.toDouble() * 3,
    status: 'pending',
  ),
  Booking(
    id: 'B002',
    machine: machines[1], // Rice Harvester 2000
    bookingDate: DateTime.now().subtract(const Duration(days: 7)),
    startDate: DateTime.now().subtract(const Duration(days: 5)),
    endDate: DateTime.now().subtract(const Duration(days: 2)),
    totalDays: 3,
    totalPrice: machines[1].pricePerDay.toDouble() * 3,
    status: 'completed',
  ),
  Booking(
    id: 'B003',
    machine: machines[5], // Universal Harvester 1
    bookingDate: DateTime.now().subtract(const Duration(days: 2)),
    startDate: DateTime.now().add(const Duration(days: 2)),
    endDate: DateTime.now().add(const Duration(days: 4)),
    totalDays: 2,
    totalPrice: machines[5].pricePerDay.toDouble() * 2,
    status: 'pending',
  ),
  Booking(
    id: 'B004',
    machine: machines[6], // Rice & Corn Combo
    bookingDate: DateTime.now().subtract(const Duration(days: 10)),
    startDate: DateTime.now().subtract(const Duration(days: 9)),
    endDate: DateTime.now().subtract(const Duration(days: 7)),
    totalDays: 2,
    totalPrice: machines[6].pricePerDay.toDouble() * 2,
    status: 'completed',
  ),
  Booking(
    id: 'B005',
    machine: machines[10], // Corn Harvester 1000
    bookingDate: DateTime.now().subtract(const Duration(days: 1)),
    startDate: DateTime.now().add(const Duration(days: 1)),
    endDate: DateTime.now().add(const Duration(days: 2)),
    totalDays: 1,
    totalPrice: machines[10].pricePerDay.toDouble() * 1,
    status: 'pending',
  ),
  Booking(
    id: 'B006',
    machine: machines[12], // Mini Corn Combine
    bookingDate: DateTime.now().subtract(const Duration(days: 5)),
    startDate: DateTime.now().subtract(const Duration(days: 4)),
    endDate: DateTime.now().subtract(const Duration(days: 2)),
    totalDays: 2,
    totalPrice: machines[12].pricePerDay.toDouble() * 2,
    status: 'completed',
  ),
  Booking(
    id: 'B007',
    machine: machines[15], // Universal Harvester 2
    bookingDate: DateTime.now().subtract(const Duration(days: 3)),
    startDate: DateTime.now().add(const Duration(days: 2)),
    endDate: DateTime.now().add(const Duration(days: 5)),
    totalDays: 3,
    totalPrice: machines[15].pricePerDay.toDouble() * 3,
    status: 'pending',
  ),
  Booking(
    id: 'B008',
    machine: machines[18], // Corn Harvester Advanced
    bookingDate: DateTime.now().subtract(const Duration(days: 20)),
    startDate: DateTime.now().subtract(const Duration(days: 18)),
    endDate: DateTime.now().subtract(const Duration(days: 15)),
    totalDays: 3,
    totalPrice: machines[18].pricePerDay.toDouble() * 3,
    status: 'completed',
  ),
  Booking(
    id: 'B009',
    machine: machines[3], // Rice Reaper X
    bookingDate: DateTime.now().subtract(const Duration(days: 2)),
    startDate: DateTime.now().add(const Duration(days: 3)),
    endDate: DateTime.now().add(const Duration(days: 4)),
    totalDays: 1,
    totalPrice: machines[3].pricePerDay.toDouble() * 1,
    status: 'pending',
  ),
  Booking(
    id: 'B010',
    machine: machines[7], // Rice Reaper Mini
    bookingDate: DateTime.now().subtract(const Duration(days: 15)),
    startDate: DateTime.now().subtract(const Duration(days: 14)),
    endDate: DateTime.now().subtract(const Duration(days: 13)),
    totalDays: 1,
    totalPrice: machines[7].pricePerDay.toDouble() * 1,
    status: 'cancelled',
  ),
];