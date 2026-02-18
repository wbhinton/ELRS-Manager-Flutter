// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'targets_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(targetsRepository)
final targetsRepositoryProvider = TargetsRepositoryProvider._();

final class TargetsRepositoryProvider
    extends
        $FunctionalProvider<
          TargetsRepository,
          TargetsRepository,
          TargetsRepository
        >
    with $Provider<TargetsRepository> {
  TargetsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'targetsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$targetsRepositoryHash();

  @$internal
  @override
  $ProviderElement<TargetsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TargetsRepository create(Ref ref) {
    return targetsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TargetsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TargetsRepository>(value),
    );
  }
}

String _$targetsRepositoryHash() => r'3e4717c0c076de279f84dd61befcc4e330dc5d98';

@ProviderFor(targets)
final targetsProvider = TargetsProvider._();

final class TargetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TargetDefinition>>,
          List<TargetDefinition>,
          FutureOr<List<TargetDefinition>>
        >
    with
        $FutureModifier<List<TargetDefinition>>,
        $FutureProvider<List<TargetDefinition>> {
  TargetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'targetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$targetsHash();

  @$internal
  @override
  $FutureProviderElement<List<TargetDefinition>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TargetDefinition>> create(Ref ref) {
    return targets(ref);
  }
}

String _$targetsHash() => r'c36e215c2ed766343a7d1682137fa9c94d542418';
