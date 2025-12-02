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
      'price': 8500000,
      'imageUrl': 'https://via.placeholder.com/400x300?text=Проект+1',
      'stages': [
        {'id': '1', 'name': 'Подготовительные работы', 'status': 'completed'},
        {'id': '2', 'name': 'Фундамент', 'status': 'in_progress'},
        {'id': '3', 'name': 'Возведение стен', 'status': 'pending'},
        {'id': '4', 'name': 'Кровля', 'status': 'pending'},
      ],
    },
    {
      'id': '2',
      'name': 'Дачный дом',
      'address': 'с. Луговое, 3',
      'description': 'Одноэтажный дачный дом площадью 80 кв.м',
      'area': 80.0,
      'floors': 1,
      'price': 4200000,
      'imageUrl': 'https://via.placeholder.com/400x300?text=Проект+2',
      'stages': [
        {'id': '1', 'name': 'Подготовительные работы', 'status': 'completed'},
        {'id': '2', 'name': 'Фундамент', 'status': 'completed'},
        {'id': '3', 'name': 'Возведение стен', 'status': 'in_progress'},
        {'id': '4', 'name': 'Кровля', 'status': 'pending'},
      ],
    },
    {
      'id': '3',
      'name': 'Коттедж с мансардой',
      'address': 'ул. Садовая, 42',
      'description': 'Дом с мансардой площадью 180 кв.м',
      'area': 180.0,
      'floors': 2,
      'price': 12000000,
      'imageUrl': 'https://via.placeholder.com/400x300?text=Проект+3',
      'stages': [
        {'id': '1', 'name': 'Подготовительные работы', 'status': 'completed'},
        {'id': '2', 'name': 'Фундамент', 'status': 'completed'},
        {'id': '3', 'name': 'Возведение стен', 'status': 'completed'},
        {'id': '4', 'name': 'Кровля', 'status': 'in_progress'},
      ],
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

