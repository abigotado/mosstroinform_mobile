import 'package:hive_ce/hive.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/construction_object.dart';

part 'construction_object_adapter.g.dart';

/// Адаптер Hive для сущности ConstructionStage
@HiveType(typeId: 2)
class ConstructionStageAdapter extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String statusString; // 'pending', 'in_progress', 'completed'

  ConstructionStageAdapter({
    required this.id,
    required this.name,
    required this.statusString,
  });

  factory ConstructionStageAdapter.fromStage(ConstructionStage stage) {
    return ConstructionStageAdapter(
      id: stage.id,
      name: stage.name,
      statusString: _statusToString(stage.status),
    );
  }

  ConstructionStage toStage() {
    return ConstructionStage(
      id: id,
      name: name,
      status: _statusFromString(statusString),
    );
  }

  static String _statusToString(StageStatus status) {
    switch (status) {
      case StageStatus.pending:
        return 'pending';
      case StageStatus.inProgress:
        return 'in_progress';
      case StageStatus.completed:
        return 'completed';
    }
  }

  static StageStatus _statusFromString(String status) {
    switch (status) {
      case 'pending':
        return StageStatus.pending;
      case 'in_progress':
        return StageStatus.inProgress;
      case 'completed':
        return StageStatus.completed;
      default:
        return StageStatus.pending;
    }
  }
}

/// Адаптер Hive для сущности ConstructionObject
@HiveType(typeId: 3)
class ConstructionObjectAdapter extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String projectId;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String address;

  @HiveField(4)
  final String description;

  @HiveField(5)
  final double area;

  @HiveField(6)
  final int floors;

  @HiveField(7)
  final int bedrooms;

  @HiveField(8)
  final int bathrooms;

  @HiveField(9)
  final int price;

  @HiveField(10)
  final String? imageUrl;

  @HiveField(11)
  final List<ConstructionStageAdapter> stages;

  @HiveField(12)
  final String? chatId;

  @HiveField(13)
  final bool allDocumentsSigned;

  @HiveField(14)
  final bool isCompleted;

  ConstructionObjectAdapter({
    required this.id,
    required this.projectId,
    required this.name,
    required this.address,
    required this.description,
    required this.area,
    required this.floors,
    required this.bedrooms,
    required this.bathrooms,
    required this.price,
    this.imageUrl,
    required this.stages,
    this.chatId,
    this.allDocumentsSigned = false,
    this.isCompleted = false,
  });

  /// Конвертация из ConstructionObject в ConstructionObjectAdapter
  factory ConstructionObjectAdapter.fromObject(ConstructionObject object) {
    return ConstructionObjectAdapter(
      id: object.id,
      projectId: object.projectId,
      name: object.name,
      address: object.address,
      description: object.description,
      area: object.area,
      floors: object.floors,
      bedrooms: object.bedrooms,
      bathrooms: object.bathrooms,
      price: object.price,
      imageUrl: object.imageUrl,
      stages: object.stages
          .map((stage) => ConstructionStageAdapter.fromStage(stage))
          .toList(),
      chatId: object.chatId,
      allDocumentsSigned: object.allDocumentsSigned,
      isCompleted: object.isCompleted,
    );
  }

  /// Конвертация из ConstructionObjectAdapter в ConstructionObject
  ConstructionObject toObject() {
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
      stages: stages.map((stage) => stage.toStage()).toList(),
      chatId: chatId,
      allDocumentsSigned: allDocumentsSigned,
      isCompleted: isCompleted,
    );
  }
}

