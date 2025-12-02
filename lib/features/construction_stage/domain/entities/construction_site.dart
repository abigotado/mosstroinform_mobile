/// Сущность строительной площадки
class ConstructionSite {
  final String id;
  final String projectId;
  final String projectName;
  final String address;
  final List<Camera> cameras;
  final DateTime? startDate;
  final DateTime? expectedCompletionDate;
  final double progress; // 0.0 - 1.0

  const ConstructionSite({
    required this.id,
    required this.projectId,
    required this.projectName,
    required this.address,
    required this.cameras,
    this.startDate,
    this.expectedCompletionDate,
    required this.progress,
  });
}

/// Сущность камеры на стройке
class Camera {
  final String id;
  final String name;
  final String description;
  final String streamUrl;
  final bool isActive;
  final String? thumbnailUrl;

  const Camera({
    required this.id,
    required this.name,
    required this.description,
    required this.streamUrl,
    required this.isActive,
    this.thumbnailUrl,
  });
}

