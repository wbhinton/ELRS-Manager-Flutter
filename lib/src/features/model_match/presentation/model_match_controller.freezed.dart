// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_match_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ModelMatchState {

 int get modelId; bool get isEnabled; ModelMatchStatus get status; String? get errorMessage;
/// Create a copy of ModelMatchState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ModelMatchStateCopyWith<ModelMatchState> get copyWith => _$ModelMatchStateCopyWithImpl<ModelMatchState>(this as ModelMatchState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ModelMatchState&&(identical(other.modelId, modelId) || other.modelId == modelId)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,modelId,isEnabled,status,errorMessage);

@override
String toString() {
  return 'ModelMatchState(modelId: $modelId, isEnabled: $isEnabled, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ModelMatchStateCopyWith<$Res>  {
  factory $ModelMatchStateCopyWith(ModelMatchState value, $Res Function(ModelMatchState) _then) = _$ModelMatchStateCopyWithImpl;
@useResult
$Res call({
 int modelId, bool isEnabled, ModelMatchStatus status, String? errorMessage
});




}
/// @nodoc
class _$ModelMatchStateCopyWithImpl<$Res>
    implements $ModelMatchStateCopyWith<$Res> {
  _$ModelMatchStateCopyWithImpl(this._self, this._then);

  final ModelMatchState _self;
  final $Res Function(ModelMatchState) _then;

/// Create a copy of ModelMatchState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? modelId = null,Object? isEnabled = null,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
modelId: null == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as int,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ModelMatchStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ModelMatchState].
extension ModelMatchStatePatterns on ModelMatchState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ModelMatchState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ModelMatchState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ModelMatchState value)  $default,){
final _that = this;
switch (_that) {
case _ModelMatchState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ModelMatchState value)?  $default,){
final _that = this;
switch (_that) {
case _ModelMatchState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int modelId,  bool isEnabled,  ModelMatchStatus status,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ModelMatchState() when $default != null:
return $default(_that.modelId,_that.isEnabled,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int modelId,  bool isEnabled,  ModelMatchStatus status,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ModelMatchState():
return $default(_that.modelId,_that.isEnabled,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int modelId,  bool isEnabled,  ModelMatchStatus status,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ModelMatchState() when $default != null:
return $default(_that.modelId,_that.isEnabled,_that.status,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _ModelMatchState implements ModelMatchState {
  const _ModelMatchState({this.modelId = 255, this.isEnabled = false, this.status = ModelMatchStatus.idle, this.errorMessage});
  

@override@JsonKey() final  int modelId;
@override@JsonKey() final  bool isEnabled;
@override@JsonKey() final  ModelMatchStatus status;
@override final  String? errorMessage;

/// Create a copy of ModelMatchState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ModelMatchStateCopyWith<_ModelMatchState> get copyWith => __$ModelMatchStateCopyWithImpl<_ModelMatchState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ModelMatchState&&(identical(other.modelId, modelId) || other.modelId == modelId)&&(identical(other.isEnabled, isEnabled) || other.isEnabled == isEnabled)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,modelId,isEnabled,status,errorMessage);

@override
String toString() {
  return 'ModelMatchState(modelId: $modelId, isEnabled: $isEnabled, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ModelMatchStateCopyWith<$Res> implements $ModelMatchStateCopyWith<$Res> {
  factory _$ModelMatchStateCopyWith(_ModelMatchState value, $Res Function(_ModelMatchState) _then) = __$ModelMatchStateCopyWithImpl;
@override @useResult
$Res call({
 int modelId, bool isEnabled, ModelMatchStatus status, String? errorMessage
});




}
/// @nodoc
class __$ModelMatchStateCopyWithImpl<$Res>
    implements _$ModelMatchStateCopyWith<$Res> {
  __$ModelMatchStateCopyWithImpl(this._self, this._then);

  final _ModelMatchState _self;
  final $Res Function(_ModelMatchState) _then;

/// Create a copy of ModelMatchState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? modelId = null,Object? isEnabled = null,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_ModelMatchState(
modelId: null == modelId ? _self.modelId : modelId // ignore: cast_nullable_to_non_nullable
as int,isEnabled: null == isEnabled ? _self.isEnabled : isEnabled // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ModelMatchStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
