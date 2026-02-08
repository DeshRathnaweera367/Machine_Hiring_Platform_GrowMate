import 'package:flutter/material.dart';
import '../models/booking_model.dart';

class MyBookingsScreen extends StatelessWidget {
  final List<Booking> bookings;
  final VoidCallback onBack;

  const MyBookingsScreen({
    super.key,
    required this.bookings,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: bookings.isEmpty
          ? const Center(
              child: Text(
                'No Bookings Yet',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];

                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        booking.machine.image, // ✅ add ! to fix null issue
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      booking.machine.name, // ✅ add ! to fix null issue
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'From: ${_formatDate(booking.startDate)}\n'
                      'To: ${_formatDate(booking.endDate)}\n'
                      'Status: ${booking.status}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: Text(
                      'LKR ${booking.totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  // Helper to format DateTime as dd/mm/yyyy
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}