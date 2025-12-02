// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'construction_site_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CameraModelImpl _$$CameraModelImplFromJson(Map<String, dynamic> json) =>
    _$CameraModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      streamUrl: json['streamUrl'] as String,
      isActive: json['isActive'] as bool,
      thumbnailUrl: json['thumbnailUrl'] as String?,
    );

Map<String, dynamic> _$$CameraModelImplToJson(_$CameraModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'streamUrl': instance.streamUrl,
      'isActive': instance.isActive,
      if (instance.thumbnailUrl case final value?) 'thumbnailUrl': value,
    };
