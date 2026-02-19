import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../flashing/data/device_repository.dart';
import '../domain/device_config_model.dart';

class DeviceSettingsScreen extends HookConsumerWidget {
  const DeviceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We fetch config on load. 
    // Ideally we'd use a FutureProvider for this screen state.
    // For now, let's just use FutureBuilder or useEffect + state.
    final config = useState<DeviceConfig?>(null);
    final error = useState<Object?>(null);
    final loading = useState(true);

    final loadConfig = useCallback(() async {
      try {
        loading.value = true;
        error.value = null;
        final data = await ref.read(deviceRepositoryProvider).fetchConfig();
        config.value = data;
      } catch (e) {
        error.value = e;
      } finally {
        loading.value = false;
      }
    }, []);

    useEffect(() {
      loadConfig();
      return null;
    }, []);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Device Configuration'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Info'),
              Tab(text: 'General'),
              Tab(text: 'Model/PWM'),
            ],
          ),
        ),
        body: loading.value
            ? const Center(child: CircularProgressIndicator())
            : error.value != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 48),
                        const SizedBox(height: 16),
                        Text('Error: ${error.value}'),
                        ElevatedButton(onPressed: loadConfig, child: const Text('Retry')),
                      ],
                    ),
                  )
                : config.value == null
                    ? const Center(child: Text('No configuration loaded.'))
                    : TabBarView(
                        children: [
                          _InfoTab(config: config.value!),
                          _GeneralTab(config: config.value!, onRefresh: loadConfig),
                          // Placeholder for now, or integration with existing PWM screen
                          const Center(child: Text('Model Match & PWM Settings go here (Integration Pending)')),
                        ],
                      ),
      ),
    );
  }
}

class _InfoTab extends StatelessWidget {
  final DeviceConfig config;
  const _InfoTab({required this.config});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoTile('Product Name', config.productName ?? 'Unknown'),
        _buildInfoTile('Firmware Version', config.version),
        _buildInfoTile('Regulatory Domain', config.regDomain ?? 'Unknown'),
        _buildInfoTile('UID', config.uid.map((e) => e.toRadixString(16).padLeft(2, '0')).join(', ')),
        _buildInfoTile('Model ID', config.modelId == 255 ? 'Off (255)' : '${config.modelId}'),
      ],
    );
  }

  Widget _buildInfoTile(String title, String subtitle) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }
}

class _GeneralTab extends HookConsumerWidget {
  final DeviceConfig config;
  final VoidCallback onRefresh;

  const _GeneralTab({required this.config, required this.onRefresh});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bindPhraseController = useTextEditingController();
    final ssidController = useTextEditingController(text: config.options['wifi_ssid'] ?? '');
    final passwordController = useTextEditingController(text: config.options['wifi_password'] ?? '');
    
    final obscureBind = useState(true);
    final obscureWifi = useState(true);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Binding Phrase', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: bindPhraseController,
          obscureText: obscureBind.value,
          decoration: InputDecoration(
            labelText: 'Enter new Binding Phrase',
            helperText: 'Will generate UID and reboot device',
            suffixIcon: IconButton(
              icon: Icon(obscureBind.value ? Icons.visibility : Icons.visibility_off),
              onPressed: () => obscureBind.value = !obscureBind.value,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
            if (bindPhraseController.text.isEmpty) return;
            try {
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              await ref.read(deviceRepositoryProvider).updateBindingPhrase(bindPhraseController.text);
              scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Binding Phrase updated! Device rebooting...')));
              // Device will reboot, so we might lose connection or need to wait.
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
            }
          },
          child: const Text('Update Binding Phrase'),
        ),

        const Divider(height: 32),

        const Text('Home WiFi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: ssidController,
          decoration: const InputDecoration(labelText: 'WiFi SSID'),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: passwordController,
          obscureText: obscureWifi.value,
          decoration: InputDecoration(
            labelText: 'WiFi Password',
             suffixIcon: IconButton(
              icon: Icon(obscureWifi.value ? Icons.visibility : Icons.visibility_off),
              onPressed: () => obscureWifi.value = !obscureWifi.value,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () async {
             try {
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              await ref.read(deviceRepositoryProvider).updateWifi(ssidController.text, passwordController.text);
              scaffoldMessenger.showSnackBar(const SnackBar(content: Text('WiFi Settings updated! Device rebooting...')));
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
            }
          },
          child: const Text('Update WiFi'),
        ),
      ],
    );
  }
}
