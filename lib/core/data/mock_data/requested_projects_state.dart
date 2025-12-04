import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'requested_projects_state.g.dart';

/// Провайдер состояния запрошенных проектов
/// Хранит ID проектов, по которым был отправлен запрос на строительство
@Riverpod(keepAlive: true)
class RequestedProjectsState extends _$RequestedProjectsState {
  @override
  Set<String> build() {
    // Начальное состояние - пустой набор запрошенных проектов
    return {};
  }

  /// Добавить проект в запрошенные
  void addRequestedProject(String projectId) {
    state = {...state, projectId};
  }

  /// Удалить проект из запрошенных
  void removeRequestedProject(String projectId) {
    state = state.where((id) => id != projectId).toSet();
  }

  /// Проверить, запрошен ли проект
  bool isRequested(String projectId) {
    return state.contains(projectId);
  }

  /// Очистить все запрошенные проекты
  void clear() {
    state = {};
  }
}

