import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_navigation_provider.g.dart';

/// Провайдер для индекса текущей вкладки в главном экране
@riverpod
class MainNavigationIndex extends _$MainNavigationIndex {
  @override
  int build() => 0;

  /// Установить новый индекс
  void setIndex(int index) {
    state = index;
  }
}
