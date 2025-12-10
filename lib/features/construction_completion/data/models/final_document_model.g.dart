// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'final_document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FinalDocumentModel _$FinalDocumentModelFromJson(Map<String, dynamic> json) =>
    _FinalDocumentModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      fileUrl: json['file_url'] as String?,
      statusString: json['status'] as String? ?? 'pending',
      submittedAt: json['submitted_at'] == null
          ? null
          : DateTime.parse(json['submitted_at'] as String),
      signedAt: json['signed_at'] == null
          ? null
          : DateTime.parse(json['signed_at'] as String),
      signatureUrl: json['signature_url'] as String?,
    );

Map<String, dynamic> _$FinalDocumentModelToJson(_FinalDocumentModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'title': ?instance.title,
      'description': ?instance.description,
      'file_url': ?instance.fileUrl,
      'status_string': instance.statusString,
      'submitted_at': ?instance.submittedAt?.toIso8601String(),
      'signed_at': ?instance.signedAt?.toIso8601String(),
      'signature_url': ?instance.signatureUrl,
    };
