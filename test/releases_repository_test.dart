import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:dio/dio.dart';
import 'package:elrs_manager/src/features/flashing/data/releases_repository.dart';

void main() {
  late Dio dio;
  late DioAdapter dioAdapter;
  late ReleasesRepository repository;

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    repository = ReleasesRepository(dio);
  });

  test('Repository fetches and filters versions correctly', () async {
    const route = 'https://api.github.com/repos/ExpressLRS/ExpressLRS/releases';
    
    final mockData = [
      {'tag_name': 'v3.3.0'},
      {'tag_name': '3.0.0'}, // Sometimes tags might lack 'v'
      {'tag_name': 'v2.5.1'},
      {'tag_name': 'v1.0.0'},
    ];

    dioAdapter.onGet(
      route,
      (server) => server.reply(200, mockData),
    );

    final versions = await repository.fetchVersions();

    // Should contain v3.3.0 and 3.0.0
    // Should NOT contain v2.5.1 or v1.0.0
    expect(versions, hasLength(2));
    expect(versions, containsAll(['v3.3.0', '3.0.0']));
    expect(versions, isNot(contains('v2.5.1')));
  });

  test('Repository handles API error', () async {
     const route = 'https://api.github.com/repos/ExpressLRS/ExpressLRS/releases';
     
     dioAdapter.onGet(
      route,
      (server) => server.reply(500, {'message': 'Server Error'}),
    );
    
    expect(() => repository.fetchVersions(), throwsException);
  });
}
