import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_manager/src/features/dashboard/presentation/dashboard_screen.dart';
import 'package:elrs_manager/src/features/dashboard/presentation/widgets/connection_status_badge.dart';

void main() {
  testWidgets('Dashboard renders all menu items', (WidgetTester tester) async {
    // 1. Pump Widget
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: DashboardScreen(),
        ),
      ),
    );

    // 2. Assertions
    
    // Verify Cards (Title)
    expect(find.text('Flash Device'), findsOneWidget);
    expect(find.text('Model Match'), findsOneWidget);
    expect(find.text('Backpack'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);

    // Verify Icons
    expect(find.byIcon(Icons.system_update), findsOneWidget);
    expect(find.byIcon(Icons.flight_takeoff), findsOneWidget); // Model Match
    expect(find.byIcon(Icons.videocam), findsOneWidget); // Backpack
    expect(find.byIcon(Icons.settings), findsOneWidget);

    // Verify Status Badge
    expect(find.byType(ConnectionStatusBadge), findsOneWidget);

    // Verify Badge Text (Default state is "No Device" or "RX Connected" depending on provider default)
    // The default in our dummy provider is `yield false`, so "No Device".
    // However, StreamProviders start with loading state. 
    // We might need to settle the stream.
    await tester.pumpAndSettle();
    
    // After settle, it should show the data from the stream.
    // Our dummy stream yields `false` immediately? Async* might take a microtask.
    // Let's check for either text to be safe, or specific.
    // "No Device" is expected for false.
    expect(find.text('No Device'), findsOneWidget);
  });
}
