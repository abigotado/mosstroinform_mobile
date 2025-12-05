import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';

part 'project_model.freezed.dart';
part 'project_model.g.dart';

/// Модель проекта для слоя данных
/// Проект не содержит этапов строительства - это каталог
@freezed
abstract class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required String id,
    required String name,
    required String description,
    required double area,
    required int floors,
    required int bedrooms,
    required int bathrooms,
    required int price,
    String? imageUrl,
    String? status, // 'available', 'requested', 'construction'
    String? objectId, // ID объекта строительства
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
}

/// Расширение для конвертации модели в сущность
extension ProjectModelX on ProjectModel {
  Project toEntity() {
    return Project(
      id: id,
      name: name,
      description: description,
      area: area,
      floors: floors,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      price: price,
      imageUrl: imageUrl,
      status: _parseStatus(status),
      objectId: objectId,
    );
  }

  static ProjectStatus _parseStatus(String? status) {
    switch (status) {
      case 'requested':
        return ProjectStatus.requested;
      case 'construction':
        return ProjectStatus.construction;
      case 'available':
      default:
        return ProjectStatus.available;
    }
  }
}
