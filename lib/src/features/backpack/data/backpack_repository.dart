import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'backpack_repository.g.dart';

@riverpod
BackpackRepository backpackRepository(Ref ref) {
  return BackpackRepository(Dio());
}


class BackpackRepository {
  final Dio _dio;

  BackpackRepository(this._dio);

  Future<List<String>> fetchBackpackTargets() async {
    // For MVP, returning hardcoded list as requested, simulating a fetch
    // Real implementation would fetch from GitHub JSON
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      'HDZero VRX4/VRX Analog',
      'HDZero Goggle',
      'Skyzone Steadyview/Fusion',
      'Fatshark Rapidfire',
      'Orqa FPV.Connect',
    ];
  }

  Future<Uint8List> downloadBackpackFirmware(String targetName) async {
    // Simulating download for MVP
    await Future.delayed(const Duration(seconds: 1));
    
    // In a real app, we'd map targetName to a URL and download
    // final response = await _dio.get(url, options: Options(responseType: ResponseType.bytes));
    // return response.data;
    
    // Return dummy bytes
    return Uint8List.fromList([0xDE, 0xAD, 0xBE, 0xEF]);
  }
}
