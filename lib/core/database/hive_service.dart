import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:mosstroinform_mobile/core/utils/logger.dart';
import 'package:mosstroinform_mobile/features/project_selection/data/models/project_model.dart';
import 'package:mosstroinform_mobile/core/data/mock_data/projects_mock_data.dart';
import 'package:mosstroinform_mobile/core/database/adapters/project_adapter.dart';
import 'package:mosstroinform_mobile/core/database/adapters/document_adapter.dart';
import 'package:mosstroinform_mobile/core/database/adapters/construction_object_adapter.dart';

/// Сервис для работы с локальной базой данных Hive
/// Используется только в моковом режиме для имитации работы бэкенда
class HiveService {
  static const String _projectsBoxName = 'projects';
  static const String _documentsBoxName = 'documents';
  static const String _constructionObjectsBoxName = 'construction_objects';
  static const String _requestedProjectsBoxName = 'requested_projects';

  static Box<ProjectAdapter>? _projectsBox;
  static Box<DocumentAdapter>? _documentsBox;
  static Box<ConstructionObjectAdapter>? _constructionObjectsBox;
  static Box<String>? _requestedProjectsBox;

  /// Проверка, инициализирован ли Hive
  static bool get isInitialized => _projectsBox != null;

  /// Инициализация Hive и загрузка начальных данных
  /// Идемпотентный метод - можно вызывать несколько раз без ошибок
  static Future<void> initialize() async {
    // Если уже инициализирован, просто возвращаемся
    if (isInitialized) {
      AppLogger.info('HiveService.initialize: Hive уже инициализирован');
      return;
    }

    try {
      await Hive.initFlutter();
      AppLogger.info('HiveService.initialize: Hive инициализирован');

      // Регистрируем адаптеры
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(ProjectAdapterAdapter());
      }
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(DocumentAdapterAdapter());
      }
      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(ConstructionStageAdapterAdapter());
      }
      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(ConstructionObjectAdapterAdapter());
      }

      // Открываем боксы
      _projectsBox = await Hive.openBox<ProjectAdapter>(_projectsBoxName);
      _documentsBox = await Hive.openBox<DocumentAdapter>(_documentsBoxName);
      _constructionObjectsBox =
          await Hive.openBox<ConstructionObjectAdapter>(_constructionObjectsBoxName);
      _requestedProjectsBox =
          await Hive.openBox<String>(_requestedProjectsBoxName);

      AppLogger.info('HiveService.initialize: боксы открыты');

      AppLogger.info('HiveService.initialize: инициализация завершена');
    } catch (e, stackTrace) {
      AppLogger.error(
        'HiveService.initialize: ошибка инициализации: $e',
        stackTrace,
      );
      rethrow;
    }
  }

  /// Обеспечить загрузку проектов, если бокс пустой (ленивая загрузка)
  /// Вызывается автоматически при первом обращении к списку проектов
  static Future<void> ensureProjectsLoaded() async {
    if (_projectsBox == null) {
      throw StateError('HiveService не инициализирован. Вызовите initialize()');
    }

    // Загружаем проекты, если база пустая
    if (_projectsBox!.isEmpty) {
      AppLogger.info('HiveService.ensureProjectsLoaded: загрузка начальных проектов');
      final mockData = ProjectsMockData.projects;
      final projects = mockData
          .map((json) => ProjectModel.fromJson(json).toEntity())
          .toList();

      for (final project in projects) {
        await _projectsBox!.put(
          project.id,
          ProjectAdapter.fromProject(project),
        );
      }
      AppLogger.info(
        'HiveService.ensureProjectsLoaded: загружено ${projects.length} проектов',
      );
    }
  }

  /// Очистить все пользовательские данные (при logout)
  /// Удаляет все данные из всех боксов, включая проекты
  /// При новом логине база будет создана с нуля через ensureProjectsLoaded()
  static Future<void> clearUserData() async {
    if (_projectsBox != null) {
      await _projectsBox!.clear();
      AppLogger.info('HiveService.clearUserData: проекты очищены');
    }
    if (_documentsBox != null) {
      await _documentsBox!.clear();
      AppLogger.info('HiveService.clearUserData: документы очищены');
    }
    if (_constructionObjectsBox != null) {
      await _constructionObjectsBox!.clear();
      AppLogger.info('HiveService.clearUserData: объекты строительства очищены');
    }
    if (_requestedProjectsBox != null) {
      await _requestedProjectsBox!.clear();
      AppLogger.info('HiveService.clearUserData: запрошенные проекты очищены');
    }
    AppLogger.info('HiveService.clearUserData: все данные очищены, база будет создана с нуля при следующем логине');
  }

  /// Получить бокс проектов
  static Box<ProjectAdapter> get projectsBox {
    if (_projectsBox == null) {
      throw StateError('HiveService не инициализирован. Вызовите initialize()');
    }
    return _projectsBox!;
  }

  /// Получить бокс документов
  static Box<DocumentAdapter> get documentsBox {
    if (_documentsBox == null) {
      throw StateError('HiveService не инициализирован. Вызовите initialize()');
    }
    return _documentsBox!;
  }

  /// Получить бокс объектов строительства
  static Box<ConstructionObjectAdapter> get constructionObjectsBox {
    if (_constructionObjectsBox == null) {
      throw StateError('HiveService не инициализирован. Вызовите initialize()');
    }
    return _constructionObjectsBox!;
  }

  /// Получить бокс запрошенных проектов
  static Box<String> get requestedProjectsBox {
    if (_requestedProjectsBox == null) {
      throw StateError('HiveService не инициализирован. Вызовите initialize()');
    }
    return _requestedProjectsBox!;
  }

  /// Очистить все данные (для тестирования)
  static Future<void> clearAll() async {
    await _projectsBox?.clear();
    await _documentsBox?.clear();
    await _constructionObjectsBox?.clear();
    await _requestedProjectsBox?.clear();
    await ensureProjectsLoaded();
  }

  /// Инициализация для тестов (без Flutter bindings)
  /// Использует Hive.init() вместо Hive.initFlutter()
  static Future<void> initializeForTests(String testPath) async {
    // Если уже инициализирован, просто возвращаемся
    if (isInitialized) {
      AppLogger.info('HiveService.initializeForTests: Hive уже инициализирован');
      return;
    }

    try {
      Hive.init(testPath);
      AppLogger.info('HiveService.initializeForTests: Hive инициализирован для тестов');

      // Регистрируем адаптеры
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(ProjectAdapterAdapter());
      }
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(DocumentAdapterAdapter());
      }
      if (!Hive.isAdapterRegistered(2)) {
        Hive.registerAdapter(ConstructionStageAdapterAdapter());
      }
      if (!Hive.isAdapterRegistered(3)) {
        Hive.registerAdapter(ConstructionObjectAdapterAdapter());
      }

      // Открываем боксы
      _projectsBox = await Hive.openBox<ProjectAdapter>(_projectsBoxName);
      _documentsBox = await Hive.openBox<DocumentAdapter>(_documentsBoxName);
      _constructionObjectsBox =
          await Hive.openBox<ConstructionObjectAdapter>(_constructionObjectsBoxName);
      _requestedProjectsBox =
          await Hive.openBox<String>(_requestedProjectsBoxName);

      AppLogger.info('HiveService.initializeForTests: боксы открыты');
      AppLogger.info('HiveService.initializeForTests: инициализация завершена');
    } catch (e, stackTrace) {
      AppLogger.error(
        'HiveService.initializeForTests: ошибка инициализации: $e',
        stackTrace,
      );
      rethrow;
    }
  }
}

