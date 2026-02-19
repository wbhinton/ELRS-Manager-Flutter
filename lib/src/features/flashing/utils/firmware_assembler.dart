
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
    // We must find the end of the valid firmware data based on the architecture.
    int firmwareEnd;
    if (platform == 'esp8285') {
      firmwareEnd = _findEndEsp8285(firmware);
    } else if (platform.startsWith('esp32')) {
      firmwareEnd = _findEndEsp32(firmware);
      print('ESP32 FINAL TRIM: Original: ${firmware.length}, New: $firmwareEnd, Delta: ${firmware.length - firmwareEnd} bytes removed.');
    } else {
      // Fallback: previous logic or assume 2704 bytes config block at end if it's already a unified binary
      final configBlockSize = 128 + 16 + 512 + 2048; // 2704
      firmwareEnd = firmware.length > configBlockSize ? firmware.length - configBlockSize : firmware.length;
    }
    
    final trimmedFirmware = firmware.sublist(0, firmwareEnd);
    builder.add(trimmedFirmware);

    // 2. Product Name (128 bytes)
    builder.add(_paddedString(productName, 128));

    // 3. Lua Name (16 bytes)
    builder.add(_paddedString(luaName, 16));

    // 4. Options JSON (512 bytes)
    // To match the official Web Flasher byte-perfectly, we must:
    // 1. Parse existing options from the base firmware (to get baud rate, etc.)
    // 2. Construct a NEW map with specific key order.
    // 3. Exclude 'domain', 'flash-dry', 'is-unified'.
    
    Map<String, dynamic> existingOptions = {};
    
    // Attempt to parse options from the ORIGINAL firmware if it has a config block
    const configBlockSize = 128 + 16 + 512 + 2048;
    if (firmware.length >= configBlockSize) {
       try {
         final optionsOffset = firmware.length - 2048 - 512;
         final existingOptionsBytes = firmware.sublist(optionsOffset, optionsOffset + 512);
         final nullIndex = existingOptionsBytes.indexOf(0);
         final existingOptionsStr = utf8.decode(
           existingOptionsBytes.sublist(0, nullIndex != -1 ? nullIndex : 512),
           allowMalformed: true
         );
         
         if (existingOptionsStr.trim().isNotEmpty && existingOptionsStr.startsWith('{')) {
            existingOptions = jsonDecode(existingOptionsStr) as Map<String, dynamic>;
         }
       } catch (e) {
         // Ignore
       }
    }

    // Construct Final Map in strict order for Golden Binary match
    final Map<String, dynamic> finalOptions = {};

    // 1. flash-discriminator
    finalOptions['flash-discriminator'] = flashDiscriminator ?? 
        existingOptions['flash-discriminator'] ?? 
        (DateTime.now().millisecondsSinceEpoch & 0xFFFFFF);

    // 2. uid
    finalOptions['uid'] = uid;

    // 3. wifi-on-interval
    finalOptions['wifi-on-interval'] = existingOptions.containsKey('wifi-on-interval') 
        ? existingOptions['wifi-on-interval'] 
        : 60;

    // 4. wifi-ssid
    if (wifiSsid.isNotEmpty) {
      finalOptions['wifi-ssid'] = wifiSsid;
    } else if (existingOptions.containsKey('wifi-ssid')) {
      finalOptions['wifi-ssid'] = existingOptions['wifi-ssid'];
    }

    // 5. wifi-password
    if (wifiSsid.isNotEmpty) { // Only set password if ssid is set (or if we are preserving)
       finalOptions['wifi-password'] = wifiPassword;
    } else if (existingOptions.containsKey('wifi-password')) {
       finalOptions['wifi-password'] = existingOptions['wifi-password'];
    }

    // 6. rcvr-uart-baud
    if (existingOptions.containsKey('rcvr-uart-baud')) {
      finalOptions['rcvr-uart-baud'] = existingOptions['rcvr-uart-baud'];
    } else {
      finalOptions['rcvr-uart-baud'] = 420000;
    }

    // 7. lock-on-first-connection
    if (existingOptions.containsKey('lock-on-first-connection')) {
      finalOptions['lock-on-first-connection'] = existingOptions['lock-on-first-connection'];
    } else {
      finalOptions['lock-on-first-connection'] = true;
    }

    // 8. Removed 'is-unified' per forensics analysis of Golden Binary.

    // Preserve other keys (excluding our specific ones and the ones explicitly requested to be removed)
    final excludedKeys = const {
      'flash-discriminator', 'uid', 'wifi-on-interval', 'wifi-ssid', 'wifi-password',
      'rcvr-uart-baud', 'lock-on-first-connection',
      'domain', 'flash-dry', 'is-unified'
    };

    for (final key in existingOptions.keys) {
      if (!excludedKeys.contains(key)) {
        finalOptions[key] = existingOptions[key];
      }
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

  /// Scans to find the end of the valid firmware data for ESP8285.
  static int _findEndEsp8285(Uint8List binary) {
    if (binary.length < 0x1000) return binary.length;
    
    int pos = 0x1000;
    // Check for Magic Byte 0xE9
    while (pos < binary.length) {
      if (binary[pos] == 0xE9) {
        break;
      }
      pos = (pos + 16) & ~15;
    }
    
    if (pos >= binary.length) return binary.length;
    
    final segmentCount = binary[pos + 1];
    pos += 8;
    
    for (int i = 0; i < segmentCount; i++) {
      if (pos + 8 > binary.length) break;
      final size = binary[pos + 4] | 
                   (binary[pos + 5] << 8) | 
                   (binary[pos + 6] << 16) | 
                   (binary[pos + 7] << 24);
      pos += 8 + size;
    }
    
    return (pos + 16) & ~15;
  }

 /// Scans to find the end of the valid firmware data for ESP32.
  static int _findEndEsp32(Uint8List binary) {
    if (binary.length < 24) return binary.length;

    // Official ELRS configure.js logic for ESP32
    // Header starts at 0. 
    final segmentCount = binary[1];
    
    // Sanity check: ESP32 usually has 1-16 segments. 
    if (segmentCount == 0 || segmentCount > 32) return binary.length;

    int pos = 24; // Start of segments

    for (int i = 0; i < segmentCount; i++) {
      if (pos + 8 > binary.length) return binary.length;

      // Read 32-bit size (Little Endian)
      final size = binary[pos + 4] |
                   (binary[pos + 5] << 8) |
                   (binary[pos + 6] << 16) |
                   (binary[pos + 7] << 24);

      // SANITY CHECK: If size is impossible, return original length
      if (size > binary.length || size < 0 || pos + 8 + size > binary.length) {
        return binary.length;
      }

      pos += 8 + size; // Header (8) + Data (size)
    }

    // Official Alignment logic: 
    // 1. Align to 16 bytes
    // 2. Add 32 bytes 
    int finalPos = (pos + 15) & ~15;
    finalPos += 32;

    // Safety: Never return an offset larger than the actual file
    return finalPos > binary.length ? binary.length : finalPos;
  }
}