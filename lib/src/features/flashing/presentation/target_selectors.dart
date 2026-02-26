import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/targets_provider.dart';
import '../domain/target_definition.dart';
import 'flashing_controller.dart';

part 'target_selectors.g.dart';

@riverpod
List<String> availableDeviceTypes(Ref ref) {
  final targetsValue = ref.watch(targetsProvider);
  return targetsValue.when(
    data: (targets) {
      final types = targets.map((t) => t.deviceType).toSet().toList();
      types.sort();
      return types;
    },
    loading: () => [],
    error: (_, _) => [],
  );
}

@riverpod
List<String> availableVendors(Ref ref) {
  final targetsValue = ref.watch(targetsProvider);
  final selectedDeviceType = ref.watch(
    flashingControllerProvider.select((s) => s.selectedDeviceType),
  );

  if (selectedDeviceType == null) return [];

  return targetsValue.when(
    data: (targets) {
      final vendors = targets
          .where((t) => t.deviceType == selectedDeviceType)
          .map((t) => t.vendor)
          .toSet()
          .toList();
      vendors.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
      return vendors;
    },
    loading: () => [],
    error: (_, _) => [],
  );
}

@riverpod
List<String> availableFrequencies(Ref ref) {
  final targetsValue = ref.watch(targetsProvider);
  final selectedDeviceType = ref.watch(
    flashingControllerProvider.select((s) => s.selectedDeviceType),
  );
  final selectedVendor = ref.watch(
    flashingControllerProvider.select((s) => s.selectedVendor),
  );

  if (selectedDeviceType == null || selectedVendor == null) return [];

  return targetsValue.when(
    data: (targets) {
      final freqs = targets
          .where(
            (t) =>
                t.deviceType == selectedDeviceType &&
                t.vendor == selectedVendor,
          )
          .map((t) => t.frequencyType)
          .toSet()
          .toList();
      // Keep Dual Band at the end perhaps, but alphabetical is fine for now
      freqs.sort();
      return freqs;
    },
    loading: () => [],
    error: (_, _) => [],
  );
}

@riverpod
List<TargetDefinition> availableTargetsList(Ref ref) {
  final targetsValue = ref.watch(targetsProvider);
  final selectedDeviceType = ref.watch(
    flashingControllerProvider.select((s) => s.selectedDeviceType),
  );
  final selectedVendor = ref.watch(
    flashingControllerProvider.select((s) => s.selectedVendor),
  );
  final selectedFrequency = ref.watch(
    flashingControllerProvider.select((s) => s.selectedFrequency),
  );

  if (selectedDeviceType == null ||
      selectedVendor == null ||
      selectedFrequency == null) {
    return [];
  }

  return targetsValue.when(
    data: (targets) {
      final devices = targets
          .where(
            (t) =>
                t.deviceType == selectedDeviceType &&
                t.vendor == selectedVendor &&
                t.frequencyType == selectedFrequency,
          )
          .toList();
      devices.sort((a, b) => a.name.compareTo(b.name));
      return devices;
    },
    loading: () => [],
    error: (_, _) => [],
  );
}
