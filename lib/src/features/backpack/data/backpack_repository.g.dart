// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backpack_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(backpackRepository)
final backpackRepositoryProvider = BackpackRepositoryProvider._();

final class BackpackRepositoryProvider
    extends
        $FunctionalProvider<
          BackpackRepository,
          BackpackRepository,
          BackpackRepository
        >
    with $Provider<BackpackRepository> {
  BackpackRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backpackRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backpackRepositoryHash();

  @$internal
  @override
  $ProviderElement<BackpackRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackpackRepository create(Ref ref) {
    return backpackRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackpackRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackpackRepository>(value),
    );
  }
}

String _$backpackRepositoryHash() =>
    r'1b8c7ef7ec37a8e20d573eed17d6b8e0043728dd';
