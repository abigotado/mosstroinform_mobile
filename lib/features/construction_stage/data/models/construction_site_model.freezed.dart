// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'construction_site_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConstructionSiteModel {

 String get id; String get projectId; String get projectName; String get address;@JsonKey(name: 'cameras') List<CameraModel> get camerasList; DateTime? get startDate; DateTime? get expectedCompletionDate; double get progress;
/// Create a copy of ConstructionSiteModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConstructionSiteModelCopyWith<ConstructionSiteModel> get copyWith => _$ConstructionSiteModelCopyWithImpl<ConstructionSiteModel>(this as ConstructionSiteModel, _$identity);

  /// Serializes this ConstructionSiteModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConstructionSiteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.camerasList, camerasList)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.expectedCompletionDate, expectedCompletionDate) || other.expectedCompletionDate == expectedCompletionDate)&&(identical(other.progress, progress) || other.progress == progress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,projectId,projectName,address,const DeepCollectionEquality().hash(camerasList),startDate,expectedCompletionDate,progress);

@override
String toString() {
  return 'ConstructionSiteModel(id: $id, projectId: $projectId, projectName: $projectName, address: $address, camerasList: $camerasList, startDate: $startDate, expectedCompletionDate: $expectedCompletionDate, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $ConstructionSiteModelCopyWith<$Res>  {
  factory $ConstructionSiteModelCopyWith(ConstructionSiteModel value, $Res Function(ConstructionSiteModel) _then) = _$ConstructionSiteModelCopyWithImpl;
@useResult
$Res call({
 String id, String projectId, String projectName, String address,@JsonKey(name: 'cameras') List<CameraModel> camerasList, DateTime? startDate, DateTime? expectedCompletionDate, double progress
});




}
/// @nodoc
class _$ConstructionSiteModelCopyWithImpl<$Res>
    implements $ConstructionSiteModelCopyWith<$Res> {
  _$ConstructionSiteModelCopyWithImpl(this._self, this._then);

  final ConstructionSiteModel _self;
  final $Res Function(ConstructionSiteModel) _then;

/// Create a copy of ConstructionSiteModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? projectId = null,Object? projectName = null,Object? address = null,Object? camerasList = null,Object? startDate = freezed,Object? expectedCompletionDate = freezed,Object? progress = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,camerasList: null == camerasList ? _self.camerasList : camerasList // ignore: cast_nullable_to_non_nullable
as List<CameraModel>,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedCompletionDate: freezed == expectedCompletionDate ? _self.expectedCompletionDate : expectedCompletionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ConstructionSiteModel].
extension ConstructionSiteModelPatterns on ConstructionSiteModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConstructionSiteModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConstructionSiteModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConstructionSiteModel value)  $default,){
final _that = this;
switch (_that) {
case _ConstructionSiteModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConstructionSiteModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConstructionSiteModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String projectId,  String projectName,  String address, @JsonKey(name: 'cameras')  List<CameraModel> camerasList,  DateTime? startDate,  DateTime? expectedCompletionDate,  double progress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConstructionSiteModel() when $default != null:
return $default(_that.id,_that.projectId,_that.projectName,_that.address,_that.camerasList,_that.startDate,_that.expectedCompletionDate,_that.progress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String projectId,  String projectName,  String address, @JsonKey(name: 'cameras')  List<CameraModel> camerasList,  DateTime? startDate,  DateTime? expectedCompletionDate,  double progress)  $default,) {final _that = this;
switch (_that) {
case _ConstructionSiteModel():
return $default(_that.id,_that.projectId,_that.projectName,_that.address,_that.camerasList,_that.startDate,_that.expectedCompletionDate,_that.progress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String projectId,  String projectName,  String address, @JsonKey(name: 'cameras')  List<CameraModel> camerasList,  DateTime? startDate,  DateTime? expectedCompletionDate,  double progress)?  $default,) {final _that = this;
switch (_that) {
case _ConstructionSiteModel() when $default != null:
return $default(_that.id,_that.projectId,_that.projectName,_that.address,_that.camerasList,_that.startDate,_that.expectedCompletionDate,_that.progress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConstructionSiteModel implements ConstructionSiteModel {
  const _ConstructionSiteModel({required this.id, required this.projectId, required this.projectName, required this.address, @JsonKey(name: 'cameras') final  List<CameraModel> camerasList = const [], this.startDate, this.expectedCompletionDate, required this.progress}): _camerasList = camerasList;
  factory _ConstructionSiteModel.fromJson(Map<String, dynamic> json) => _$ConstructionSiteModelFromJson(json);

@override final  String id;
@override final  String projectId;
@override final  String projectName;
@override final  String address;
 final  List<CameraModel> _camerasList;
@override@JsonKey(name: 'cameras') List<CameraModel> get camerasList {
  if (_camerasList is EqualUnmodifiableListView) return _camerasList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_camerasList);
}

@override final  DateTime? startDate;
@override final  DateTime? expectedCompletionDate;
@override final  double progress;

/// Create a copy of ConstructionSiteModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConstructionSiteModelCopyWith<_ConstructionSiteModel> get copyWith => __$ConstructionSiteModelCopyWithImpl<_ConstructionSiteModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConstructionSiteModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConstructionSiteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.projectName, projectName) || other.projectName == projectName)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other._camerasList, _camerasList)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.expectedCompletionDate, expectedCompletionDate) || other.expectedCompletionDate == expectedCompletionDate)&&(identical(other.progress, progress) || other.progress == progress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,projectId,projectName,address,const DeepCollectionEquality().hash(_camerasList),startDate,expectedCompletionDate,progress);

@override
String toString() {
  return 'ConstructionSiteModel(id: $id, projectId: $projectId, projectName: $projectName, address: $address, camerasList: $camerasList, startDate: $startDate, expectedCompletionDate: $expectedCompletionDate, progress: $progress)';
}


}

/// @nodoc
abstract mixin class _$ConstructionSiteModelCopyWith<$Res> implements $ConstructionSiteModelCopyWith<$Res> {
  factory _$ConstructionSiteModelCopyWith(_ConstructionSiteModel value, $Res Function(_ConstructionSiteModel) _then) = __$ConstructionSiteModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String projectId, String projectName, String address,@JsonKey(name: 'cameras') List<CameraModel> camerasList, DateTime? startDate, DateTime? expectedCompletionDate, double progress
});




}
/// @nodoc
class __$ConstructionSiteModelCopyWithImpl<$Res>
    implements _$ConstructionSiteModelCopyWith<$Res> {
  __$ConstructionSiteModelCopyWithImpl(this._self, this._then);

  final _ConstructionSiteModel _self;
  final $Res Function(_ConstructionSiteModel) _then;

/// Create a copy of ConstructionSiteModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? projectId = null,Object? projectName = null,Object? address = null,Object? camerasList = null,Object? startDate = freezed,Object? expectedCompletionDate = freezed,Object? progress = null,}) {
  return _then(_ConstructionSiteModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,projectName: null == projectName ? _self.projectName : projectName // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,camerasList: null == camerasList ? _self._camerasList : camerasList // ignore: cast_nullable_to_non_nullable
as List<CameraModel>,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,expectedCompletionDate: freezed == expectedCompletionDate ? _self.expectedCompletionDate : expectedCompletionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CameraModel {

 String get id; String get name; String get description; String get streamUrl; bool get isActive; String? get thumbnailUrl;
/// Create a copy of CameraModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CameraModelCopyWith<CameraModel> get copyWith => _$CameraModelCopyWithImpl<CameraModel>(this as CameraModel, _$identity);

  /// Serializes this CameraModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CameraModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,streamUrl,isActive,thumbnailUrl);

@override
String toString() {
  return 'CameraModel(id: $id, name: $name, description: $description, streamUrl: $streamUrl, isActive: $isActive, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class $CameraModelCopyWith<$Res>  {
  factory $CameraModelCopyWith(CameraModel value, $Res Function(CameraModel) _then) = _$CameraModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String streamUrl, bool isActive, String? thumbnailUrl
});




}
/// @nodoc
class _$CameraModelCopyWithImpl<$Res>
    implements $CameraModelCopyWith<$Res> {
  _$CameraModelCopyWithImpl(this._self, this._then);

  final CameraModel _self;
  final $Res Function(CameraModel) _then;

/// Create a copy of CameraModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? streamUrl = null,Object? isActive = null,Object? thumbnailUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,streamUrl: null == streamUrl ? _self.streamUrl : streamUrl // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CameraModel].
extension CameraModelPatterns on CameraModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CameraModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CameraModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CameraModel value)  $default,){
final _that = this;
switch (_that) {
case _CameraModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CameraModel value)?  $default,){
final _that = this;
switch (_that) {
case _CameraModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String streamUrl,  bool isActive,  String? thumbnailUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CameraModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.streamUrl,_that.isActive,_that.thumbnailUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String streamUrl,  bool isActive,  String? thumbnailUrl)  $default,) {final _that = this;
switch (_that) {
case _CameraModel():
return $default(_that.id,_that.name,_that.description,_that.streamUrl,_that.isActive,_that.thumbnailUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String streamUrl,  bool isActive,  String? thumbnailUrl)?  $default,) {final _that = this;
switch (_that) {
case _CameraModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.streamUrl,_that.isActive,_that.thumbnailUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CameraModel implements CameraModel {
  const _CameraModel({required this.id, required this.name, required this.description, required this.streamUrl, required this.isActive, this.thumbnailUrl});
  factory _CameraModel.fromJson(Map<String, dynamic> json) => _$CameraModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String streamUrl;
@override final  bool isActive;
@override final  String? thumbnailUrl;

/// Create a copy of CameraModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CameraModelCopyWith<_CameraModel> get copyWith => __$CameraModelCopyWithImpl<_CameraModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CameraModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CameraModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.streamUrl, streamUrl) || other.streamUrl == streamUrl)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,streamUrl,isActive,thumbnailUrl);

@override
String toString() {
  return 'CameraModel(id: $id, name: $name, description: $description, streamUrl: $streamUrl, isActive: $isActive, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class _$CameraModelCopyWith<$Res> implements $CameraModelCopyWith<$Res> {
  factory _$CameraModelCopyWith(_CameraModel value, $Res Function(_CameraModel) _then) = __$CameraModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String streamUrl, bool isActive, String? thumbnailUrl
});




}
/// @nodoc
class __$CameraModelCopyWithImpl<$Res>
    implements _$CameraModelCopyWith<$Res> {
  __$CameraModelCopyWithImpl(this._self, this._then);

  final _CameraModel _self;
  final $Res Function(_CameraModel) _then;

/// Create a copy of CameraModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? streamUrl = null,Object? isActive = null,Object? thumbnailUrl = freezed,}) {
  return _then(_CameraModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,streamUrl: null == streamUrl ? _self.streamUrl : streamUrl // ignore: cast_nullable_to_non_nullable
as String,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,thumbnailUrl: freezed == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
