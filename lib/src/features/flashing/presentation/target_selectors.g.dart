// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_selectors.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(uniqueVendors)
final uniqueVendorsProvider = UniqueVendorsProvider._();

final class UniqueVendorsProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  UniqueVendorsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'uniqueVendorsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$uniqueVendorsHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return uniqueVendors(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$uniqueVendorsHash() => r'21b470381c26c27689bc4346150eb828e0d405ea';

@ProviderFor(devicesForVendor)
final devicesForVendorProvider = DevicesForVendorProvider._();

final class DevicesForVendorProvider
    extends
        $FunctionalProvider<
          List<TargetDefinition>,
          List<TargetDefinition>,
          List<TargetDefinition>
        >
    with $Provider<List<TargetDefinition>> {
  DevicesForVendorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'devicesForVendorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$devicesForVendorHash();

  @$internal
  @override
  $ProviderElement<List<TargetDefinition>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TargetDefinition> create(Ref ref) {
    return devicesForVendor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TargetDefinition> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TargetDefinition>>(value),
    );
  }
}

String _$devicesForVendorHash() => r'b9037c1f77873518ae6c74ff5363134fdaff84a4';
