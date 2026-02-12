import 'package:flutter/material.dart';
import '../models/booking_model.dart';

class InvoiceScreen extends StatelessWidget {
  final Booking booking;

  const InvoiceScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Invoice')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Invoice',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const SizedBox(height: 10),

            /// Machine & Owner Info
            Text('Machine: ${booking.machine.name}', style: const TextStyle(fontSize: 16)),
            Text('Owner: ${booking.machine.owner.name}'),
            Text('Booking ID: ${booking.id}'),
            Text('Status: ${booking.status[0].toUpperCase()}${booking.status.substring(1)}'),
            const SizedBox(height: 10),

            /// Booking Dates
            Text('From: ${_formatDate(booking.startDate)}'),
            Text('To: ${_formatDate(booking.endDate)}'),
            const SizedBox(height: 10),

            /// Total Paid
            Text(
              'Total Paid: LKR ${booking.totalPrice.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            /// Download Button
            ElevatedButton.icon(
              icon: const Icon(Icons.download),
              label: const Text('Download Invoice'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Invoice download feature not implemented yet.'),
                  ),
                );
              },
            ),
          ],
        ),
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