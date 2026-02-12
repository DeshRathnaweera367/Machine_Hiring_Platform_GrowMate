import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Import your project files
import 'package:growmate_machine_hiring_platform/main.dart';
import 'package:growmate_machine_hiring_platform/screens/machine_details_screen.dart';

/// A simple mock to stop Network Image errors during testing
class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() {
  // Override HTTP globally for network images during tests
  HttpOverrides.global = MockHttpOverrides();

  testWidgets('GrowMate app loads machine list and navigates to details',
      (WidgetTester tester) async {

    // Initialize ScreenUtil to avoid layout errors
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690), // Match your design size
        builder: (context, child) => const GrowMateApp(),
      ),
    );

    // Wait for widgets to build
    await tester.pumpAndSettle();

    // Verify the AppBar of the home screen
    expect(find.text('GrowMate'), findsOneWidget);

    // Find all Cards (machines) on the list
    final cardFinder = find.byType(Card);
    expect(cardFinder, findsWidgets);

    // Tap the first card to navigate to MachineDetailsScreen
    await tester.tap(cardFinder.first);
    await tester.pumpAndSettle();

    // Verify MachineDetailsScreen opened
    expect(find.byType(MachineDetailsScreen), findsOneWidget);

    // Check that the machine name and description are visible
    expect(
      find.descendant(
        of: find.byType(MachineDetailsScreen),
        matching: find.byType(Text),
      ),
      findsWidgets,
    );

    // Check that the 'Book Now' button exists if the machine is available
    expect(find.widgetWithText(ElevatedButton, 'Book Now'), findsWidgets);
  });
}