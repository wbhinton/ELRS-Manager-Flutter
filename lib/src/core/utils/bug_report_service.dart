import 'dart:collection';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:github_snitch/github_snitch.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';

class BugReportService {
  static final BugReportService instance = BugReportService._internal();
  BugReportService._internal();

  final _logBuffer = Queue<String>();
  static const int _maxLogLines = 200;

  void init() {
    // 1. Initialize GitHub Snitch with PAT from environment
    const String githubToken = String.fromEnvironment('GITHUB_TOKEN');
    if (githubToken.isNotEmpty) {
      // GhSnitch uses static methods for initialization in 0.0.18
      GhSnitch.initialize(
        token: githubToken,
        owner: 'wbhinton', 
        repo: 'ELRS-Flutter', // Fixed: was repository
      );
    }

    // 2. Set up logging listener
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      final logLine = '${record.time}: ${record.level.name}: ${record.loggerName}: ${record.message}';
      _logBuffer.addLast(logLine);
      if (_logBuffer.length > _maxLogLines) {
        _logBuffer.removeFirst();
      }
    });
  }

  Future<bool> submitReport(String title, String description) async {
    try {
      final metadata = await _collectMetadata();
      final logs = _logBuffer.toList().reversed.join('\n'); 

      final body = '''
### Description
$description

### System Metadata
$metadata

### Recent Logs (Last $_maxLogLines lines)
```
$logs
```
''';

      // GhSnitch uses static report method
      return await GhSnitch.report(
        title: title,
        body: body,
        labels: ['bug', 'user-report'],
      );
    } catch (e) {
      Logger.root.severe('Failed to submit bug report: $e');
      return false;
    }
  }

  Future<String> _collectMetadata() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String systemInfo = '';

    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      systemInfo = 'Model: ${androidInfo.model}, Brand: ${androidInfo.brand}, Android Version: ${androidInfo.version.release}, SDK: ${androidInfo.version.sdkInt}';
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      systemInfo = 'Model: ${iosInfo.utsname.machine}, System Name: ${iosInfo.systemName}, System Version: ${iosInfo.systemVersion}';
    } else {
      systemInfo = 'Platform: ${Platform.operatingSystem}, Version: ${Platform.operatingSystemVersion}';
    }

    return '''
App Version: ${packageInfo.version} (${packageInfo.buildNumber})
$systemInfo
''';
  }
}
