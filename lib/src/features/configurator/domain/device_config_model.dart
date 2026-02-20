import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_config_model.freezed.dart';
part 'device_config_model.g.dart';

@freezed
abstract class DeviceConfig with _$DeviceConfig {
  const factory DeviceConfig({
    @JsonKey(name: 'product_name') String? productName,
    @Default('unknown') String version,
    @Default([]) List<int> uid,
    @JsonKey(name: 'pwm_outputs') @Default([]) List<int> pwmOutputs,
    @Default(255) int modelId,
    @Default(false) bool modelMatch,
    @Default({}) Map<String, dynamic> options,
    @JsonKey(name: 'reg_domain') String? regDomain,
    @Default({}) Map<String, dynamic> exp, // Betaflight/Export options often here
  }) = _DeviceConfig;

  factory DeviceConfig.fromJson(Map<String, dynamic> json) =>
      _$DeviceConfigFromJson(json);
}
