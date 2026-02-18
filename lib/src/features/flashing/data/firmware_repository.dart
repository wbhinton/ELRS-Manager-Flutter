import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firmware_repository.g.dart';

class FirmwareRepository {
  final Dio _dio;

  FirmwareRepository(this._dio);

  Future<Uint8List> downloadFirmware(String filename, String version) async {
    // Construct the URL for the specific version
    // Example: https://github.com/ExpressLRS/ExpressLRS/releases/download/3.3.0/firmware.bin
    // Note: GitHub releases often have a 'v' prefix in the tag but not in the download URL sometimes, 
    // or vice versa. Usually: .../download/3.3.0/target.bin or .../download/v3.3.0/target.bin
    // Let's assume the version string passed in matches the tag name exactly (e.g. "3.3.0").
    // If the tag is "v3.3.0", pass "v3.3.0".
    
    // However, ELRS releases usually don't include 'v' in the folder path for assets? 
    // Checking recent releases: https://github.com/ExpressLRS/ExpressLRS/releases/download/3.4.3/firmware.bin 
    // So if the tag is "3.4.3", the URL has "3.4.3".
    
    final url = 'https://github.com/ExpressLRS/ExpressLRS/releases/download/$version/$filename';
    
    try {
      final response = await _dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );
      return response.data as Uint8List;
    } catch (e) {
      throw Exception('Failed to download firmware: $e');
    }
  }
}

@riverpod
FirmwareRepository firmwareRepository(Ref ref) {
  return FirmwareRepository(Dio());
}
