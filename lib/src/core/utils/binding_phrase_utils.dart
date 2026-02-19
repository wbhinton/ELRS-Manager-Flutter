import 'dart:convert';
import 'package:crypto/crypto.dart';

class BindingPhraseUtils {
  /// Generates the unique user ID (UID) from a binding phrase.
  /// 
  /// Logic based on ELRS `src/js/phrase.js`:
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
}
