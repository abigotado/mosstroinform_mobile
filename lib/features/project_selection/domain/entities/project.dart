/// Сущность проекта в доменном слое
class Project {
  final String id;
  final String name;
  final String address;
  final String description;
  final double area;
  final int floors;
  final int price;
  final String? imageUrl;
  final List<ConstructionStage> stages;

  const Project({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.area,
    required this.floors,
    required this.price,
    this.imageUrl,
    required this.stages,
  });
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
}

/// Статус этапа строительства
enum StageStatus {
  pending,
  inProgress,
  completed,
}

