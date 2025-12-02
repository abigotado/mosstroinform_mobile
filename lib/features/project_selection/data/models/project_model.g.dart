// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectModelImpl _$$ProjectModelImplFromJson(Map<String, dynamic> json) =>
    _$ProjectModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
      area: (json['area'] as num).toDouble(),
      floors: (json['floors'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
      stages: (json['stages'] as List<dynamic>)
          .map(
            (e) => ConstructionStageModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$$ProjectModelImplToJson(_$ProjectModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'area': instance.area,
      'floors': instance.floors,
      'price': instance.price,
      'imageUrl': instance.imageUrl,
      'stages': instance.stages,
    };

_$ConstructionStageModelImpl _$$ConstructionStageModelImplFromJson(
  Map<String, dynamic> json,
) => _$ConstructionStageModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$$ConstructionStageModelImplToJson(
  _$ConstructionStageModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': instance.status,
};
