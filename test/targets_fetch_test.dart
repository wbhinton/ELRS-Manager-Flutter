import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_manager/src/features/flashing/data/targets_provider.dart';

void main() {
  test('Targets Provider fetches data successfully', () async {
    // 1. Create a container (simulates the app scope)
    final container = ProviderContainer();
    addTearDown(container.dispose);

    // 2. Listen to the provider and wait for the future to complete
    // Note: We read the .future to get the actual value, not the AsyncValue wrapper
    final targets = await container.read(targetsProvider.future);

    // 3. Assertions
    expect(targets, isNotEmpty);
    print('✅ Successfully fetched ${targets.length} targets');
    print('Sample: ${targets.first.name}');
  });
}