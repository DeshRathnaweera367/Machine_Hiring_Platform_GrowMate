import 'package:flutter/material.dart';

import 'models/machine_model.dart';
import 'models/booking_model.dart';
import 'data/machine_data.dart';
import 'screens/machine_list_screen.dart';
import 'screens/machine_details_screen.dart';
import 'screens/my_bookings_screen.dart';

void main() {
  runApp(const GrowMateApp());
}

class GrowMateApp extends StatefulWidget {
  const GrowMateApp({super.key});

  @override
  State<GrowMateApp> createState() => _GrowMateAppState();
}

class _GrowMateAppState extends State<GrowMateApp> {
  Machine? selectedMachine;
  final List<Booking> myBookings = [];
  String currentScreen = 'list'; // list, details, myBookings

  @override
  Widget build(BuildContext context) {
    Widget screen;

    switch (currentScreen) {
      case 'details':
        screen = MachineDetailsScreen(
          machine: selectedMachine!, // ✅ use !
          onBack: () => setState(() => currentScreen = 'list'),
          onBookNow: (machine) {
            setState(() {
              final newBooking = Booking(
                id: 'B${myBookings.length + 1}',
                machine: machine, // ✅ lowercase matches Booking model
                bookingDate: DateTime.now(),
                startDate: DateTime.now(),
                endDate: DateTime.now().add(const Duration(days: 1)),
                totalDays: 1,
                totalPrice: machine.pricePerDay.toDouble(),
                status: 'pending',
              );
              myBookings.add(newBooking);
              currentScreen = 'myBookings';
            });
          },
        );
        break;

      case 'myBookings':
        screen = MyBookingsScreen(
          bookings: myBookings,
          onBack: () => setState(() => currentScreen = 'list'),
        );
        break;

      default:
        screen = MachineListScreen(
          machines: machines,
          onMachineSelect: (machine) {
            setState(() {
              selectedMachine = machine;
              currentScreen = 'details';
            });
          },
          onNavigateToBookings: () => setState(() => currentScreen = 'myBookings'),
        );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GrowMate',
      theme: ThemeData(primarySwatch: Colors.green),
      home: screen,
    );
  }
}