import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../flashing_controller.dart';
import 'version_selector.dart';

class OptionsCard extends ConsumerStatefulWidget {
  const OptionsCard({super.key});

  @override
  ConsumerState<OptionsCard> createState() => _OptionsCardState();
}

class _OptionsCardState extends ConsumerState<OptionsCard> {
  late TextEditingController _bindPhraseController;
  late TextEditingController _wifiSsidController;
  late TextEditingController _wifiPasswordController;

  @override
  void initState() {
    super.initState();
    _bindPhraseController = TextEditingController();
    _wifiSsidController = TextEditingController();
    _wifiPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _bindPhraseController.dispose();
    _wifiSsidController.dispose();
    _wifiPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to state changes to update controllers when data loads
    ref.listen(flashingControllerProvider, (previous, next) {
      if (previous?.bindPhrase != next.bindPhrase && _bindPhraseController.text != next.bindPhrase) {
         _bindPhraseController.text = next.bindPhrase;
      }
      if (previous?.wifiSsid != next.wifiSsid && _wifiSsidController.text != next.wifiSsid) {
         _wifiSsidController.text = next.wifiSsid;
      }
      if (previous?.wifiPassword != next.wifiPassword && _wifiPasswordController.text != next.wifiPassword) {
         _wifiPasswordController.text = next.wifiPassword;
      }
    });

    final regulatoryDomain = ref.watch(flashingControllerProvider.select((s) => s.regulatoryDomain));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.settings),
                SizedBox(width: 8),
                Text('Device Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            
            // Firmware Version
            const VersionSelector(),
            const SizedBox(height: 16),

            // Bind Phrase
            TextFormField(
              controller: _bindPhraseController,
              decoration: const InputDecoration(
                labelText: 'Binding Phrase',
                helperText: 'Your unique binding phrase',
              ),
              onChanged: (value) => ref.read(flashingControllerProvider.notifier).setBindPhrase(value),
              obscureText: true,
            ),
             const SizedBox(height: 16),

            // Wifi SSID
            TextFormField(
              controller: _wifiSsidController,
              decoration: const InputDecoration(labelText: 'WiFi SSID'),
              onChanged: (value) => ref.read(flashingControllerProvider.notifier).setWifiSsid(value),
            ),
             const SizedBox(height: 16),

            // Wifi Password
            TextFormField(
              controller: _wifiPasswordController,
              decoration: const InputDecoration(labelText: 'WiFi Password'),
              onChanged: (value) => ref.read(flashingControllerProvider.notifier).setWifiPassword(value),
              obscureText: true,
            ),
            const SizedBox(height: 16),

            // Regulatory Domain
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(labelText: 'Regulatory Domain'),
              value: regulatoryDomain,
              items: const [
                 DropdownMenuItem(value: 0, child: Text('FCC (915MHz)')),
                 DropdownMenuItem(value: 1, child: Text('EU (868MHz)')),
                 DropdownMenuItem(value: 2, child: Text('ISM (2.4GHz)')),
                 DropdownMenuItem(value: 3, child: Text('AU (915MHz)')),
              ],
              onChanged: (value) {
                if (value != null) {
                  ref.read(flashingControllerProvider.notifier).setRegulatoryDomain(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
