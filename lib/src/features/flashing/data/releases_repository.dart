import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'releases_repository.g.dart';

class ReleasesRepository {
  final Dio _dio;

  ReleasesRepository(this._dio);

  Future<List<String>> fetchVersions() async {
    try {
      final response = await _dio.get('https://api.github.com/repos/ExpressLRS/ExpressLRS/releases');
      final List<dynamic> data = response.data as List<dynamic>;
      
      return data
          .map((e) => e['tag_name'] as String)
          .where((tag) {
            // Simple filtering for 3.x.x versions
            // Remove 'v' prefix if present for parsing, though usually tags are "3.3.0" or "v3.3.0"
            // ELRS tags are usually just "3.x.x" or "v3.x.x"
            // We want >= 3.0.0
            final cleanTag = tag.startsWith('v') ? tag.substring(1) : tag;
            return cleanTag.startsWith('3.');
          })
          .toList();
    } catch (e) {
      // Return a fallback list or rethrow. For now, empty list or throw.
      // Re-throwing allows the UI to show error state.
       throw Exception('Failed to fetch releases: $e');
    }
  }
}

@riverpod
ReleasesRepository releasesRepository(Ref ref) {
  return ReleasesRepository(Dio());
}

@riverpod
Future<List<String>> releases(Ref ref) async {
  final repo = ref.watch(releasesRepositoryProvider);
  return repo.fetchVersions();
}
