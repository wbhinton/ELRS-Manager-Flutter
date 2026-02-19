
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
  static Uint8List assembleEspUnified({
    required Uint8List firmware,
    required String productName,
    required String luaName,
    required List<int> uid,
    required Map<String, dynamic> hardwareLayout,
    String wifiSsid = '',
    String wifiPassword = '',
    int? flashDiscriminator,
  }) {
    final builder = BytesBuilder();

    // 1. Trim Firmware
    // The input firmware for Unified targets (e.g. Generic targets from zip) 
    // ALREADY contains a default configuration block at the end.
    // We must overwrite this block (2704 bytes total).
    // Structure: Product(128) + Lua(16) + Options(512) + Layout(2048) = 2704.
    // So we keep everything BEFORE the last 2704 bytes.
    
    final configBlockSize = 128 + 16 + 512 + 2048; // 2704
    
    // Safety check
    if (firmware.length < configBlockSize) {
      // Should not happen for valid Unified binary, but fallback to raw if too small
      builder.add(firmware);
    } else {
      builder.add(firmware.sublist(0, firmware.length - configBlockSize));
    }

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

  /// Scans to find the end of the valid firmware data.
  /// 
  /// Tries to parse the ESP image header to find the exact end of segments.
  /// If the header is invalid (no 0xE9 magic), falls back to 0x00/0xFF trimming.
  static int _findFirmwareEnd(Uint8List firmware) {
    if (firmware.isEmpty) return 0;

    // Check for ESP Image Magic (0xE9)
    if (firmware[0] == 0xE9) {
      try {
        // Parse Header
        // Byte 1: Segment Count
        final segmentCount = firmware[1];
        
        // Header size is 24 bytes standard for ESP32/ESP8266
        // But let's be careful.
        // ESP32: 24 bytes.
        
        int offset = 24;
        
        for (int i = 0; i < segmentCount; i++) {
          if (offset + 8 > firmware.length) break; // Safety
          
          // Segment Header: [Address 4b] [Size 4b]
          // Size is at offset+4. Little Endian.
          final size = firmware[offset + 4] | 
                       (firmware[offset + 5] << 8) | 
                       (firmware[offset + 6] << 16) | 
                       (firmware[offset + 7] << 24);
          
          offset += 8 + size;
        }

        // 'offset' is now the end of the last segment.
        // However, there might be a hash appended? (SHA256 is 32 bytes)
        // Usually flashed binaries might have checksum/hash.
        // But the Config block we want to strip is definitely AFTER this.
        // Let's check 16-byte alignment?
        // ESP32 requires 16-byte alignment.
        while (offset % 16 != 0) {
           offset++;
        }
        
        // Safety check: if offset is way off, fallback?
        if (offset <= firmware.length) {
            return offset;
        }
      } catch (e) {
        // Parse error, fallback
        print('Warning: Failed to parse firmware segments: $e');
      }
    }

    // Fallback: Scan backwards skipping 0x00 and 0xFF
    int end = firmware.length;
    while (end > 0) {
      final byte = firmware[end - 1];
      if (byte != 0x00 && byte != 0xFF) {
        return end;
      }
      end--;
    }
    return firmware.length;
  }
}
