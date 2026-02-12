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
  // 1. Initial setup for the test environment
  HttpOverrides.global = MockHttpOverrides();

  testWidgets('GrowMate app loads Machine List screen and navigates to details',
      (WidgetTester tester) async {
    
    // 2. Initialize ScreenUtil for the test (fixes 'setWidth' errors)
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690), // Match your design size
        builder: (context, child) => const GrowMateApp(),
      ),
    );

    // 3. Wait for the app to load and settle
    // If you have a splash screen or Firebase loading, you might need multiple pumps
    await tester.pumpAndSettle();

    // 4. Verify the App Bar title
    expect(find.text('GrowMate'), findsOneWidget);

    // 5. Find the machine list cards
    // We check for 'findsWidgets' (plural) to ensure the list isn't empty
    final cardFinder = find.byType(Card);
    expect(cardFinder, findsWidgets);

    // 6. Tap the first machine to test navigation
    await tester.tap(cardFinder.first);
    
    // Wait for the navigation animation to finish
    await tester.pumpAndSettle();

    // 7. Verify we are now on the details screen
    expect(find.byType(MachineDetailsScreen), findsOneWidget);

    // 8. Verify the details screen actually has content
    expect(find.descendant(
      of: find.byType(MachineDetailsScreen), 
      matching: find.byType(Text)
    ), findsWidgets);
  });
}