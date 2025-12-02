import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/models/project_model.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';

/// Моковая реализация репозитория проектов
/// Используется для демонстрации приложения без реального бэкенда
class MockProjectRepository implements ProjectRepository {
  @override
  Future<List<Project>> getProjects() async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    final mockData = [
      {
        'id': '1',
        'name': 'Частный жилой дом',
        'address': 'ул. Лесная, 15',
        'description': 'Двухэтажный дом площадью 150 кв.м с гаражом',
        'area': 150.0,
        'floors': 2,
        'price': 8500000,
        'imageUrl':
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',
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
        'imageUrl':
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop',
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
        'imageUrl':
            'https://images.unsplash.com/photo-1600607687644-c7171b42498b?w=800&h=600&fit=crop',
        'stages': [
          {'id': '1', 'name': 'Подготовительные работы', 'status': 'completed'},
          {'id': '2', 'name': 'Фундамент', 'status': 'completed'},
          {'id': '3', 'name': 'Возведение стен', 'status': 'completed'},
          {'id': '4', 'name': 'Кровля', 'status': 'in_progress'},
        ],
      },
    ];

    final models = mockData.map((json) => ProjectModel.fromJson(json)).toList();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Project> getProjectById(String id) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 300));

    final projects = await getProjects();
    try {
      final project = projects.firstWhere((p) => p.id == id);
      return project;
    } catch (e) {
      throw UnknownFailure('Проект с ID $id не найден');
    }
  }

  @override
  Future<void> requestConstruction(String projectId) async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));
    // В реальном приложении здесь была бы отправка запроса
  }
}

