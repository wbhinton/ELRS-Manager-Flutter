// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {

 bool get developerMode; bool get forceMobileData; int get defaultRegulatoryDomain; String get globalBindPhrase; String get homeWifiSsid; String get homeWifiPassword; int get maxCachedVersions; bool get expertMode; String get appVersion; bool get disclaimerAccepted; bool get isLoaded;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.developerMode, developerMode) || other.developerMode == developerMode)&&(identical(other.forceMobileData, forceMobileData) || other.forceMobileData == forceMobileData)&&(identical(other.defaultRegulatoryDomain, defaultRegulatoryDomain) || other.defaultRegulatoryDomain == defaultRegulatoryDomain)&&(identical(other.globalBindPhrase, globalBindPhrase) || other.globalBindPhrase == globalBindPhrase)&&(identical(other.homeWifiSsid, homeWifiSsid) || other.homeWifiSsid == homeWifiSsid)&&(identical(other.homeWifiPassword, homeWifiPassword) || other.homeWifiPassword == homeWifiPassword)&&(identical(other.maxCachedVersions, maxCachedVersions) || other.maxCachedVersions == maxCachedVersions)&&(identical(other.expertMode, expertMode) || other.expertMode == expertMode)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.disclaimerAccepted, disclaimerAccepted) || other.disclaimerAccepted == disclaimerAccepted)&&(identical(other.isLoaded, isLoaded) || other.isLoaded == isLoaded));
}


@override
int get hashCode => Object.hash(runtimeType,developerMode,forceMobileData,defaultRegulatoryDomain,globalBindPhrase,homeWifiSsid,homeWifiPassword,maxCachedVersions,expertMode,appVersion,disclaimerAccepted,isLoaded);

@override
String toString() {
  return 'SettingsState(developerMode: $developerMode, forceMobileData: $forceMobileData, defaultRegulatoryDomain: $defaultRegulatoryDomain, globalBindPhrase: $globalBindPhrase, homeWifiSsid: $homeWifiSsid, homeWifiPassword: $homeWifiPassword, maxCachedVersions: $maxCachedVersions, expertMode: $expertMode, appVersion: $appVersion, disclaimerAccepted: $disclaimerAccepted, isLoaded: $isLoaded)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 bool developerMode, bool forceMobileData, int defaultRegulatoryDomain, String globalBindPhrase, String homeWifiSsid, String homeWifiPassword, int maxCachedVersions, bool expertMode, String appVersion, bool disclaimerAccepted, bool isLoaded
});




}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? developerMode = null,Object? forceMobileData = null,Object? defaultRegulatoryDomain = null,Object? globalBindPhrase = null,Object? homeWifiSsid = null,Object? homeWifiPassword = null,Object? maxCachedVersions = null,Object? expertMode = null,Object? appVersion = null,Object? disclaimerAccepted = null,Object? isLoaded = null,}) {
  return _then(_self.copyWith(
developerMode: null == developerMode ? _self.developerMode : developerMode // ignore: cast_nullable_to_non_nullable
as bool,forceMobileData: null == forceMobileData ? _self.forceMobileData : forceMobileData // ignore: cast_nullable_to_non_nullable
as bool,defaultRegulatoryDomain: null == defaultRegulatoryDomain ? _self.defaultRegulatoryDomain : defaultRegulatoryDomain // ignore: cast_nullable_to_non_nullable
as int,globalBindPhrase: null == globalBindPhrase ? _self.globalBindPhrase : globalBindPhrase // ignore: cast_nullable_to_non_nullable
as String,homeWifiSsid: null == homeWifiSsid ? _self.homeWifiSsid : homeWifiSsid // ignore: cast_nullable_to_non_nullable
as String,homeWifiPassword: null == homeWifiPassword ? _self.homeWifiPassword : homeWifiPassword // ignore: cast_nullable_to_non_nullable
as String,maxCachedVersions: null == maxCachedVersions ? _self.maxCachedVersions : maxCachedVersions // ignore: cast_nullable_to_non_nullable
as int,expertMode: null == expertMode ? _self.expertMode : expertMode // ignore: cast_nullable_to_non_nullable
as bool,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,disclaimerAccepted: null == disclaimerAccepted ? _self.disclaimerAccepted : disclaimerAccepted // ignore: cast_nullable_to_non_nullable
as bool,isLoaded: null == isLoaded ? _self.isLoaded : isLoaded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool developerMode,  bool forceMobileData,  int defaultRegulatoryDomain,  String globalBindPhrase,  String homeWifiSsid,  String homeWifiPassword,  int maxCachedVersions,  bool expertMode,  String appVersion,  bool disclaimerAccepted,  bool isLoaded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.developerMode,_that.forceMobileData,_that.defaultRegulatoryDomain,_that.globalBindPhrase,_that.homeWifiSsid,_that.homeWifiPassword,_that.maxCachedVersions,_that.expertMode,_that.appVersion,_that.disclaimerAccepted,_that.isLoaded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool developerMode,  bool forceMobileData,  int defaultRegulatoryDomain,  String globalBindPhrase,  String homeWifiSsid,  String homeWifiPassword,  int maxCachedVersions,  bool expertMode,  String appVersion,  bool disclaimerAccepted,  bool isLoaded)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.developerMode,_that.forceMobileData,_that.defaultRegulatoryDomain,_that.globalBindPhrase,_that.homeWifiSsid,_that.homeWifiPassword,_that.maxCachedVersions,_that.expertMode,_that.appVersion,_that.disclaimerAccepted,_that.isLoaded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool developerMode,  bool forceMobileData,  int defaultRegulatoryDomain,  String globalBindPhrase,  String homeWifiSsid,  String homeWifiPassword,  int maxCachedVersions,  bool expertMode,  String appVersion,  bool disclaimerAccepted,  bool isLoaded)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.developerMode,_that.forceMobileData,_that.defaultRegulatoryDomain,_that.globalBindPhrase,_that.homeWifiSsid,_that.homeWifiPassword,_that.maxCachedVersions,_that.expertMode,_that.appVersion,_that.disclaimerAccepted,_that.isLoaded);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState implements SettingsState {
  const _SettingsState({this.developerMode = false, this.forceMobileData = false, this.defaultRegulatoryDomain = 0, this.globalBindPhrase = '', this.homeWifiSsid = '', this.homeWifiPassword = '', this.maxCachedVersions = 2, this.expertMode = false, this.appVersion = 'Unknown', this.disclaimerAccepted = false, this.isLoaded = false});
  

@override@JsonKey() final  bool developerMode;
@override@JsonKey() final  bool forceMobileData;
@override@JsonKey() final  int defaultRegulatoryDomain;
@override@JsonKey() final  String globalBindPhrase;
@override@JsonKey() final  String homeWifiSsid;
@override@JsonKey() final  String homeWifiPassword;
@override@JsonKey() final  int maxCachedVersions;
@override@JsonKey() final  bool expertMode;
@override@JsonKey() final  String appVersion;
@override@JsonKey() final  bool disclaimerAccepted;
@override@JsonKey() final  bool isLoaded;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.developerMode, developerMode) || other.developerMode == developerMode)&&(identical(other.forceMobileData, forceMobileData) || other.forceMobileData == forceMobileData)&&(identical(other.defaultRegulatoryDomain, defaultRegulatoryDomain) || other.defaultRegulatoryDomain == defaultRegulatoryDomain)&&(identical(other.globalBindPhrase, globalBindPhrase) || other.globalBindPhrase == globalBindPhrase)&&(identical(other.homeWifiSsid, homeWifiSsid) || other.homeWifiSsid == homeWifiSsid)&&(identical(other.homeWifiPassword, homeWifiPassword) || other.homeWifiPassword == homeWifiPassword)&&(identical(other.maxCachedVersions, maxCachedVersions) || other.maxCachedVersions == maxCachedVersions)&&(identical(other.expertMode, expertMode) || other.expertMode == expertMode)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.disclaimerAccepted, disclaimerAccepted) || other.disclaimerAccepted == disclaimerAccepted)&&(identical(other.isLoaded, isLoaded) || other.isLoaded == isLoaded));
}


@override
int get hashCode => Object.hash(runtimeType,developerMode,forceMobileData,defaultRegulatoryDomain,globalBindPhrase,homeWifiSsid,homeWifiPassword,maxCachedVersions,expertMode,appVersion,disclaimerAccepted,isLoaded);

@override
String toString() {
  return 'SettingsState(developerMode: $developerMode, forceMobileData: $forceMobileData, defaultRegulatoryDomain: $defaultRegulatoryDomain, globalBindPhrase: $globalBindPhrase, homeWifiSsid: $homeWifiSsid, homeWifiPassword: $homeWifiPassword, maxCachedVersions: $maxCachedVersions, expertMode: $expertMode, appVersion: $appVersion, disclaimerAccepted: $disclaimerAccepted, isLoaded: $isLoaded)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool developerMode, bool forceMobileData, int defaultRegulatoryDomain, String globalBindPhrase, String homeWifiSsid, String homeWifiPassword, int maxCachedVersions, bool expertMode, String appVersion, bool disclaimerAccepted, bool isLoaded
});




}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? developerMode = null,Object? forceMobileData = null,Object? defaultRegulatoryDomain = null,Object? globalBindPhrase = null,Object? homeWifiSsid = null,Object? homeWifiPassword = null,Object? maxCachedVersions = null,Object? expertMode = null,Object? appVersion = null,Object? disclaimerAccepted = null,Object? isLoaded = null,}) {
  return _then(_SettingsState(
developerMode: null == developerMode ? _self.developerMode : developerMode // ignore: cast_nullable_to_non_nullable
as bool,forceMobileData: null == forceMobileData ? _self.forceMobileData : forceMobileData // ignore: cast_nullable_to_non_nullable
as bool,defaultRegulatoryDomain: null == defaultRegulatoryDomain ? _self.defaultRegulatoryDomain : defaultRegulatoryDomain // ignore: cast_nullable_to_non_nullable
as int,globalBindPhrase: null == globalBindPhrase ? _self.globalBindPhrase : globalBindPhrase // ignore: cast_nullable_to_non_nullable
as String,homeWifiSsid: null == homeWifiSsid ? _self.homeWifiSsid : homeWifiSsid // ignore: cast_nullable_to_non_nullable
as String,homeWifiPassword: null == homeWifiPassword ? _self.homeWifiPassword : homeWifiPassword // ignore: cast_nullable_to_non_nullable
as String,maxCachedVersions: null == maxCachedVersions ? _self.maxCachedVersions : maxCachedVersions // ignore: cast_nullable_to_non_nullable
as int,expertMode: null == expertMode ? _self.expertMode : expertMode // ignore: cast_nullable_to_non_nullable
as bool,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,disclaimerAccepted: null == disclaimerAccepted ? _self.disclaimerAccepted : disclaimerAccepted // ignore: cast_nullable_to_non_nullable
as bool,isLoaded: null == isLoaded ? _self.isLoaded : isLoaded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
