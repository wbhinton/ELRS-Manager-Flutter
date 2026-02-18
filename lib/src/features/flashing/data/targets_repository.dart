import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../domain/target_definition.dart';

class TargetsRepository {
  final Dio _dio;

  TargetsRepository(this._dio);

  Future<List<TargetDefinition>> fetchTargets() async {
    try {
      final response = await _dio.get(
        'https://raw.githubusercontent.com/ExpressLRS/targets/master/targets.json',
        options: Options(responseType: ResponseType.plain),
      );

      return await compute(_parseTargets, response.data as String);
    } catch (e) {
      throw Exception('Failed to fetch targets: $e');
    }
  }

  static List<TargetDefinition> _parseTargets(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final List<TargetDefinition> targets = [];

    // The targets.json structure is typically:
    // {
    //   "vendor1": {
    //     "device1": { ... },
    //     "device2": { ... }
    //   },
    //   "vendor2": { ... }
    // }
    // We need to flatten this into a list of TargetDefinition objects.
    // However, the user request implied a simpler list or direct mapping. 
    // Given the complexity of targets.json, we'll implement a recursive or nested parsing logic
    // if we needed to preserve the structure, but here we will try to iterate through vendors and devices.

    // Wait, the user said: "The model should represent an ELRS Target... based on targets.json".
    // And "Map the 'firmware' key if it exists, or use a dynamic map".
    
    // Let's iterate over the keys (vendors) and then their values (devices).
    jsonMap.forEach((vendorKey, vendorValue) {
      if (vendorValue is Map<String, dynamic>) {
        vendorValue.forEach((deviceKey, deviceValue) {
           if (deviceValue is Map<String, dynamic>) {
             // We inject the vendor and name from the keys if they are missing in the value,
             // or just use the value's fields.
             // Actually, 'name' is usually inside the device object. 
             // 'vendor' might be the top key or inside.
             // Let's just try to parse the deviceValue as a TargetDefinition,
             // adding the vendor context if needed.
             
             // To match the requested fields:
             // vendor, name, product_code, firmware, config.
             
             // Construct the data map
             final data = Map<String, dynamic>.from(deviceValue);
             data['vendor'] ??= vendorKey;
             data['name'] ??= deviceKey; // Fallback name
             
             try {
                targets.add(TargetDefinition.fromJson(data));
             } catch (e) {
               print('Error parsing target $deviceKey: $e');
             }
           }
        });
      }
    });

    return targets;
  }
}
