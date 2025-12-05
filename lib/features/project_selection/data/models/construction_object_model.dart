import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/construction_object.dart';

part 'construction_object_model.freezed.dart';
part 'construction_object_model.g.dart';

/// Модель объекта строительства для слоя данных
@freezed
abstract class ConstructionObjectModel with _$ConstructionObjectModel {
  const factory ConstructionObjectModel({
    required String id,
    required String projectId,
    required String name,
    required String address,
    required String description,
    required double area,
    required int floors,
    required int bedrooms,
    required int bathrooms,
    required int price,
    String? imageUrl,
    required List<ConstructionStageModel> stages,
    String? chatId,
    @Default(false) bool allDocumentsSigned,
    @Default(false) bool isCompleted,
  }) = _ConstructionObjectModel;

  factory ConstructionObjectModel.fromJson(Map<String, dynamic> json) =>
      _$ConstructionObjectModelFromJson(json);
}

/// Модель этапа строительства
@freezed
abstract class ConstructionStageModel with _$ConstructionStageModel {
  const factory ConstructionStageModel({
    required String id,
    required String name,
    required String status,
  }) = _ConstructionStageModel;

  factory ConstructionStageModel.fromJson(Map<String, dynamic> json) =>
      _$ConstructionStageModelFromJson(json);
}

/// Расширение для конвертации модели в сущность
extension ConstructionObjectModelX on ConstructionObjectModel {
  ConstructionObject toEntity() {
    return ConstructionObject(
      id: id,
      projectId: projectId,
      name: name,
      address: address,
      description: description,
      area: area,
      floors: floors,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      price: price,
      imageUrl: imageUrl,
      stages: stages.map((s) => s.toEntity()).toList(),
      chatId: chatId,
      allDocumentsSigned: allDocumentsSigned,
    );
  }
}

/// Расширение для конвертации модели этапа в сущность
extension ConstructionStageModelX on ConstructionStageModel {
  ConstructionStage toEntity() {
    return ConstructionStage(id: id, name: name, status: _parseStatus(status));
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

