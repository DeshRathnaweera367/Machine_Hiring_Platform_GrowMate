import 'machine_model.dart';

class Booking {
  final String id;
  final Machine machine; // reference to a Machine from machine_data.dart
  final String userId;   // who booked it
  final DateTime date;   // booking date
  final int hours;       // number of hours booked

  Booking({
    required this.id,
    required this.machine,
    required this.userId,
    required this.date,
    required this.hours,
  });
}