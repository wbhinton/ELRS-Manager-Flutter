import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/target_definition.dart';
import '../flashing_controller.dart';
import '../target_selectors.dart';

class TargetSelectionCard extends ConsumerWidget {
  const TargetSelectionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vendors = ref.watch(uniqueVendorsProvider);
    final devices = ref.watch(devicesForVendorProvider);
    final selectedVendor = ref.watch(
      flashingControllerProvider.select((s) => s.selectedVendor),
    );
    final selectedTarget = ref.watch(
      flashingControllerProvider.select((s) => s.selectedTarget),
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.developer_board),
                SizedBox(width: 8),
                Text(
                  'Target Selection',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Vendor Dropdown
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Device Vendor'),
              initialValue: selectedVendor,
              items: vendors.map((vendor) {
                return DropdownMenuItem(value: vendor, child: Text(vendor));
              }).toList(),
              onChanged: (value) {
                ref
                    .read(flashingControllerProvider.notifier)
                    .selectVendor(value);
              },
            ),
            const SizedBox(height: 16),

            // Device Dropdown
            DropdownButtonFormField<TargetDefinition>(
              decoration: const InputDecoration(labelText: 'Device Target'),
              initialValue: selectedTarget,
              // If no vendor selected, disable the dropdown
              items: selectedVendor == null
                  ? []
                  : devices.map((device) {
                      return DropdownMenuItem(
                        value: device,
                        // Show Name and Product Code
                        child: Text(
                          '${device.name} ${device.productCode != null ? "(${device.productCode})" : ""}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
              onChanged: selectedVendor == null
                  ? null
                  : (value) {
                      ref
                          .read(flashingControllerProvider.notifier)
                          .selectTarget(value);
                    },
              isExpanded: true, // Handle long text
            ),
          ],
        ),
      ),
    );
  }
}
