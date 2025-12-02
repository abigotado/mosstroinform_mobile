// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'final_document_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FinalDocumentModel {

 String get id; String get title; String get description; String? get fileUrl;@JsonKey(name: 'status') String get statusString; DateTime? get submittedAt; DateTime? get signedAt; String? get signatureUrl;
/// Create a copy of FinalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FinalDocumentModelCopyWith<FinalDocumentModel> get copyWith => _$FinalDocumentModelCopyWithImpl<FinalDocumentModel>(this as FinalDocumentModel, _$identity);

  /// Serializes this FinalDocumentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinalDocumentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.statusString, statusString) || other.statusString == statusString)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt)&&(identical(other.signatureUrl, signatureUrl) || other.signatureUrl == signatureUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,fileUrl,statusString,submittedAt,signedAt,signatureUrl);

@override
String toString() {
  return 'FinalDocumentModel(id: $id, title: $title, description: $description, fileUrl: $fileUrl, statusString: $statusString, submittedAt: $submittedAt, signedAt: $signedAt, signatureUrl: $signatureUrl)';
}


}

/// @nodoc
abstract mixin class $FinalDocumentModelCopyWith<$Res>  {
  factory $FinalDocumentModelCopyWith(FinalDocumentModel value, $Res Function(FinalDocumentModel) _then) = _$FinalDocumentModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String? fileUrl,@JsonKey(name: 'status') String statusString, DateTime? submittedAt, DateTime? signedAt, String? signatureUrl
});




}
/// @nodoc
class _$FinalDocumentModelCopyWithImpl<$Res>
    implements $FinalDocumentModelCopyWith<$Res> {
  _$FinalDocumentModelCopyWithImpl(this._self, this._then);

  final FinalDocumentModel _self;
  final $Res Function(FinalDocumentModel) _then;

/// Create a copy of FinalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? fileUrl = freezed,Object? statusString = null,Object? submittedAt = freezed,Object? signedAt = freezed,Object? signatureUrl = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,statusString: null == statusString ? _self.statusString : statusString // ignore: cast_nullable_to_non_nullable
as String,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,signedAt: freezed == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,signatureUrl: freezed == signatureUrl ? _self.signatureUrl : signatureUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FinalDocumentModel].
extension FinalDocumentModelPatterns on FinalDocumentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FinalDocumentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FinalDocumentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FinalDocumentModel value)  $default,){
final _that = this;
switch (_that) {
case _FinalDocumentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FinalDocumentModel value)?  $default,){
final _that = this;
switch (_that) {
case _FinalDocumentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String? fileUrl, @JsonKey(name: 'status')  String statusString,  DateTime? submittedAt,  DateTime? signedAt,  String? signatureUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FinalDocumentModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.fileUrl,_that.statusString,_that.submittedAt,_that.signedAt,_that.signatureUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String? fileUrl, @JsonKey(name: 'status')  String statusString,  DateTime? submittedAt,  DateTime? signedAt,  String? signatureUrl)  $default,) {final _that = this;
switch (_that) {
case _FinalDocumentModel():
return $default(_that.id,_that.title,_that.description,_that.fileUrl,_that.statusString,_that.submittedAt,_that.signedAt,_that.signatureUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String? fileUrl, @JsonKey(name: 'status')  String statusString,  DateTime? submittedAt,  DateTime? signedAt,  String? signatureUrl)?  $default,) {final _that = this;
switch (_that) {
case _FinalDocumentModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.fileUrl,_that.statusString,_that.submittedAt,_that.signedAt,_that.signatureUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FinalDocumentModel implements FinalDocumentModel {
  const _FinalDocumentModel({required this.id, required this.title, required this.description, this.fileUrl, @JsonKey(name: 'status') this.statusString = 'pending', this.submittedAt, this.signedAt, this.signatureUrl});
  factory _FinalDocumentModel.fromJson(Map<String, dynamic> json) => _$FinalDocumentModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String? fileUrl;
@override@JsonKey(name: 'status') final  String statusString;
@override final  DateTime? submittedAt;
@override final  DateTime? signedAt;
@override final  String? signatureUrl;

/// Create a copy of FinalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FinalDocumentModelCopyWith<_FinalDocumentModel> get copyWith => __$FinalDocumentModelCopyWithImpl<_FinalDocumentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FinalDocumentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FinalDocumentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.statusString, statusString) || other.statusString == statusString)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt)&&(identical(other.signedAt, signedAt) || other.signedAt == signedAt)&&(identical(other.signatureUrl, signatureUrl) || other.signatureUrl == signatureUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,fileUrl,statusString,submittedAt,signedAt,signatureUrl);

@override
String toString() {
  return 'FinalDocumentModel(id: $id, title: $title, description: $description, fileUrl: $fileUrl, statusString: $statusString, submittedAt: $submittedAt, signedAt: $signedAt, signatureUrl: $signatureUrl)';
}


}

/// @nodoc
abstract mixin class _$FinalDocumentModelCopyWith<$Res> implements $FinalDocumentModelCopyWith<$Res> {
  factory _$FinalDocumentModelCopyWith(_FinalDocumentModel value, $Res Function(_FinalDocumentModel) _then) = __$FinalDocumentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String? fileUrl,@JsonKey(name: 'status') String statusString, DateTime? submittedAt, DateTime? signedAt, String? signatureUrl
});




}
/// @nodoc
class __$FinalDocumentModelCopyWithImpl<$Res>
    implements _$FinalDocumentModelCopyWith<$Res> {
  __$FinalDocumentModelCopyWithImpl(this._self, this._then);

  final _FinalDocumentModel _self;
  final $Res Function(_FinalDocumentModel) _then;

/// Create a copy of FinalDocumentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? fileUrl = freezed,Object? statusString = null,Object? submittedAt = freezed,Object? signedAt = freezed,Object? signatureUrl = freezed,}) {
  return _then(_FinalDocumentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,statusString: null == statusString ? _self.statusString : statusString // ignore: cast_nullable_to_non_nullable
as String,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,signedAt: freezed == signedAt ? _self.signedAt : signedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,signatureUrl: freezed == signatureUrl ? _self.signatureUrl : signatureUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
