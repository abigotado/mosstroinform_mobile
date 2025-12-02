// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) =>
    _ProjectModel(
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

Map<String, dynamic> _$ProjectModelToJson(_ProjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'description': instance.description,
      'area': instance.area,
      'floors': instance.floors,
      'price': instance.price,
      'imageUrl': ?instance.imageUrl,
      'stages': instance.stages.map((e) => e.toJson()).toList(),
    };

_ConstructionStageModel _$ConstructionStageModelFromJson(
  Map<String, dynamic> json,
) => _ConstructionStageModel(
  id: json['id'] as String,
  name: json['name'] as String,
  status: json['status'] as String,
);

Map<String, dynamic> _$ConstructionStageModelToJson(
  _ConstructionStageModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': instance.status,
};
