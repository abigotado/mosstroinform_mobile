/// Статус проекта
enum ProjectStatus {
  /// Доступен для выбора и запроса
  available,

  /// Запрошен пользователем, ожидает подписания документов
  requested,

  /// Начато строительство, объект создан
  construction,
}

/// Сущность проекта в доменном слое
/// Проект - это каталог вариантов домов для выбора, без этапов строительства
class Project {
  final String id;
  final String name;
  final String description;
  final double area;
  final int floors;
  final int bedrooms;
  final int bathrooms;
  final int price;
  final String? imageUrl;
  final ProjectStatus status;
  final String? objectId; // ID объекта строительства (если проект в статусе строительства)

  const Project({
    required this.id,
    required this.name,
    required this.description,
    required this.area,
    required this.floors,
    required this.bedrooms,
    required this.bathrooms,
    required this.price,
    this.imageUrl,
    this.status = ProjectStatus.available,
    this.objectId,
  });

  @override
  String toString() {
    return 'Project(id: $id, name: $name, status: $status, objectId: $objectId, area: $area, floors: $floors, bedrooms: $bedrooms, bathrooms: $bathrooms, price: $price)';
  }
}
