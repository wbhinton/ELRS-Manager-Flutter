// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backpack_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BackpackState {

 String? get selectedTarget; BackpackStatus get status; double get progress; String? get errorMessage; List<String> get availableTargets;
/// Create a copy of BackpackState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackpackStateCopyWith<BackpackState> get copyWith => _$BackpackStateCopyWithImpl<BackpackState>(this as BackpackState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackpackState&&(identical(other.selectedTarget, selectedTarget) || other.selectedTarget == selectedTarget)&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.availableTargets, availableTargets));
}


@override
int get hashCode => Object.hash(runtimeType,selectedTarget,status,progress,errorMessage,const DeepCollectionEquality().hash(availableTargets));

@override
String toString() {
  return 'BackpackState(selectedTarget: $selectedTarget, status: $status, progress: $progress, errorMessage: $errorMessage, availableTargets: $availableTargets)';
}


}

/// @nodoc
abstract mixin class $BackpackStateCopyWith<$Res>  {
  factory $BackpackStateCopyWith(BackpackState value, $Res Function(BackpackState) _then) = _$BackpackStateCopyWithImpl;
@useResult
$Res call({
 String? selectedTarget, BackpackStatus status, double progress, String? errorMessage, List<String> availableTargets
});




}
/// @nodoc
class _$BackpackStateCopyWithImpl<$Res>
    implements $BackpackStateCopyWith<$Res> {
  _$BackpackStateCopyWithImpl(this._self, this._then);

  final BackpackState _self;
  final $Res Function(BackpackState) _then;

/// Create a copy of BackpackState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedTarget = freezed,Object? status = null,Object? progress = null,Object? errorMessage = freezed,Object? availableTargets = null,}) {
  return _then(_self.copyWith(
selectedTarget: freezed == selectedTarget ? _self.selectedTarget : selectedTarget // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BackpackStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,availableTargets: null == availableTargets ? _self.availableTargets : availableTargets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [BackpackState].
extension BackpackStatePatterns on BackpackState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackpackState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackpackState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackpackState value)  $default,){
final _that = this;
switch (_that) {
case _BackpackState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackpackState value)?  $default,){
final _that = this;
switch (_that) {
case _BackpackState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? selectedTarget,  BackpackStatus status,  double progress,  String? errorMessage,  List<String> availableTargets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackpackState() when $default != null:
return $default(_that.selectedTarget,_that.status,_that.progress,_that.errorMessage,_that.availableTargets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? selectedTarget,  BackpackStatus status,  double progress,  String? errorMessage,  List<String> availableTargets)  $default,) {final _that = this;
switch (_that) {
case _BackpackState():
return $default(_that.selectedTarget,_that.status,_that.progress,_that.errorMessage,_that.availableTargets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? selectedTarget,  BackpackStatus status,  double progress,  String? errorMessage,  List<String> availableTargets)?  $default,) {final _that = this;
switch (_that) {
case _BackpackState() when $default != null:
return $default(_that.selectedTarget,_that.status,_that.progress,_that.errorMessage,_that.availableTargets);case _:
  return null;

}
}

}

/// @nodoc


class _BackpackState implements BackpackState {
  const _BackpackState({this.selectedTarget, this.status = BackpackStatus.idle, this.progress = 0.0, this.errorMessage, final  List<String> availableTargets = const []}): _availableTargets = availableTargets;
  

@override final  String? selectedTarget;
@override@JsonKey() final  BackpackStatus status;
@override@JsonKey() final  double progress;
@override final  String? errorMessage;
 final  List<String> _availableTargets;
@override@JsonKey() List<String> get availableTargets {
  if (_availableTargets is EqualUnmodifiableListView) return _availableTargets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableTargets);
}


/// Create a copy of BackpackState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackpackStateCopyWith<_BackpackState> get copyWith => __$BackpackStateCopyWithImpl<_BackpackState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackpackState&&(identical(other.selectedTarget, selectedTarget) || other.selectedTarget == selectedTarget)&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._availableTargets, _availableTargets));
}


@override
int get hashCode => Object.hash(runtimeType,selectedTarget,status,progress,errorMessage,const DeepCollectionEquality().hash(_availableTargets));

@override
String toString() {
  return 'BackpackState(selectedTarget: $selectedTarget, status: $status, progress: $progress, errorMessage: $errorMessage, availableTargets: $availableTargets)';
}


}

/// @nodoc
abstract mixin class _$BackpackStateCopyWith<$Res> implements $BackpackStateCopyWith<$Res> {
  factory _$BackpackStateCopyWith(_BackpackState value, $Res Function(_BackpackState) _then) = __$BackpackStateCopyWithImpl;
@override @useResult
$Res call({
 String? selectedTarget, BackpackStatus status, double progress, String? errorMessage, List<String> availableTargets
});




}
/// @nodoc
class __$BackpackStateCopyWithImpl<$Res>
    implements _$BackpackStateCopyWith<$Res> {
  __$BackpackStateCopyWithImpl(this._self, this._then);

  final _BackpackState _self;
  final $Res Function(_BackpackState) _then;

/// Create a copy of BackpackState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedTarget = freezed,Object? status = null,Object? progress = null,Object? errorMessage = freezed,Object? availableTargets = null,}) {
  return _then(_BackpackState(
selectedTarget: freezed == selectedTarget ? _self.selectedTarget : selectedTarget // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BackpackStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,availableTargets: null == availableTargets ? _self._availableTargets : availableTargets // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
