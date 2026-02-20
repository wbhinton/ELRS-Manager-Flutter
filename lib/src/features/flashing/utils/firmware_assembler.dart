
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class FirmwareAssembler {
  /// Generates the unique user ID (UID) from a binding phrase.
  /// 
  /// Logic:
  /// 1. Prefix with `-DMY_BINDING_PHRASE="`
  /// 2. MD5 hash the result
  /// 3. Take first 6 bytes
  static List<int> generateUid(String phrase) {
    if (phrase.isEmpty) return [0, 0, 0, 0, 0, 0];

    // Construct the exact compiler literal string: '-DMY_BINDING_PHRASE="$phrase"'
    final input = '-DMY_BINDING_PHRASE="$phrase"';
    final bytes = utf8.encode(input);
    final digest = md5.convert(bytes);
    
    // Extract the first 6 bytes
    return digest.bytes.sublist(0, 6);
  }

  /// Assembles the EspUnified Firmware binary.
  ///
  /// Structure:
  /// [Trimmed Firmware]
  /// [Product Name (128 bytes)]
  /// [Lua Name (16 bytes)]
  /// [Options JSON (512 bytes)]
  /// [Hardware Layout JSON (2048 bytes)]
  /// Assembles the EspUnified Firmware binary.
  ///
  /// Structure:
  /// [Trimmed Firmware]
  /// [Product Name (128 bytes)]
  /// [Lua Name (16 bytes)]
  /// [Options JSON (512 bytes)]
  /// [Hardware Layout JSON (2048 bytes)]
  static Uint8List assembleEspUnified({
    required Uint8List firmware,
    required String productName,
    required String luaName,
    required List<int> uid,
    required Map<String, dynamic> hardwareLayout,
    required String platform,
    String wifiSsid = '',
    String wifiPassword = '',
    int? flashDiscriminator,
  }) {
    final builder = BytesBuilder();

    // 1. Trim Firmware
    final end = findFirmwareEnd(firmware, platform);
    final trimmedFirmware = firmware.sublist(0, end);
    builder.add(trimmedFirmware);

    // 2. Product Name (128 bytes)
    builder.add(_paddedString(productName, 128));

    // 3. Lua Name (16 bytes)
    builder.add(_paddedString(luaName, 16));

    // 4. Options JSON (512 bytes)
    // Deterministic Options: Build from scratch based on Web Flasher forensics.
    final Map<String, dynamic> finalOptions = {
      'flash-discriminator': flashDiscriminator ?? (DateTime.now().millisecondsSinceEpoch & 0xFFFFFF),
      'uid': uid,
      'wifi-on-interval': 60,
      'rcvr-uart-baud': 420000,
      'lock-on-first-connection': true,
    };

    if (wifiSsid.isNotEmpty) {
      finalOptions['wifi-ssid'] = wifiSsid;
      finalOptions['wifi-password'] = wifiPassword;
    }

    if (platform.startsWith('esp32')) {
      finalOptions['customised'] = true;
    }

    final optionsJson = jsonEncode(finalOptions);
    builder.add(_paddedString(optionsJson, 512));

    // 5. Hardware Layout JSON (2048 bytes)
    final layoutJson = jsonEncode(hardwareLayout);
    builder.add(_paddedString(layoutJson, 2048));

    return builder.toBytes();
  }

  /// Pads (or truncates) string to exact byte length.
  static Uint8List _paddedString(String text, int length) {
    final bytes = utf8.encode(text);
    if (bytes.length > length) {
      // Truncate
      return Uint8List.fromList(bytes.sublist(0, length));
    }
    
    // Pad with 0x00
    final padded = Uint8List(length);
    padded.setRange(0, bytes.length, bytes);
    return padded;
  }

  /// Scans to find the end of the valid firmware data based on the platform.
  static int findFirmwareEnd(Uint8List firmware, String platform) {
    if (platform == 'esp8285') {
      // For esp8285, Header at 0x1000, Magic check 0xE9
      if (firmware.length < 0x1008 || firmware[0x1000] != 0xE9) return firmware.length;
      final segmentCount = firmware[0x1001];
      int pos = 0x1008;
      for (int i = 0; i < segmentCount; i++) {
        if (pos + 8 > firmware.length) break;
        final size = firmware[pos + 4] | (firmware[pos + 5] << 8) | (firmware[pos + 6] << 16) | (firmware[pos + 7] << 24);
        pos += 8 + size;
      }
      return (pos + 15) & ~15;
    } else if (platform.startsWith('esp32')) {
      // For esp32, Header at 0x0, Magic check 0xE9
      if (firmware.isEmpty || firmware[0] != 0xE9 || firmware.length < 24) return firmware.length;
      final segmentCount = firmware[1];
      int pos = 24;
      for (int i = 0; i < segmentCount; i++) {
        if (pos + 8 > firmware.length) break;
        final size = firmware[pos + 4] | (firmware[pos + 5] << 8) | (firmware[pos + 6] << 16) | (firmware[pos + 7] << 24);
        pos += 8 + size;
      }
      int end = (pos + 15) & ~15;
      // Add exactly +32 bytes
      final finalEnd = end + 32;
      return finalEnd > firmware.length ? firmware.length : finalEnd;
    }
    return firmware.length;
  }
}