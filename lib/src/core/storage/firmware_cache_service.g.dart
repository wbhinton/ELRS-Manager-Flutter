// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firmware_cache_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firmwareCacheService)
final firmwareCacheServiceProvider = FirmwareCacheServiceProvider._();

final class FirmwareCacheServiceProvider
    extends
        $FunctionalProvider<
          FirmwareCacheService,
          FirmwareCacheService,
          FirmwareCacheService
        >
    with $Provider<FirmwareCacheService> {
  FirmwareCacheServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firmwareCacheServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firmwareCacheServiceHash();

  @$internal
  @override
  $ProviderElement<FirmwareCacheService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirmwareCacheService create(Ref ref) {
    return firmwareCacheService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirmwareCacheService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirmwareCacheService>(value),
    );
  }
}

String _$firmwareCacheServiceHash() =>
    r'946864c40e5ecd2599756584ca7c5c92c879bd96';
