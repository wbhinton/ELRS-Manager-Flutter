import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elrs_mobile/src/features/flashing/domain/target_definition.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/flashing_controller.dart';
import 'package:elrs_mobile/src/features/flashing/presentation/target_selectors.dart';
import 'package:elrs_mobile/src/features/flashing/data/targets_provider.dart';

void main() {
  test('Selection Logic Resets Correctly', () async {
    // 1. Mock Data Setup
    final t1 = TargetDefinition(
      vendor: 'BetaFPV',
      name: 'Nano RX',
      firmware: 'f1',
    );
    final t2 = TargetDefinition(
      vendor: 'BetaFPV',
      name: 'Micro TX',
      firmware: 'f2',
    );
    final t3 = TargetDefinition(
      vendor: 'HappyModel',
      name: 'EP1 RX',
      firmware: 'f3',
    );
    final dummyTargets = [t1, t2, t3];

    // 2. Setup Container
    final container = ProviderContainer(
      overrides: [
        targetsProvider.overrideWith((ref) => Future.value(dummyTargets)),
      ],
    );
    addTearDown(container.dispose);

    // Act 1 (Filter)
    container.read(flashingControllerProvider.notifier).selectVendor('BetaFPV');

    // Wait for the async targetsProvider to resolve if needed,
    // though the override is a Future.value.
    // However, devicesForVendorProvider watches targetsProvider.
    // Reading devicesForVendorProvider will trigger the provider.

    // Since targetsProvider is async, devicesForVendorProvider will expose AsyncValue initially if we used AsyncValue in targetsProvider.
    // But wait, targetsProvider returns Future<List>.
    // uniqueVendorsProvider uses ref.watch(targetsProvider).when...
    // So we need to wait for the future to complete.
    await container.read(targetsProvider.future);
    await null; // Allow microtasks to propagate selections

    // Assert 1: Select RX -> BetaFPV -> 2.4GHz
    final notifier = container.read(flashingControllerProvider.notifier);
    notifier.selectDeviceType('RX');
    notifier.selectVendor('BetaFPV');
    notifier.selectFrequency('2.4GHz');

    final devices1 = container.read(availableTargetsListProvider);
    expect(devices1, contains(t1));
    expect(devices1, contains(t2));
    expect(devices1, isNot(contains(t3)));
  });

  // Re-writing the test to be async and handle the AsyncValue propagation
  test('Selection Logic Verify', () async {
    final t1 = TargetDefinition(
      vendor: 'BetaFPV',
      name: 'Nano RX',
      firmware: 'f1',
    );
    final t2 = TargetDefinition(
      vendor: 'BetaFPV',
      name: 'Micro TX',
      firmware: 'f2',
    );
    final t3 = TargetDefinition(
      vendor: 'HappyModel',
      name: 'EP1 RX',
      firmware: 'f3',
    );
    final dummyTargets = [t1, t2, t3];

    final container = ProviderContainer(
      overrides: [
        targetsProvider.overrideWith((ref) => Future.value(dummyTargets)),
      ],
    );
    addTearDown(container.dispose);

    // Initialize/Wait for data
    await container.read(targetsProvider.future);

    // Act 1: Select RX -> BetaFPV -> 2.4GHz
    final notifier = container.read(flashingControllerProvider.notifier);
    notifier.selectDeviceType('RX');
    notifier.selectVendor('BetaFPV');
    notifier.selectFrequency('2.4GHz');
    await null;

    // Assert 1: Devices list should have T1 and T2 (assuming T2 is RX)
    // T2 in dummyTargets is "Micro TX" but default deviceType is "RX".
    // T1: BetaFPV Nano RX, T2: BetaFPV Micro TX (default RX), T3: HappyModel EP1 RX
    final devicesBeta = container.read(availableTargetsListProvider);
    expect(devicesBeta, containsAll([t1, t2]));
    expect(devicesBeta, isNot(contains(t3)));

    // Act 2: Select T1
    notifier.selectTarget(t1);
    final state2 = container.read(flashingControllerProvider);
    expect(state2.selectedTarget, equals(t1));

    // Act 3: Reset - Select HappyModel
    // To see HappyModel EP1 RX, we need to keep DeviceType=RX and Freq=2.4GHz
    notifier.selectVendor('HappyModel');
    notifier.selectFrequency('2.4GHz');
    await null;

    // Assert 3
    final state3 = container.read(flashingControllerProvider);
    expect(
      state3.selectedTarget,
      isNull,
      reason: 'Target should be reset to null',
    );
    expect(state3.selectedVendor, 'HappyModel');

    final devicesHappy = container.read(availableTargetsListProvider);
    expect(devicesHappy, contains(t3));
    expect(devicesHappy.length, 1);
  });
}
