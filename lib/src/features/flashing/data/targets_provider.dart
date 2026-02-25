import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/target_definition.dart';
import 'targets_repository.dart';
import '../../../core/storage/firmware_cache_service.dart';

part 'targets_provider.g.dart';

@riverpod
TargetsRepository targetsRepository(Ref ref) {
  final cacheService = ref.watch(firmwareCacheServiceProvider);
  return TargetsRepository(Dio(), cacheService);
}

@riverpod
Future<List<TargetDefinition>> targets(Ref ref) async {
  final repository = ref.watch(targetsRepositoryProvider);
  return repository.fetchTargets();
}
