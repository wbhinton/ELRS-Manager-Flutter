import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'model_match_controller.dart';

class ModelMatchScreen extends HookConsumerWidget {
  const ModelMatchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(modelMatchControllerProvider);
    final controller = ref.read(modelMatchControllerProvider.notifier);

    // Load config on mount
    useEffect(() {
      Future.microtask(() => controller.loadConfig());
      return null;
    }, []);

    // Local state for UI feedback before saving? 
    // Or just drive directly from riverpod state if we want optimistic updates?
    // Using local state for the slider allows smooth dragging, then save on release/button.
    // The requirement says "Action Button: APPLY". So we need local state for the inputs.
    
    final localId = useState(state.modelId);
    final localEnabled = useState(state.isEnabled);
    
    // Sync local state when remote state loads/changes successfully
    useEffect(() {
        if (state.status == ModelMatchStatus.success || state.status == ModelMatchStatus.idle) {
             localId.value = state.modelId;
             localEnabled.value = state.isEnabled;
        }
        return null;
    }, [state.modelId, state.isEnabled, state.status]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Model Match'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            if (state.status == ModelMatchStatus.loading)
               const LinearProgressIndicator(),
            if (state.errorMessage != null)
               Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
               
            const SizedBox(height: 32),
            
            // Big Number Display
            Text(
              localEnabled.value ? localId.value.toString() : 'OFF',
              style: TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.bold,
                color: localEnabled.value 
                    ? Theme.of(context).colorScheme.primary 
                    : Colors.grey,
              ),
            ),
            const Text('Model ID'),
            
            const SizedBox(height: 48),

            // Toggle
            SwitchListTile(
              title: const Text('Enable Model Match'),
              value: localEnabled.value,
              onChanged: (val) => localEnabled.value = val,
            ),
            
            const SizedBox(height: 24),

            // Slider
            // Only active if enabled
            Text('Adjust ID (0-63)'),
            Slider(
              value: localId.value.toDouble().clamp(0, 63),
              min: 0,
              max: 63,
              divisions: 63,
              label: localId.value.toString(),
              onChanged: localEnabled.value 
                  ? (val) => localId.value = val.toInt()
                  : null,
            ),

            const Spacer(),
            
            // Action Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: state.status == ModelMatchStatus.loading 
                    ? null 
                    : () {
                        controller.save(localId.value, localEnabled.value);
                      },
                child: const Text('APPLY'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
