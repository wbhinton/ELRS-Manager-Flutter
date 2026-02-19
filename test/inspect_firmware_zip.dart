import 'package:dio/dio.dart';
import 'package:archive/archive.dart';

void main() async {
  final dio = Dio();
  // Hash for 3.3.0 (from previous recon)
  const hash = 'ae9df3d202aa905358f0fdc1ca36718736ebdf38'; 
  final zipUrl = 'https://artifactory.expresslrs.org/ExpressLRS/$hash/firmware.zip';
  
  print('Downloading 3.3.0 zip from: $zipUrl');
  try {
    final response = await dio.get<List<int>>(
      zipUrl,
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: (count, total) {
        if (total > 0) {
           // print progress every 1MB? nah just wait.
        }
      }
    );
    
    final bytes = response.data!;
    print('Downloaded ${bytes.length} bytes. Extracting...');
    
    final archive = ZipDecoder().decodeBytes(bytes);
    print('Found ${archive.length} entries.');
    
    var binCount = 0;
    print('\n--- SAMPLE BINARY FILES ---');
    for (final file in archive) {
      if (file.isFile && file.name.endsWith('.bin')) {
        binCount++;
        if (binCount <= 20) {
          print(file.name);
        }
      }
    }
    print('...\nTotal .bin files: $binCount');
    
  } catch (e) {
    print('Error: $e');
  }
}
