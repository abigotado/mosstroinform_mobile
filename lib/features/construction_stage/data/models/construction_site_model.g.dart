// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_site_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConstructionSiteModel _$ConstructionSiteModelFromJson(
  Map<String, dynamic> json,
) => _ConstructionSiteModel(
  id: json['id'] as String,
  projectId: json['projectId'] as String,
  projectName: json['projectName'] as String,
  address: json['address'] as String,
  camerasList:
      (json['cameras'] as List<dynamic>?)
          ?.map((e) => CameraModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  startDate: json['startDate'] == null
      ? null
      : DateTime.parse(json['startDate'] as String),
  expectedCompletionDate: json['expectedCompletionDate'] == null
      ? null
      : DateTime.parse(json['expectedCompletionDate'] as String),
  progress: (json['progress'] as num).toDouble(),
);

Map<String, dynamic> _$ConstructionSiteModelToJson(
  _ConstructionSiteModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'projectId': instance.projectId,
  'projectName': instance.projectName,
  'address': instance.address,
  'cameras': instance.camerasList.map((e) => e.toJson()).toList(),
  'startDate': ?instance.startDate?.toIso8601String(),
  'expectedCompletionDate': ?instance.expectedCompletionDate?.toIso8601String(),
  'progress': instance.progress,
};

_CameraModel _$CameraModelFromJson(Map<String, dynamic> json) => _CameraModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  streamUrl: json['streamUrl'] as String,
  isActive: json['isActive'] as bool,
  thumbnailUrl: json['thumbnailUrl'] as String?,
);

Map<String, dynamic> _$CameraModelToJson(_CameraModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'streamUrl': instance.streamUrl,
      'isActive': instance.isActive,
      'thumbnailUrl': ?instance.thumbnailUrl,
    };
