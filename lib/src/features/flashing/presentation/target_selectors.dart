import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/targets_provider.dart';
import '../domain/target_definition.dart';
import 'flashing_controller.dart';

part 'target_selectors.g.dart';

@riverpod
List<String> uniqueVendors(Ref ref) {
  final targetsValue = ref.watch(targetsProvider);
  
  return targetsValue.when(
    data: (targets) {
      final vendors = targets.map((t) => t.vendor).toSet().toList();
      vendors.sort((a, b) => a.compareTo(b));
      return vendors;
    },
    loading: () => [],
    error: (_, __) => [],
  );
}

@riverpod
List<TargetDefinition> devicesForVendor(Ref ref) {
  final targetsValue = ref.watch(targetsProvider);
  // Correct usage: watch the provider, then select properties
  final selectedVendor = ref.watch(flashingControllerProvider.select((s) => s.selectedVendor));

  if (selectedVendor == null) return [];

  return targetsValue.when(
    data: (targets) {
      final devices = targets.where((t) => t.vendor == selectedVendor).toList();
      devices.sort((a, b) => a.name.compareTo(b.name));
      return devices;
    },
    loading: () => [],
    error: (_, __) => [],
  );
}
