// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectModel _$ProjectModelFromJson(Map<String, dynamic> json) =>
    _ProjectModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      area: (json['area'] as num).toDouble(),
      floors: (json['floors'] as num).toInt(),
      bedrooms: (json['bedrooms'] as num).toInt(),
      bathrooms: (json['bathrooms'] as num).toInt(),
      price: (json['price'] as num).toInt(),
      imageUrl: json['imageUrl'] as String?,
      status: json['status'] as String?,
      objectId: json['objectId'] as String?,
    );

Map<String, dynamic> _$ProjectModelToJson(_ProjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'area': instance.area,
      'floors': instance.floors,
      'bedrooms': instance.bedrooms,
      'bathrooms': instance.bathrooms,
      'price': instance.price,
      'imageUrl': ?instance.imageUrl,
      'status': ?instance.status,
      'objectId': ?instance.objectId,
    };
