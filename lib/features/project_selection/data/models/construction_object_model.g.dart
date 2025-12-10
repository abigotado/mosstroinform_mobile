// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_object_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConstructionObjectModel _$ConstructionObjectModelFromJson(
  Map<String, dynamic> json,
) => _ConstructionObjectModel(
  id: _stringFromJson(json['id']),
  projectId: _stringFromJson(json['project_id']),
  name: _stringFromJson(json['name']),
  address: _stringFromJson(json['address']),
  description: _stringFromJson(json['description']),
  area: (json['area'] as num).toDouble(),
  floors: (json['floors'] as num).toInt(),
  bedrooms: (json['bedrooms'] as num).toInt(),
  bathrooms: (json['bathrooms'] as num).toInt(),
  price: (json['price'] as num).toInt(),
  imageUrl: json['image_url'] as String?,
  stages: _stagesFromJson(json['stages']),
  chatId: json['chat_id'] as String?,
  allDocumentsSigned: json['all_documents_signed'] as bool? ?? false,
  isCompleted: json['is_completed'] as bool? ?? false,
);

Map<String, dynamic> _$ConstructionObjectModelToJson(
  _ConstructionObjectModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'project_id': instance.projectId,
  'name': instance.name,
  'address': instance.address,
  'description': instance.description,
  'area': instance.area,
  'floors': instance.floors,
  'bedrooms': instance.bedrooms,
  'bathrooms': instance.bathrooms,
  'price': instance.price,
  'image_url': ?instance.imageUrl,
  'stages': instance.stages.map((e) => e.toJson()).toList(),
  'chat_id': ?instance.chatId,
  'all_documents_signed': instance.allDocumentsSigned,
  'is_completed': instance.isCompleted,
};

_ConstructionStageModel _$ConstructionStageModelFromJson(
  Map<String, dynamic> json,
) => _ConstructionStageModel(
  id: _stringFromJson(json['id']),
  name: _stringFromJson(json['name']),
  status: _stringFromJson(json['status']),
);

Map<String, dynamic> _$ConstructionStageModelToJson(
  _ConstructionStageModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': instance.status,
};
