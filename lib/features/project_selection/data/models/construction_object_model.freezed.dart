// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'construction_object_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConstructionObjectModel {

 String get id; String get projectId; String get name; String get address; String get description; double get area; int get floors; int get bedrooms; int get bathrooms; int get price; String? get imageUrl; List<ConstructionStageModel> get stages; String? get chatId; bool get allDocumentsSigned; bool get isCompleted;
/// Create a copy of ConstructionObjectModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConstructionObjectModelCopyWith<ConstructionObjectModel> get copyWith => _$ConstructionObjectModelCopyWithImpl<ConstructionObjectModel>(this as ConstructionObjectModel, _$identity);

  /// Serializes this ConstructionObjectModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConstructionObjectModel&&(identical(other.id, id) || other.id == id)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.area, area) || other.area == area)&&(identical(other.floors, floors) || other.floors == floors)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.bathrooms, bathrooms) || other.bathrooms == bathrooms)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other.stages, stages)&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.allDocumentsSigned, allDocumentsSigned) || other.allDocumentsSigned == allDocumentsSigned)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,projectId,name,address,description,area,floors,bedrooms,bathrooms,price,imageUrl,const DeepCollectionEquality().hash(stages),chatId,allDocumentsSigned,isCompleted);

@override
String toString() {
  return 'ConstructionObjectModel(id: $id, projectId: $projectId, name: $name, address: $address, description: $description, area: $area, floors: $floors, bedrooms: $bedrooms, bathrooms: $bathrooms, price: $price, imageUrl: $imageUrl, stages: $stages, chatId: $chatId, allDocumentsSigned: $allDocumentsSigned, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class $ConstructionObjectModelCopyWith<$Res>  {
  factory $ConstructionObjectModelCopyWith(ConstructionObjectModel value, $Res Function(ConstructionObjectModel) _then) = _$ConstructionObjectModelCopyWithImpl;
@useResult
$Res call({
 String id, String projectId, String name, String address, String description, double area, int floors, int bedrooms, int bathrooms, int price, String? imageUrl, List<ConstructionStageModel> stages, String? chatId, bool allDocumentsSigned, bool isCompleted
});




}
/// @nodoc
class _$ConstructionObjectModelCopyWithImpl<$Res>
    implements $ConstructionObjectModelCopyWith<$Res> {
  _$ConstructionObjectModelCopyWithImpl(this._self, this._then);

  final ConstructionObjectModel _self;
  final $Res Function(ConstructionObjectModel) _then;

/// Create a copy of ConstructionObjectModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? projectId = null,Object? name = null,Object? address = null,Object? description = null,Object? area = null,Object? floors = null,Object? bedrooms = null,Object? bathrooms = null,Object? price = null,Object? imageUrl = freezed,Object? stages = null,Object? chatId = freezed,Object? allDocumentsSigned = null,Object? isCompleted = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as double,floors: null == floors ? _self.floors : floors // ignore: cast_nullable_to_non_nullable
as int,bedrooms: null == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int,bathrooms: null == bathrooms ? _self.bathrooms : bathrooms // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,stages: null == stages ? _self.stages : stages // ignore: cast_nullable_to_non_nullable
as List<ConstructionStageModel>,chatId: freezed == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String?,allDocumentsSigned: null == allDocumentsSigned ? _self.allDocumentsSigned : allDocumentsSigned // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ConstructionObjectModel].
extension ConstructionObjectModelPatterns on ConstructionObjectModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConstructionObjectModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConstructionObjectModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConstructionObjectModel value)  $default,){
final _that = this;
switch (_that) {
case _ConstructionObjectModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConstructionObjectModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConstructionObjectModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String projectId,  String name,  String address,  String description,  double area,  int floors,  int bedrooms,  int bathrooms,  int price,  String? imageUrl,  List<ConstructionStageModel> stages,  String? chatId,  bool allDocumentsSigned,  bool isCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConstructionObjectModel() when $default != null:
return $default(_that.id,_that.projectId,_that.name,_that.address,_that.description,_that.area,_that.floors,_that.bedrooms,_that.bathrooms,_that.price,_that.imageUrl,_that.stages,_that.chatId,_that.allDocumentsSigned,_that.isCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String projectId,  String name,  String address,  String description,  double area,  int floors,  int bedrooms,  int bathrooms,  int price,  String? imageUrl,  List<ConstructionStageModel> stages,  String? chatId,  bool allDocumentsSigned,  bool isCompleted)  $default,) {final _that = this;
switch (_that) {
case _ConstructionObjectModel():
return $default(_that.id,_that.projectId,_that.name,_that.address,_that.description,_that.area,_that.floors,_that.bedrooms,_that.bathrooms,_that.price,_that.imageUrl,_that.stages,_that.chatId,_that.allDocumentsSigned,_that.isCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String projectId,  String name,  String address,  String description,  double area,  int floors,  int bedrooms,  int bathrooms,  int price,  String? imageUrl,  List<ConstructionStageModel> stages,  String? chatId,  bool allDocumentsSigned,  bool isCompleted)?  $default,) {final _that = this;
switch (_that) {
case _ConstructionObjectModel() when $default != null:
return $default(_that.id,_that.projectId,_that.name,_that.address,_that.description,_that.area,_that.floors,_that.bedrooms,_that.bathrooms,_that.price,_that.imageUrl,_that.stages,_that.chatId,_that.allDocumentsSigned,_that.isCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConstructionObjectModel implements ConstructionObjectModel {
  const _ConstructionObjectModel({required this.id, required this.projectId, required this.name, required this.address, required this.description, required this.area, required this.floors, required this.bedrooms, required this.bathrooms, required this.price, this.imageUrl, required final  List<ConstructionStageModel> stages, this.chatId, this.allDocumentsSigned = false, this.isCompleted = false}): _stages = stages;
  factory _ConstructionObjectModel.fromJson(Map<String, dynamic> json) => _$ConstructionObjectModelFromJson(json);

@override final  String id;
@override final  String projectId;
@override final  String name;
@override final  String address;
@override final  String description;
@override final  double area;
@override final  int floors;
@override final  int bedrooms;
@override final  int bathrooms;
@override final  int price;
@override final  String? imageUrl;
 final  List<ConstructionStageModel> _stages;
@override List<ConstructionStageModel> get stages {
  if (_stages is EqualUnmodifiableListView) return _stages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stages);
}

@override final  String? chatId;
@override@JsonKey() final  bool allDocumentsSigned;
@override@JsonKey() final  bool isCompleted;

/// Create a copy of ConstructionObjectModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConstructionObjectModelCopyWith<_ConstructionObjectModel> get copyWith => __$ConstructionObjectModelCopyWithImpl<_ConstructionObjectModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConstructionObjectModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConstructionObjectModel&&(identical(other.id, id) || other.id == id)&&(identical(other.projectId, projectId) || other.projectId == projectId)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.description, description) || other.description == description)&&(identical(other.area, area) || other.area == area)&&(identical(other.floors, floors) || other.floors == floors)&&(identical(other.bedrooms, bedrooms) || other.bedrooms == bedrooms)&&(identical(other.bathrooms, bathrooms) || other.bathrooms == bathrooms)&&(identical(other.price, price) || other.price == price)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&const DeepCollectionEquality().equals(other._stages, _stages)&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.allDocumentsSigned, allDocumentsSigned) || other.allDocumentsSigned == allDocumentsSigned)&&(identical(other.isCompleted, isCompleted) || other.isCompleted == isCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,projectId,name,address,description,area,floors,bedrooms,bathrooms,price,imageUrl,const DeepCollectionEquality().hash(_stages),chatId,allDocumentsSigned,isCompleted);

@override
String toString() {
  return 'ConstructionObjectModel(id: $id, projectId: $projectId, name: $name, address: $address, description: $description, area: $area, floors: $floors, bedrooms: $bedrooms, bathrooms: $bathrooms, price: $price, imageUrl: $imageUrl, stages: $stages, chatId: $chatId, allDocumentsSigned: $allDocumentsSigned, isCompleted: $isCompleted)';
}


}

/// @nodoc
abstract mixin class _$ConstructionObjectModelCopyWith<$Res> implements $ConstructionObjectModelCopyWith<$Res> {
  factory _$ConstructionObjectModelCopyWith(_ConstructionObjectModel value, $Res Function(_ConstructionObjectModel) _then) = __$ConstructionObjectModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String projectId, String name, String address, String description, double area, int floors, int bedrooms, int bathrooms, int price, String? imageUrl, List<ConstructionStageModel> stages, String? chatId, bool allDocumentsSigned, bool isCompleted
});




}
/// @nodoc
class __$ConstructionObjectModelCopyWithImpl<$Res>
    implements _$ConstructionObjectModelCopyWith<$Res> {
  __$ConstructionObjectModelCopyWithImpl(this._self, this._then);

  final _ConstructionObjectModel _self;
  final $Res Function(_ConstructionObjectModel) _then;

/// Create a copy of ConstructionObjectModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? projectId = null,Object? name = null,Object? address = null,Object? description = null,Object? area = null,Object? floors = null,Object? bedrooms = null,Object? bathrooms = null,Object? price = null,Object? imageUrl = freezed,Object? stages = null,Object? chatId = freezed,Object? allDocumentsSigned = null,Object? isCompleted = null,}) {
  return _then(_ConstructionObjectModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,projectId: null == projectId ? _self.projectId : projectId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as double,floors: null == floors ? _self.floors : floors // ignore: cast_nullable_to_non_nullable
as int,bedrooms: null == bedrooms ? _self.bedrooms : bedrooms // ignore: cast_nullable_to_non_nullable
as int,bathrooms: null == bathrooms ? _self.bathrooms : bathrooms // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,stages: null == stages ? _self._stages : stages // ignore: cast_nullable_to_non_nullable
as List<ConstructionStageModel>,chatId: freezed == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String?,allDocumentsSigned: null == allDocumentsSigned ? _self.allDocumentsSigned : allDocumentsSigned // ignore: cast_nullable_to_non_nullable
as bool,isCompleted: null == isCompleted ? _self.isCompleted : isCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$ConstructionStageModel {

 String get id; String get name; String get status;
/// Create a copy of ConstructionStageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConstructionStageModelCopyWith<ConstructionStageModel> get copyWith => _$ConstructionStageModelCopyWithImpl<ConstructionStageModel>(this as ConstructionStageModel, _$identity);

  /// Serializes this ConstructionStageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConstructionStageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status);

@override
String toString() {
  return 'ConstructionStageModel(id: $id, name: $name, status: $status)';
}


}

/// @nodoc
abstract mixin class $ConstructionStageModelCopyWith<$Res>  {
  factory $ConstructionStageModelCopyWith(ConstructionStageModel value, $Res Function(ConstructionStageModel) _then) = _$ConstructionStageModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String status
});




}
/// @nodoc
class _$ConstructionStageModelCopyWithImpl<$Res>
    implements $ConstructionStageModelCopyWith<$Res> {
  _$ConstructionStageModelCopyWithImpl(this._self, this._then);

  final ConstructionStageModel _self;
  final $Res Function(ConstructionStageModel) _then;

/// Create a copy of ConstructionStageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ConstructionStageModel].
extension ConstructionStageModelPatterns on ConstructionStageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConstructionStageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConstructionStageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConstructionStageModel value)  $default,){
final _that = this;
switch (_that) {
case _ConstructionStageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConstructionStageModel value)?  $default,){
final _that = this;
switch (_that) {
case _ConstructionStageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConstructionStageModel() when $default != null:
return $default(_that.id,_that.name,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String status)  $default,) {final _that = this;
switch (_that) {
case _ConstructionStageModel():
return $default(_that.id,_that.name,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String status)?  $default,) {final _that = this;
switch (_that) {
case _ConstructionStageModel() when $default != null:
return $default(_that.id,_that.name,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConstructionStageModel implements ConstructionStageModel {
  const _ConstructionStageModel({required this.id, required this.name, required this.status});
  factory _ConstructionStageModel.fromJson(Map<String, dynamic> json) => _$ConstructionStageModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String status;

/// Create a copy of ConstructionStageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConstructionStageModelCopyWith<_ConstructionStageModel> get copyWith => __$ConstructionStageModelCopyWithImpl<_ConstructionStageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConstructionStageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConstructionStageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,status);

@override
String toString() {
  return 'ConstructionStageModel(id: $id, name: $name, status: $status)';
}


}

/// @nodoc
abstract mixin class _$ConstructionStageModelCopyWith<$Res> implements $ConstructionStageModelCopyWith<$Res> {
  factory _$ConstructionStageModelCopyWith(_ConstructionStageModel value, $Res Function(_ConstructionStageModel) _then) = __$ConstructionStageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String status
});




}
/// @nodoc
class __$ConstructionStageModelCopyWithImpl<$Res>
    implements _$ConstructionStageModelCopyWith<$Res> {
  __$ConstructionStageModelCopyWithImpl(this._self, this._then);

  final _ConstructionStageModel _self;
  final $Res Function(_ConstructionStageModel) _then;

/// Create a copy of ConstructionStageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? status = null,}) {
  return _then(_ConstructionStageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
