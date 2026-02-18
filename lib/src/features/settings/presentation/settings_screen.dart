import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'settings_controller.dart';

class SettingsScreen extends HookConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(settingsControllerProvider.notifier);
    final state = ref.watch(settingsControllerProvider);

    useEffect(() {
      Future.microtask(() => controller.loadSettings());
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          _buildSectionHeader(context, 'Flashing Defaults'),
          ListTile(
            title: const Text('Default Regulatory Domain'),
            subtitle: Text(_getDomainLabel(state.defaultRegulatoryDomain)),
            trailing: DropdownButton<int>(
              value: state.defaultRegulatoryDomain,
              onChanged: (val) {
                if (val != null) controller.setDefaultRegulatoryDomain(val);
              },
              items: const [
                DropdownMenuItem(value: 0, child: Text('FCC (915MHz)')),
                DropdownMenuItem(value: 1, child: Text('EU (868MHz)')),
                DropdownMenuItem(value: 2, child: Text('ISM (2.4GHz)')),
                DropdownMenuItem(value: 3, child: Text('AU (915MHz)')),
              ],
            ),
          ),
          
          _buildSectionHeader(context, 'Networking'),
          SwitchListTile(
            title: const Text('Force Mobile Data'),
            subtitle: const Text('Use cellular data for downloads while connected to ELRS WiFi'),
            value: state.forceMobileData,
            onChanged: (val) => controller.setForceMobileData(val),
          ),
          
          _buildSectionHeader(context, 'About'),
          ListTile(
            title: const Text('App Version'),
            subtitle: Text(state.appVersion),
            onTap: () {
              // Easter egg logic could go here
            },
            leading: const Icon(Icons.info_outline),
          ),
          ListTile(
            title: const Text('GitHub Repository'),
            subtitle: const Text('https://github.com/ExpressLRS/ExpressLRS'),
            leading: const Icon(Icons.code),
            onTap: () => _launchUrl('https://github.com/ExpressLRS/ExpressLRS'),
          ),
          ListTile(
            title: const Text('Discord Community'),
            subtitle: const Text('Join the ELRS Discord'),
            leading: const Icon(Icons.chat),
            onTap: () => _launchUrl('https://discord.gg/dS6ReFY'),
          ),
          
          if (state.developerMode) ...[
             _buildSectionHeader(context, 'Developer'),
             const ListTile(title: Text('Developer Mode Enabled')),
          ]
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getDomainLabel(int value) {
    switch (value) {
      case 0: return 'FCC (915MHz)';
      case 1: return 'EU (868MHz)';
      case 2: return 'ISM (2.4GHz)';
      case 3: return 'AU (915MHz)';
      default: return 'Unknown';
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
