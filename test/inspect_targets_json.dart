import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  const url = 'https://raw.githubusercontent.com/ExpressLRS/targets/master/targets.json';
  
  print('Fetching targets from: $url');
  try {
    final response = await dio.get(url);
    final data = response.data;
    
    if (data is Map<String, dynamic>) {
       print('Top Level Keys (First 10):');
       print(data.keys.take(10).toList());
       
       final firstKey = data.keys.first;
       print('\nSample Value for "$firstKey":');
       final val = data[firstKey];
       if (val is Map<String, dynamic>) {
          print('  Keys: ${val.keys.take(5).toList()}');
          
          final subKey = val.keys.first;
          print('  Sub-value for "$subKey":');
          print(val[subKey]); // Print EVERYTHING
       } else {
          print('  Value: $val');
       }
    } else if (data is List) {
       print('Top Level is List of length ${data.length}');
       if (data.isNotEmpty) {
         print('Sample Item 0: ${data[0]}');
       }
    } else {
       print('Unknown type: ${data.runtimeType}');
       print(data.toString().substring(0, 500));
    }
    
  } catch (e) {
    print('Error: $e');
  }
}
