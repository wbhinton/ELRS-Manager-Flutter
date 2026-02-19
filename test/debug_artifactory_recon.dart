import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  
  // 1. Fetch Index
  print('Fetching Artifactory Index...');
  try {
    final indexResponse = await dio.get('https://artifactory.expresslrs.org/ExpressLRS/index.json');
    final tags = indexResponse.data['tags'] as Map<String, dynamic>;
    
    print('Found ${tags.length} entries.');
    // Print first 3
    var count = 0;
    for (final entry in tags.entries) {
      if (count < 3) {
        print('Tag: ${entry.key}, Hash: ${entry.value}');
        count++;
      }
    }

    // 2. Pick a Version
    const targetVersion = '3.3.0';
    if (tags.containsKey(targetVersion)) {
      final hash = tags[targetVersion];
      print('\nTarget Version: $targetVersion');
      print('Hash: $hash');

      // 3. Check Zip Size (HEAD Request)
      final zipUrl = 'https://artifactory.expresslrs.org/ExpressLRS/$hash/firmware.zip';
      print('\nChecking Zip Size: $zipUrl');
      try {
        final headResponse = await dio.head(zipUrl);
        final contentLength = int.tryParse(headResponse.headers.value('content-length') ?? '0') ?? 0;
        final sizeMB = contentLength / (1024 * 1024);
        print('Content-Length: $contentLength bytes (${sizeMB.toStringAsFixed(2)} MB)');
      } catch (e) {
        print('HEAD request failed for Zip: $e');
      }

      // 4. Check "Web Flasher Mirror" (The Shortcut)
      // Note: The URL pattern provided by user seems to imply a structure.
      // https://expresslrs.github.io/web-flasher/assets/firmware/{version}/FCC/Generic_ESP8285_SX1280_RX/firmware.bin
      // We might need to guess the device path if it's strictly folder based.
      // Let's try a known device path if possible, or just the base if directory listing is allowed (likely not on github pages).
      // The user provided specific example: FCC/Generic_ESP8285_SX1280_RX/firmware.bin
      final mirrorUrl = 'https://expresslrs.github.io/web-flasher/assets/firmware/$targetVersion/FCC/Generic_ESP8285_SX1280_RX/firmware.bin';
      print('\nChecking Mirror Link: $mirrorUrl');
      try {
        final mirrorResponse = await dio.head(mirrorUrl);
        print('Direct Mirror Link Status: ${mirrorResponse.statusCode}');
      } catch (e) {
        print('Mirror check failed: $e');
        if (e is DioException) {
           print('Status Code: ${e.response?.statusCode}');
        }
      }

    } else {
      print('Version $targetVersion not found in index.');
    }

  } catch (e) {
    print('Error fetching index: $e');
  }
}
