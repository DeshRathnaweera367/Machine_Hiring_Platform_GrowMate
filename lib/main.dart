import 'package:flutter/material.dart';

import 'data/machine_data.dart';
import 'screens/machine_list_screen.dart';

void main() {
  runApp(const GrowMateApp());
}

class GrowMateApp extends StatelessWidget {
  const GrowMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GrowMate',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MachineListScreen(
        machines: machines,
        onMachineSelect: (machine) {},
        onNavigateToBookings: () {},
      ),
    );
  }
}