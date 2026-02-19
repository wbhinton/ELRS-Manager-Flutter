// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeviceConfig _$DeviceConfigFromJson(Map<String, dynamic> json) =>
    _DeviceConfig(
      productName: json['product_name'] as String?,
      version: json['version'] as String? ?? 'unknown',
      uid:
          (json['uid'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      pwmOutputs:
          (json['pwm_outputs'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      modelId: (json['modelId'] as num?)?.toInt() ?? 255,
      options: json['options'] as Map<String, dynamic>? ?? const {},
      regDomain: json['reg_domain'] as String?,
      exp: json['exp'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$DeviceConfigToJson(_DeviceConfig instance) =>
    <String, dynamic>{
      'product_name': instance.productName,
      'version': instance.version,
      'uid': instance.uid,
      'pwm_outputs': instance.pwmOutputs,
      'modelId': instance.modelId,
      'options': instance.options,
      'reg_domain': instance.regDomain,
      'exp': instance.exp,
    };
