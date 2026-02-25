import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/networking/discovery_provider.dart';

class ConnectionStatusBadge extends ConsumerWidget {
  const ConnectionStatusBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ipAsync = ref.watch(discoveryProvider);

    return ipAsync.when(
      data: (ip) {
        final isConnected = ip != null;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Connection Status'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status: ${isConnected ? "Connected" : "Disconnected"}',
                      ),
                      if (isConnected) Text('IP Address: $ip'),
                      // Signal strength could be added here if available from discovery service
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Chip(
              avatar: Icon(
                isConnected ? Icons.wifi : Icons.wifi_off,
                size: 16,
                color: isConnected ? Colors.green : Colors.grey,
              ),
              label: Text(
                isConnected ? 'Connected ($ip)' : 'Searching...',
                style: const TextStyle(fontSize: 12),
              ),
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest,
            ),
          ),
        );
      },
      loading: () => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Chip(
          avatar: Icon(Icons.wifi_find, size: 16, color: Colors.grey),
          label: Text('Scanning...', style: TextStyle(color: Colors.grey)),
        ),
      ),
      error: (err, _) => const SizedBox.shrink(),
    );
  }
}
