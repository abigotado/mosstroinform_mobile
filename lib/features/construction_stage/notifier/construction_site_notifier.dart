import 'package:mosstroinform_mobile/core/errors/failures.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/providers/construction_site_repository_provider.dart';
import 'package:mosstroinform_mobile/features/construction_stage/domain/entities/construction_site.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'construction_site_notifier.g.dart';

/// Состояние строительной площадки
class ConstructionSiteState {
  final ConstructionSite? site;
  final bool isLoading;
  final Failure? error;

  const ConstructionSiteState({
    this.site,
    this.isLoading = false,
    this.error,
  });

  ConstructionSiteState copyWith({
    ConstructionSite? site,
    bool? isLoading,
    Failure? error,
  }) {
    return ConstructionSiteState(
      site: site ?? this.site,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier для управления состоянием строительной площадки
@riverpod
class ConstructionSiteNotifier extends _$ConstructionSiteNotifier {
  @override
  Future<ConstructionSiteState> build(String projectId) async {
    return const ConstructionSiteState();
  }

  /// Загрузить информацию о строительной площадке
  Future<void> loadConstructionSite() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(constructionSiteRepositoryProvider);
      final site = await repository.getConstructionSiteByProjectId(projectId);
      state = AsyncValue.data(
        ConstructionSiteState(site: site, isLoading: false),
      );
    } on Failure catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } catch (e, s) {
      state = AsyncValue.error(UnknownFailure('Неизвестная ошибка: $e'), s);
    }
  }
}

/// Состояние списка камер
class CamerasState {
  final List<Camera> cameras;
  final bool isLoading;
  final Failure? error;

  const CamerasState({
    required this.cameras,
    this.isLoading = false,
    this.error,
  });

  CamerasState copyWith({
    List<Camera>? cameras,
    bool? isLoading,
    Failure? error,
  }) {
    return CamerasState(
      cameras: cameras ?? this.cameras,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier для управления состоянием списка камер
@riverpod
class CamerasNotifier extends _$CamerasNotifier {
  @override
  Future<CamerasState> build(String siteId) async {
    return const CamerasState(cameras: []);
  }

  /// Загрузить список камер
  Future<void> loadCameras() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(constructionSiteRepositoryProvider);
      final cameras = await repository.getCameras(siteId);
      state = AsyncValue.data(
        CamerasState(cameras: cameras, isLoading: false),
      );
    } on Failure catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    } catch (e, s) {
      state = AsyncValue.error(UnknownFailure('Неизвестная ошибка: $e'), s);
    }
  }
}

