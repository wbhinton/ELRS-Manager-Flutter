// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pwm_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PwmState {

 List<int> get outputs;// Index = Pin, Value = Channel
 PwmStatus get status; String? get errorMessage;
/// Create a copy of PwmState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PwmStateCopyWith<PwmState> get copyWith => _$PwmStateCopyWithImpl<PwmState>(this as PwmState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PwmState&&const DeepCollectionEquality().equals(other.outputs, outputs)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(outputs),status,errorMessage);

@override
String toString() {
  return 'PwmState(outputs: $outputs, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $PwmStateCopyWith<$Res>  {
  factory $PwmStateCopyWith(PwmState value, $Res Function(PwmState) _then) = _$PwmStateCopyWithImpl;
@useResult
$Res call({
 List<int> outputs, PwmStatus status, String? errorMessage
});




}
/// @nodoc
class _$PwmStateCopyWithImpl<$Res>
    implements $PwmStateCopyWith<$Res> {
  _$PwmStateCopyWithImpl(this._self, this._then);

  final PwmState _self;
  final $Res Function(PwmState) _then;

/// Create a copy of PwmState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? outputs = null,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
outputs: null == outputs ? _self.outputs : outputs // ignore: cast_nullable_to_non_nullable
as List<int>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PwmStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PwmState].
extension PwmStatePatterns on PwmState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PwmState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PwmState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PwmState value)  $default,){
final _that = this;
switch (_that) {
case _PwmState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PwmState value)?  $default,){
final _that = this;
switch (_that) {
case _PwmState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<int> outputs,  PwmStatus status,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PwmState() when $default != null:
return $default(_that.outputs,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<int> outputs,  PwmStatus status,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _PwmState():
return $default(_that.outputs,_that.status,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<int> outputs,  PwmStatus status,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _PwmState() when $default != null:
return $default(_that.outputs,_that.status,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _PwmState implements PwmState {
  const _PwmState({final  List<int> outputs = const [], this.status = PwmStatus.idle, this.errorMessage}): _outputs = outputs;
  

 final  List<int> _outputs;
@override@JsonKey() List<int> get outputs {
  if (_outputs is EqualUnmodifiableListView) return _outputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_outputs);
}

// Index = Pin, Value = Channel
@override@JsonKey() final  PwmStatus status;
@override final  String? errorMessage;

/// Create a copy of PwmState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PwmStateCopyWith<_PwmState> get copyWith => __$PwmStateCopyWithImpl<_PwmState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PwmState&&const DeepCollectionEquality().equals(other._outputs, _outputs)&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_outputs),status,errorMessage);

@override
String toString() {
  return 'PwmState(outputs: $outputs, status: $status, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$PwmStateCopyWith<$Res> implements $PwmStateCopyWith<$Res> {
  factory _$PwmStateCopyWith(_PwmState value, $Res Function(_PwmState) _then) = __$PwmStateCopyWithImpl;
@override @useResult
$Res call({
 List<int> outputs, PwmStatus status, String? errorMessage
});




}
/// @nodoc
class __$PwmStateCopyWithImpl<$Res>
    implements _$PwmStateCopyWith<$Res> {
  __$PwmStateCopyWithImpl(this._self, this._then);

  final _PwmState _self;
  final $Res Function(_PwmState) _then;

/// Create a copy of PwmState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? outputs = null,Object? status = null,Object? errorMessage = freezed,}) {
  return _then(_PwmState(
outputs: null == outputs ? _self._outputs : outputs // ignore: cast_nullable_to_non_nullable
as List<int>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PwmStatus,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
