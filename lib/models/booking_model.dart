import 'machine_model.dart';

class Booking {
  final String id;
  final Machine machine; // ✅ add this
  final DateTime bookingDate;
  final DateTime startDate;
  final DateTime endDate;
  final int totalDays;
  final double totalPrice;
  final String status;

  Booking({
    required this.id,
    required this.machine, // ✅ match the field name
    required this.bookingDate,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.totalPrice,
    required this.status,
  });
}