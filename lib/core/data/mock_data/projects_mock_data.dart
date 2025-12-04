// Моковые данные для проектов
// Используются для демонстрации приложения без реального бэкенда

class ProjectsMockData {
  static const List<Map<String, dynamic>> projects = [
    {
      'id': '1',
      'name': 'Частный жилой дом',
      'address': 'ул. Лесная, 15',
      'description': 'Двухэтажный дом площадью 150 кв.м с гаражом',
      'area': 150.0,
      'floors': 2,
      'bedrooms': 3,
      'bathrooms': 2,
      'price': 8500000,
      'imageUrl': 'https://via.placeholder.com/400x300?text=Проект+1',
      'stages': [],
    },
    {
      'id': '2',
      'name': 'Дачный дом',
      'address': 'с. Луговое, 3',
      'description': 'Одноэтажный дачный дом площадью 80 кв.м',
      'area': 80.0,
      'floors': 1,
      'bedrooms': 2,
      'bathrooms': 1,
      'price': 4200000,
      'imageUrl': 'https://via.placeholder.com/400x300?text=Проект+2',
      'stages': [],
    },
    {
      'id': '3',
      'name': 'Коттедж с мансардой',
      'address': 'ул. Садовая, 42',
      'description': 'Дом с мансардой площадью 180 кв.м',
      'area': 180.0,
      'floors': 2,
      'bedrooms': 4,
      'bathrooms': 3,
      'price': 12000000,
      'imageUrl': 'https://via.placeholder.com/400x300?text=Проект+3',
      'stages': [],
    },
  ];

  static Map<String, dynamic>? getProjectById(String id) {
    try {
      return projects.firstWhere((project) => project['id'] == id);
    } catch (e) {
      return null;
    }
  }
}
