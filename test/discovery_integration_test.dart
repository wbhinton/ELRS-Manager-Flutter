import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_manager/src/core/networking/discovery_provider.dart';
import 'package:elrs_manager/src/features/flashing/data/device_repository.dart';
import 'package:elrs_manager/src/features/dashboard/presentation/widgets/connection_status_badge.dart';

void main() {
  group('Discovery Integration Test', () {
    test('Repository updates Base URL when Discovery finds device', () async {
      // Setup
      final controller = StreamController<String?>.broadcast();
      addTearDown(controller.close);

      final container = ProviderContainer(
        overrides: [
          discoveryProvider.overrideWith((ref) => controller.stream),
        ],
      );
      addTearDown(container.dispose);

      // Keep the provider alive and print logic
      container.listen(discoveryProvider, (previous, next) {
        print('Provider Transition: $previous -> $next');
      });

      // Act 1 (Default/Initial State - null)
      // StreamProvider starts with AsyncLoading.
      // We emit null.
      controller.add(null);
      await Future.microtask(() {});
      await Future.delayed(const Duration(milliseconds: 50));
      
      // Check if we have data
      // Read Repo
      var repo = container.read(deviceRepositoryProvider);
      
      // Assert Default
      expect(repo.dio.options.baseUrl, contains('10.0.0.1'));

      // Act 2 (Discovery)
      controller.add('192.168.1.55');
      
      // Wait for stream propagation
      await Future.delayed(const Duration(milliseconds: 50));
      
      // Verify provider updated
      final ipState = container.read(discoveryProvider);
      if (ipState.isLoading) {
         // wait a bit more if needed
         await Future.delayed(const Duration(milliseconds: 50));
      }
      print('Final Provider Value: ${container.read(discoveryProvider)}');

      // Read Repo again 
      repo = container.read(deviceRepositoryProvider);
      print('Repo Base URL: ${repo.dio.options.baseUrl}');

      // Assert New IP
      expect(repo.dio.options.baseUrl, contains('192.168.1.55'));
    });

    testWidgets('Badge shows Green when connected', (tester) async {
      final controller = StreamController<String?>.broadcast();
      addTearDown(controller.close);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            discoveryProvider.overrideWith((ref) => controller.stream),
          ],
          child: const MaterialApp(home: Scaffold(body: ConnectionStatusBadge())),
        ),
      );
      
      // Initial state is Loading -> "Initializing..."
      expect(find.text('Initializing...'), findsOneWidget);

      // Act 1: Searching (null)
      controller.add(null);
      await tester.pump(const Duration(milliseconds: 100)); // Allow stream to emit
      await tester.pump(); // Rebuild UI

      // Assert Searching
      expect(find.byIcon(Icons.wifi_off), findsOneWidget);
      expect(find.text('Searching...'), findsOneWidget);

      // Act 2: Connected
      controller.add('192.168.1.55');
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump();

      // Assert Connected
      expect(find.byIcon(Icons.wifi), findsOneWidget);
      expect(find.textContaining('192.168.1.55'), findsOneWidget);
    });
  });
}
