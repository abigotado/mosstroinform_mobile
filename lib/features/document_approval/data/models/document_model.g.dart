// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentModel _$DocumentModelFromJson(Map<String, dynamic> json) =>
    _DocumentModel(
      id: _stringFromJson(json['id']),
      projectId: _stringFromJson(json['project_id']),
      title: _stringFromJson(json['title']),
      description: _stringFromJson(json['description']),
      fileUrl: json['file_url'] as String?,
      statusString: json['status'] as String? ?? 'pending',
      submittedAt: json['submitted_at'] == null
          ? null
          : DateTime.parse(json['submitted_at'] as String),
      approvedAt: json['approved_at'] == null
          ? null
          : DateTime.parse(json['approved_at'] as String),
      rejectionReason: json['rejection_reason'] as String?,
    );

Map<String, dynamic> _$DocumentModelToJson(_DocumentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'project_id': instance.projectId,
      'title': instance.title,
      'description': instance.description,
      'file_url': ?instance.fileUrl,
      'status': instance.statusString,
      'submitted_at': ?instance.submittedAt?.toIso8601String(),
      'approved_at': ?instance.approvedAt?.toIso8601String(),
      'rejection_reason': ?instance.rejectionReason,
    };
