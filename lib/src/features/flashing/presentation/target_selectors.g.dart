// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_selectors.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(availableDeviceTypes)
final availableDeviceTypesProvider = AvailableDeviceTypesProvider._();

final class AvailableDeviceTypesProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  AvailableDeviceTypesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableDeviceTypesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableDeviceTypesHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return availableDeviceTypes(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$availableDeviceTypesHash() =>
    r'5bd93a6cda77b8f9b62a5ec453f9409bc3e37332';

@ProviderFor(availableVendors)
final availableVendorsProvider = AvailableVendorsProvider._();

final class AvailableVendorsProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  AvailableVendorsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableVendorsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableVendorsHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return availableVendors(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$availableVendorsHash() => r'7960899ffedc00ca283027ac8cefeb8a20f6e7b1';

@ProviderFor(availableFrequencies)
final availableFrequenciesProvider = AvailableFrequenciesProvider._();

final class AvailableFrequenciesProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  AvailableFrequenciesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableFrequenciesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableFrequenciesHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return availableFrequencies(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$availableFrequenciesHash() =>
    r'e82b2b7d91cc49b98f433368fb89fb92bffa7f8e';

@ProviderFor(availableTargetsList)
final availableTargetsListProvider = AvailableTargetsListProvider._();

final class AvailableTargetsListProvider
    extends
        $FunctionalProvider<
          List<TargetDefinition>,
          List<TargetDefinition>,
          List<TargetDefinition>
        >
    with $Provider<List<TargetDefinition>> {
  AvailableTargetsListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'availableTargetsListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableTargetsListHash();

  @$internal
  @override
  $ProviderElement<List<TargetDefinition>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<TargetDefinition> create(Ref ref) {
    return availableTargetsList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TargetDefinition> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TargetDefinition>>(value),
    );
  }
}

String _$availableTargetsListHash() =>
    r'6c9462429f174bdb784b7ad3ec770c2440828c95';
