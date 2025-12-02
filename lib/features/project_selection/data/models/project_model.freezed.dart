// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) {
  return _ProjectModel.fromJson(json);
}

/// @nodoc
mixin _$ProjectModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  double get area => throw _privateConstructorUsedError;
  int get floors => throw _privateConstructorUsedError;
  int get price => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  List<ConstructionStageModel> get stages => throw _privateConstructorUsedError;

  /// Serializes this ProjectModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProjectModelCopyWith<ProjectModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectModelCopyWith<$Res> {
  factory $ProjectModelCopyWith(
    ProjectModel value,
    $Res Function(ProjectModel) then,
  ) = _$ProjectModelCopyWithImpl<$Res, ProjectModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String address,
    String description,
    double area,
    int floors,
    int price,
    String? imageUrl,
    List<ConstructionStageModel> stages,
  });
}

/// @nodoc
class _$ProjectModelCopyWithImpl<$Res, $Val extends ProjectModel>
    implements $ProjectModelCopyWith<$Res> {
  _$ProjectModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? description = null,
    Object? area = null,
    Object? floors = null,
    Object? price = null,
    Object? imageUrl = freezed,
    Object? stages = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            address: null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            area: null == area
                ? _value.area
                : area // ignore: cast_nullable_to_non_nullable
                      as double,
            floors: null == floors
                ? _value.floors
                : floors // ignore: cast_nullable_to_non_nullable
                      as int,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            stages: null == stages
                ? _value.stages
                : stages // ignore: cast_nullable_to_non_nullable
                      as List<ConstructionStageModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProjectModelImplCopyWith<$Res>
    implements $ProjectModelCopyWith<$Res> {
  factory _$$ProjectModelImplCopyWith(
    _$ProjectModelImpl value,
    $Res Function(_$ProjectModelImpl) then,
  ) = __$$ProjectModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String address,
    String description,
    double area,
    int floors,
    int price,
    String? imageUrl,
    List<ConstructionStageModel> stages,
  });
}

/// @nodoc
class __$$ProjectModelImplCopyWithImpl<$Res>
    extends _$ProjectModelCopyWithImpl<$Res, _$ProjectModelImpl>
    implements _$$ProjectModelImplCopyWith<$Res> {
  __$$ProjectModelImplCopyWithImpl(
    _$ProjectModelImpl _value,
    $Res Function(_$ProjectModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? address = null,
    Object? description = null,
    Object? area = null,
    Object? floors = null,
    Object? price = null,
    Object? imageUrl = freezed,
    Object? stages = null,
  }) {
    return _then(
      _$ProjectModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        address: null == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        area: null == area
            ? _value.area
            : area // ignore: cast_nullable_to_non_nullable
                  as double,
        floors: null == floors
            ? _value.floors
            : floors // ignore: cast_nullable_to_non_nullable
                  as int,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        stages: null == stages
            ? _value._stages
            : stages // ignore: cast_nullable_to_non_nullable
                  as List<ConstructionStageModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProjectModelImpl implements _ProjectModel {
  const _$ProjectModelImpl({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.area,
    required this.floors,
    required this.price,
    this.imageUrl,
    required final List<ConstructionStageModel> stages,
  }) : _stages = stages;

  factory _$ProjectModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProjectModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String address;
  @override
  final String description;
  @override
  final double area;
  @override
  final int floors;
  @override
  final int price;
  @override
  final String? imageUrl;
  final List<ConstructionStageModel> _stages;
  @override
  List<ConstructionStageModel> get stages {
    if (_stages is EqualUnmodifiableListView) return _stages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stages);
  }

  @override
  String toString() {
    return 'ProjectModel(id: $id, name: $name, address: $address, description: $description, area: $area, floors: $floors, price: $price, imageUrl: $imageUrl, stages: $stages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProjectModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.area, area) || other.area == area) &&
            (identical(other.floors, floors) || other.floors == floors) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._stages, _stages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    address,
    description,
    area,
    floors,
    price,
    imageUrl,
    const DeepCollectionEquality().hash(_stages),
  );

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProjectModelImplCopyWith<_$ProjectModelImpl> get copyWith =>
      __$$ProjectModelImplCopyWithImpl<_$ProjectModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProjectModelImplToJson(this);
  }
}

abstract class _ProjectModel implements ProjectModel {
  const factory _ProjectModel({
    required final String id,
    required final String name,
    required final String address,
    required final String description,
    required final double area,
    required final int floors,
    required final int price,
    final String? imageUrl,
    required final List<ConstructionStageModel> stages,
  }) = _$ProjectModelImpl;

  factory _ProjectModel.fromJson(Map<String, dynamic> json) =
      _$ProjectModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get address;
  @override
  String get description;
  @override
  double get area;
  @override
  int get floors;
  @override
  int get price;
  @override
  String? get imageUrl;
  @override
  List<ConstructionStageModel> get stages;

  /// Create a copy of ProjectModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProjectModelImplCopyWith<_$ProjectModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConstructionStageModel _$ConstructionStageModelFromJson(
  Map<String, dynamic> json,
) {
  return _ConstructionStageModel.fromJson(json);
}

/// @nodoc
mixin _$ConstructionStageModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;

  /// Serializes this ConstructionStageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConstructionStageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConstructionStageModelCopyWith<ConstructionStageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConstructionStageModelCopyWith<$Res> {
  factory $ConstructionStageModelCopyWith(
    ConstructionStageModel value,
    $Res Function(ConstructionStageModel) then,
  ) = _$ConstructionStageModelCopyWithImpl<$Res, ConstructionStageModel>;
  @useResult
  $Res call({String id, String name, String status});
}

/// @nodoc
class _$ConstructionStageModelCopyWithImpl<
  $Res,
  $Val extends ConstructionStageModel
>
    implements $ConstructionStageModelCopyWith<$Res> {
  _$ConstructionStageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConstructionStageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? status = null}) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConstructionStageModelImplCopyWith<$Res>
    implements $ConstructionStageModelCopyWith<$Res> {
  factory _$$ConstructionStageModelImplCopyWith(
    _$ConstructionStageModelImpl value,
    $Res Function(_$ConstructionStageModelImpl) then,
  ) = __$$ConstructionStageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String status});
}

/// @nodoc
class __$$ConstructionStageModelImplCopyWithImpl<$Res>
    extends
        _$ConstructionStageModelCopyWithImpl<$Res, _$ConstructionStageModelImpl>
    implements _$$ConstructionStageModelImplCopyWith<$Res> {
  __$$ConstructionStageModelImplCopyWithImpl(
    _$ConstructionStageModelImpl _value,
    $Res Function(_$ConstructionStageModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConstructionStageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null, Object? status = null}) {
    return _then(
      _$ConstructionStageModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConstructionStageModelImpl implements _ConstructionStageModel {
  const _$ConstructionStageModelImpl({
    required this.id,
    required this.name,
    required this.status,
  });

  factory _$ConstructionStageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConstructionStageModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String status;

  @override
  String toString() {
    return 'ConstructionStageModel(id: $id, name: $name, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConstructionStageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, status);

  /// Create a copy of ConstructionStageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConstructionStageModelImplCopyWith<_$ConstructionStageModelImpl>
  get copyWith =>
      __$$ConstructionStageModelImplCopyWithImpl<_$ConstructionStageModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConstructionStageModelImplToJson(this);
  }
}

abstract class _ConstructionStageModel implements ConstructionStageModel {
  const factory _ConstructionStageModel({
    required final String id,
    required final String name,
    required final String status,
  }) = _$ConstructionStageModelImpl;

  factory _ConstructionStageModel.fromJson(Map<String, dynamic> json) =
      _$ConstructionStageModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get status;

  /// Create a copy of ConstructionStageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConstructionStageModelImplCopyWith<_$ConstructionStageModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
