import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'widgets/target_selection_card.dart';
import 'widgets/options_card.dart';
import 'package:go_router/go_router.dart';
import 'flashing_controller.dart';

class FlashingScreen extends HookConsumerWidget {
  const FlashingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      // Load saved options on mount
      Future.microtask(() => ref.read(flashingControllerProvider.notifier).loadSavedOptions());
      return null;
    }, []);

    final state = ref.watch(flashingControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ELRS Mobile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Target Selection Card
            const TargetSelectionCard(),
            const SizedBox(height: 16),

            // 2. Options Card
            const OptionsCard(),
            const SizedBox(height: 24),
            const SizedBox(height: 24),

            // 3. Action Button & Progress
            if (state.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  state.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
              
            if (state.status == FlashingStatus.success)
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Flashing Successful! Device is rebooting.',
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),

            if (state.status != FlashingStatus.idle && state.status != FlashingStatus.error && state.status != FlashingStatus.success)
              Column(
                children: [
                   LinearProgressIndicator(value: state.progress),
                   const SizedBox(height: 8),
                   Text(state.status.name.toUpperCase()),
                   const SizedBox(height: 16),
                ],
              ),

            ElevatedButton(
              onPressed: (state.status == FlashingStatus.idle || state.status == FlashingStatus.error || state.status == FlashingStatus.success)
                  ? () {
                      if (state.status == FlashingStatus.success) {
                        ref.read(flashingControllerProvider.notifier).resetStatus();
                      } else {
                        ref.read(flashingControllerProvider.notifier).flash();
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: state.status == FlashingStatus.success ? Colors.green : null,
              ),
              child: Text(state.status == FlashingStatus.success ? 'DONE' : 'FLASH'),
            ),
          ],
        ),
      ),
    );
  }
}
