import 'project.dart';

/// Сущность объекта строительства
/// Объект создается после запроса проекта и имеет этапы строительства
class ConstructionObject {
  final String id;
  final String projectId; // ID проекта, на основе которого создан объект
  final String name;
  final String address;
  final String description;
  final double area;
  final int floors;
  final int bedrooms;
  final int bathrooms;
  final int price;
  final String? imageUrl;
  final List<ConstructionStage> stages;
  final String? chatId; // ID чата для этого объекта
  final bool allDocumentsSigned; // Все документы подписаны
  final bool isCompleted; // Строительство завершено (кнопка нажата)

  const ConstructionObject({
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

  @override
  String toString() {
    return 'ConstructionObject(id: $id, projectId: $projectId, name: $name, address: $address, area: $area, floors: $floors, stages: ${stages.length}, allDocumentsSigned: $allDocumentsSigned, isCompleted: $isCompleted)';
  }

  /// Создать объект из проекта
  factory ConstructionObject.fromProject(
    Project project,
    String objectId,
    String address,
    List<ConstructionStage> initialStages, {
    String? chatId,
    bool allDocumentsSigned = false,
    bool isCompleted = false,
  }) {
    return ConstructionObject(
      id: objectId,
      projectId: project.id,
      name: project.name,
      address: address,
      description: project.description,
      area: project.area,
      floors: project.floors,
      bedrooms: project.bedrooms,
      bathrooms: project.bathrooms,
      price: project.price,
      imageUrl: project.imageUrl,
      stages: initialStages,
      chatId: chatId,
      allDocumentsSigned: allDocumentsSigned,
      isCompleted: isCompleted,
    );
  }
}

/// Этап строительства
class ConstructionStage {
  final String id;
  final String name;
  final StageStatus status;

  const ConstructionStage({
    required this.id,
    required this.name,
    required this.status,
  });

  @override
  String toString() {
    return 'ConstructionStage(id: $id, name: $name, status: $status)';
  }
}

/// Статус этапа строительства
enum StageStatus { pending, inProgress, completed }

