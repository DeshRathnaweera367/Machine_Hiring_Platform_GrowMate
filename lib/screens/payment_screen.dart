import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import 'invoice_screen.dart';

class PaymentScreen extends StatelessWidget {
  final Booking booking; // Pass the full booking, not just price

  const PaymentScreen({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Amount: LKR ${booking.totalPrice.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            /// Pay with Card
            ElevatedButton.icon(
              icon: const Icon(Icons.credit_card),
              label: const Text('Pay with Card'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                // After payment, navigate to invoice
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InvoiceScreen(booking: booking),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            /// Pay with Wallet
            ElevatedButton.icon(
              icon: const Icon(Icons.account_balance_wallet),
              label: const Text('Pay with Wallet'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                // After payment, navigate to invoice
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InvoiceScreen(booking: booking),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}