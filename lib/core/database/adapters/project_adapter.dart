import 'package:hive_ce/hive.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';

part 'project_adapter.g.dart';

/// Адаптер Hive для сущности Project
@HiveType(typeId: 0)
class ProjectAdapter extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String address;

  @HiveField(3)
  final String description;

  @HiveField(4)
  final double area;

  @HiveField(5)
  final int floors;

  @HiveField(6)
  final int bedrooms;

  @HiveField(7)
  final int bathrooms;

  @HiveField(8)
  final int price;

  @HiveField(9)
  final String? imageUrl;

  @HiveField(10)
  final String? statusString; // 'available', 'requested', 'construction'

  @HiveField(11)
  final String? constructionAddress;

  @HiveField(12)
  final String? objectId; // ID объекта строительства

  ProjectAdapter({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.area,
    required this.floors,
    required this.bedrooms,
    required this.bathrooms,
    required this.price,
    this.imageUrl,
    this.statusString,
    this.constructionAddress,
    this.objectId,
  });

  /// Конвертация из Project в ProjectAdapter
  factory ProjectAdapter.fromProject(Project project) {
    return ProjectAdapter(
      id: project.id,
      name: project.name,
      address: '', // Проект больше не имеет адреса по умолчанию
      description: project.description,
      area: project.area,
      floors: project.floors,
      bedrooms: project.bedrooms,
      bathrooms: project.bathrooms,
      price: project.price,
      imageUrl: project.imageUrl,
      statusString: _statusToString(project.status),
      constructionAddress: null, // Адрес больше не хранится в проекте
      objectId: project.objectId,
    );
  }

  static String _statusToString(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.available:
        return 'available';
      case ProjectStatus.requested:
        return 'requested';
      case ProjectStatus.construction:
        return 'construction';
    }
  }

  /// Конвертация из ProjectAdapter в Project
  Project toProject() {
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
      status: _parseStatus(statusString),
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

