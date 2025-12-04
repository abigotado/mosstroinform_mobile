// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'debug_info_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DebugInfoEntity {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugInfoEntity);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DebugInfoEntity()';
}


}

/// @nodoc
class $DebugInfoEntityCopyWith<$Res>  {
$DebugInfoEntityCopyWith(DebugInfoEntity _, $Res Function(DebugInfoEntity) __);
}


/// Adds pattern-matching-related methods to [DebugInfoEntity].
extension DebugInfoEntityPatterns on DebugInfoEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DebugInfoEntityData value)?  data,TResult Function( DebugInfoEntityLoading value)?  loading,TResult Function( DebugInfoEntityError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DebugInfoEntityData() when data != null:
return data(_that);case DebugInfoEntityLoading() when loading != null:
return loading(_that);case DebugInfoEntityError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DebugInfoEntityData value)  data,required TResult Function( DebugInfoEntityLoading value)  loading,required TResult Function( DebugInfoEntityError value)  error,}){
final _that = this;
switch (_that) {
case DebugInfoEntityData():
return data(_that);case DebugInfoEntityLoading():
return loading(_that);case DebugInfoEntityError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DebugInfoEntityData value)?  data,TResult? Function( DebugInfoEntityLoading value)?  loading,TResult? Function( DebugInfoEntityError value)?  error,}){
final _that = this;
switch (_that) {
case DebugInfoEntityData() when data != null:
return data(_that);case DebugInfoEntityLoading() when loading != null:
return loading(_that);case DebugInfoEntityError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String appVersion,  String appBuildNumber,  String flavor,  String? deviceModel,  String deviceOS)?  data,TResult Function()?  loading,TResult Function( String errorMessage)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DebugInfoEntityData() when data != null:
return data(_that.appVersion,_that.appBuildNumber,_that.flavor,_that.deviceModel,_that.deviceOS);case DebugInfoEntityLoading() when loading != null:
return loading();case DebugInfoEntityError() when error != null:
return error(_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String appVersion,  String appBuildNumber,  String flavor,  String? deviceModel,  String deviceOS)  data,required TResult Function()  loading,required TResult Function( String errorMessage)  error,}) {final _that = this;
switch (_that) {
case DebugInfoEntityData():
return data(_that.appVersion,_that.appBuildNumber,_that.flavor,_that.deviceModel,_that.deviceOS);case DebugInfoEntityLoading():
return loading();case DebugInfoEntityError():
return error(_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String appVersion,  String appBuildNumber,  String flavor,  String? deviceModel,  String deviceOS)?  data,TResult? Function()?  loading,TResult? Function( String errorMessage)?  error,}) {final _that = this;
switch (_that) {
case DebugInfoEntityData() when data != null:
return data(_that.appVersion,_that.appBuildNumber,_that.flavor,_that.deviceModel,_that.deviceOS);case DebugInfoEntityLoading() when loading != null:
return loading();case DebugInfoEntityError() when error != null:
return error(_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class DebugInfoEntityData extends DebugInfoEntity {
  const DebugInfoEntityData({required this.appVersion, required this.appBuildNumber, required this.flavor, required this.deviceModel, required this.deviceOS}): super._();
  

 final  String appVersion;
 final  String appBuildNumber;
 final  String flavor;
 final  String? deviceModel;
 final  String deviceOS;

/// Create a copy of DebugInfoEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebugInfoEntityDataCopyWith<DebugInfoEntityData> get copyWith => _$DebugInfoEntityDataCopyWithImpl<DebugInfoEntityData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugInfoEntityData&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.appBuildNumber, appBuildNumber) || other.appBuildNumber == appBuildNumber)&&(identical(other.flavor, flavor) || other.flavor == flavor)&&(identical(other.deviceModel, deviceModel) || other.deviceModel == deviceModel)&&(identical(other.deviceOS, deviceOS) || other.deviceOS == deviceOS));
}


@override
int get hashCode => Object.hash(runtimeType,appVersion,appBuildNumber,flavor,deviceModel,deviceOS);

@override
String toString() {
  return 'DebugInfoEntity.data(appVersion: $appVersion, appBuildNumber: $appBuildNumber, flavor: $flavor, deviceModel: $deviceModel, deviceOS: $deviceOS)';
}


}

/// @nodoc
abstract mixin class $DebugInfoEntityDataCopyWith<$Res> implements $DebugInfoEntityCopyWith<$Res> {
  factory $DebugInfoEntityDataCopyWith(DebugInfoEntityData value, $Res Function(DebugInfoEntityData) _then) = _$DebugInfoEntityDataCopyWithImpl;
@useResult
$Res call({
 String appVersion, String appBuildNumber, String flavor, String? deviceModel, String deviceOS
});




}
/// @nodoc
class _$DebugInfoEntityDataCopyWithImpl<$Res>
    implements $DebugInfoEntityDataCopyWith<$Res> {
  _$DebugInfoEntityDataCopyWithImpl(this._self, this._then);

  final DebugInfoEntityData _self;
  final $Res Function(DebugInfoEntityData) _then;

/// Create a copy of DebugInfoEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? appVersion = null,Object? appBuildNumber = null,Object? flavor = null,Object? deviceModel = freezed,Object? deviceOS = null,}) {
  return _then(DebugInfoEntityData(
appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,appBuildNumber: null == appBuildNumber ? _self.appBuildNumber : appBuildNumber // ignore: cast_nullable_to_non_nullable
as String,flavor: null == flavor ? _self.flavor : flavor // ignore: cast_nullable_to_non_nullable
as String,deviceModel: freezed == deviceModel ? _self.deviceModel : deviceModel // ignore: cast_nullable_to_non_nullable
as String?,deviceOS: null == deviceOS ? _self.deviceOS : deviceOS // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DebugInfoEntityLoading extends DebugInfoEntity {
  const DebugInfoEntityLoading(): super._();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugInfoEntityLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DebugInfoEntity.loading()';
}


}




/// @nodoc


class DebugInfoEntityError extends DebugInfoEntity {
  const DebugInfoEntityError(this.errorMessage): super._();
  

 final  String errorMessage;

/// Create a copy of DebugInfoEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DebugInfoEntityErrorCopyWith<DebugInfoEntityError> get copyWith => _$DebugInfoEntityErrorCopyWithImpl<DebugInfoEntityError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DebugInfoEntityError&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,errorMessage);

@override
String toString() {
  return 'DebugInfoEntity.error(errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $DebugInfoEntityErrorCopyWith<$Res> implements $DebugInfoEntityCopyWith<$Res> {
  factory $DebugInfoEntityErrorCopyWith(DebugInfoEntityError value, $Res Function(DebugInfoEntityError) _then) = _$DebugInfoEntityErrorCopyWithImpl;
@useResult
$Res call({
 String errorMessage
});




}
/// @nodoc
class _$DebugInfoEntityErrorCopyWithImpl<$Res>
    implements $DebugInfoEntityErrorCopyWith<$Res> {
  _$DebugInfoEntityErrorCopyWithImpl(this._self, this._then);

  final DebugInfoEntityError _self;
  final $Res Function(DebugInfoEntityError) _then;

/// Create a copy of DebugInfoEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorMessage = null,}) {
  return _then(DebugInfoEntityError(
null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
