import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/target_definition.dart';
import 'targets_repository.dart';

part 'targets_provider.g.dart';

@riverpod
TargetsRepository targetsRepository(Ref ref) {
  return TargetsRepository(Dio());
}

@riverpod
Future<List<TargetDefinition>> targets(Ref ref) async {
  final repository = ref.watch(targetsRepositoryProvider);
  return repository.fetchTargets();
}
