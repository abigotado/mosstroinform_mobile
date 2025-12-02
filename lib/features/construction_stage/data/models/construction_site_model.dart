import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';

part 'construction_site_model.freezed.dart';
part 'construction_site_model.g.dart';

/// Модель строительной площадки для работы с API
@freezed
class ConstructionSiteModel with _$ConstructionSiteModel {
  const factory ConstructionSiteModel({
    required String id,
    required String projectId,
    required String projectName,
    required String address,
    @Default([]) List<CameraModel> camerasList,
    DateTime? startDate,
    DateTime? expectedCompletionDate,
    required double progress,
  }) = _ConstructionSiteModel;

  factory ConstructionSiteModel.fromJson(Map<String, dynamic> json) {
    return ConstructionSiteModel(
      id: json['id'] as String,
      projectId: json['projectId'] as String,
      projectName: json['projectName'] as String,
      address: json['address'] as String,
      camerasList: (json['cameras'] as List<dynamic>?)
              ?.map((e) => CameraModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      expectedCompletionDate: json['expectedCompletionDate'] == null
          ? null
          : DateTime.parse(json['expectedCompletionDate'] as String),
      progress: (json['progress'] as num).toDouble(),
    );
  }

}

/// Модель камеры для работы с API
@freezed
class CameraModel with _$CameraModel {
  const factory CameraModel({
    required String id,
    required String name,
    required String description,
    required String streamUrl,
    required bool isActive,
    String? thumbnailUrl,
  }) = _CameraModel;

  factory CameraModel.fromJson(Map<String, dynamic> json) =>
      _$CameraModelFromJson(json);
}

/// Расширение для конвертации модели в сущность
extension ConstructionSiteModelExtension on ConstructionSiteModel {
  ConstructionSite toEntity() {
    return ConstructionSite(
      id: id,
      projectId: projectId,
      projectName: projectName,
      address: address,
      cameras: camerasList.map((c) => c.toEntity()).toList(),
      startDate: startDate,
      expectedCompletionDate: expectedCompletionDate,
      progress: progress,
    );
  }
}

/// Расширение для конвертации модели камеры в сущность
extension CameraModelExtension on CameraModel {
  Camera toEntity() {
    return Camera(
      id: id,
      name: name,
      description: description,
      streamUrl: streamUrl,
      isActive: isActive,
      thumbnailUrl: thumbnailUrl,
    );
  }
}

