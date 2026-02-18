import 'dart:async';
import 'package:nsd/nsd.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'discovery_service.g.dart';

@Riverpod(keepAlive: true)
DiscoveryService discoveryService(Ref ref) {
  return DiscoveryService();
}

class DiscoveryService {
  Discovery? _discovery;
  final _ipController = StreamController<String?>.broadcast();
  
  Stream<String?> get targetIpStream => _ipController.stream;
  
  Future<void> startScan() async {
    // Prevent multiple scans
    if (_discovery != null) return;

    try {
      _discovery = await startDiscovery('_http._tcp');
      
      _discovery!.addListener(() {
        // Listener fires on changes. Iterate over services.
        for (final service in _discovery!.services) {
          final name = service.name ?? '';
          if (name.toLowerCase().contains('elrs')) {
            final host = service.host;
            if (host != null) {
              _ipController.add(host);
              // Found one, we could stop or keep scanning. 
              // For now, let's keep scanning but just emit.
            }
          }
        }
      });
    } catch (e) {
      print('Discovery failed: $e');
    }
  }

  Future<void> stopScan() async {
    if (_discovery != null) {
      await stopDiscovery(_discovery!);
      _discovery = null;
      _ipController.add(null); // Emit null to indicate scan stopped / disconnected
    }
  }
}
