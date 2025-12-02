import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/repositories/construction_site_repository.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/providers/construction_site_repository_provider.dart';
import 'package:mosstroinform_mobile/features/construction_stage/notifier/construction_site_notifier.dart';

class MockConstructionSiteRepository extends Mock
    implements ConstructionSiteRepository {}

void main() {
  late MockConstructionSiteRepository mockRepository;
  late ProviderContainer container;

  setUp(() {
    mockRepository = MockConstructionSiteRepository();
    container = ProviderContainer(
      overrides: [
        constructionSiteRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('ConstructionSiteNotifier', () {
    const projectId = 'project1';

    test('build возвращает начальное состояние', () async {
      final state =
          await container.read(constructionSiteNotifierProvider(projectId).future);

      expect(state.site, isNull);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('loadConstructionSite успешно загружает площадку', () async {
      final site = ConstructionSite(
        id: 'site1',
        projectId: projectId,
        projectName: 'Проект 1',
        address: 'Адрес 1',
        cameras: [],
        progress: 0.5,
      );

      when(() => mockRepository.getConstructionSiteByProjectId(projectId))
          .thenAnswer((_) async => site);

      final notifier =
          container.read(constructionSiteNotifierProvider(projectId).notifier);
      await notifier.loadConstructionSite();

      final state =
          await container.read(constructionSiteNotifierProvider(projectId).future);

      expect(state.site, equals(site));
      expect(state.isLoading, false);
      expect(state.error, isNull);
      verify(() => mockRepository.getConstructionSiteByProjectId(projectId)).called(1);
    });

    test('loadConstructionSite обрабатывает Failure', () async {
      final failure = NetworkFailure('Ошибка сети');

      // Для асинхронных методов нужно использовать thenAnswer с throw
      when(() => mockRepository.getConstructionSiteByProjectId(projectId))
          .thenAnswer((_) async => throw failure);

      final notifier =
          container.read(constructionSiteNotifierProvider(projectId).notifier);
      
      // Вызываем метод - он установит AsyncValue.error
      await notifier.loadConstructionSite();

      // Проверяем состояние - AsyncValue.error устанавливается синхронно внутри catch
      final state = container.read(constructionSiteNotifierProvider(projectId));

      // ConstructionSiteNotifier использует AsyncValue.error для ошибок
      expect(state.hasError, true, reason: 'State should have error after Failure');
      expect(state.error, isA<NetworkFailure>());
      verify(() => mockRepository.getConstructionSiteByProjectId(projectId)).called(1);
    });
  });

  group('CamerasNotifier', () {
    const siteId = 'site1';

    test('build возвращает начальное состояние с пустым списком', () async {
      final state = await container.read(camerasNotifierProvider(siteId).future);

      expect(state.cameras, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('loadCameras успешно загружает камеры', () async {
      final cameras = [
        Camera(
          id: '1',
          name: 'Камера 1',
          description: 'Описание 1',
          streamUrl: 'https://example.com/stream1',
          isActive: true,
        ),
        Camera(
          id: '2',
          name: 'Камера 2',
          description: 'Описание 2',
          streamUrl: 'https://example.com/stream2',
          isActive: false,
        ),
      ];

      when(() => mockRepository.getCameras(siteId))
          .thenAnswer((_) async => cameras);

      final notifier = container.read(camerasNotifierProvider(siteId).notifier);
      await notifier.loadCameras();

      final state = await container.read(camerasNotifierProvider(siteId).future);

      expect(state.cameras, equals(cameras));
      expect(state.isLoading, false);
      expect(state.error, isNull);
      verify(() => mockRepository.getCameras(siteId)).called(1);
    });

    test('loadCameras обрабатывает Failure', () async {
      final failure = ServerFailure('Ошибка сервера');

      // Для асинхронных методов нужно использовать thenAnswer с throw
      when(() => mockRepository.getCameras(siteId))
          .thenAnswer((_) async => throw failure);

      final notifier = container.read(camerasNotifierProvider(siteId).notifier);
      
      // Вызываем метод - он установит AsyncValue.error
      await notifier.loadCameras();

      // Проверяем состояние - AsyncValue.error устанавливается синхронно внутри catch
      final state = container.read(camerasNotifierProvider(siteId));

      // CamerasNotifier использует AsyncValue.error для ошибок
      expect(state.hasError, true, reason: 'State should have error after Failure');
      expect(state.error, isA<ServerFailure>());
      verify(() => mockRepository.getCameras(siteId)).called(1);
    });
  });
}

