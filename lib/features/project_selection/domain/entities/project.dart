/// Сущность проекта в доменном слое
/// Проект - это каталог вариантов домов для выбора, без этапов строительства
class Project {
  final String id;
  final String name;
  final String address;
  final String description;
  final double area;
  final int floors;
  final int bedrooms;
  final int bathrooms;
  final int price;
  final String? imageUrl;

  const Project({
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
  });

  @override
  String toString() {
    return 'Project(id: $id, name: $name, address: $address, area: $area, floors: $floors, bedrooms: $bedrooms, bathrooms: $bathrooms, price: $price)';
  }
}
