import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'discovery_provider.dart';

part 'device_dio.g.dart';

@riverpod
Dio deviceDio(Ref ref) {
  // Watch discovery provider for IP changes
  final ipAsync = ref.watch(discoveryProvider);
  final baseUrl = ipAsync.asData?.value != null 
      ? 'http://${ipAsync.asData!.value}' 
      : 'http://10.0.0.1'; // Default Fallback

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'User-Agent': 'ELRSManager/1.0',
      },
      // Ensure we don't follow redirects automatically if that causes issues with captive portals,
      // though typically ELRS devices don't redirect.
    ),
  );
  return dio;
}
