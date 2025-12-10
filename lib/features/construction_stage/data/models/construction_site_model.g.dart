// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_site_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ConstructionSiteModel _$ConstructionSiteModelFromJson(
  Map<String, dynamic> json,
) => _ConstructionSiteModel(
  id: json['id'] as String,
  projectId: json['project_id'] as String,
  projectName: json['project_name'] as String,
  address: json['address'] as String,
  camerasList:
      (json['cameras'] as List<dynamic>?)
          ?.map((e) => CameraModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  startDate: json['start_date'] == null
      ? null
      : DateTime.parse(json['start_date'] as String),
  expectedCompletionDate: json['expected_completion_date'] == null
      ? null
      : DateTime.parse(json['expected_completion_date'] as String),
  progress: (json['progress'] as num).toDouble(),
);

Map<String, dynamic> _$ConstructionSiteModelToJson(
  _ConstructionSiteModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'project_id': instance.projectId,
  'project_name': instance.projectName,
  'address': instance.address,
  'cameras': instance.camerasList.map((e) => e.toJson()).toList(),
  'start_date': ?instance.startDate?.toIso8601String(),
  'expected_completion_date': ?instance.expectedCompletionDate
      ?.toIso8601String(),
  'progress': instance.progress,
};

_CameraModel _$CameraModelFromJson(Map<String, dynamic> json) => _CameraModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  streamUrl: json['stream_url'] as String,
  isActive: json['is_active'] as bool,
  thumbnailUrl: json['thumbnail_url'] as String?,
);

Map<String, dynamic> _$CameraModelToJson(_CameraModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'stream_url': instance.streamUrl,
      'is_active': instance.isActive,
      'thumbnail_url': ?instance.thumbnailUrl,
    };
