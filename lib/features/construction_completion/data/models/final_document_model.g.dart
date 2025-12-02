// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'final_document_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FinalDocumentModel _$FinalDocumentModelFromJson(Map<String, dynamic> json) =>
    _FinalDocumentModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      fileUrl: json['fileUrl'] as String?,
      statusString: json['status'] as String? ?? 'pending',
      submittedAt: json['submittedAt'] == null
          ? null
          : DateTime.parse(json['submittedAt'] as String),
      signedAt: json['signedAt'] == null
          ? null
          : DateTime.parse(json['signedAt'] as String),
      signatureUrl: json['signatureUrl'] as String?,
    );

Map<String, dynamic> _$FinalDocumentModelToJson(_FinalDocumentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'fileUrl': ?instance.fileUrl,
      'status': instance.statusString,
      'submittedAt': ?instance.submittedAt?.toIso8601String(),
      'signedAt': ?instance.signedAt?.toIso8601String(),
      'signatureUrl': ?instance.signatureUrl,
    };
