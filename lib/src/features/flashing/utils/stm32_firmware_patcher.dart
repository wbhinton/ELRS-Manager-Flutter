
import 'dart:typed_data';

class Stm32FirmwarePatcher {
  static const _magicHeader = [0xBE, 0xEF, 0xBA, 0xBE, 0xCA, 0xFE, 0xF0, 0x0D];

  /// Patches the STM32 firmware with the provided UID and Regulatory Domain.
  /// 
  /// Locates the magic header and writes configuration data at the correct offset.
  /// Returns a NEW Uint8List to avoid mutating the original reference if it's shared.
  static Uint8List patchStm32({
    required Uint8List firmware,
    required List<int> uid,
    int domain = 0,
  }) {
    if (uid.length != 6) {
      throw ArgumentError('UID must be exactly 6 bytes.');
    }

    // Copy firmware to a new list to modify
    final patched = Uint8List.fromList(firmware);
    final view = ByteData.view(patched.buffer);

    final offset = _findMagicHeader(patched);
    if (offset == -1) {
      throw Exception('Magic header not found in firmware.');
    }

    // Read version (uint16) at BaseOffset + 0
    final version = view.getUint16(offset, Endian.little);
    
    int writeOffset;
    if (version == 0) {
      writeOffset = offset + 3;
    } else {
      writeOffset = offset + 2;
    }

    // Ensure we have enough space
    if (writeOffset + 2 + 6 > patched.length) {
      throw Exception('Firmware too short for patching.');
    }

    // Write Domain (uint8)
    view.setUint8(writeOffset + 0, domain);

    // Write UID Flag (uint8) = 1
    view.setUint8(writeOffset + 1, 1);

    // Write UID (6 bytes)
    for (int i = 0; i < 6; i++) {
      view.setUint8(writeOffset + 2 + i, uid[i]);
    }

    return patched;
  }

  /// Searches for the magic header sequence.
  /// Returns the index immediately following the magic header (BaseOffset).
  static int _findMagicHeader(Uint8List firmware) {
    for (int i = 0; i <= firmware.length - _magicHeader.length; i++) {
        bool match = true;
        for (int j = 0; j < _magicHeader.length; j++) {
            if (firmware[i + j] != _magicHeader[j]) {
                match = false;
                break;
            }
        }
        if (match) {
            return i + _magicHeader.length;
        }
    }
    return -1;
  }
}
