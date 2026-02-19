// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'device_config_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeviceConfig {

@JsonKey(name: 'product_name') String? get productName; String get version; List<int> get uid;@JsonKey(name: 'pwm_outputs') List<int> get pwmOutputs; int get modelId; Map<String, dynamic> get options;@JsonKey(name: 'reg_domain') String? get regDomain; Map<String, dynamic> get exp;
/// Create a copy of DeviceConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeviceConfigCopyWith<DeviceConfig> get copyWith => _$DeviceConfigCopyWithImpl<DeviceConfig>(this as DeviceConfig, _$identity);

  /// Serializes this DeviceConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeviceConfig&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other.uid, uid)&&const DeepCollectionEquality().equals(other.pwmOutputs, pwmOutputs)&&(identical(other.modelId, modelId) || other.modelId == modelId)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.regDomain, regDomain) || other.regDomain == regDomain)&&const DeepCollectionEquality().equals(other.exp, exp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,version,const DeepCollectionEquality().hash(uid),const DeepCollectionEquality().hash(pwmOutputs),modelId,const DeepCollectionEquality().hash(options),regDomain,const DeepCollectionEquality().hash(exp));

@override
String toString() {
  return 'DeviceConfig(productName: $productName, version: $version, uid: $uid, pwmOutputs: $pwmOutputs, modelId: $modelId, options: $options, regDomain: $regDomain, exp: $exp)';
}


}

/// @nodoc
abstract mixin class $DeviceConfigCopyWith<$Res>  {
  factory $DeviceConfigCopyWith(DeviceConfig value, $Res Function(DeviceConfig) _then) = _$DeviceConfigCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'product_name') String? productName, String version, List<int> uid,@JsonKey(name: 'pwm_outputs') List<int> pwmOutputs, int modelId, Map<String, dynamic> options,@JsonKey(name: 'reg_domain') String? regDomain, Map<String, dynamic> exp
});




}
/// @nodoc
class _$DeviceConfigCopyWithImpl<$Res>
    implements $DeviceConfigCopyWith<$Res> {
  _$DeviceConfigCopyWithImpl(this._self, this._then);

  final DeviceConfig _self;
  final $Res Function(DeviceConfig) _then;

/// Create a copy of DeviceConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productName = freezed,Object? version = null,Object? uid = null,Object? pwmOutputs = null,Object? modelId = null,Object? options = null,Object? regDomain = freezed,Object? exp = null,}) {
  return _then(_self.copyWith(
productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as List<int>,pwmOutputs: null == pwmOutputs ? _self.pwmOutputs : pwmOutputs // ignore: cast_nullable_to_non_nullable
as List<int>,modelId: null == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,regDomain: freezed == regDomain ? _self.regDomain : regDomain // ignore: cast_nullable_to_non_nullable
as String?,exp: null == exp ? _self.exp : exp // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [DeviceConfig].
extension DeviceConfigPatterns on DeviceConfig {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeviceConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeviceConfig() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeviceConfig value)  $default,){
final _that = this;
switch (_that) {
case _DeviceConfig():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeviceConfig value)?  $default,){
final _that = this;
switch (_that) {
case _DeviceConfig() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_name')  String? productName,  String version,  List<int> uid, @JsonKey(name: 'pwm_outputs')  List<int> pwmOutputs,  int modelId,  Map<String, dynamic> options, @JsonKey(name: 'reg_domain')  String? regDomain,  Map<String, dynamic> exp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeviceConfig() when $default != null:
return $default(_that.productName,_that.version,_that.uid,_that.pwmOutputs,_that.modelId,_that.options,_that.regDomain,_that.exp);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'product_name')  String? productName,  String version,  List<int> uid, @JsonKey(name: 'pwm_outputs')  List<int> pwmOutputs,  int modelId,  Map<String, dynamic> options, @JsonKey(name: 'reg_domain')  String? regDomain,  Map<String, dynamic> exp)  $default,) {final _that = this;
switch (_that) {
case _DeviceConfig():
return $default(_that.productName,_that.version,_that.uid,_that.pwmOutputs,_that.modelId,_that.options,_that.regDomain,_that.exp);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'product_name')  String? productName,  String version,  List<int> uid, @JsonKey(name: 'pwm_outputs')  List<int> pwmOutputs,  int modelId,  Map<String, dynamic> options, @JsonKey(name: 'reg_domain')  String? regDomain,  Map<String, dynamic> exp)?  $default,) {final _that = this;
switch (_that) {
case _DeviceConfig() when $default != null:
return $default(_that.productName,_that.version,_that.uid,_that.pwmOutputs,_that.modelId,_that.options,_that.regDomain,_that.exp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeviceConfig implements DeviceConfig {
  const _DeviceConfig({@JsonKey(name: 'product_name') this.productName, this.version = 'unknown', final  List<int> uid = const [], @JsonKey(name: 'pwm_outputs') final  List<int> pwmOutputs = const [], this.modelId = 255, final  Map<String, dynamic> options = const {}, @JsonKey(name: 'reg_domain') this.regDomain, final  Map<String, dynamic> exp = const {}}): _uid = uid,_pwmOutputs = pwmOutputs,_options = options,_exp = exp;
  factory _DeviceConfig.fromJson(Map<String, dynamic> json) => _$DeviceConfigFromJson(json);

@override@JsonKey(name: 'product_name') final  String? productName;
@override@JsonKey() final  String version;
 final  List<int> _uid;
@override@JsonKey() List<int> get uid {
  if (_uid is EqualUnmodifiableListView) return _uid;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uid);
}

 final  List<int> _pwmOutputs;
@override@JsonKey(name: 'pwm_outputs') List<int> get pwmOutputs {
  if (_pwmOutputs is EqualUnmodifiableListView) return _pwmOutputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pwmOutputs);
}

@override@JsonKey() final  int modelId;
 final  Map<String, dynamic> _options;
@override@JsonKey() Map<String, dynamic> get options {
  if (_options is EqualUnmodifiableMapView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_options);
}

@override@JsonKey(name: 'reg_domain') final  String? regDomain;
 final  Map<String, dynamic> _exp;
@override@JsonKey() Map<String, dynamic> get exp {
  if (_exp is EqualUnmodifiableMapView) return _exp;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_exp);
}


/// Create a copy of DeviceConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeviceConfigCopyWith<_DeviceConfig> get copyWith => __$DeviceConfigCopyWithImpl<_DeviceConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeviceConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeviceConfig&&(identical(other.productName, productName) || other.productName == productName)&&(identical(other.version, version) || other.version == version)&&const DeepCollectionEquality().equals(other._uid, _uid)&&const DeepCollectionEquality().equals(other._pwmOutputs, _pwmOutputs)&&(identical(other.modelId, modelId) || other.modelId == modelId)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.regDomain, regDomain) || other.regDomain == regDomain)&&const DeepCollectionEquality().equals(other._exp, _exp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productName,version,const DeepCollectionEquality().hash(_uid),const DeepCollectionEquality().hash(_pwmOutputs),modelId,const DeepCollectionEquality().hash(_options),regDomain,const DeepCollectionEquality().hash(_exp));

@override
String toString() {
  return 'DeviceConfig(productName: $productName, version: $version, uid: $uid, pwmOutputs: $pwmOutputs, modelId: $modelId, options: $options, regDomain: $regDomain, exp: $exp)';
}


}

/// @nodoc
abstract mixin class _$DeviceConfigCopyWith<$Res> implements $DeviceConfigCopyWith<$Res> {
  factory _$DeviceConfigCopyWith(_DeviceConfig value, $Res Function(_DeviceConfig) _then) = __$DeviceConfigCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'product_name') String? productName, String version, List<int> uid,@JsonKey(name: 'pwm_outputs') List<int> pwmOutputs, int modelId, Map<String, dynamic> options,@JsonKey(name: 'reg_domain') String? regDomain, Map<String, dynamic> exp
});




}
/// @nodoc
class __$DeviceConfigCopyWithImpl<$Res>
    implements _$DeviceConfigCopyWith<$Res> {
  __$DeviceConfigCopyWithImpl(this._self, this._then);

  final _DeviceConfig _self;
  final $Res Function(_DeviceConfig) _then;

/// Create a copy of DeviceConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productName = freezed,Object? version = null,Object? uid = null,Object? pwmOutputs = null,Object? modelId = null,Object? options = null,Object? regDomain = freezed,Object? exp = null,}) {
  return _then(_DeviceConfig(
productName: freezed == productName ? _self.productName : productName // ignore: cast_nullable_to_non_nullable
as String?,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,uid: null == uid ? _self._uid : uid // ignore: cast_nullable_to_non_nullable
as List<int>,pwmOutputs: null == pwmOutputs ? _self._pwmOutputs : pwmOutputs // ignore: cast_nullable_to_non_nullable
as List<int>,modelId: null == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as int,options: null == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,regDomain: freezed == regDomain ? _self.regDomain : regDomain // ignore: cast_nullable_to_non_nullable
as String?,exp: null == exp ? _self._exp : exp // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
