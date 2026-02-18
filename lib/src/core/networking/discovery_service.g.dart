// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discovery_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(discoveryService)
final discoveryServiceProvider = DiscoveryServiceProvider._();

final class DiscoveryServiceProvider
    extends
        $FunctionalProvider<
          DiscoveryService,
          DiscoveryService,
          DiscoveryService
        >
    with $Provider<DiscoveryService> {
  DiscoveryServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoveryServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoveryServiceHash();

  @$internal
  @override
  $ProviderElement<DiscoveryService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DiscoveryService create(Ref ref) {
    return discoveryService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DiscoveryService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DiscoveryService>(value),
    );
  }
}

String _$discoveryServiceHash() => r'cc7a0330a7ed7ae698a3c87dc3f691903d2a1a52';
