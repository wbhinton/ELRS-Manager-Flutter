import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  final url = 'https://raw.githubusercontent.com/ExpressLRS/ExpressLRS-targets/master/targets.json'; // Or 'targets/targets.json'? Need correct path.
  // Actually, let's just try to list the repo contents via API to find targets.json if this fails.
  // But raw content is easier if the path is right.
  // The repo is ExpressLRS/targets? Or ExpressLRS/ExpressLRS-targets?
  // Search results said `ExpressLRS/targets`. Let's allow for 404 and try both.

  final urlsToCheck = [
    'https://raw.githubusercontent.com/ExpressLRS/targets/master/targets.json',
    'https://raw.githubusercontent.com/ExpressLRS/ExpressLRS-targets/master/targets.json',
  ];

  for (final u in urlsToCheck) {
    print('\nFetching targets from: $u');
    try {
      final response = await dio.get(u);
      print('Status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = response.data; // This might be a Map or List
        print('Data type: ${data.runtimeType}');
        // If it's a map, print keys.
        // Look for "firmware" or "url" string in the content?
        final content = data.toString();
        if (content.contains('http') && content.contains('.bin')) {
           print('FOUND BINARY URLs!');
           // Print a snippet
           print(content.substring(0, 200)); 
           // If small, print more
        } else {
           print('No obvious binary URLs found in json.');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
