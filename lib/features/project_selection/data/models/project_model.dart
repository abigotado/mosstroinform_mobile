import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart'
    show Project, ConstructionStage, StageStatus;

part 'project_model.freezed.dart';
part 'project_model.g.dart';

/// Модель проекта для слоя данных
@freezed
class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required String id,
    required String name,
    required String address,
    required String description,
    required double area,
    required int floors,
    required int price,
    String? imageUrl,
    required List<ConstructionStageModel> stages,
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
}

/// Модель этапа строительства
@freezed
class ConstructionStageModel with _$ConstructionStageModel {
  const factory ConstructionStageModel({
    required String id,
    required String name,
    required String status,
  }) = _ConstructionStageModel;

  factory ConstructionStageModel.fromJson(Map<String, dynamic> json) =>
      _$ConstructionStageModelFromJson(json);
}

/// Расширение для конвертации модели в сущность
extension ProjectModelX on ProjectModel {
  Project toEntity() {
    return Project(
      id: id,
      name: name,
      address: address,
      description: description,
      area: area,
      floors: floors,
      price: price,
      imageUrl: imageUrl,
      stages: stages.map((s) => s.toEntity()).toList(),
    );
  }
}

/// Расширение для конвертации модели этапа в сущность
extension ConstructionStageModelX on ConstructionStageModel {
  ConstructionStage toEntity() {
    return ConstructionStage(
      id: id,
      name: name,
      status: _parseStatus(status),
    );
  }

  StageStatus _parseStatus(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return StageStatus.completed;
      case 'in_progress':
        return StageStatus.inProgress;
      case 'pending':
      default:
        return StageStatus.pending;
    }
  }
}

