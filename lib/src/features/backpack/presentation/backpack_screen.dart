import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'backpack_controller.dart';

class BackpackScreen extends HookConsumerWidget {
  const BackpackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(backpackControllerProvider);
    final controller = ref.read(backpackControllerProvider.notifier);

    useEffect(() {
      Future.microtask(() => controller.loadTargets());
      return null;
    }, []);

    // Purple theme accent
    final purpleColor = Colors.deepPurpleAccent;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Backpack Flashing'),
        foregroundColor: purpleColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Flash your VRX Backpack',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Select your goggle module from the list below.'),
            
            const SizedBox(height: 32),

            if (state.errorMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.red.withOpacity(0.1),
                child: Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
              ),

            // Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Goggle Module',
                border: const OutlineInputBorder(),
                prefixIcon: Icon(Icons.videocam, color: purpleColor),
              ),
              value: state.selectedTarget,
              items: state.availableTargets.map((t) {
                return DropdownMenuItem(value: t, child: Text(t));
              }).toList(),
              onChanged: state.status == BackpackStatus.idle || state.status == BackpackStatus.error
                  ? (val) => controller.selectTarget(val)
                  : null, // Disable during flash
            ),

            const SizedBox(height: 48),

            // Progress
            if (state.status == BackpackStatus.downloading || state.status == BackpackStatus.flashing) ...[
               LinearProgressIndicator(
                 value: state.progress, 
                 backgroundColor: purpleColor.withOpacity(0.2),
                 valueColor: AlwaysStoppedAnimation<Color>(purpleColor),
               ),
               const SizedBox(height: 8),
               Text(
                 state.status == BackpackStatus.downloading ? 'Downloading Firmware...' : 'Flashing to Device...',
                 textAlign: TextAlign.center,
               ),
            ],

            if (state.status == BackpackStatus.success)
               const Center(
                 child: Column(
                   children: [
                     Icon(Icons.check_circle, color: Colors.green, size: 64),
                     SizedBox(height: 8),
                     Text('Flashing Successful!', style: TextStyle(fontWeight: FontWeight.bold)),
                   ],
                 ),
               ),

            const Spacer(),

            // Action Button
            SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: purpleColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: (state.status == BackpackStatus.downloading || state.status == BackpackStatus.flashing)
                    ? null
                    : () => controller.flash(),
                icon: const Icon(Icons.system_update_alt),
                label: const Text('UPDATE BACKPACK'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
