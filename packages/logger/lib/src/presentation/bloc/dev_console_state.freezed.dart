// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dev_console_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DevConsoleState {

 DebugInfoEntity get debugInfoState; AppLoggerOutputMode get loggerOutputMode;
/// Create a copy of DevConsoleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DevConsoleStateCopyWith<DevConsoleState> get copyWith => _$DevConsoleStateCopyWithImpl<DevConsoleState>(this as DevConsoleState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DevConsoleState&&(identical(other.debugInfoState, debugInfoState) || other.debugInfoState == debugInfoState)&&(identical(other.loggerOutputMode, loggerOutputMode) || other.loggerOutputMode == loggerOutputMode));
}


@override
int get hashCode => Object.hash(runtimeType,debugInfoState,loggerOutputMode);

@override
String toString() {
  return 'DevConsoleState(debugInfoState: $debugInfoState, loggerOutputMode: $loggerOutputMode)';
}


}

/// @nodoc
abstract mixin class $DevConsoleStateCopyWith<$Res>  {
  factory $DevConsoleStateCopyWith(DevConsoleState value, $Res Function(DevConsoleState) _then) = _$DevConsoleStateCopyWithImpl;
@useResult
$Res call({
 DebugInfoEntity debugInfoState, AppLoggerOutputMode loggerOutputMode
});


$DebugInfoEntityCopyWith<$Res> get debugInfoState;

}
/// @nodoc
class _$DevConsoleStateCopyWithImpl<$Res>
    implements $DevConsoleStateCopyWith<$Res> {
  _$DevConsoleStateCopyWithImpl(this._self, this._then);

  final DevConsoleState _self;
  final $Res Function(DevConsoleState) _then;

/// Create a copy of DevConsoleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? debugInfoState = null,Object? loggerOutputMode = null,}) {
  return _then(_self.copyWith(
debugInfoState: null == debugInfoState ? _self.debugInfoState : debugInfoState // ignore: cast_nullable_to_non_nullable
as DebugInfoEntity,loggerOutputMode: null == loggerOutputMode ? _self.loggerOutputMode : loggerOutputMode // ignore: cast_nullable_to_non_nullable
as AppLoggerOutputMode,
  ));
}
/// Create a copy of DevConsoleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DebugInfoEntityCopyWith<$Res> get debugInfoState {
  
  return $DebugInfoEntityCopyWith<$Res>(_self.debugInfoState, (value) {
    return _then(_self.copyWith(debugInfoState: value));
  });
}
}


/// Adds pattern-matching-related methods to [DevConsoleState].
extension DevConsoleStatePatterns on DevConsoleState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DevConsoleState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DevConsoleState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DevConsoleState value)  $default,){
final _that = this;
switch (_that) {
case _DevConsoleState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DevConsoleState value)?  $default,){
final _that = this;
switch (_that) {
case _DevConsoleState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DebugInfoEntity debugInfoState,  AppLoggerOutputMode loggerOutputMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DevConsoleState() when $default != null:
return $default(_that.debugInfoState,_that.loggerOutputMode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DebugInfoEntity debugInfoState,  AppLoggerOutputMode loggerOutputMode)  $default,) {final _that = this;
switch (_that) {
case _DevConsoleState():
return $default(_that.debugInfoState,_that.loggerOutputMode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DebugInfoEntity debugInfoState,  AppLoggerOutputMode loggerOutputMode)?  $default,) {final _that = this;
switch (_that) {
case _DevConsoleState() when $default != null:
return $default(_that.debugInfoState,_that.loggerOutputMode);case _:
  return null;

}
}

}

/// @nodoc


class _DevConsoleState implements DevConsoleState {
  const _DevConsoleState({required this.debugInfoState, required this.loggerOutputMode});
  

@override final  DebugInfoEntity debugInfoState;
@override final  AppLoggerOutputMode loggerOutputMode;

/// Create a copy of DevConsoleState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DevConsoleStateCopyWith<_DevConsoleState> get copyWith => __$DevConsoleStateCopyWithImpl<_DevConsoleState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DevConsoleState&&(identical(other.debugInfoState, debugInfoState) || other.debugInfoState == debugInfoState)&&(identical(other.loggerOutputMode, loggerOutputMode) || other.loggerOutputMode == loggerOutputMode));
}


@override
int get hashCode => Object.hash(runtimeType,debugInfoState,loggerOutputMode);

@override
String toString() {
  return 'DevConsoleState(debugInfoState: $debugInfoState, loggerOutputMode: $loggerOutputMode)';
}


}

/// @nodoc
abstract mixin class _$DevConsoleStateCopyWith<$Res> implements $DevConsoleStateCopyWith<$Res> {
  factory _$DevConsoleStateCopyWith(_DevConsoleState value, $Res Function(_DevConsoleState) _then) = __$DevConsoleStateCopyWithImpl;
@override @useResult
$Res call({
 DebugInfoEntity debugInfoState, AppLoggerOutputMode loggerOutputMode
});


@override $DebugInfoEntityCopyWith<$Res> get debugInfoState;

}
/// @nodoc
class __$DevConsoleStateCopyWithImpl<$Res>
    implements _$DevConsoleStateCopyWith<$Res> {
  __$DevConsoleStateCopyWithImpl(this._self, this._then);

  final _DevConsoleState _self;
  final $Res Function(_DevConsoleState) _then;

/// Create a copy of DevConsoleState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? debugInfoState = null,Object? loggerOutputMode = null,}) {
  return _then(_DevConsoleState(
debugInfoState: null == debugInfoState ? _self.debugInfoState : debugInfoState // ignore: cast_nullable_to_non_nullable
as DebugInfoEntity,loggerOutputMode: null == loggerOutputMode ? _self.loggerOutputMode : loggerOutputMode // ignore: cast_nullable_to_non_nullable
as AppLoggerOutputMode,
  ));
}

/// Create a copy of DevConsoleState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DebugInfoEntityCopyWith<$Res> get debugInfoState {
  
  return $DebugInfoEntityCopyWith<$Res>(_self.debugInfoState, (value) {
    return _then(_self.copyWith(debugInfoState: value));
  });
}
}

// dart format on
