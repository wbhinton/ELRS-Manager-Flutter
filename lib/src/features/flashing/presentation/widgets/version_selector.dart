import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../data/releases_repository.dart';
import '../../../../core/storage/firmware_cache_service.dart';
import '../flashing_controller.dart';

class VersionSelector extends HookConsumerWidget {
  const VersionSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final releasesAsync = ref.watch(releasesProvider);
    final selectedVersion = ref.watch(
      flashingControllerProvider.select((s) => s.selectedVersion),
    );
    final controller = ref.read(flashingControllerProvider.notifier);

    // Auto-select latest on data load if nothing selected
    final cachedVersions = useState<List<String>>([]);

    useEffect(() {
      // Load cached versions
      Future.microtask(() async {
        final cacheService = ref.read(firmwareCacheServiceProvider);
        cachedVersions.value = await cacheService.getCachedVersions();
      });

      if (releasesAsync.hasValue &&
          selectedVersion == null &&
          releasesAsync.value!.isNotEmpty) {
        // Defer update to avoid build cycle
        Future.microtask(
          () => controller.selectVersion(releasesAsync.value!.first),
        );
      }
      return null;
    }, [releasesAsync.hasValue]);

    return releasesAsync.when(
      data: (versions) {
        // Ensure selected version is in the list, otherwise reset (or handle custom?)
        // If selectedVersion is not null but not in list, it might be fine if we allow custom,
        // but for now let's assume valid selection.

        return DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Firmware Version',
            border: OutlineInputBorder(),
            helperText: 'Select the ELRS version to flash (>= 3.0.0)',
          ),
          initialValue: selectedVersion,
          items: versions.map((version) {
            final isCached = cachedVersions.value.contains(version);
            return DropdownMenuItem(
              value: version,
              child: Row(
                children: [
                  Text(version),
                  if (isCached) ...[
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.offline_pin,
                      size: 16,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '(Offline)',
                      style: TextStyle(fontSize: 12, color: Colors.green),
                    ),
                  ],
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.selectVersion(value);
            }
          },
        );
      },
      loading: () => const Center(child: LinearProgressIndicator()),
      error: (err, stack) => Text(
        'Error loading versions: $err',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}
