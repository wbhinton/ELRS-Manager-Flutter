import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'pwm_controller.dart';

class PwmScreen extends HookConsumerWidget {
  const PwmScreen({super.key});

  static const List<String> channelNames = [
    'Ch 1', 'Ch 2', 'Ch 3', 'Ch 4', 
    'Ch 5 (Aux1)', 'Ch 6 (Aux2)', 'Ch 7 (Aux3)', 'Ch 8 (Aux4)',
    'Ch 9 (Aux5)', 'Ch 10 (Aux6)', 'Ch 11 (Aux7)', 'Ch 12 (Aux8)',
    'Ch 13', 'Ch 14', 'Ch 15', 'Ch 16'
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pwmControllerProvider);
    final controller = ref.read(pwmControllerProvider.notifier);

    useEffect(() {
      Future.microtask(() => controller.loadConfig());
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PWM Configuration'),
      ),
      body: state.status == PwmStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (state.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(state.errorMessage!, style: const TextStyle(color: Colors.red)),
                  ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.outputs.length,
                    separatorBuilder: (ctx, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final currentChannel = state.outputs[index];
                      // Ensure channel index is within valid range for existing names, or show raw
                      
                      return ListTile(
                        title: Text('Output Pin ${index + 1}'),
                        subtitle: Text('Mapped to ${currentChannel < channelNames.length ? channelNames[currentChannel] : "Ch ${currentChannel + 1}"}'),
                        trailing: DropdownButton<int>(
                          value: currentChannel < channelNames.length ? currentChannel : null,
                          onChanged: (val) {
                            if (val != null) {
                              controller.updateOutput(index, val);
                            }
                          },
                          items: List.generate(channelNames.length, (i) {
                            return DropdownMenuItem(
                              value: i,
                              child: Text(
                                channelNames[i],
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: state.status == PwmStatus.saving 
            ? null 
            : () => controller.save(),
        child: state.status == PwmStatus.saving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save),
      ),
    );
  }
}
