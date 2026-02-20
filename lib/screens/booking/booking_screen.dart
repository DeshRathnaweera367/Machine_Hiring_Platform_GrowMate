import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_fonts/google_fonts.dart';
import '../../models/harvester.dart';
import '../../models/user.dart';
import '../../services/payment_service.dart';
import '../../services/web_payment_service.dart';

// This screen handles the booking process
class BookingScreen extends StatefulWidget {
  final Harvester harvester;

  const BookingScreen({super.key, required this.harvester});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // Date/time selection
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  
  // Rental type: 'daily' or 'hourly'
  String _rentalType = 'daily';
  
  // Additional options
  bool _withOperator = false;
  bool _withFuel = false;
  
  // Controller for hours input (if hourly rental)
  final TextEditingController _hoursController = TextEditingController();
  int _rentalHours = 8; // Default 8 hours
  
  @override
  void initState() {
    super.initState();
    _hoursController.text = _rentalHours.toString();
  }

  @override
  void dispose() {
    _hoursController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Harvester',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Harvester summary card
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.image, color: Colors.grey),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.harvester.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Owner: ${widget.harvester.ownerName}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text(
                                '${widget.harvester.location}, ${widget.harvester.district}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              Text(
                                '${widget.harvester.machineType} Harvester',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Price Options Section
                  const Text(
                    'Select Rental Type',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Daily vs Hourly toggle
                  Row(
                    children: [
                      Expanded(
                        child: _buildRentalTypeCard(
                          type: 'daily',
                          label: 'Daily Rental',
                          price: 'LKR ${widget.harvester.pricePerDay}/day',
                          icon: Icons.calendar_month,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildRentalTypeCard(
                          type: 'hourly',
                          label: 'Hourly Rental',
                          price: 'LKR ${widget.harvester.pricePerHour}/hour',
                          icon: Icons.access_time,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Conditional UI based on rental type
                  if (_rentalType == 'daily') ...[
                    // DAILY RENTAL UI
                    const Text(
                      'Select Rental Dates',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Start Date Picker
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey[200]!),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.calendar_today, color: Colors.green[700]),
                        title: Text(_startDate == null 
                            ? 'Start Date' 
                            : 'Start: ${_formatDate(_startDate!)}'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => _selectDate(context, isStart: true),
                      ),
                    ),
                    
                    // End Date Picker
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey[200]!),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.calendar_today, color: Colors.green[700]),
                        title: Text(_endDate == null 
                            ? 'End Date' 
                            : 'End: ${_formatDate(_endDate!)}'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: _startDate == null 
                            ? null  // Disable if no start date
                            : () => _selectDate(context, isStart: false),
                      ),
                    ),
                    
                    // Show number of days if both dates selected
                    if (_startDate != null && _endDate != null)
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.info, color: Colors.green[700], size: 20),
                            const SizedBox(width: 8),
                            Text(
                              '${_calculateDays()} days rental period',
                              style: TextStyle(color: Colors.green[700]),
                            ),
                          ],
                        ),
                      ),
                  ] else ...[
                    // HOURLY RENTAL UI
                    const Text(
                      'Select Rental Date & Time',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Date Picker
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey[200]!),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.calendar_today, color: Colors.green[700]),
                        title: Text(_startDate == null 
                            ? 'Select Date' 
                            : 'Date: ${_formatDate(_startDate!)}'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () => _selectDate(context, isStart: true),
                      ),
                    ),
                    
                    // Start Time Picker
                    if (_startDate != null)
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey[200]!),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.access_time, color: Colors.green[700]),
                          title: Text(_startTime == null 
                              ? 'Start Time' 
                              : 'Start: ${_formatTime(_startTime!)}'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () => _selectTime(context),
                        ),
                      ),
                    
                    // Duration
                    if (_startDate != null && _startTime != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Rental Duration (hours)',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Slider(
                                    value: _rentalHours.toDouble(),
                                    min: 1,
                                    max: 24,
                                    divisions: 23,
                                    activeColor: Colors.green[700],
                                    onChanged: (value) {
                                      setState(() {
                                        _rentalHours = value.round();
                                        _hoursController.text = _rentalHours.toString();
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 70,
                                  child: TextField(
                                    controller: _hoursController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _rentalHours = int.tryParse(value) ?? 8;
                                        if (_rentalHours < 1) _rentalHours = 1;
                                        if (_rentalHours > 24) _rentalHours = 24;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text('hrs'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    
                    // End Time (calculated)
                    if (_startDate != null && _startTime != null)
                      Card(
                        elevation: 0,
                        color: Colors.grey[50],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey[200]!),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.access_time, color: Colors.grey[600]),
                          title: Text(
                            'End Time: ${_calculateEndTime()}',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          subtitle: const Text('(calculated based on duration)'),
                        ),
                      ),
                  ],
                  
                  const SizedBox(height: 24),
                  
                  // Additional Options
                  const Text(
                    'Additional Options',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Operator option
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey[200]!),
                    ),
                    child: CheckboxListTile(
                      title: const Text('Include operator'),
                      subtitle: Text(_rentalType == 'daily' 
                          ? '+LKR 50/day' 
                          : '+LKR 50/hour'),
                      value: _withOperator,
                      onChanged: (value) {
                        setState(() {
                          _withOperator = value ?? false;
                        });
                      },
                      secondary: const Icon(Icons.person),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  
                  // Fuel option
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey[200]!),
                    ),
                    child: CheckboxListTile(
                      title: const Text('Fuel included'),
                      subtitle: Text(_rentalType == 'daily' 
                          ? '+LKR 30/day' 
                          : '+LKR 30/hour'),
                      value: _withFuel,
                      onChanged: (value) {
                        setState(() {
                          _withFuel = value ?? false;
                        });
                      },
                      secondary: const Icon(Icons.local_gas_station),
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Price Breakdown
                  if (_isBookingValid())
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Price Breakdown',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[200]!),
                          ),
                          child: Column(
                            children: [
                              if (_rentalType == 'daily') ...[
                                _buildPriceRow(
                                  'Base rate (daily)',
                                  'LKR ${widget.harvester.pricePerDay} × ${_calculateDays()} days',
                                  'LKR ${_calculateBaseTotal().toStringAsFixed(0)}',
                                ),
                              ] else ...[
                                _buildPriceRow(
                                  'Base rate (hourly)',
                                  'LKR ${widget.harvester.pricePerHour} × $_rentalHours hours',
                                  'LKR ${_calculateBaseTotal().toStringAsFixed(0)}',
                                ),
                              ],
                              if (_withOperator)
                                _buildPriceRow(
                                  'Operator',
                                  _rentalType == 'daily'
                                      ? 'LKR 50 × ${_calculateDays()} days'
                                      : 'LKR 50 × $_rentalHours hours',
                                  'LKR ${_calculateOperatorTotal().toStringAsFixed(0)}',
                                ),
                              if (_withFuel)
                                _buildPriceRow(
                                  'Fuel',
                                  _rentalType == 'daily'
                                      ? 'LKR 30 × ${_calculateDays()} days'
                                      : 'LKR 30 × $_rentalHours hours',
                                  'LKR ${_calculateFuelTotal().toStringAsFixed(0)}',
                                ),
                              const Divider(),
                              _buildPriceRow(
                                'Total',
                                '',
                                'LKR ${_calculateTotal().toStringAsFixed(0)}',
                                isTotal: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          
          // Book Button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _isBookingValid()
                    ? () => _showPaymentConfirmation(context)
                    : null,
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build rental type cards
  Widget _buildRentalTypeCard({
    required String type,
    required String label,
    required String price,
    required IconData icon,
  }) {
    bool isSelected = _rentalType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _rentalType = type;
          // Reset selections when changing type
          _startDate = null;
          _endDate = null;
          _startTime = null;
          _rentalHours = 8;
          _hoursController.text = '8';
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[50] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green[700]! : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.green[700] : Colors.grey[600],
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.green[700] : Colors.grey[800],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(
                color: isSelected ? Colors.green[700] : Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Check if booking is valid based on rental type
  bool _isBookingValid() {
    if (_rentalType == 'daily') {
      return _startDate != null && _endDate != null;
    } else {
      return _startDate != null && _startTime != null && _rentalHours > 0;
    }
  }

  // Helper method to format date
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  // Helper method to format time
  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Calculate end time for hourly rental
  String _calculateEndTime() {
    if (_startTime == null) return '';
    final startMinutes = _startTime!.hour * 60 + _startTime!.minute;
    final endMinutes = startMinutes + _rentalHours * 60;
    final endHour = (endMinutes ~/ 60) % 24;
    final endMinute = endMinutes % 60;
    return '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}';
  }

  // Date picker
  Future<void> _selectDate(BuildContext context, {required bool isStart}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_rentalType == 'daily') {
            _endDate = null; // Reset end date when start date changes
          }
        } else {
          if (_startDate != null && picked.isAfter(_startDate!)) {
            _endDate = picked;
          } else {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('End date must be after start date'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      });
    }
  }

  // Time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    
    if (picked != null) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  // Calculate number of days for daily rental
  int _calculateDays() {
    if (_startDate != null && _endDate != null) {
      return _endDate!.difference(_startDate!).inDays + 1;
    }
    return 0;
  }

  // Calculate base total
  double _calculateBaseTotal() {
    if (_rentalType == 'daily') {
      return widget.harvester.pricePerDay * _calculateDays().toDouble();
    } else {
      return widget.harvester.pricePerHour * _rentalHours.toDouble();
    }
  }

  // Calculate operator total
  double _calculateOperatorTotal() {
    if (_rentalType == 'daily') {
      return 50.0 * _calculateDays().toDouble();
    } else {
      return 50.0 * _rentalHours.toDouble();
    }
  }

  // Calculate fuel total
  double _calculateFuelTotal() {
    if (_rentalType == 'daily') {
      return 30.0 * _calculateDays().toDouble();
    } else {
      return 30.0 * _rentalHours.toDouble();
    }
  }

  // Calculate grand total
  double _calculateTotal() {
    double total = _calculateBaseTotal();
    if (_withOperator) total += _calculateOperatorTotal();
    if (_withFuel) total += _calculateFuelTotal();
    return total;
  }

  // Build price row widget
  Widget _buildPriceRow(String label, String details, String amount,
      {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                fontSize: isTotal ? 16 : 14,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              details,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: isTotal ? 14 : 12,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              amount,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
                color: isTotal ? Colors.green[700] : Colors.black,
                fontSize: isTotal ? 16 : 14,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  // Show payment confirmation dialog with platform-specific payment
  void _showPaymentConfirmation(BuildContext context) {
    String bookingDetails;
    if (_rentalType == 'daily') {
      bookingDetails = '${_formatDate(_startDate!)} - ${_formatDate(_endDate!)} (${_calculateDays()} days)';
    } else {
      bookingDetails = '${_formatDate(_startDate!)} at ${_formatTime(_startTime!)} for $_rentalHours hours (ends at ${_calculateEndTime()})';
    }

    final totalAmount = _calculateTotal();
    final orderId = PaymentService.generateOrderId();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Booking Confirmation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Your booking for ${widget.harvester.name} is ready.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Booking Details:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(bookingDetails),
            Text('Total: LKR ${totalAmount.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              'Proceed to payment?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
            ),
            onPressed: () async {
              Navigator.pop(context); // Close confirmation dialog
              
              // Show loading dialog
              if (!context.mounted) return;
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );
              
              // Choose payment method based on platform
              if (kIsWeb) {
                // Web payment
                WebPaymentService.makePayment(
                  context: context,
                  orderId: orderId,
                  amount: totalAmount,
                  items: '${widget.harvester.name} - $bookingDetails',
                  customerName: currentUser.name,
                  customerEmail: currentUser.email,
                  customerPhone: currentUser.phone,
                  customerAddress: currentUser.address,
                  customerCity: currentUser.city,
                  onSuccess: () {
                    debugPrint('✅ Payment successful for order: $orderId');
                    if (context.mounted) {
                      Navigator.pop(context); // Close loading dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Booking confirmed! Payment successful.'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.popUntil(context, (route) => route.isFirst);
                    }
                  },
                  onError: () {
                    debugPrint('❌ Payment failed for order: $orderId');
                    if (context.mounted) {
                      Navigator.pop(context); // Close loading dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Payment failed. Please try again.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                );
              } else {
                // Mobile payment
                PaymentService.makePayment(
                  context: context,
                  orderId: orderId,
                  amount: totalAmount,
                  items: '${widget.harvester.name} - $bookingDetails',
                  customerName: currentUser.name,
                  customerEmail: currentUser.email,
                  customerPhone: currentUser.phone,
                  customerAddress: currentUser.address,
                  customerCity: currentUser.city,
                  onSuccess: () {
                    debugPrint('✅ Payment successful for order: $orderId');
                    if (context.mounted) {
                      Navigator.pop(context); // Close loading dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Booking confirmed! Payment successful.'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.popUntil(context, (route) => route.isFirst);
                    }
                  },
                  onError: () {
                    debugPrint('❌ Payment failed for order: $orderId');
                    if (context.mounted) {
                      Navigator.pop(context); // Close loading dialog
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Payment failed. Please try again.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                );
              }
            },
            child: const Text('Pay Now'),
          ),
        ],
      ),
    );
  }
}