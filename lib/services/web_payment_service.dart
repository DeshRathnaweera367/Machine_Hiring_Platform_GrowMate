import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:web/web.dart' as web;
import 'dart:js_interop';
import 'payhere_credentials.dart';

class WebPaymentService {
  static void makePayment({
    required BuildContext context,
    required String orderId,
    required double amount,
    required String items,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    required String customerAddress,
    required String customerCity,
    VoidCallback? onSuccess,
    VoidCallback? onError,
  }) {
    
    // Only works on web
    if (!kIsWeb) {
      debugPrint('WebPaymentService can only be used on web platform');
      return;
    }

    List<String> nameParts = customerName.split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts.first : customerName;
    String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    // Get the current port
    final port = web.window.location.port;
    final baseUrl = 'http://localhost:${port.isNotEmpty ? port : '62220'}';

    // Build URL with parameters
    final url = Uri.parse('$baseUrl/payment.html').replace(queryParameters: {
      'sandbox': PayHereCredentials.isSandbox.toString(),
      'merchant_id': PayHereCredentials.merchantId,
      'return_url': '$baseUrl/success',
      'cancel_url': '$baseUrl/cancel',
      'notify_url': 'https://sandbox.payhere.lk/notify',
      'order_id': orderId,
      'items': items,
      'amount': amount.toStringAsFixed(2),
      'currency': 'LKR',
      'first_name': firstName,
      'last_name': lastName,
      'email': customerEmail,
      'phone': customerPhone,
      'address': customerAddress,
      'city': customerCity,
      'country': 'Sri Lanka',
      'delivery_address': customerAddress,
      'delivery_city': customerCity,
      'delivery_country': 'Sri Lanka',
    });

    debugPrint('💰 Opening payment URL: $url');

    // Open payment window using JS interop
    _openPaymentWindow(url.toString());

    // Show a message to the user
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('📱 Payment window opened. Please complete the payment in the new window.'),
          backgroundColor: Colors.blue,
          duration: Duration(seconds: 5),
        ),
      );
    }

    // Set up a listener for when the payment window closes
    Future.delayed(const Duration(seconds: 10), () {
      if (context.mounted) {
        _showPaymentConfirmationDialog(context, onSuccess, onError);
      }
    });
  }

  static void _openPaymentWindow(String url) {
    // Use JS interop to open window
    final jsCode = '''
      var paymentWindow = window.open('$url', 'PayHere Payment', 'width=800,height=600,scrollbars=yes,resizable=yes');
      if (!paymentWindow) {
        alert('Please allow pop-ups to make payment.\\n\\nClick the pop-up blocked icon in the address bar and select "Always allow pop-ups from localhost"');
      }
    '''.toJS;
    
    // Execute JavaScript code
    _executeJS(jsCode);
  }

  static void _executeJS(JSString jsCode) {
    // Simple JS execution using eval
    (web.window as dynamic).eval(jsCode);
  }

  static void _showPaymentConfirmationDialog(
    BuildContext context, 
    VoidCallback? onSuccess, 
    VoidCallback? onError
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.help, color: Colors.blue, size: 50),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Payment Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Did you complete the payment?'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (onError != null) onError();
            },
            child: const Text('No, Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              Navigator.pop(context);
              if (onSuccess != null) onSuccess();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Payment successful! Booking confirmed.'),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
            child: const Text('Yes, Completed'),
          ),
        ],
      ),
    );
  }

  static String generateOrderId() {
    final now = DateTime.now();
    return 'HARV-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${now.millisecondsSinceEpoch % 10000}';
  }
}