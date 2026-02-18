import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/networking/device_dio.dart';

part 'device_repository.g.dart';

@riverpod
DeviceRepository deviceRepository(Ref ref) {
  final dio = ref.watch(deviceDioProvider);
  return DeviceRepository(dio);
}

class DeviceRepository {
  final Dio _dio;

  DeviceRepository(this._dio);

  Dio get dio => _dio;

  /// Fetches the current configuration from the device.
  /// Endpoint: GET /config
  Future<Map<String, dynamic>> fetchConfig() async {
    try {
      final response = await _dio.get('/config');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch config: $e');
    }
  }

  /// Fetches the hardware definition from the device.
  /// Endpoint: GET /hardware.json
  Future<Map<String, dynamic>> fetchHardware() async {
    try {
      final response = await _dio.get('/hardware.json');
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch hardware info: $e');
    }
  }

  /// Flashes the firmware to the device.
  /// Endpoint: POST /update
  ///
  /// [firmwareData] is the binary data of the firmware file.
  /// [onSendProgress] is an optional callback for upload progress.
  Future<void> flashFirmware(
    Uint8List firmwareData, {
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        'update': MultipartFile.fromBytes(
          firmwareData,
          filename: 'firmware.bin',
        ),
      });

      await _dio.post(
        '/update',
        data: formData,
        onSendProgress: onSendProgress,
      );
    } catch (e) {
      throw Exception('Failed to flash firmware: $e');
    }
  }

  /// Updates the Model Match configuration.
  /// Endpoint: POST /config
  ///
  /// [modelId] is the ID (0-63). 255 usually means off in ELRS context, 
  /// but we'll stick to the user request.
  /// [enabled] determines if model match is active.
  Future<void> updateModelMatch(int modelId, bool enabled) async {
    try {
      // Structure based on ELRS config API. 
      // For MVP, sending flat JSON keys as requested.
      // Real ELRS uses a more complex structure, but this is the requested contract.
      await _dio.post(
        '/config',
        data: {
          'modelId': modelId,
          'modelMatch': enabled,
        },
      );
    } catch (e) {
      throw Exception('Failed to update model match: $e');
    }
  }

  /// Sets the PWM output mapping.
  /// Endpoint: POST /config
  ///
  /// [mapping] maps Output Pin Index (0-based) to Input Channel Index.
  /// The payload sent is {'pwm_outputs': [ch_for_pin0, ch_for_pin1, ...]}
  Future<void> setPwmMapping(Map<int, int> mapping) async {
    try {
      // Convert map to list. Identifying max index to determine list size.
      // Assuming contiguous indices starting from 0.
      if (mapping.isEmpty) return;
      
      final maxIndex = mapping.keys.reduce((a, b) => a > b ? a : b);
      final List<int> pwmOutputs = List.filled(maxIndex + 1, 0);
      
      mapping.forEach((pin, channel) {
        if (pin >= 0 && pin < pwmOutputs.length) {
          pwmOutputs[pin] = channel;
        }
      });

      await _dio.post(
        '/config',
        data: {
          'pwm_outputs': pwmOutputs,
        },
      );
    } catch (e) {
      throw Exception('Failed to set PWM mapping: $e');
    }
  }
}
