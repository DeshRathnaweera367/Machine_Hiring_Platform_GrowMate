import 'machine_model.dart';

class Booking {
  final String id;            // Unique booking ID
  final Machine machine;      // Must be a Machine object
  final DateTime bookingDate; // When the booking was created
  final DateTime startDate;   // Rental start date
  final DateTime endDate;     // Rental end date
  final int totalDays;        // Total days of rental
  final double totalPrice;    // Total price for rental
  final String status;        // Booking status (pending, completed, cancelled)

  Booking({
    required this.id,
    required this.machine,
    required this.bookingDate,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.totalPrice,
    required this.status,
  });
}