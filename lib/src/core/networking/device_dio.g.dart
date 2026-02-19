// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_dio.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceDio)
final deviceDioProvider = DeviceDioProvider._();

final class DeviceDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  DeviceDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceDioProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return deviceDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$deviceDioHash() => r'0c1e519322abcb64219483722d439c41afaeadb4';
