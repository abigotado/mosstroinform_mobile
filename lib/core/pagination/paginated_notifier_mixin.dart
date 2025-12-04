import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mosstroinform_mobile/core/pagination/paginated_state.dart';

/// Миксин для нотифаеров с пагинацией
/// T - тип элемента списка
/// S - тип состояния с пагинацией
/// 
/// Использование:
/// ```dart
/// @riverpod
/// class MyNotifier extends _$MyNotifier
///     with PaginatedNotifierMixin<MyItem, MyPaginatedState> {
///   @override
///   Future<MyPaginatedState> build() async {
///     return const MyPaginatedState(items: []);
///   }
///   
///   @override
///   Future<void> loadFirstPage() async {
///     // Реализация загрузки первой страницы
///   }
///   
///   @override
///   Future<void> loadNextPage() async {
///     // Реализация загрузки следующей страницы
///   }
/// }
/// ```
mixin PaginatedNotifierMixin<T, S extends PaginatedState<T>> {
  /// State нотифаера (должен быть переопределен в классе)
  AsyncValue<S> get state;
  
  /// Установить state (должен быть переопределен в классе)
  set state(AsyncValue<S> value);

  /// Загрузить первую страницу (сбросить пагинацию)
  Future<void> loadFirstPage();

  /// Загрузить следующую страницу
  Future<void> loadNextPage();

  /// Проверить, можно ли загрузить следующую страницу
  bool canLoadNextPage() {
    if (!state.hasValue) return false;
    final currentState = state.value;
    if (currentState == null) return false;
    return currentState.hasMore && !currentState.isLoadingMore;
  }

  /// Получить параметры пагинации для запроса
  Map<String, dynamic> getPaginationParams() {
    if (!state.hasValue) {
      return {'page': 0, 'limit': 10};
    }
    final currentState = state.value;
    if (currentState == null) {
      return {'page': 0, 'limit': 10};
    }
    return {
      'page': currentState.currentPage,
      'limit': currentState.itemsPerPage,
    };
  }
}

