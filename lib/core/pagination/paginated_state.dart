/// Базовое состояние с пагинацией
abstract class PaginatedState<T> {
  /// Список элементов текущей страницы
  List<T> get items;

  /// Текущая страница (начинается с 0)
  int get currentPage;

  /// Количество элементов на странице
  int get itemsPerPage;

  /// Есть ли еще данные для загрузки
  bool get hasMore;

  /// Идет ли загрузка следующей страницы
  bool get isLoadingMore;

  /// Общее количество элементов (если известно)
  int? get totalCount;

  /// Ошибка загрузки
  Object? get error;
}

/// Базовая реализация состояния с пагинацией
class BasePaginatedState<T> implements PaginatedState<T> {
  @override
  final List<T> items;

  @override
  final int currentPage;

  @override
  final int itemsPerPage;

  @override
  final bool hasMore;

  @override
  final bool isLoadingMore;

  @override
  final int? totalCount;

  @override
  final Object? error;

  const BasePaginatedState({
    required this.items,
    this.currentPage = 0,
    this.itemsPerPage = 10,
    this.hasMore = false,
    this.isLoadingMore = false,
    this.totalCount,
    this.error,
  });

  BasePaginatedState<T> copyWith({
    List<T>? items,
    int? currentPage,
    int? itemsPerPage,
    bool? hasMore,
    bool? isLoadingMore,
    int? totalCount,
    Object? error,
  }) {
    return BasePaginatedState<T>(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      totalCount: totalCount ?? this.totalCount,
      error: error,
    );
  }

  /// Добавить новые элементы (для следующей страницы)
  BasePaginatedState<T> appendItems(List<T> newItems, {bool? hasMore}) {
    return BasePaginatedState<T>(
      items: [...items, ...newItems],
      currentPage: currentPage + 1,
      itemsPerPage: itemsPerPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: false,
      totalCount: totalCount,
      error: null,
    );
  }

  /// Сбросить пагинацию (начать с первой страницы)
  BasePaginatedState<T> reset() {
    return BasePaginatedState<T>(
      items: [],
      currentPage: 0,
      itemsPerPage: itemsPerPage,
      hasMore: false,
      isLoadingMore: false,
      totalCount: totalCount,
      error: null,
    );
  }
}

