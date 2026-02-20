import 'package:flutter/material.dart';
import 'package:payhere_mobilesdk_flutter/payhere_mobilesdk_flutter.dart';
import 'payhere_credentials.dart';

class PaymentService {
  static final PaymentService _instance = PaymentService._internal();
  factory PaymentService() => _instance;
  PaymentService._internal();

  static Future<void> makePayment({
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
  }) async {
    
    List<String> nameParts = customerName.split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts.first : customerName;
    String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

    debugPrint('💰 Starting payment for order: $orderId');
    debugPrint('Amount: LKR $amount');

    Map<String, dynamic> paymentObject = {
      "sandbox": PayHereCredentials.isSandbox,
      "merchant_id": PayHereCredentials.merchantId,
      "notify_url": "https://sandbox.payhere.lk/notify",
      "order_id": orderId,
      "items": items,
      "amount": amount.toStringAsFixed(2),
      "currency": "LKR",
      "first_name": firstName,
      "last_name": lastName,
      "email": customerEmail,
      "phone": customerPhone,
      "address": customerAddress,
      "city": customerCity,
      "country": "Sri Lanka",
      "delivery_address": customerAddress,
      "delivery_city": customerCity,
      "delivery_country": "Sri Lanka",
    };

    debugPrint('📦 Payment Object: $paymentObject');

    try {
      if (context.mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
      }

      PayHere.startPayment(
        paymentObject,
        (paymentId) {
          debugPrint('✅ Payment Success: $paymentId');
          if (context.mounted) Navigator.pop(context);
          
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Payment Successful!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Payment ID: $paymentId'),
                    Text('Amount: LKR ${amount.toStringAsFixed(2)}'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
          if (onSuccess != null) onSuccess();
        },
        (error) {
          debugPrint('❌ Payment Error: $error');
          if (context.mounted) Navigator.pop(context);
          
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Icon(Icons.error, color: Colors.red, size: 60),
                content: Text('Payment failed: $error'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }
          if (onError != null) onError();
        },
        () {
          debugPrint('⚠️ Payment Dismissed');
          if (context.mounted) Navigator.pop(context);
          
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Payment cancelled'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        },
      );
      
    } catch (e) {
      debugPrint('❌ Payment Exception: $e');
      if (context.mounted) Navigator.pop(context);
      
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static String generateOrderId() {
    final now = DateTime.now();
    return 'HARV-${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}-${now.millisecondsSinceEpoch % 10000}';
  }
}