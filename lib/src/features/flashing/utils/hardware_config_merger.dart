
class HardwareConfigMerger {
  /// Merges the overlay configuration into the base hardware layout.
  /// 
  /// The [overlay] values overwrite the [baseLayout] values.
  /// Returns a new map with the merged configuration.
  static Map<String, dynamic> mergeOverlay(
    Map<String, dynamic> baseLayout, 
    Map<String, dynamic>? overlay,
  ) {
    if (overlay == null || overlay.isEmpty) {
      return Map<String, dynamic>.from(baseLayout);
    }

    final merged = Map<String, dynamic>.from(baseLayout);
    
    for (final entry in overlay.entries) {
      merged[entry.key] = entry.value;
    }

    return merged;
  }
}
