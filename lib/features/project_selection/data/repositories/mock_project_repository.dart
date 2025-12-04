import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/models/project_model.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/entities/project.dart';
import 'package:mosstroinform_mobile/features/project_selection/domain/repositories/project_repository.dart';

/// Интерактивная моковая реализация репозитория проектов
/// Использует состояние через Riverpod для имитации реальной работы приложения
/// Состояние сбрасывается при перезапуске приложения
class MockProjectRepository implements ProjectRepository {
  final Ref ref;

  MockProjectRepository(this.ref);

  @override
  Future<List<Project>> getProjects() async {
    // Симуляция задержки сети
    await Future.delayed(const Duration(milliseconds: 500));

    // Всегда используем данные напрямую из мок-данных
    // Не используем провайдер здесь, так как он может быть disposed к моменту асинхронного вызова
    final mockData = [
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
        'imageUrl':
            'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?w=800&h=600&fit=crop',
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
        'imageUrl':
            'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?w=800&h=600&fit=crop',
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
        'imageUrl':
            'https://images.unsplash.com/photo-1600607687644-c7171b42498b?w=800&h=600&fit=crop',
        'stages': [],
      },
    ];

    // Создаем проекты напрямую из мок-данных
    final models = mockData.map((json) => ProjectModel.fromJson(json)).toList();
    final projects = models.map((model) => model.toEntity()).toList();
    AppLogger.info(
      'MockProjectRepository.getProjects: создано ${projects.length} проектов из мок-данных',
    );
    return Future.value(projects);
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

    // TODO: Реализовать создание объекта строительства через ConstructionObjectRepository
    // При запросе проекта должен создаваться объект с начальными этапами
    AppLogger.info(
      'MockProjectRepository.requestConstruction: запрос на строительство проекта $projectId',
    );
  }
}
