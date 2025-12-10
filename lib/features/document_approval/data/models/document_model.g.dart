// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocumentModel _$DocumentModelFromJson(Map<String, dynamic> json) =>
    _DocumentModel(
      id: json['id'] as String?,
      projectId: json['project_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      fileUrl: json['file_url'] as String?,
      statusString: json['status_string'] as String? ?? 'pending',
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
      'id': ?instance.id,
      'project_id': ?instance.projectId,
      'title': ?instance.title,
      'description': ?instance.description,
      'file_url': ?instance.fileUrl,
      'status_string': instance.statusString,
      'submitted_at': ?instance.submittedAt?.toIso8601String(),
      'approved_at': ?instance.approvedAt?.toIso8601String(),
      'rejection_reason': ?instance.rejectionReason,
    };
