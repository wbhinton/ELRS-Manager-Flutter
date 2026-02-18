// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firmware_patcher.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firmwarePatcher)
final firmwarePatcherProvider = FirmwarePatcherProvider._();

final class FirmwarePatcherProvider
    extends
        $FunctionalProvider<FirmwarePatcher, FirmwarePatcher, FirmwarePatcher>
    with $Provider<FirmwarePatcher> {
  FirmwarePatcherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firmwarePatcherProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firmwarePatcherHash();

  @$internal
  @override
  $ProviderElement<FirmwarePatcher> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirmwarePatcher create(Ref ref) {
    return firmwarePatcher(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirmwarePatcher value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirmwarePatcher>(value),
    );
  }
}

String _$firmwarePatcherHash() => r'd49b85fac9da21e3ac3643418689fc727aab96b1';
