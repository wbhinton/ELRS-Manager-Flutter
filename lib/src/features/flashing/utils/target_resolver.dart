import 'dart:convert';
import 'package:archive/archive.dart';

class TargetResolver {
  /// Merges the overlay configuration into the base hardware layout.
  ///
  /// The [overlay] values overwrite the [base] values.
  /// Returns a new map with the merged configuration.
  static Map<String, dynamic> applyOverlay(
    Map<String, dynamic> base,
    Map<String, dynamic>? overlay,
  ) {
    if (overlay == null || overlay.isEmpty) {
      return Map<String, dynamic>.from(base);
    }

    final merged = Map<String, dynamic>.from(base);

    for (final entry in overlay.entries) {
      merged[entry.key] = entry.value;
    }

    return merged;
  }

  /// resolving the final hardware layout by extracting the base layout from
  /// the hardware zip and applying any overlays from the target config.
  ///
  /// [targetConfig] must contain 'layout_file'.
  /// [hardwareZip] is the Archive object of the hardware.zip.
  static Map<String, dynamic> resolveLayout(
    Map<String, dynamic> targetConfig,
    Archive hardwareZip,
  ) {
    // 1. Get layout filename
    final layoutFile = targetConfig['layout_file'] as String?;
    if (layoutFile == null) {
      throw Exception('Target config parsing error: layout_file is missing.');
    }

    // 2. Determine Search Paths
    // Heuristic: Check if firmware string contains RX or TX to determine folder
    // Default to searching in root or specific folders if not found.
    // The zip structure has 'RX/' and 'TX/' folders.

    final firmwareStr = (targetConfig['firmware'] as String? ?? '')
        .toUpperCase();
    String? folder;
    if (firmwareStr.contains('RX')) {
      folder = 'RX';
    } else if (firmwareStr.contains('TX')) {
      folder = 'TX';
    }

    // Primary Attempt: Folder + Filename
    ArchiveFile? file;
    if (folder != null) {
      final path = '$folder/$layoutFile';
      file = hardwareZip.findFile(path);
    }

    // Secondary Attempt: Just the filename (if not found in folder or folder unknown)
    file ??= hardwareZip.findFile(layoutFile);

    // Fallback: Scan all files for matching basename
    if (file == null) {
      final basename = layoutFile.split('/').last;
      try {
        file = hardwareZip.files.firstWhere(
          (f) => f.name.endsWith('/$basename') || f.name == basename,
        );
      } catch (e) {
        // Not found
        file = null;
      }
    }

    if (file == null) {
      throw Exception(
        'Could not find layout "$layoutFile" in hardware archive (checked RX/, TX/, and full scan).',
      );
    }

    final content = String.fromCharCodes(file.content as List<int>);
    final baseLayout = jsonDecode(content) as Map<String, dynamic>;

    // 2. Extract Overlay
    final overlay = targetConfig['overlay'] as Map<String, dynamic>?;

    // 3. Merge
    return applyOverlay(baseLayout, overlay);
  }
}
