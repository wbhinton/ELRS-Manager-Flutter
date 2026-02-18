import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'discovery_service.dart';

part 'discovery_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<String?> discovery(Ref ref) {
  final service = ref.watch(discoveryServiceProvider);
  
  // Start scanning when this provider is listened to
  service.startScan();
  
  // Stop scanning when this provider is disposed (no more listeners)
  ref.onDispose(() {
    service.stopScan();
  });
  
  return service.targetIpStream;
}
