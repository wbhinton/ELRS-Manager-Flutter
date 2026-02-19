
import 'dart:convert';
import 'dart:typed_data';

class UnifiedFirmwareBuilder {
  /// Builds the Unified Firmware binary by appending configuration data.
  ///
  /// Structure:
  /// [Trimmed Firmware]
  /// [Product Name (128 bytes)]
  /// [Lua Name (16 bytes)]
  /// [Options JSON (512 bytes)]
  /// [Hardware Layout JSON (2048 bytes)]
  static Uint8List build({
    required Uint8List firmware,
    required String productName,
    required String luaName,
    required List<int> uid,
    required Map<String, dynamic> hardwareLayout,
    String wifiSsid = '',
    String wifiPassword = '',
  }) {
    final builder = BytesBuilder();

    // 1. Trim Firmware
    final end = _findFirmwareEnd(firmware);
    builder.add(firmware.sublist(0, end));

    // 2. Product Name (128 bytes)
    builder.add(_paddedString(productName, 128));

    // 3. Lua Name (16 bytes)
    builder.add(_paddedString(luaName, 16));

    // 4. Options JSON (512 bytes)
    // "uid" must be a JSON array of integers.
    final options = <String, dynamic>{
      'uid': uid,
    };
    
    if (wifiSsid.isNotEmpty) {
      options['wifi-ssid'] = wifiSsid;
      options['wifi-password'] = wifiPassword;
    }

    // Ensure we encode it as simple JSON string
    final optionsJson = jsonEncode(options);
    builder.add(_paddedString(optionsJson, 512));

    // 5. Hardware Layout JSON (2048 bytes)
    final layoutJson = jsonEncode(hardwareLayout);
    builder.add(_paddedString(layoutJson, 2048));

    return builder.toBytes();
  }

  /// Pads (or truncates) string to exact byte length.
  /// Validates that text is ASCII/UTF-8 compatible.
  static Uint8List _paddedString(String text, int length) {
    final bytes = utf8.encode(text);
    if (bytes.length > length) {
      // Truncate
      return Uint8List.fromList(bytes.sublist(0, length));
    }
    
    // Pad with 0x00
    final padded = Uint8List(length);
    padded.setRange(0, bytes.length, bytes);
    // Remaining bytes are already 0 initialized in Uint8List
    return padded;
  }

  /// Scans backwards to find the end of data (skipping 0x00 and 0xFF padding).
  static int _findFirmwareEnd(Uint8List firmware) {
    int end = firmware.length;
    while (end > 0) {
      final byte = firmware[end - 1];
      if (byte != 0x00 && byte != 0xFF) {
        return end;
      }
      end--;
    }
    return firmware.length; // Fallback if all empty? Or 0?
  }
}
