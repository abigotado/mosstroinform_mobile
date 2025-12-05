// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_object_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConstructionObjectModel _$ConstructionObjectModelFromJson(
  Map<String, dynamic> json,
) => _ConstructionObjectModel(
  id: json['id'] as String,
  projectId: json['projectId'] as String,
  name: json['name'] as String,
  address: json['address'] as String,
  description: json['description'] as String,
  area: (json['area'] as num).toDouble(),
  floors: (json['floors'] as num).toInt(),
  bedrooms: (json['bedrooms'] as num).toInt(),
  bathrooms: (json['bathrooms'] as num).toInt(),
  price: (json['price'] as num).toInt(),
  imageUrl: json['imageUrl'] as String?,
  stages: (json['stages'] as List<dynamic>)
      .map((e) => ConstructionStageModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  chatId: json['chatId'] as String?,
  allDocumentsSigned: json['allDocumentsSigned'] as bool? ?? false,
  isCompleted: json['isCompleted'] as bool? ?? false,
);

Map<String, dynamic> _$ConstructionObjectModelToJson(
  _ConstructionObjectModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'projectId': instance.projectId,
  'name': instance.name,
  'address': instance.address,
  'description': instance.description,
  'area': instance.area,
  'floors': instance.floors,
  'bedrooms': instance.bedrooms,
  'bathrooms': instance.bathrooms,
  'price': instance.price,
  'imageUrl': ?instance.imageUrl,
  'stages': instance.stages.map((e) => e.toJson()).toList(),
  'chatId': ?instance.chatId,
  'allDocumentsSigned': instance.allDocumentsSigned,
  'isCompleted': instance.isCompleted,
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
